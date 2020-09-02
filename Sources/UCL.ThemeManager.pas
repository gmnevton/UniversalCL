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
  TUThemeType = (ttSystem, ttLight, ttDark);

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
      FUseSystemTheme: Boolean;
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
      procedure CollectAndConnectControls(const Root: TComponent);
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
      class function IsThemeAvailable(const Comp: TComponent): Boolean;
      function ConnectedComponentCount: Integer;
      procedure Connect(const Comp: TComponent);
      procedure Disconnect(const Comp: TComponent);

    published
      // System
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
  UpdateTheme;
end;

procedure TUThemeManager.SetTheme(Value: TUThemeType);
begin
  if FTheme <> Value then begin
    FTheme := Value;
    Changed;
  end;
end;

procedure TUThemeManager.SetAutoUpdateControls(Value: Boolean);
begin
  if FAutoUpdateControls <> Value then begin
    FAutoUpdateControls := Value;
    Changed;
  end;
end;

procedure TUThemeManager.SetAccentColor(Value: TColor);
begin
  if FAccentColor <> Value then begin
    FAccentColor := Value;
    Changed;
  end;
end;

procedure TUThemeManager.SetColorOnBorder(Value: TColor);
begin
  if FColorOnBorder <> Value then begin
    FColorOnBorder := Value;
    Changed;
  end;
end;

procedure TUThemeManager.SetUseColorOnBorder(Value: Boolean);
begin
  if FUseColorOnBorder <> Value then begin
    FUseColorOnBorder := Value;
    Changed;
  end;
end;

procedure TUThemeManager.SetUseSystemAccentColor(Value: Boolean);
begin
  if FUseSystemAccentColor <> Value then begin
    FUseSystemAccentColor := Value;
    Changed;
  end;
end;

procedure TUThemeManager.SetUseSystemColorOnBorder(Value: Boolean);
begin
  if FUseSystemColorOnBorder <> Value then begin
    FUseSystemColorOnBorder := Value;
    Changed;
  end;
end;

procedure TUThemeManager.Reload;
begin
  ISystemTheme := utLight;
  if IsAppsUseDarkTheme then
    ISystemTheme := utDark;
  ISystemAccentColor := GetAccentColor;
  ISystemColorOnBorder := IsColorOnBorderEnabled;
  UpdateTheme;
end;

procedure TUThemeManager.UpdateTheme;
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

class function TUThemeManager.IsThemeAvailable(const Comp: TComponent): Boolean;
begin
  Result := Supports(Comp, IUThemedComponent) and IsPublishedProp(Comp, 'ThemeManager');
end;

function TUThemeManager.ConnectedComponentCount: Integer;
begin
  Result := -1;
  if FCompList <> Nil then
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

procedure TUThemeManager.Changed;
begin
  UpdateTheme;
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
