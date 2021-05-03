unit UCL.CheckBox;

interface

uses
  Classes,
  Messages,
  Windows,
  Controls,
  StdCtrls,
  Graphics,
  UCL.Classes,
  UCL.Utils,
  UCL.Graphics;

type
  TUCheckBoxState = (cbsUnchecked, cbsChecked, cbsGrayed);

  TUCheckBox = class(TUCustomControl)
  private var
    ActiveColor, TextColor: TColor;
    IconRect, TextRect, FocusRect: TRect;

  private const
    Space: Integer = 5;

  private
    FIconFont: TFont;
    FAutoSize: Boolean;
    FAllowGrayed: Boolean;
    FMultiline,
    FTransparent,
    FTextOnGlass: Boolean;
    FState: TUCheckBoxState;
    FCustomActiveColor: TColor;
    FOnChange: TNotifyEvent;

    // Internal
    procedure UpdateColors;
    procedure UpdateRects;
    procedure Toggle;

    // Getters / Setters
    function GetChecked: Boolean;
    procedure SetChecked(const Value: Boolean);
    procedure SetAutoSize(const Value: Boolean); reintroduce;
    procedure SetMultiline(const Value: Boolean);
    procedure SetTransparent(const Value: Boolean);
    procedure SetTextOnGlass(const Value: Boolean);
    procedure SetAllowGrayed(const Value: Boolean);
    procedure SetState(const Value: TUCheckBoxState);

    //  Messages
    procedure WMEraseBkgnd(var Msg: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
    procedure CMTextChanged(var Msg: TMessage); message CM_TEXTCHANGED;
    procedure CMFontChanged(var Msg: TMessage); message CM_FONTCHANGED;
    procedure CMParentFontChanged(var Msg: TCMParentFontChanged); message CM_PARENTFONTCHANGED;

  protected
    procedure Paint; override;
    procedure Resize; override;
    procedure DoChangeScale(M, D: Integer); override;
    procedure KeyPress(var Key: Char); override;

    function GetIconWidth: Integer; virtual;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // IUThemedComponent
    procedure UpdateTheme; override;

  published
    property IconFont: TFont read FIconFont write FIconFont;
    //
    property AutoSize: Boolean read FAutoSize write SetAutoSize default False;
    property AllowGrayed: Boolean read FAllowGrayed write SetAllowGrayed default False;
    property Checked: Boolean read GetChecked write SetChecked default False;
    property Multiline: Boolean read FMultiline write SetMultiline default False;
    property Transparent: Boolean read FTransparent write SetTransparent default True;
    property TextOnGlass: Boolean read FTextOnGlass write SetTextOnGlass default False;
    //
    property State: TUCheckBoxState read FState write SetState default cbsUnchecked;
    property CustomActiveColor: TColor read FCustomActiveColor write FCustomActiveColor default clDefault;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    //
    property Caption;
    property Color;
    property ParentColor default True;
    property Height default 30;
    property Width default 180;
    property TabOrder;
    property TabStop default True;
  end;

implementation

uses
  SysUtils,
  UITypes,
  Forms,
  UCL.ThemeManager,
  UCL.Colors,
  UCL.FontIcons;

{ TUCheckBox }

//  MAIN CLASS

constructor TUCheckBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csOpaque];

  FIconFont := TFont.Create;
  FIconFont.Name := 'Segoe MDL2 Assets';
  FIconFont.Size := 15;

  FAutoSize := False;
  FAllowGrayed := False;
  FMultiline := False;
  FTransparent := True;
  FTextOnGlass := False;
  FState := cbsUnchecked;
  FCustomActiveColor := clDefault; // $D77800 // Default blue

  ParentColor := True;
  ParentFont := True;
//  Font.Name := 'Segoe UI';
//  Font.Size := 10;

  Height := 30;
  Width := 180;
  TabStop := True;

  UpdateColors;
  UpdateRects;
end;

destructor TUCheckBox.Destroy;
begin
  FIconFont.Free;
  inherited;
end;

//  THEME

procedure TUCheckBox.UpdateTheme;
begin
  UpdateColors;
  UpdateRects;
  Repaint;
end;

//  INTERNAL

procedure TUCheckBox.UpdateColors;
var
  TM: TUCustomThemeManager;
