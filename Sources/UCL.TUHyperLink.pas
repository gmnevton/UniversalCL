unit UCL.TUHyperLink;

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
  UCL.TUThemeManager;

type
  TUHyperLink = class(TLabel, IUThemeComponent)
  private const
    DefTextColor: TDefColor = (
      ($D77800, clGray, clMedGray, clMedGray, clGray),
      ($D77800, clMedGray, clGray, clGray, clMedGray)
    );

  private
    FThemeManager: TUThemeManager;
    FButtonState: TUControlState;
    FCustomTextColors: TControlStateColors;

    FEnabled: Boolean;  //  Must override Enabled, if not disabled style wrong on Dark theme
    FOpenLink: Boolean;
    FURL: string;

    //  Setters
    procedure SetThemeManager; // (const Value: TUThemeManager);
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
    //procedure Notification(AComponent: TComponent; Operation: TOperation); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure UpdateTheme;

  published
    property ThemeManager: TUThemeManager read FThemeManager; // write SetThemeManager;
    property ButtonState: TUControlState read FButtonState write SetButtonState default csNone;
    property CustomTextColors: TControlStateColors read FCustomTextColors write FCustomTextColors;

    property Enabled: Boolean read FEnabled write SetEnabled default true;
    property OpenLink: Boolean read FOpenLink write FOpenLink default true;
    property URL: string read FURL write FURL;

    property Cursor default crHandPoint;
  end;

implementation

{ TUHyperLink }

//  THEME

procedure TUHyperLink.SetThemeManager; // (const Value: TUThemeManager);
begin
  FThemeManager := GetCommonThemeManager;
  UpdateTheme;
end;

procedure TUHyperLink.UpdateTheme;
begin
  if ThemeManager = Nil then
    Font.Color := CustomTextColors.GetStateColor(ButtonState)
  else begin
    if ButtonState = csNone then
      Font.Color := ThemeManager.AccentColor
    else
      Font.Color := DefTextColor[ThemeManager.Theme, ButtonState];
  end;
end;
{
procedure TUHyperLink.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FThemeManager) then
    FThemeManager := nil;
end;
}
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

//  MAIN CLASS

constructor TUHyperLink.Create(AOwner: TComponent);
begin
  inherited Create(aOwner);
  FThemeManager := Nil;

  FButtonState := csNone;
  FCustomTextColors := TControlStateColors.Create($D77800, clGray, clMedGray, clMedGray, $D77800);
  FCustomTextColors.OnChange := DoCustomTextColorsChange;

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
begin
  FCustomTextColors.Free;
  if FThemeManager <> Nil then
    FThemeManager.Disconnect(Self);
  inherited;
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
      ShellExecute(0, '', PWideChar(URL), '', '', SW_SHOWNORMAL);
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
