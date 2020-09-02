unit UCL.Button;

interface

{$IF CompilerVersion > 29}
  {$LEGACYIFEND ON}
{$IFEND}

uses
  SysUtils,
  Windows,
  Messages,
  Classes,
  Types,
  Controls,
  Graphics,
  ImgList,
  UCL.Classes,
  UCL.ThemeManager,
  UCL.Utils,
  UCL.Graphics,
  UCL.Colors;

type
  TUButton = class(TUCustomControl, IUThemedComponent)
  private var
    BorderThickness: Integer;
    BorderColor, BackColor, TextColor: TColor;
    ImgRect, TextRect: TRect;

  private
    FThemeManager: TUThemeManager;
    FBackColor: TControlStateColors;
    FBorderColor: TControlStateColors;
    FTextColor: TControlStateColors;

    FButtonState: TUControlState;
    FAlignment: TAlignment;
    FImages: TCustomImageList;
    FImageIndex: Integer;
    FAllowFocus: Boolean;
    FHighlight: Boolean;
    FIsToggleButton: Boolean;
    FIsToggled: Boolean;
    FTransparent: Boolean;
    FMouseInClient: Boolean;

    // Internal
    procedure UpdateColors;
    procedure UpdateRects;

    // Setters
    procedure SetThemeManager; // (const Value: TUThemeManager);
    procedure SetButtonState(const Value: TUControlState);
    procedure SetAlignment(const Value: TAlignment);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetImageIndex(const Value: Integer);
    procedure SetAllowFocus(const Value: Boolean);
    procedure SetHighlight(const Value: Boolean);
    procedure SetIsToggleButton(const Value: Boolean);
    procedure SetIsToggled(const Value: Boolean);
    procedure SetTransparent(const Value: Boolean);

    // Messages
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;

    //procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMMouseMove(var Msg: TWMMouseMove); message WM_MOUSEMOVE;

    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
    procedure CMDialogKey(var Msg: TCMDialogKey); message CM_DIALOGKEY;
    procedure CMTextChanged(var Msg: TMessage); message CM_TEXTCHANGED;

    // Childs property change events
    procedure BackColorChange(Sender: TObject);
    procedure BorderColorChange(Sender: TObject);
    procedure TextColorChange(Sender: TObject);

  protected
    //procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure Resize; override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND}); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    // IUThemedComponent
    procedure UpdateTheme;

  published
    property ThemeManager: TUThemeManager read FThemeManager; // write SetThemeManager;
    property BackColors: TControlStateColors read FCustomBackColors write FCustomBackColors;
    property BorderColors: TControlStateColors read FCustomBorderColors write FCustomBorderColors;
    property TextColors: TControlStateColors read FCustomTextColors write FCustomTextColors;

    property ButtonState: TUControlState read FButtonState write SetButtonState default csNone;
    property Alignment: TAlignment read FAlignment write SetAlignment default taCenter;
    property Images: TCustomImageList read FImages write SetImages;
    property ImageIndex: Integer read FImageIndex write SetImageIndex default -1;
    property AllowFocus: Boolean read FAllowFocus write SetAllowFocus default True;
    property Highlight: Boolean read FHighlight write SetHighlight default false;
    property IsToggleButton: Boolean read FIsToggleButton write SetIsToggleButton default False;
    property IsToggled: Boolean read FIsToggled write SetIsToggled default False;
    property Transparent: Boolean read FTransparent write SetTransparent default False;

    property Height default 30;
    property Width default 135;
    property TabStop default True;
  end;

implementation

{ TUButton }

// IUThemedComponent

procedure TUButton.SetThemeManager; // (const Value: TUThemeManager);
begin
  FThemeManager := GetCommonThemeManager;
  UpdateTheme;
end;

procedure TUButton.UpdateTheme;
begin
  UpdateColors;
  UpdateRects;
  Invalidate;
end;
{
procedure TUButton.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FThemeManager) then
    FThemeManager := nil;
end;
}

