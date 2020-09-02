unit UCL.ThemeManager;

interface

uses
  SysUtils,
  Classes,
  TypInfo,
  Controls,
  Graphics,
  Generics.Collections,
  UCL.Classes,
  UCL.SystemSettings;

type
  TUTheme = (utLight, utDark);
  TUThemeType = (ttAuto, ttLight, ttDark);

  IUThemedComponent = interface ['{C9D5D479-2F52-4BB9-8023-6EA00B5084F0}']
    procedure SetThemeManager;
    procedure UpdateTheme;
  end;

  // @Info: GM; 2-09-2020
  // the goal is to have one ThemeManager for whole application,
  // automatically created and disposed when first instance of TUForm is created
  // this allows us to manage all settings from one place
  // if You want to be able to visually make changes to properties inside ThemeManager,
  // than You must place it on any form in Your application
  // 
  // this approch is not limiting You from using individual ThemeManager for any control 
  // in Your application, You must only place additional ThemeManagers for any control 
  // You want to be able to individually or group controlled and change its ThemeManager 
  // property to instance layed on the form
  TUThemeManager = class(TComponent)
    private
      FAutoUpdateControls: Boolean;
      FCompList: TList<TComponent>;

      //  Events
      FOnBeforeColorLoading: TNotifyEvent;
      FOnBeforeUpdate: TNotifyEvent;
      FOnAfterUpdate: TNotifyEvent;

      //  Internal
      FTheme: TUTheme;
      FAccentColor: TColor;
      FColorOnBorder: Boolean;

      //  System
      FUseSystemTheme: Boolean;
      FUseSystemAccentColor: Boolean;

      //  Custom
      FCustomTheme: TUTheme;
      FCustomAccentColor: TColor;
    private
      procedure CollectAndConnectControls(const Root: TComponent);

    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure AfterConstruction; override;
      procedure Loaded; override;

      //  Utils
      procedure Reload;
      procedure UpdateTheme;

      //  Components connecting
      class function IsThemeAvailable(const Comp: TComponent): Boolean;
      function ConnectedComponentCount: Integer;
      procedure Connect(const Comp: TComponent);
      procedure Disconnect(const Comp: TComponent);

    published
      property AutoUpdateControls: Boolean read FAutoUpdateControls write FAutoUpdateControls default true;

      //  System
      property UseSystemTheme: Boolean read FUseSystemTheme write FUseSystemTheme default true;
      property UseSystemAccentColor: Boolean read FUseSystemAccentColor write FUseSystemAccentColor default true;

      //  Custom
      property CustomTheme: TUTheme read FCustomTheme write FCustomTheme default utLight;
      property CustomAccentColor: TColor read FCustomAccentColor write FCustomAccentColor default $D77800;

      property Theme: TUTheme read FTheme stored false;
      property AccentColor: TColor read FAccentColor stored false;
      property ColorOnBorder: Boolean read FColorOnBorder stored false;

      //  Events
      property OnBeforeColorLoading: TNotifyEvent read FOnBeforeColorLoading write FOnBeforeColorLoading;
      property OnBeforeUpdate: TNotifyEvent read FOnBeforeUpdate write FOnBeforeUpdate;
      property OnAfterUpdate: TNotifyEvent read FOnAfterUpdate write FOnAfterUpdate;
  end;

function GetCommonThemeManager: TUThemeManager;

implementation

var
  CommonThemeManager: TUThemeManager;

function GetCommonThemeManager: TUThemeManager;
begin
  Result := CommonThemeManager;
end;

{ TUThemeManager }

constructor TUThemeManager.Create(AOwner: TComponent);
begin
  //just for now we are limiting use of ThemeManager to only one
  if not (csLoading in ComponentState) and (CommonThemeManager <> Nil) then
    raise Exception.Create('TUThemeManager allready used in application!');
  inherited;

  CommonThemeManager := Self;

  //  Objects
  FCompList := TList<TComponent>.Create;

  //  Default properties
  FAutoUpdateControls := True;

  FUseSystemTheme := True;
  FUseSystemAccentColor := True;

  FCustomTheme := utLight;
  FCustomAccentColor := $D77800;

  //  Default vars
  FTheme := utLight;
  FColorOnBorder := False;
  FAccentColor := $D77800;
end;

destructor TUThemeManager.Destroy;
begin
  FCompList.Free;
  CommonThemeManager := Nil;
  inherited;
end;

procedure TUThemeManager.AfterConstruction;
begin
  inherited;
  CollectAndConnectControls(Self.Owner);
end;

procedure TUThemeManager.Loaded;
begin
  inherited;
  if Assigned(OnBeforeColorLoading) then
    FOnBeforeColorLoading(Self);
  Reload;
end;

procedure TUThemeManager.Reload;
begin
  if csDesigning in ComponentState then
    Exit;

  //  Theme
  if not UseSystemTheme then
    FTheme := CustomTheme
  else begin
    if IsAppsUseDarkTheme then
      FTheme := utDark
    else
      FTheme := utLight;
  end;

  //  Accent color
  if not UseSystemAccentColor then
    FAccentColor := CustomAccentColor
  else
    FAccentColor := GetAccentColor;

  //  Color on border (read only)
  FColorOnBorder := IsColorOnBorderEnabled;

  //  Update for controls
  if AutoUpdateControls then
    UpdateTheme;
end;

procedure TUThemeManager.UpdateTheme;
var
  Comp: TComponent;
begin
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

class function TUThemeManager.IsThemeAvailable(const Comp: TComponent): Boolean;
begin
  Result := IsPublishedProp(Comp, 'ThemeManager') and Supports(Comp, IUThemedComponent);
end;

function TUThemeManager.ConnectedComponentCount: Integer;
begin
  if FCompList = Nil then
    Result := -1
  else
    Result := FCompList.Count;
end;

procedure TUThemeManager.CollectAndConnectControls(const Root: TComponent);
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

procedure TUThemeManager.Connect(const Comp: TComponent);
var
  ConnectedYet: Boolean;
  ThemedComponent: IUThemedComponent;
begin
  if IsThemeAvailable(Comp) then begin
    ConnectedYet := (FCompList.IndexOf(Comp) <> -1);
    if not ConnectedYet then begin
      FCompList.Add(Comp);
      if Supports(Comp, IUThemedComponent, ThemedComponent) then
        ThemedComponent.SetThemeManager;
    end;
  end;
end;

procedure TUThemeManager.Disconnect(const Comp: TComponent);
var
  Index: Integer;
begin
  Index := FCompList.IndexOf(Comp);
  if Index <> -1 then
    FCompList.Delete(Index);
end;

initialization
  CommonThemeManager := Nil;

//finalization
//  if CommonThemeManager <> Nil then
//    CommonThemeManager.Free;

end.
