unit UCL.Text;

interface

uses
  Classes,
  Windows,
  Messages,
  Controls,
  StdCtrls,
  UCL.Classes,
  UCL.ThemeManager;

type
  TUTextKind = (tkCustom, tkNormal, tkDescription, tkEntry, tkHeading, tkTitle);

  TUText = class(TLabel, IUThemedComponent)
  private
    FThemeManager: TUThemeManager;
    FTextKind: TUTextKind;
    FUseAccentColor: Boolean;

    procedure SetThemeManager(const Value: TUThemeManager);
    procedure SetTextKind(const Value: TUTextKind);
    procedure SetUseAccentColor(const Value: Boolean);

    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;

  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // IUThemedComponent
    procedure UpdateTheme;
    function IsCustomThemed: Boolean;
    function CustomThemeManager: TUCustomThemeManager;

  published
    property ThemeManager: TUThemeManager read FThemeManager write SetThemeManager;
    property TextKind: TUTextKind read FTextKind write SetTextKind default tkNormal;
    property UseAccentColor: Boolean read FUseAccentColor write SetUseAccentColor default false;
  end;

implementation

uses
  UCL.Utils,
  UCL.Colors;

{ TUText }

//  MAIN CLASS

constructor TUText.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FThemeManager := Nil;

  //  New properties
  FTextKind := tkNormal;
  FUseAccentColor := False;

  Font.Name := 'Segoe UI';
  Font.Size := 10;

  if GetCommonThemeManager <> Nil then
    GetCommonThemeManager.Connect(Self);

//  UpdateTheme;
end;

destructor TUText.Destroy;
var
  TM: TUCustomThemeManager;
begin
  TM:=SelectThemeManager(Self);
  TM.Disconnect(Self);
  inherited;
end;

//  THEME

procedure TUText.SetThemeManager(const Value: TUThemeManager);
begin
  if (Value <> Nil) and (FThemeManager = Nil) then
    GetCommonThemeManager.Disconnect(Self);

  if (Value = Nil) and (FThemeManager <> Nil) then
    FThemeManager.Disconnect(Self);

  FThemeManager := Value;

  if FThemeManager <> Nil then
    FThemeManager.Connect(Self);

  if FThemeManager = Nil then
    GetCommonThemeManager.Connect(Self);

  UpdateTheme;
end;

procedure TUText.UpdateTheme;
var
  TM: TUCustomThemeManager;
begin
  TM:=SelectThemeManager(Self);
  //  Font color
  if not Enabled or (TextKind = tkDescription) then
    Font.Color := $666666
  else begin
    if UseAccentColor then
      Font.Color := SelectAccentColor(TM, $D77800)
    else if TM.ThemeUsed = utLight then
      Font.Color := $000000
    else
      Font.Color := $FFFFFF;
  end;
  if csDesigning in Self.ComponentState then
    Font.Color := GetTextColorFromBackground(Color);
  Repaint;
end;

function TUText.IsCustomThemed: Boolean;
begin
  Result:=(FThemeManager <> Nil);
end;

function TUText.CustomThemeManager: TUCustomThemeManager;
begin
  Result:=FThemeManager;
end;


procedure TUText.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FThemeManager) then begin
    ThemeManager:=Nil;
    Exit;
  end;
  inherited Notification(AComponent, Operation);
end;

//  SETTERS

procedure TUText.SetTextKind(const Value: TUTextKind);
begin
  if Value <> FTextKind then begin
    FTextKind := Value;

    if FTextKind <> tkCustom then begin
      if TextKind = tkEntry then
        Font.Name := 'Segoe UI Semibold'
      else
        Font.Name := 'Segoe UI';

      //  Font size
      case TextKind of
        tkNormal     : Font.Size := 10;
        tkDescription: Font.Size := 9;
        tkEntry      : Font.Size := 10;
        tkHeading    : Font.Size := 15;
        tkTitle      : Font.Size := 21;
      end;
    end;

    UpdateTheme;
  end;
end;

procedure TUText.SetUseAccentColor(const Value: Boolean);
begin
  if Value <> FUseAccentColor then begin
    FUseAccentColor := Value;
    UpdateTheme;
  end;
end;

procedure TUText.CMEnabledChanged(var Msg: TMessage);
begin
  UpdateTheme;
  inherited;
end;

end.