procedure TUButton.UpdateColors;
begin
  //  Not connect ThemeManager, use custom colors
  if ThemeManager = Nil then begin
    BackColor   := BackColors.GetStateColor(ButtonState);
    BorderColor := BorderColors.GetStateColor(ButtonState);
    TextColor   := TextColors.GetStateColor(ButtonState);
  end
  //  Highlight button
  else if (Highlight or (IsToggleButton and IsToggled)) and //  Is highlight button, or toggle on
          (ButtonState in [csNone, csHover, csFocused]) then begin //  Highlight only when mouse normal, hover and focused
    BackColor := ThemeManager.AccentColor;
    if ButtonState = csNone then
      BorderColor := BackColor
    else
      BorderColor := MulColor(BackColor, 0.6);
    TextColor := GetTextColorFromBackground(BackColor);
  end
  //  Default colors
  else begin
    BackColor   := DefBackColor[ThemeManager.Theme, ButtonState];
    BorderColor := DefBorderColor[ThemeManager.Theme, ButtonState];
    TextColor   := DefTextColor[ThemeManager.Theme, ButtonState];
  end;

  //  Transparent
  if (ButtonState = csNone) and Transparent then begin
    ParentColor := True;
    BackColor := Color;
    BorderColor := Color; //  The same background, because of button state
    TextColor := GetTextColorFromBackground(Color);
  end;
end;

procedure TUButton.UpdateRects;
begin
  //  Calc rects
  if (Images <> Nil) and (ImageIndex >= 0) then begin
    ImgRect := Rect(0, 0, Height, Height);  //  Square left align
    TextRect := Rect(Height, 0, Width, Height);
  end
  else
    TextRect := Rect(0, 0, Width, Height);
end;

procedure TUButton.SetButtonState(const Value: TUControlState);
begin
  if Value <> FButtonState then begin
    FButtonState := Value;
    UpdateColors;
    Invalidate;;
  end;
end;

procedure TUButton.SetAlignment(const Value: TAlignment);
begin
  if Value <> FAlignment then begin
    FAlignment := Value;
    Invalidate;
  end;
end;

procedure TUButton.SetImages(const Value: TCustomImageList);
begin
  if Value <> FImages then begin
    FImages := Value;
    UpdateRects;
    Invalidate;
  end;
end;

procedure TUButton.SetImageIndex(const Value: Integer);
begin
  if Value <> FImageIndex then begin
    FImageIndex := Value;
    UpdateRects;
    Invalidate;
  end;
end;

procedure TUButton.SetAllowFocus(const Value: Boolean);
begin
  if Value <> FAllowFocus then begin
    FAllowFocus := Value;
    UpdateColors;
    Invalidate;
  end;
end;

procedure TUButton.SetHighlight(const Value: Boolean);
begin
  if Value <> FHighlight then begin
    FHighlight := Value;
    UpdateColors;
    Invalidate;
  end;
end;

procedure TUButton.SetIsToggleButton(const Value: Boolean);
begin
  if Value <> FIsToggleButton then begin
    FIsToggleButton := Value;
    UpdateColors;
    Invalidate;
  end;
end;

procedure TUButton.SetIsToggled(const Value: Boolean);
begin
  if Value <> FIsToggled then begin
    FIsToggled := Value;
    UpdateColors;
    Invalidate;
  end;
end;

procedure TUButton.SetTransparent(const Value: Boolean);
begin
  if Value <> FTransparent then begin
    FTransparent := Value;
    UpdateColors;
    Invalidate;
  end;
end;

constructor TUButton.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  ControlStyle := ControlStyle - [csDoubleClicks];
  
  FThemeManager := Nil;

  BorderThickness := 2;

  //  New properties
  FBackColors := TControlStateColors.Create($F2F2F2, $E6E6E6, $CCCCCC, $F2F2F2, $F2F2F2);
  FBorderColors := TControlStateColors.Create($F2F2F2, $E6E6E6, $CCCCCC, $F2F2F2, $F2F2F2);
  FTextColors := TControlStateColors.Create(clBlack, clBlack, clBlack, clGray, clBlack);

  FBackColors.OnChange := DoCustomBackColorsChange;
  FBorderColors.OnChange := DoCustomBorderColorsChange;
  FTextColors.OnChange := DoCustomTextColorsChange;

  FButtonState := csNone;
  FAlignment := taCenter;
  FImageIndex := -1;
  FAllowFocus := True;
  FHighlight := False;
  FIsToggleButton := False;
  FIsToggled := False;
  FTransparent := False;

  //  Property
  Height := 30;
  Width := 135;
//  Font.Name := 'Segoe UI';
//  Font.Size := 10;
  TabStop := True;

  InitBumpMap;

  if GetCommonThemeManager <> Nil then
    GetCommonThemeManager.Connect(Self);
end;

destructor TUButton.Destroy;
begin
  FCustomBorderColors.Free;
  FCustomBackColors.Free;
  FCustomTextColors.Free;
  if FThemeManager <> Nil then
    FThemeManager.Disconnect(Self);
  inherited;
end;

