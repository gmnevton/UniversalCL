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

  private
    FIconFont: TFont;
    FAutoSize: Boolean;
    FAllowGrayed: Boolean;
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
    procedure SetTextOnGlass(const Value: Boolean);
    procedure SetAllowGrayed(const Value: Boolean);
    procedure SetState(const Value: TUCheckBoxState);

    // Messages
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;

  protected
    procedure Paint; override;
    procedure Resize; override;
    procedure DoChangeScale(M, D: Integer); override;
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
    property AllowGrayed: Boolean read FAllowGrayed write SetAllowGrayed default False;
    property Checked: Boolean read GetChecked write SetChecked default False;
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

  FIconFont := TFont.Create;
  FIconFont.Name := 'Segoe MDL2 Assets';
  FIconFont.Size := 15;

  FAutoSize := False;
  FAllowGrayed := False;
  FTextOnGlass := False;
  FState := cbsUnchecked;
  FCustomActiveColor := clDefault; // $D77800 // Default blue

  ParentColor := True;
  //Font.Name := 'Segoe UI';
  //Font.Size := 10;

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
begin
  IconRect := Rect(0, 0, Height, Height);
  TextRect := Rect(Height, 0, Width - 2, Height);
  FocusRect:= Rect(Height - 3, 2, Width, Height - 2);
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

procedure TUCheckBox.SetTextOnGlass(const Value: Boolean);
begin
  if Value <> FTextOnGlass then begin
    FTextOnGlass := Value;
    Invalidate;
  end;
end;

// CUSTOM METHODS

procedure TUCheckBox.Paint;
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
  DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, TextRect, Caption, TextOnGlass);

  // Paint icon
  Canvas.Font.Assign(IconFont);
  Canvas.Font.Color := ActiveColor;
  case State of
    cbsChecked  : DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, IconRect, UF_CHECKBOX_CHECKED, TextOnGlass);
    cbsUnchecked: DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, IconRect, UF_CHECKBOX_OUTLINE, TextOnGlass);
    cbsGrayed   : begin
      DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, IconRect, UF_CHECKBOX_OUTLINE, TextOnGlass);
      //
      Canvas.Font.Color := TextColor;
      DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, IconRect, UF_CHECKBOX_SMALL, TextOnGlass);
    end;
  end;

  // Paint focus rect
  if Focused or MouseInClient then begin
    DrawFocusRect(Canvas, FocusRect, Color);
//    Canvas.Font.Color := TextColor;
//    Canvas.Pen.Style := psDot;
//    Canvas.Pen.Color := TextColor;
//    DrawFocusRect(Canvas.Handle, FocusRect);
//    Canvas.Pen.Style := psClear;
//    Canvas.Pen.Color := Color;
  end;
end;

procedure TUCheckBox.Resize;
var
  Space: Integer;
begin
  if AutoSize and (Align = alNone) then begin
    Space := 5;
    Canvas.Font.Assign(IconFont);
    Height := 2 * Space + Canvas.TextHeight(UF_CHECKBOX_OUTLINE);
    Canvas.Font.Assign(Font);
    Width := Height + Canvas.TextWidth(Text) + (Height - Canvas.TextHeight(Text)) div 2;
  end
  else
    inherited;
  UpdateRects;
end;

procedure TUCheckBox.DoChangeScale(M, D: Integer);
begin
  IconFont.Height := MulDiv(IconFont.Height, M, D);
  Resize;   //  Autosize
  //UpdateRects;  //  Do not update rects, resize already do that
end;

procedure TUCheckBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if Key = ' ' then
    Toggle;
end;

// MESSAGES

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

end.