begin
  //  Disabled
  if not Enabled or (csCreating in ControlState) then begin
    ActiveColor := $808080;
    TextColor := $808080;
    Exit;
  end;
  //
  TM := SelectThemeManager(Self);
  //  Active & text color
  if (CustomActiveColor <> clNone) and (CustomActiveColor <> clDefault) then begin
    ActiveColor := CustomActiveColor;
    if TM.ThemeUsed = utLight then
      TextColor := $000000
    else
      TextColor := $FFFFFF;
  end
  else if CustomActiveColor = clDefault then
    ActiveColor := SelectAccentColor(TM, clNone)
  else
    ActiveColor := SelectAccentColor(TM, CustomActiveColor);
  //
  if TM.ThemeUsed = utLight then
    TextColor := $000000
  else
    TextColor := $FFFFFF;
  //
  if IsDesigning then
    TextColor := GetTextColorFromBackground(Color);
end;

procedure TUCheckBox.UpdateRects;
var
  W: Integer;
begin
  W := GetIconWidth;
  IconRect := Rect(0, 0, W, Height);
  TextRect := Rect(W, 0, Width - 1, Height);
  FocusRect:= Rect(W - 1, 2, Width, Height - 2);
end;

procedure TUCheckBox.Toggle;
begin
  if not Enabled then
    Exit;
  //
  // Unchecked > (Grayed) > Checked > ...
  case State of
    cbsUnchecked: if AllowGrayed then
      State := cbsGrayed
    else
      State := cbsChecked;
    cbsChecked  : State := cbsUnchecked;
    cbsGrayed   : State := cbsChecked;
  end;
end;

// GETTERS / SETTERS

function TUCheckBox.GetChecked: Boolean;
begin
  Result := (State = cbsChecked);
end;

procedure TUCheckBox.SetChecked(const Value: Boolean);
begin
  if Value then
    State := cbsChecked
  else
    State := cbsUnchecked;
end;

procedure TUCheckBox.SetState(const Value: TUCheckBoxState);
begin
  if Value <> FState then begin
    if not AllowGrayed and (Value = cbsGrayed) then
      FState := cbsChecked
    else
      FState := Value;
    Invalidate;
    //
    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TUCheckBox.SetAllowGrayed(const Value: Boolean);
begin
  if Value <> FAllowGrayed then begin
    FAllowGrayed := Value;
    if not FAllowGrayed and (FState = cbsGrayed) then
      FState := cbsChecked;
    Repaint;
  end;
end;

procedure TUCheckBox.SetAutoSize(const Value: Boolean);
begin
  if Value <> FAutoSize then begin
    FAutoSize := Value;
    Invalidate;
  end;
end;

procedure TUCheckBox.SetMultiline(const Value: Boolean);
begin
  if Value <> FMultiline then begin
    FMultiline := Value;
    Repaint;
  end;
end;

procedure TUCheckBox.SetTransparent(const Value: Boolean);
begin
  if Value <> FTransparent then begin
    FTransparent := Value;
//    if Value then
//      ControlStyle := ControlStyle - [csOpaque]
//    else
//      ControlStyle := ControlStyle + [csOpaque];
    Repaint;
  end;
end;

procedure TUCheckBox.SetTextOnGlass(const Value: Boolean);
begin
  if Value <> FTextOnGlass then begin
    FTextOnGlass := Value;
    Repaint;
  end;
end;

// CUSTOM METHODS

procedure TUCheckBox.Paint;

  function DoGlassPaint: Boolean;
  var
    LParent: TWinControl;
  begin
    Result := csGlassPaint in ControlState;
    if Result then begin
      LParent := Parent;
      while (LParent <> Nil) and not LParent.DoubleBuffered do
        LParent := LParent.Parent;
      Result := (LParent = Nil) or not LParent.DoubleBuffered or (LParent is TCustomForm);
    end;
  end;

begin
  // Paint background
  if not Transparent then begin
    if not DoGlassPaint or not TextOnGlass then begin
