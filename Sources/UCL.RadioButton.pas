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

  private
    FIconFont: TFont;
    FAutoSize: Boolean;
    //FButtonState: TUControlState;
    FChecked: Boolean;
    FGroup: string;
    FCustomActiveColor: TColor;
    FMultiline,
    FTextOnGlass: Boolean;
    FOnChange: TNotifyEvent;

    //  Internal
    procedure UpdateColors;
    procedure UpdateRects;

    //  Setters
    procedure SetAutoSize(const Value: Boolean); reintroduce;
    //procedure SetButtonState(const Value: TUControlState);
    procedure SetChecked(const Value: Boolean);
    procedure SetMultiline(const Value: Boolean);
    procedure SetTextOnGlass(const Value: Boolean);

    //  Messages
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;

  protected
    procedure DoChangeScale(M, D: Integer); override;
    procedure Paint; override;
    procedure Resize; override;
    procedure KeyPress(var Key: Char); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // IUThemedComponent
    procedure UpdateTheme; override;

  published
    property IconFont: TFont read FIconFont write FIconFont;
    //
    property AutoSize: Boolean read FAutoSize write SetAutoSize default False;
    //property ButtonState: TUControlState read FButtonState write SetButtonState default csNone;
    property Checked: Boolean read FChecked write SetChecked default False;
    property Group: string read FGroup write FGroup;
    property CustomActiveColor: TColor read FCustomActiveColor write FCustomActiveColor default clDefault;
    property Multiline: Boolean read FMultiline write SetMultiline default False;
    property TextOnGlass: Boolean read FTextOnGlass write SetTextOnGlass default False;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
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
  UCL.ThemeManager,
  UCL.Colors,
  UCL.FontIcons;

{ TURadioButton }

//  MAIN CLASS

constructor TURadioButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  //  New props
  FAutoSize := False;
  //FButtonState := csNone;
  FChecked := False;
  FCustomActiveColor := clDefault; // $D77800;
  FMultiline := False;
  FTextOnGlass := False;

  FIconFont := TFont.Create;
  FIconFont.Name := 'Segoe MDL2 Assets';
  FIconFont.Size := 15;

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
begin
  IconRect := Rect(0, 0, Height, Height);
  TextRect := Rect(Height, 0, Width - 2, Height);
  FocusRect:= Rect(Height - 3, 2, Width, Height - 2);
end;

//  SETTERS

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
    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TURadioButton.SetMultiline(const Value: Boolean);
begin
  if Value <> FMultiline then begin
    FMultiline := Value;
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

procedure TURadioButton.DoChangeScale(M, D: Integer);
begin
  inherited DoChangeScale(M, D);
//  Width := MulDiv(Width, M, D);
//  Font.Height := MulDiv(Font.Height, M, D);
  IconFont.Height := MulDiv(IconFont.Height, M, D);
  Resize;   //  Autosize
  //UpdateRects;  //  Do not update rects, resize already do that
end;

procedure TURadioButton.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (Key = ' ') and not Checked then
    Checked := True;
end;

procedure TURadioButton.Paint;
begin
  // Paint background
  if not TextOnGlass then begin
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Handle := CreateSolidBrushWithAlpha(Color, 255);
    Canvas.FillRect(Rect(0, 0, Width, Height));
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
  if not IsDesigning and (Focused or MouseInClient) then begin
    DrawFocusRect(Canvas, FocusRect, Color);
    //Canvas.Font.Color := GetTextColorFromBackground(Color);
    //Canvas.Pen.Style := psDot;
    //Canvas.Pen.Color := GetTextColorFromBackground(Color);
    //DrawFocusRect(Canvas.Handle, FocusRect);
    //Canvas.Pen.Style := psClear;
    //Canvas.Pen.Color := Color;
  end;
end;

procedure TURadioButton.Resize;
var
  Space, W, H: Integer;
  R: TRect;
//  ParentForm: TCustomForm;
begin
//  ParentForm := GetParentForm(Self, True);
  if AutoSize and (Align = alNone) then begin
    Space := 5;
    Canvas.Font.Assign(IconFont);
    W := Canvas.TextHeight(UF_RADIO_OUTLINE);
    H := 2 * Space + W;
//    Canvas.Font.Assign(Font);
    R := TextRect;
    MeasureTextRect(Canvas, taLeftJustify, taAlignTop, R, Caption, Multiline, TextOnGlass);
    W := W + Space + R.Width;
    //
    Height := H;
    Width := W;
  end
  else
    inherited;
  UpdateRects;
end;

//  MESSAGES

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

procedure TURadioButton.CMTextChanged(var Message: TMessage);
begin
  inherited;
  Resize;
end;

end.
