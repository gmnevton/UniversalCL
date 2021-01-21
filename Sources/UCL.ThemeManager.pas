unit UCL.ThemeManager;

interface

uses
  SysUtils,
  Classes,
  TypInfo,
  Controls,
  Graphics,
  Menus,
  Generics.Collections,
//  UCL.Classes,
  UCL.SystemSettings;

type
  TUTheme = (utLight, utDark);
  TUThemeType = (ttSystem, ttLight, ttDark);

  TUCustomThemeManager = class;

  IUThemedComponent = interface ['{C9D5D479-2F52-4BB9-8023-6EA00B5084F0}']
//    procedure SetThemeManager;
    procedure UpdateTheme;
    function IsCustomThemed: Boolean;
    function CustomThemeManager: TUCustomThemeManager;
  end;

  // @Info:
  //
  // The goal is to have one ThemeManager for whole application,
  // automatically created and disposed when first instance of TUForm is created
  // this allows us to manage all settings from one place
  // if You want to be able to visually make changes to properties inside ThemeManager,
  // than You must place it on any form in Your application
  //
  // This approch is not limiting You from using individual ThemeManagers for any control
  // in Your application, You must only place additional ThemeManagers for any control
  // You want to be able to individually or group controlled and change its ThemeManager
  // property to instance layed on the form
  //
  // >>> 2-09-2020; GM
  //
  TUCustomThemeManager = class(TComponent)
  private
    // System
    ISystemTheme: TUTheme;
    ISystemAccentColor: TColor;
    ISystemColorOnBorder: Boolean;

    // Internal
    FCompList: TList<TComponent>;
    FTheme: TUThemeType;
    FAutoUpdateControls: Boolean;
    FAccentColor: TColor;
    FColorOnBorder: TColor;
    FUseSystemAccentColor: Boolean;
    FUseSystemColorOnBorder: Boolean;
    FUseColorOnBorder: Boolean;

    // Events
    FOnBeforeColorLoading: TNotifyEvent;
    FOnBeforeUpdate: TNotifyEvent;
    FOnAfterUpdate: TNotifyEvent;
  private
    // Properties
    procedure SetTheme(Value: TUThemeType);
    procedure SetAutoUpdateControls(Value: Boolean);
    procedure SetAccentColor(Value: TColor);
    procedure SetColorOnBorder(Value: TColor);
    procedure SetUseSystemAccentColor(Value: Boolean);
    procedure SetUseSystemColorOnBorder(Value: Boolean);
    procedure SetUseColorOnBorder(Value: Boolean);
    //
    procedure Changed;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure Loaded; override;

    // Utils
    procedure Reload;
    procedure UpdateTheme;

    // Components connecting
    class function IsThemingAvailable(const Comp: TComponent): Boolean;
    function ConnectedComponentCount: Integer;
    procedure Connect(const Comp: TComponent);
    procedure Disconnect(const Comp: TComponent);
    procedure CollectAndConnectControls(const Root: TComponent);
    function ThemeUsed: TUTheme;

  published
    // System
    // indicates current system settings
    // right now NOT auto-updated internally; use Reload to update (see TUForm.WMDWMColorizationColorChanged)
    property SystemTheme: TUTheme read ISystemTheme stored False;
    property SystemAccentColor: TColor read ISystemAccentColor stored False;
    property SystemColorOnBorder: Boolean read ISystemColorOnBorder stored False;

    // Properties
    property Theme: TUThemeType read FTheme write SetTheme default ttSystem;
    property AutoUpdateControls: Boolean read FAutoUpdateControls write SetAutoUpdateControls default True;
    property AccentColor: TColor read FAccentColor write SetAccentColor default $D77800;
    property ColorOnBorder: TColor read FColorOnBorder write SetColorOnBorder default $000000;
    property UseSystemAccentColor: Boolean read FUseSystemAccentColor write SetUseSystemAccentColor default True;
    property UseSytemColorOnBorder: Boolean read FUseSystemColorOnBorder write SetUseSystemColorOnBorder default True;
    property UseColorOnBorder: Boolean read FUseColorOnBorder write SetUseColorOnBorder default True;

    // Events
    property OnBeforeColorLoading: TNotifyEvent read FOnBeforeColorLoading write FOnBeforeColorLoading;
    property OnBeforeUpdate: TNotifyEvent read FOnBeforeUpdate write FOnBeforeUpdate;
    property OnAfterUpdate: TNotifyEvent read FOnAfterUpdate write FOnAfterUpdate;
  end;

  TUApplicationThemeManager = class(TUCustomThemeManager)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TUThemeManager = class(TUCustomThemeManager);