//      PerformEraseBackground(Self, Canvas.Handle)
//    else begin
      //FillRect(Canvas.Handle, ClientRect, GetStockObject(BLACK_BRUSH));
      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Handle := CreateSolidBrushWithAlpha(Color, 255);
      Canvas.FillRect(Rect(0, 0, Width, Height));
    end;
  end;

  // Paint text
  Canvas.Brush.Style := bsClear;
  Canvas.Font.Assign(Font);
  Canvas.Font.Color := TextColor;
  DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, TextRect, Caption, Multiline, TextOnGlass);

  // Paint icon
  Canvas.Font.Assign(IconFont);
  Canvas.Font.Color := ActiveColor;
  case State of
    cbsChecked  : DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, IconRect, UF_CHECKBOX_CHECKED, Multiline, TextOnGlass);
    cbsUnchecked: DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, IconRect, UF_CHECKBOX_OUTLINE, Multiline, TextOnGlass);
    cbsGrayed   : begin
      DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, IconRect, UF_CHECKBOX_OUTLINE, Multiline, TextOnGlass);
      //
      Canvas.Font.Color := TextColor;
      DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, IconRect, UF_CHECKBOX_SMALL, Multiline, TextOnGlass);
    end;
  end;

  // Paint focus rect
  if not IsDesigning and (Focused or MouseInClient) then
    DrawFocusRect(Canvas, FocusRect, Color);
end;

procedure TUCheckBox.Resize;
var
  W, H: Integer;
  R: TRect;
begin
  if AutoSize and (Align = alNone) then begin
    H := GetIconWidth;
    Canvas.Font.Assign(Font);
    R := TextRect;
    MeasureTextRect(Canvas, taLeftJustify, taAlignTop, R, Caption, Multiline, TextOnGlass);
    W := R.Left + R.Width + 1;
    //
    SetBounds(Left, Top, W, H);
  end
  else
    inherited;
  UpdateRects;
end;

procedure TUCheckBox.DoChangeScale(M, D: Integer);
begin
  inherited DoChangeScale(M, D);
  if M = D then
    Exit;
  //
  IconFont.Height := MulDiv(IconFont.Height, M, D);
  Invalidate;
  Resize;   //  Autosize
end;

procedure TUCheckBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if Key = ' ' then
    Toggle;
end;

function TUCheckBox.GetIconWidth: Integer;
begin
  if HandleAllocated then begin
    Canvas.Font.Assign(IconFont);
    Result := Canvas.TextHeight(UF_RADIO_OUTLINE);
  end
  else
    Result := Height;
  Result := 2 * Space + Result;
end;

// MESSAGES

procedure TUCheckBox.WMEraseBkgnd(var Msg: TWmEraseBkgnd);
begin
  if Transparent then begin
    if (Parent <> Nil) and Parent.DoubleBuffered then
      PerformEraseBackground(Self, Msg.DC);
    DrawParentImage(Self, Msg.DC, False);
    Msg.Result := 1;
  end
  else
    inherited;
end;

procedure TUCheckBox.WMSetFocus(var Msg: TWMSetFocus);
var
  LFocused: Boolean;
begin
  LFocused:=Enabled and CanFocus;
  inherited;
  if LFocused then begin
    UpdateColors;
    Invalidate;
  end;
end;

procedure TUCheckBox.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  UpdateColors;
  Invalidate;
end;

procedure TUCheckBox.WMLButtonDown(var Msg: TWMLButtonDown);
begin
  if Enabled then begin
    if not Focused and CanFocus then
      SetFocus;
    inherited;
  end;
end;

procedure TUCheckBox.WMLButtonUp(var Msg: TWMLButtonUp);
begin
  if not Enabled then
    Exit;
  //
  if PtInRect(IconRect, Msg.Pos) then
    Toggle;
  inherited;
end;

procedure TUCheckBox.CMMouseEnter(var Msg: TMessage);
begin
  if Enabled then begin
    Invalidate;
    inherited;
  end;
end;

procedure TUCheckBox.CMMouseLeave(var Msg: TMessage);
begin
  if Enabled then begin
    Invalidate;
    inherited;
  end;
end;

procedure TUCheckBox.CMEnabledChanged(var Msg: TMessage);
begin
  UpdateColors;
  Repaint;
  inherited;
end;

procedure TUCheckBox.CMTextChanged(var Msg: TMessage);
begin
  inherited;
  Resize;
  Invalidate;
end;

procedure TUCheckBox.CMFontChanged(var Msg: TMessage);
begin
  inherited;
  Resize;
  Invalidate;
end;

procedure TUCheckBox.CMParentFontChanged(var Msg: TCMParentFontChanged);
begin
  inherited;
  Resize;
  Invalidate;
end;

end.
