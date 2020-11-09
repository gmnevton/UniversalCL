unit UCL.HyperLink;

interface

{$IF CompilerVersion > 29}
  {$LEGACYIFEND ON}
{$IFEND}

uses
  Classes,
{$IF CompilerVersion <= 30}
  Dialogs,
{$ELSE}
  UITypes,
{$IFEND}
  Windows,
  Messages,
  Shellapi,
  Controls,
  StdCtrls,
  Graphics,
  UCL.Classes,
  UCL.Types,
  UCL.Colors,
  UCL.ThemeManager;

type
  TUHyperLink = class(TLabel, IUThemedComponent)
  private
    FThemeManager: TUThemeManager;
    FButtonState: TUControlState;
    FTextColors: TUThemeFocusableControlStateColors;

    FEnabled: Boolean;  //  Must override Enabled, if not disabled style wrong on Dark theme
    FOpenLink: Boolean;
    FURL: string;

    //  Setters
    procedure SetThemeManager(const Value: TUThemeManager);
    procedure SetButtonState(const Value: TUControlState);
    procedure SetEnabled(const Value: Boolean); reintroduce;

    //  Messages
    procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;

    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;

    //  Group property change
    procedure DoCustomTextColorsChange(Sender: TObject);

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
    property ButtonState: TUControlState read FButtonState write SetButtonState default csNone;
    property TextColors: TUThemeFocusableControlStateColors read FTextColors;

    property Enabled: Boolean read FEnabled write SetEnabled default true;
    property OpenLink: Boolean read FOpenLink write FOpenLink default true;
    property URL: string read FURL write FURL;

    property Cursor default crHandPoint;
  end;

implementation

{ TUHyperLink }

//  MAIN CLASS

constructor TUHyperLink.Create(AOwner: TComponent);
begin
  inherited Create(aOwner);
  FThemeManager := Nil;

  FButtonState := csNone;
  FTextColors := TUThemeFocusableControlStateColors.Create;
  FTextColors.SetColors(utLight, $D77800, clBlue, clMedGray, clGray, $D77800);
  FTextColors.SetColors(utDark,  $D77800, clBlue, clMedGray, clGray, $D77800);
  FTextColors.OnChange := DoCustomTextColorsChange;

  FEnabled := true;
  FOpenLink := true;
  FURL := 'https://embarcadero.com/';

//  Caption := 'Embarcadero website';

  Cursor := crHandPoint;

//  Font.Name := 'Segoe UI';
//  Font.Size := 10;

  if GetCommonThemeManager <> Nil then
    GetCommonThemeManager.Connect(Self);

//  UpdateTheme;
end;

destructor TUHyperLink.Destroy;
var
  TM: TUCustomThemeManager;
begin
  FTextColors.Free;
  TM:=SelectThemeManager(Self);
  TM.Disconnect(Self);
  inherited;
end;

//  THEME

procedure TUHyperLink.SetThemeManager(const Value: TUThemeManager);
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

procedure TUHyperLink.UpdateTheme;
var
  TM: TUCustomThemeManager;
begin
  TM:=SelectThemeManager(Self);
  if ButtonState = csNone then
    Font.Color := TM.AccentColor
  else
    Font.Color := TextColors.GetColor(TM.ThemeUsed, ButtonState);
  Repaint;
end;

function TUHyperLink.IsCustomThemed: Boolean;
begin
  Result:=(FThemeManager <> Nil);
end;

function TUHyperLink.CustomThemeManager: TUCustomThemeManager;
begin
  Result:=FThemeManager;
end;

procedure TUHyperLink.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FThemeManager) then begin
    ThemeManager:=Nil;
    Exit;
  end;
  inherited Notification(AComponent, Operation);
end;

//  SETTERS

procedure TUHyperLink.SetButtonState(const Value: TUControlState);
begin
  if Value <> FButtonState then begin
    FButtonState := Value;
    UpdateTheme;
  end;
end;

procedure TUHyperLink.SetEnabled(const Value: Boolean);
begin
  if Value <> FEnabled then begin
    FEnabled := Value;
    if not FEnabled then begin
      FButtonState := csDisabled;
      Cursor := crDefault;
    end
    else begin
      FButtonState := csNone;
      Cursor := crHandPoint;
    end;
    UpdateTheme;
  end;
end;

//  MESSAGES

procedure TUHyperLink.WMLButtonDblClk(var Msg: TWMLButtonDblClk);
begin
  if Enabled then begin
    ButtonState := csPress;
    inherited;
  end;
end;

procedure TUHyperLink.WMLButtonDown(var Msg: TWMLButtonDown);
begin
  if Enabled then begin
    ButtonState := csPress;
    inherited;
  end;
end;

procedure TUHyperLink.WMLButtonUp(var Msg: TWMLButtonUp);
begin
  if Enabled then begin
    if OpenLink then
      ShellExecute(0, 'open', PWideChar(URL), '', '', SW_SHOWNORMAL);
    ButtonState := csHover;
    inherited;
  end;
end;

procedure TUHyperLink.CMMouseEnter(var Msg: TMessage);
begin
  if Enabled then begin
    ButtonState := csHover;
    inherited;
  end;
end;

procedure TUHyperLink.CMMouseLeave(var Msg: TMessage);
begin
  if Enabled then begin
    ButtonState := csNone;
    inherited;
  end;
end;

//  GROUP PROPERTY CHANGED

procedure TUHyperLink.DoCustomTextColorsChange(Sender: TObject);
begin
  UpdateTheme;
end;

end.
