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
  UCL.Types,
  UCL.Utils,
  UCL.Graphics,
  UCL.Colors;

type
  TUButton = class(TUCustomControl)
  private var
    BorderThickness: Integer;
    BorderColor, BackColor, TextColor: TColor;
    ImgRect, TextRect: TRect;

  private
    FBackColors: TUThemeButtonStateColorSet;
    FBorderColors: TUThemeButtonStateColorSet;
    FTextColors: TUThemeButtonStateColorSet;

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
    procedure Paint; override;
    procedure Resize; override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DoChangeScale(M, D: Integer); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    // IUThemedComponent
    procedure UpdateTheme; override;

  published
    property BackColors: TUThemeButtonStateColorSet read FBackColors;
    property BorderColors: TUThemeButtonStateColorSet read FBorderColors;
    property TextColors: TUThemeButtonStateColorSet read FTextColors;

    property ButtonState: TUControlState read FButtonState write SetButtonState default csNone;
    property Alignment: TAlignment read FAlignment write SetAlignment default taCenter;
    property Images: TCustomImageList read FImages write SetImages;
    property ImageIndex: Integer read FImageIndex write SetImageIndex default -1;
    property AllowFocus: Boolean read FAllowFocus write SetAllowFocus default True;
    property Highlight: Boolean read FHighlight write SetHighlight default false;
    property IsToggleButton: Boolean read FIsToggleButton write SetIsToggleButton default False;
    property IsToggled: Boolean read FIsToggled write SetIsToggled default False;
    property Transparent: Boolean read FTransparent write SetTransparent default False;

    property Caption;
    property Height default 30;
    property Width default 135;
    property TabStop default True;
  end;

implementation

uses
  UITypes,
  UCL.ThemeManager;

{ TUButton }

constructor TUButton.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  ControlStyle := ControlStyle - [csDoubleClicks];

  BorderThickness := 2;

  //  New properties
  FBackColors := TUThemeButtonStateColorSet.Create;
  //FBackColors.SetColors(utLight, $F2F2F2, $E6E6E6, $CCCCCC, $F2F2F2, $F2F2F2);
  FBackColors.Assign(BUTTON_BACK);


  FBorderColors := TUThemeButtonStateColorSet.Create;
//  FBorderColors.SetColors(utLight, $F2F2F2, $E6E6E6, $CCCCCC, $F2F2F2, $F2F2F2);
  FBorderColors.Assign(BUTTON_BORDER);

  FTextColors := TUThemeButtonStateColorSet.Create;
  FTextColors.SetColors(utLight, clBlack, clBlack, clBlack, clGray, clBlack);
  FTextColors.SetColors(utDark, clWhite, clWhite, clWhite, clGray, clWhite);

  FBackColors.OnChange := BackColorChange;
  FBorderColors.OnChange := BorderColorChange;
  FTextColors.OnChange := TextColorChange;

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
end;

destructor TUButton.Destroy;
begin
  FBackColors.Free;
  FBorderColors.Free;
  FTextColors.Free;
  inherited;
end;

// IUThemedComponent

procedure TUButton.UpdateTheme;
begin
  UpdateColors;
  UpdateRects;
  Invalidate;
end;

procedure TUButton.UpdateColors;
var
  TM: TUCustomThemeManager;
  AccentColor: TColor;
begin
  // Prepairing
  TM := SelectThemeManager(Self);
  AccentColor := SelectAccentColor(TM, clNone);

  // Disabled
  if not Enabled then begin
    BackColor   := BackColors.GetColor(TM.ThemeUsed, csDisabled);
    BorderColor := BorderColors.GetColor(TM.ThemeUsed, csDisabled);
    TextColor   := TextColors.GetColor(TM.ThemeUsed, csDisabled);
    Exit;
  end
  // Others
  else begin
    // Highlight
    // Is highlight button, or toggle on
    // Highlight only when mouse normal, hover and focused
    if (Highlight or (IsToggleButton and IsToggled)) and (ButtonState in [csNone, csHover, csFocused]) then begin
      BackColor := AccentColor;
      if (ButtonState = csHover) or (AllowFocus and Focused) then
        BorderColor := BrightenColor(BackColor, -32)
      else
        BorderColor := BackColor;
    end
    // Focused
    else if AllowFocus and Focused and (ButtonState = csFocused) then begin
      BackColor   := BackColors.GetColor(TM.ThemeUsed, ButtonState);
      BorderColor := BorderColors.GetColor(TM.ThemeUsed, ButtonState);
      TextColor   := TextColors.GetColor(TM.ThemeUsed, ButtonState);
      Exit;
    end
    // Transparent
    else if (ButtonState = csNone) and Transparent then begin
      ParentColor := True;
      BackColor := Color;
      BorderColor := Color;
    end
    // Default cases
    else begin
      //  Select style
      BackColor   := BackColors.GetColor(TM.ThemeUsed, ButtonState);
      BorderColor := BorderColors.GetColor(TM.ThemeUsed, ButtonState);
      TextColor   := TextColors.GetColor(TM.ThemeUsed, ButtonState);
      Exit;
    end;
    TextColor := GetTextColorFromBackground(BackColor);
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
    Invalidate;
  end;
end;

procedure TUButton.SetAlignment(const Value: TAlignment);
begin
  if Value <> FAlignment then begin
    FAlignment := Value;
    UpdateRects;
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

procedure TUButton.Paint;
var
  TM: TUCustomThemeManager;
  ImgX, ImgY: Integer;
  bmp: TBitmap;
  P: TPoint;
begin
//  inherited;
  TM:=SelectThemeManager(Self);
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

    if Enabled and FMouseInClient and not (csPaintCopy in ControlState) then
      DrawBumpMap(bmp.Canvas, P.X, Height div 2, TM.ThemeUsed = utDark);

    //  Paint image
    if (Images <> Nil) and (ImageIndex >= 0) then begin
      GetCenterPos(Images.Width, Images.Height, ImgRect, ImgX, ImgY);
      Images.Draw(bmp.Canvas, ImgX, ImgY, ImageIndex, Enabled);
    end;

    //  Paint text
    bmp.Canvas.Font.Assign(Font);
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

procedure TUButton.DoChangeScale(M, D: Integer);
begin
  BorderThickness := MulDiv(BorderThickness, M, D);
  UpdateRects;
end;

procedure TUButton.WMSetFocus(var Msg: TWMSetFocus);
begin
  if Enabled and AllowFocus then begin
    if CanFocus and not Focused then
      SetFocus;
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
    if IsToggleButton and PtInRect(GetClientRect, MousePoint) then
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

procedure TUButton.CMTextChanged(var Msg: TMessage);
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