function GetCommonThemeManager: TUCustomThemeManager;
function SelectThemeManager(Control: TControl): TUCustomThemeManager; overload; inline;
function SelectThemeManager(Control: TMenu): TUCustomThemeManager; overload; inline;
function SelectAccentColor(const TM: TUCustomThemeManager; CustomAccentColor: TColor): TColor; inline;


implementation

uses
  Windows,
  Forms,
  UCL.Utils;

type
  TComponentAccess = class(TComponent);

var
  CommonThemeManager: TUCustomThemeManager;

function GetCommonThemeManager: TUCustomThemeManager;
begin
  if CommonThemeManager = Nil then
    CommonThemeManager:=TUApplicationThemeManager.Create(Nil);
  //
  Result := CommonThemeManager;
end;

//function SelectThemeManager(Control: TControl): TUThemeManager;
//var
//  ParentForm: TCustomForm;
//begin
//  ParentForm := GetParentForm(Control, True);
//  if (ParentForm <> Nil) and (ParentForm is TUForm) then
//    Result := (ParentForm as TUForm).ThemeManager
//  else
//    Result := Nil;
//end;

function SelectThemeManager(Control: TControl): TUCustomThemeManager;
var
  ThemedComponent: IUThemedComponent;
begin
  Result:=GetCommonThemeManager;
  if TUCustomThemeManager.IsThemingAvailable(Control) then begin
    if Supports(Control, IUThemedComponent, ThemedComponent) and (ThemedComponent <> Nil) and ThemedComponent.IsCustomThemed then
      Result:=ThemedComponent.CustomThemeManager;
  end;
end;

function SelectThemeManager(Control: TMenu): TUCustomThemeManager; overload;
var
  ThemedComponent: IUThemedComponent;
begin
  Result:=GetCommonThemeManager;
  if TUCustomThemeManager.IsThemingAvailable(Control) then begin
    if Supports(Control, IUThemedComponent, ThemedComponent) and (ThemedComponent <> Nil) and ThemedComponent.IsCustomThemed then
      Result:=ThemedComponent.CustomThemeManager;
  end;
end;

function SelectAccentColor(const TM: TUCustomThemeManager; CustomAccentColor: TColor): TColor;
begin
  if (TM = Nil) or ((CustomAccentColor <> clNone) and (CustomAccentColor <> clDefault))  then
    Result := CustomAccentColor
  else begin
    if TM.UseSystemAccentColor then
      Result := TM.SystemAccentColor
    else
      Result := TM.AccentColor;
  end;
end;

{ TUCustomThemeManager }

constructor TUCustomThemeManager.Create(AOwner: TComponent);
begin
  //just for now we are limiting use of ThemeManager to only one
//  if not (csLoading in ComponentState) and (CommonThemeManager <> Nil) then
//    raise Exception.Create('TUThemeManager allready used in application!');
  inherited;

//  CommonThemeManager := Self;

  ISystemTheme := utLight;
  if IsAppsUseDarkTheme then
    ISystemTheme := utDark;
  ISystemAccentColor := GetAccentColor;
  ISystemColorOnBorder := IsColorOnBorderEnabled;

  //  Objects
  FCompList := TList<TComponent>.Create;

  //  Default properties
  FTheme := ttSystem;
  FAutoUpdateControls := True;
  FAccentColor := $D77800;
  FColorOnBorder := $000000;
  FUseSystemAccentColor := True;
  FUseSystemColorOnBorder := True;
  FUseColorOnBorder := True;
end;

destructor TUCustomThemeManager.Destroy;
var
  Comp: TComponent;
  i: Integer;
begin
  // If any components are connected than notify them of self-destroying
  for i:=FCompList.Count -1 downto 0 do begin
    Comp:=FCompList.Items[i];
    try // @hack for now
      if Comp <> Nil then
        TComponentAccess(Comp).Notification(Self, opRemove);
    except
    end;
  end;
  FCompList.Free;
  if CommonThemeManager = Self then
    CommonThemeManager := Nil;
  inherited;
end;

procedure TUCustomThemeManager.AfterConstruction;
begin
  inherited;
  if (Application.MainForm <> Nil) and not (fsCreating in Application.MainForm.FormState) and (Self.Owner <> Nil) then
    CollectAndConnectControls(Self.Owner);
end;

procedure TUCustomThemeManager.Loaded;
begin
  inherited;
  if Assigned(OnBeforeColorLoading) then
    FOnBeforeColorLoading(Self);
  UpdateTheme;
end;

procedure TUCustomThemeManager.SetTheme(Value: TUThemeType);
begin
  if FTheme <> Value then begin
    FTheme := Value;
    Changed;
  end;
end;