procedure TUButton.Paint;
var
  ImgX, ImgY: Integer;
  bmp: TBitmap;
  P: TPoint;
begin
  inherited;

  bmp := TBitmap.Create;
  try
    bmp.SetSize(Width, Height);
    //bmp.Canvas.Assign(Canvas);

    //  Paint background
    bmp.Canvas.Brush.Handle := CreateSolidBrushWithAlpha(BackColor, 255);
    bmp.Canvas.FillRect(Rect(0, 0, Width, Height));

    P:=Mouse.CursorPos;
    P:=ScreenToClient(P);

    //  Draw border
    DrawBorder(bmp.Canvas, Rect(0, 0, Width, Height), BorderColor, BorderThickness);

    if Enabled and FMouseInClient then
      DrawBumpMap(bmp.Canvas, P.X, Height div 2);

    //  Paint image
    if (Images <> Nil) and (ImageIndex >= 0) then begin
      GetCenterPos(Images.Width, Images.Height, ImgRect, ImgX, ImgY);
      Images.Draw(bmp.Canvas, ImgX, ImgY, ImageIndex, Enabled);
    end;

    //  Paint text
    bmp.Canvas.Font := Font;
    bmp.Canvas.Font.Color := TextColor;
    DrawTextRect(bmp.Canvas, Alignment, taVerticalCenter, TextRect, Caption, False);

    //
    Canvas.Draw(0, 0, bmp);
  finally
    bmp.Free;
  end;
end;

procedure TUButton.Resize;
begin
  inherited;
  UpdateRects;
end;

procedure TUButton.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  UpdateColors;
  UpdateRects;
end;

procedure TUButton.ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND});
begin
  inherited;
  BorderThickness := MulDiv(BorderThickness, M, D);
  UpdateRects;
end;

procedure TUButton.WMSetFocus(var Msg: TWMSetFocus);
begin
  if Enabled and AllowFocus then begin
    ButtonState := csFocused;
    inherited;
  end;
end;

procedure TUButton.WMKillFocus(var Msg: TWMKillFocus);
begin
  if Enabled then begin
    ButtonState := csNone;
    inherited;
  end;
end;

{
procedure TUButton.WMLButtonDblClk(var Msg: TWMLButtonDblClk);
begin
  if Enabled then begin
    ButtonState := csPress;
    inherited;
  end;
end;
}

procedure TUButton.WMLButtonDown(var Msg: TWMLButtonDown);
begin
  if Enabled then begin
    if AllowFocus then
      SetFocus;
    ButtonState := csPress;
    inherited;
  end;
end;

procedure TUButton.WMLButtonUp(var Msg: TWMLButtonUp);
var
  MousePoint: TPoint;
begin
  if Enabled then begin
    MousePoint := ScreenToClient(Mouse.CursorPos);
    if IsToggleButton and PtInRect(GetClientRect, MousePoint) then begin
      FIsToggled := not FIsToggled;
    ButtonState := csHover;
    inherited;
  end;
end;

procedure TUButton.WMMouseMove(var Msg: TWMMouseMove);
begin
  if Enabled then
    Invalidate;
  inherited;
end;

procedure TUButton.CMMouseEnter(var Msg: TMessage);
begin
  FMouseInClient := True;
  if Enabled then begin
    ButtonState := csHover;
    inherited;
  end;
end;

procedure TUButton.CMMouseLeave(var Msg: TMessage);
begin
  FMouseInClient := False;
  if Enabled then begin
    //  Dont allow focus
    if not AllowFocus then
      ButtonState := csNone //  No keep border

    //  Allow focus
    else if not Focused then
      ButtonState := csNone //  No focus, no border
    else
      ButtonState := csFocused; //  Keep focus border

    inherited;
  end;
end;

procedure TUButton.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;
  if not Enabled then
    FButtonState := csDisabled
  else
    FButtonState := csNone;
  UpdateColors;
  Invalidate;
end;

procedure TUButton.CMDialogKey(var Msg: TWMKey);
begin
  if AllowFocus and Focused and (Msg.CharCode = VK_RETURN) then begin
    Click;
    Msg.Result := 1;
  end
  else
    inherited;
end;

procedure TUButton.CM_TextChanged(var Msg: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TUButton.BackColorChange(Sender: TObject);
begin
  UpdateColors;
  Invalidate;
end;

procedure TUButton.BorderColorChange(Sender: TObject);
begin
  UpdateColors;
  Invalidate;
end;

procedure TUButton.TextColorChange(Sender: TObject);
begin
  UpdateColors;
  Invalidate;
end;

end.
