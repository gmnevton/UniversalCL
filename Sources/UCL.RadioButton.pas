unit UCL.RadioButton;

interface

uses
  Classes,
  Messages,
  Windows,
  Controls,
  StdCtrls,
  Graphics,
  UCL.Classes,
  UCL.Types,
  UCL.Utils,
  UCL.Graphics;

type
  TURadioButton = class(TUCustomControl)
  private var
    ActiveColor, TextColor: TColor;
    IconRect, TextRect, FocusRect: TRect;

  private const
    Space: Integer = 5;

  private
    FIconFont: TFont;
    FAutoSize: Boolean;
    //FButtonState: TUControlState;
    FChecked: Boolean;
    FGroup: string;
    FCustomActiveColor: TColor;
    FMultiline,
    FTransparent,
    FTextOnGlass: Boolean;
    FUpdating: Boolean;

    //  Internal
    procedure UpdateColors;
    procedure UpdateRects;
    procedure FontChanged(Sender: TObject);

    //  Setters
    procedure SetIconFont(Value: TFont);
    procedure SetAutoSize(const Value: Boolean); reintroduce;
    //procedure SetButtonState(const Value: TUControlState);
    procedure SetChecked(const Value: Boolean);
    procedure SetMultiline(const Value: Boolean);
    procedure SetTransparent(const Value: Boolean);
    procedure SetTextOnGlass(const Value: Boolean);

    //  Messages
    procedure WMEraseBkgnd(var Msg: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
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
    property IconFont: TFont read FIconFont write SetIconFont;
    //
    property AutoSize: Boolean read FAutoSize write SetAutoSize default False;
    //property ButtonState: TUControlState read FButtonState write SetButtonState default csNone;
    property Checked: Boolean read FChecked write SetChecked default False;
    property Group: string read FGroup write FGroup;
    property CustomActiveColor: TColor read FCustomActiveColor write FCustomActiveColor default clDefault;
    property Multiline: Boolean read FMultiline write SetMultiline default False;
    property Transparent: Boolean read FTransparent write SetTransparent default True;
    property TextOnGlass: Boolean read FTextOnGlass write SetTextOnGlass default False;
    //
    property Caption;
    property Color;
    property ParentColor default true;
    property Height default 30;
    property Width default 180;
    property TabOrder;
    property TabStop default True;
  end;

implementation

uses
  SysUtils,
  Forms,
  UITypes,
//  Themes,
//  UxTheme,
//  DwmApi,
  UCL.ThemeManager,
  UCL.Colors,
  UCL.FontIcons;

{ TURadioButton }

//  MAIN CLASS

constructor TURadioButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csOpaque];

  //  New props
  FAutoSize := False;
  //FButtonState := csNone;
  FChecked := False;
  FCustomActiveColor := clDefault; // $D77800;
  FMultiline := False;
  FTransparent := True;
  FTextOnGlass := False;
  FUpdating := False;

  FIconFont := TFont.Create;
  FIconFont.Name := 'Segoe MDL2 Assets';
  FIconFont.Size := 15;
  FIconFont.OnChange := FontChanged;

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

destructor TURadioButton.Destroy;
begin
  FIconFont.Free;
  inherited;
end;

//  THEME

procedure TURadioButton.UpdateTheme;
begin
  UpdateColors;
  UpdateRects;
  Repaint;
end;

//  INTERNAL

procedure TURadioButton.UpdateColors;
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

procedure TURadioButton.UpdateRects;
var
  W: Integer;
begin
  W := GetIconWidth;
  if W = -1 then
    Exit;
  //
  IconRect := Rect(0, 0, W, Height);
  TextRect := Rect(W, 0, Width - 1, Height);
  FocusRect:= Rect(W - 1, 2, Width, Height - 2);
end;

procedure TURadioButton.FontChanged(Sender: TObject);
begin
  if FUpdating then
    Exit;
  //
  UpdateRects;
  Repaint;
end;

//  SETTERS

procedure TURadioButton.SetIconFont(Value: TFont);
begin
  FIconFont.Assign(Value);
end;

procedure TURadioButton.SetAutoSize(const Value: Boolean);
begin
  if Value <> FAutoSize then begin
    FAutoSize := Value;
    Resize;
  end;
end;
{
procedure TURadioButton.SetButtonState(const Value: TUControlState);
begin
  if Value <> FButtonState then begin
    FButtonState := Value;
    UpdateColors;
    Repaint;
  end;
end;
}
procedure TURadioButton.SetChecked(const Value: Boolean);

  procedure TurnSiblingsOff;
  var
    I: Integer;
    Sibling: TControl;
  begin
    if Parent <> Nil then begin
      for I:= 0 to Parent.ControlCount - 1 do begin
        Sibling := Parent.Controls[I];
        if (Sibling <> Self) and (Sibling is TURadioButton) and (TURadioButton(Sibling).Group = Group) then
          TURadioButton(Sibling).SetChecked(False);
      end;
    end;
  end;

begin
  if Value <> FChecked then begin
    FChecked := Value;
    //  Uncheck all items with the same group
    if Value then
      TurnSiblingsOff;
    Invalidate;
    //
    Click;