procedure TUCustomThemeManager.SetAutoUpdateControls(Value: Boolean);
begin
  if FAutoUpdateControls <> Value then begin
    FAutoUpdateControls := Value;
    Changed;
  end;
end;

procedure TUCustomThemeManager.SetAccentColor(Value: TColor);
begin
  if FAccentColor <> Value then begin
    FAccentColor := Value;
    Changed;
  end;
end;

procedure TUCustomThemeManager.SetColorOnBorder(Value: TColor);
begin
  if FColorOnBorder <> Value then begin
    FColorOnBorder := Value;
    Changed;
  end;
end;

procedure TUCustomThemeManager.SetUseColorOnBorder(Value: Boolean);
begin
  if FUseColorOnBorder <> Value then begin
    FUseColorOnBorder := Value;
    Changed;
  end;
end;

procedure TUCustomThemeManager.SetUseSystemAccentColor(Value: Boolean);
begin
  if FUseSystemAccentColor <> Value then begin
    FUseSystemAccentColor := Value;
    Changed;
  end;
end;

procedure TUCustomThemeManager.SetUseSystemColorOnBorder(Value: Boolean);
begin
  if FUseSystemColorOnBorder <> Value then begin
    FUseSystemColorOnBorder := Value;
    Changed;
  end;
end;

procedure TUCustomThemeManager.Changed;
begin
  UpdateTheme;
end;

procedure TUCustomThemeManager.Reload;
begin
  ISystemTheme := utLight;
  if IsAppsUseDarkTheme then
    ISystemTheme := utDark;
  ISystemAccentColor := GetAccentColor;
  ISystemColorOnBorder := IsColorOnBorderEnabled;
  UpdateTheme;
end;

procedure TUCustomThemeManager.UpdateTheme;
var
  Comp: TComponent;
begin
  if not AutoUpdateControls then
    Exit;

  if Assigned(FOnBeforeUpdate) then
    FOnBeforeUpdate(Self);

  for Comp in FCompList do begin
    if Comp <> Nil then
      (Comp as IUThemedComponent).UpdateTheme;
  end;

  if Assigned(FOnAfterUpdate) then
    FOnAfterUpdate(Self);
end;

//  COMPONENTS CONNECTING

class function TUCustomThemeManager.IsThemingAvailable(const Comp: TComponent): Boolean;
begin
  Result := Supports(Comp, IUThemedComponent) and IsPublishedProp(Comp, 'ThemeManager');
end;

function TUCustomThemeManager.ConnectedComponentCount: Integer;
begin
  Result := -1;
  if FCompList <> Nil then
    Result := FCompList.Count;
end;

procedure TUCustomThemeManager.Connect(const Comp: TComponent);
var
  ConnectedYet: Boolean;
  ThemedComponent: IUThemedComponent;
begin
  if IsThemingAvailable(Comp) then begin
    ConnectedYet := (FCompList.IndexOf(Comp) <> -1);
    if not ConnectedYet then begin
      if Supports(Comp, IUThemedComponent, ThemedComponent) and (ThemedComponent <> Nil) and not ThemedComponent.IsCustomThemed then begin
        FCompList.Add(Comp);
        //ThemedComponent.SetThemeManager;
        ThemedComponent.UpdateTheme;
      end;
    end;
  end;
end;

procedure TUCustomThemeManager.Disconnect(const Comp: TComponent);
var
  Index: Integer;
begin
  Index := FCompList.IndexOf(Comp);
  if Index <> -1 then
    FCompList.Delete(Index);
end;

procedure TUCustomThemeManager.CollectAndConnectControls(const Root: TComponent);
var
  i: Integer;
  Component: TComponent;
begin
  for i:=0 to Root.ComponentCount - 1 do begin
    Component:=Root.Components[i];
    Self.Connect(Component);
    if Component.ComponentCount > 0 then
      CollectAndConnectControls(Component);
  end;
end;

function TUCustomThemeManager.ThemeUsed: TUTheme;
begin
  //if Theme = ttSystem then
  Result:=SystemTheme;
  if Theme = ttLight then
    Result:=utLight
  else if Theme = ttDark then
    Result:=utDark;
end;

{ TUApplicationThemeManager }

constructor TUApplicationThemeManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Name:='ApplicationThemeManager';
end;

initialization
  CommonThemeManager := Nil;
  LoadResourceFontByName('SEGOEUI', RT_RCDATA);
  LoadResourceFontByName('SEGOEMDL2ASSETS', RT_RCDATA);
  LoadResourceFontByName('SEGOEUISEMIBOLD', RT_RCDATA);
//  LoadResourceFontByID(2, RT_FONT);

finalization
  if CommonThemeManager <> Nil then
    CommonThemeManager.Free;

end.