//    if Assigned(FOnChange) then
//      FOnChange(Self);
  end;
end;

procedure TURadioButton.SetMultiline(const Value: Boolean);
begin
  if Value <> FMultiline then begin
    FMultiline := Value;
    Repaint;
  end;
end;

procedure TURadioButton.SetTransparent(const Value: Boolean);
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

procedure TURadioButton.SetTextOnGlass(const Value: Boolean);
begin
  if Value <> FTextOnGlass then begin
    FTextOnGlass := Value;
    Repaint;
  end;
end;

//  CUSTOM METHODS

procedure TURadioButton.Paint;

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
  if not Checked then
    DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, IconRect, UF_RADIO_OUTLINE, Multiline, TextOnGlass)
  else begin
    DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, IconRect, UF_RADIO_OUTLINE, Multiline, TextOnGlass);
    //
    Canvas.Font.Color := TextColor;
    DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, IconRect, UF_RADIO_SMALL, Multiline, TextOnGlass);
  end;

  // Paint focus rect
  if not IsDesigning and (Focused or MouseInClient) then
    DrawFocusRect(Canvas, FocusRect, Color);
end;

procedure TURadioButton.Resize;
var
  W, H{, L}: Integer;
  R: TRect;
begin
  if AutoSize and (Align = alNone) then begin
    H := GetIconWidth;
    if H > -1 then begin
      Canvas.Font.Assign(Font);
      R := Rect(H, 0, Width - 1, Height);
      MeasureTextRect(Canvas, taLeftJustify, taAlignTop, R, Caption, Multiline, TextOnGlass);
      W := R.Left + R.Width + 1;
      //
      SetBounds(Left, Top, W, H);
    end;
  end
  else begin
    inherited;
    // ensure that all sizes are good when not autosize and multiline
//    if Multiline then begin
//      L := GetIconWidth;
//      if L > -1 then begin
//        Canvas.Font.Assign(Font);
//        R := Rect(L, 0, Width - 1, Height);
//        MeasureTextRect(Canvas, taLeftJustify, taAlignTop, R, Caption, Multiline, TextOnGlass);
//        W := Width;
//        H := Height;
//        if W < (R.Left + R.Width + 1) then
//          W := R.Left + R.Width + 1;
//        if H < R.Height then
//          H := R.Height;
//        //
//        if (W <> Width) or (H <> Height) then
//          SetBounds(Left, Top, W, H);
//      end;
//    end;
  end;
  UpdateRects;
end;

procedure TURadioButton.DoChangeScale(M, D: Integer);
begin
  inherited DoChangeScale(M, D);
  if M = D then
    Exit;
  //
  FUpdating := True;
  try
    IconFont.Height := MulDiv(IconFont.Height, M, D);
    Invalidate;
    Resize;   //  Autosize
  finally
    FUpdating := False;
  end;
end;

procedure TURadioButton.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (Key = ' ') and not Checked then
    Checked := True;
end;

function TURadioButton.GetIconWidth: Integer;
begin
  if HandleAllocated then begin
    Canvas.Font.Assign(IconFont);
    Result := Canvas.TextHeight(UF_RADIO_OUTLINE);
  end
  else begin
    Result := -1;
    Exit;
  end;
  Result := 2 * Space + Result;
end;

//  MESSAGES

procedure TURadioButton.WMEraseBkgnd(var Msg: TWmEraseBkgnd);
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

procedure TURadioButton.WMSetFocus(var Msg: TWMSetFocus);
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

procedure TURadioButton.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  UpdateColors;
  Invalidate;
end;

procedure TURadioButton.WMLButtonDown(var Msg: TWMLButtonDown);
begin
  if Enabled then begin
    if not Focused and CanFocus then
      SetFocus;
    inherited;
  end;
end;

procedure TURadioButton.WMLButtonUp(var Msg: TWMLButtonUp);
begin
  if not Enabled then
    Exit;
  //
  if PtInRect(IconRect, Msg.Pos) then
    Checked := True;
  inherited;
end;

procedure TURadioButton.WMLButtonDblClk(var Msg: TWMLButtonDblClk);
begin
  if not Enabled then
    Exit;
  //
  //if PtInRect(IconRect, Msg.Pos) then
    Checked := True;
  inherited;
end;

procedure TURadioButton.CMMouseEnter(var Msg: TMessage);
begin
  if Enabled then begin
    Invalidate;
    inherited;
  end;
end;

procedure TURadioButton.CMMouseLeave(var Msg: TMessage);
begin
  if Enabled then begin
    Invalidate;
    inherited;
  end;
end;

procedure TURadioButton.CMEnabledChanged(var Msg: TMessage);
begin
  UpdateColors;
  Repaint;
  inherited;
end;

procedure TURadioButton.CMTextChanged(var Msg: TMessage);
begin
  inherited;
  Resize;
  Invalidate;
end;

procedure TURadioButton.CMFontChanged(var Msg: TMessage);
begin
  inherited;
  Resize;
  Invalidate;
end;

procedure TURadioButton.CMParentFontChanged(var Msg: TCMParentFontChanged);
begin
  inherited;
  Resize;
  Invalidate;
end;

end.
