unit UCL.Slider;

interface

{$IF CompilerVersion > 29}
  {$LEGACYIFEND ON}
{$IFEND}

uses
  Classes,
  Windows,
  Messages,
  Controls,
  Graphics,
  UCL.Classes,
  UCL.Types,
  UCL.ThemeManager,
  UCL.Utils,
  UCL.Colors;

type
  TUSlider = class(TUGraphicControl, IUThemedComponent)
//  private const
//    DefActiveColor: TDefColor = (
//      ($D77800, $D77800, $D77800, $CCCCCC, $D77800),
//      ($D77800, $D77800, $D77800, $333333, $D77800));
//    DefBackColor: TDefColor = (
//      ($999999, $666666, $999999, $CCCCCC, $999999),
//      ($666666, $999999, $666666, $333333, $666666));
//    DefCurColor: TDefColor = (
//      ($D77800, $171717, $CCCCCC, $CCCCCC, $D77800),
//      ($D77800, $F2F2F2, $767676, $333333, $D77800));

  private var
    LCurWidth: Integer;
    LCurHeight: Integer;
    LCurCorner: Integer;
    LBarHeight: Integer;
    LActiveRect, LNormalRect, LCurRect: TRect;
    LAccentColor, LBackColor, LCurColor: TColor;

  private
    FThemeManager: TUThemeManager;
    FBackColor: TUThemeFocusableControlStateColors;
    FCurColor: TUThemeFocusableControlStateColors;
    FIsSliding: Boolean;
    FControlState: TUControlState;
    FOrientation: TUOrientation;
    FMin: Integer;
    FMax: Integer;
    FValue: Integer;

    //  Events
    FOnChange: TNotifyEvent;

    //  Internal
    procedure UpdateColors;
    procedure UpdateRects;

    //  Setters
    procedure SetThemeManager(const Value: TUThemeManager);
    procedure SetControlState(const Value: TUControlState);
    procedure SetOrientation(const Value: TUOrientation);
    procedure SetMin(const Value: Integer);
    procedure SetMax(const Value: Integer);
    procedure SetValue(const Value: Integer);

    //  Messages
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;

    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMMouseMove(var Msg: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;

    procedure BackColor_OnChange(Sender: TObject);
    procedure CurColor_OnChange(Sender: TObject);

  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure Resize; override;
    procedure ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND}); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property IsSliding: Boolean read FIsSliding;

    // IUThemedComponent
    procedure UpdateTheme;
    function IsCustomThemed: Boolean;
    function CustomThemeManager: TUCustomThemeManager;

  published
    property ThemeManager: TUThemeManager read FThemeManager write SetThemeManager;
    property BackColor: TUThemeFocusableControlStateColors read FBackColor;
    property CurColor: TUThemeFocusableControlStateColors read FCurColor;
    property ControlState: TUControlState read FControlState write SetControlState default csNone;
    property Orientation: TUOrientation read FOrientation write SetOrientation default oHorizontal;
    property Min: Integer read FMin write SetMin default 0;
    property Max: Integer read FMax write SetMax default 100;
    property Value: Integer read FValue write SetValue default 0;

    //  Events
    property OnChange: TNotifyEvent read FOnChange write FOnChange;

    property Height default 25;
    property Width default 100;
  end;

implementation

uses
  SysUtils,
  UITypes;

{ TUSlider }

//  MAIN CLASS

constructor TUSlider.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FThemeManager := Nil;

  //  New properties
  LCurWidth := 8;
  LCurHeight := 23;
  LCurCorner := 5;
  LBarHeight := 2;

  FIsSliding := False;

  FControlState := csNone;
  FOrientation := oHorizontal;

  FMin := 0;
  FMax := 100;
  FValue := 0;

  FBackColor := TUThemeFocusableControlStateColors.Create;
  FBackColor.Assign(SLIDER_BACK);
  FBackColor.OnChange := BackColor_OnChange;
  FCurColor := TUThemeFocusableControlStateColors.Create;
  FCurColor.Assign(SLIDER_CURSOR);
  FCurColor.OnChange := CurColor_OnChange;

  if GetCommonThemeManager <> Nil then
    GetCommonThemeManager.Connect(Self);

  //  Common properties
  Height := 25;
  Width := 100;

  UpdateColors;
  UpdateRects;
end;

destructor TUSlider.Destroy;
var
  TM: TUCustomThemeManager;
begin
  FBackColor.Free;
  FCurColor.Free;
  TM:=SelectThemeManager(Self);
  TM.Disconnect(Self);
  inherited;
end;

//  THEME

procedure TUSlider.SetThemeManager(const Value: TUThemeManager);
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

procedure TUSlider.UpdateTheme;
begin
  UpdateColors;
  UpdateRects;
  Repaint;
end;

function TUSlider.IsCustomThemed: Boolean;
begin
  Result:=(FThemeManager <> Nil);
end;

function TUSlider.CustomThemeManager: TUCustomThemeManager;
begin
  Result:=FThemeManager;
end;

procedure TUSlider.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FThemeManager) then begin
    ThemeManager:=Nil;
    Exit;
  end;
  inherited Notification(AComponent, Operation);
end;

//  INTERNAL

procedure TUSlider.UpdateColors;
var
  TM: TUCustomThemeManager;
begin
  TM := SelectThemeManager(Self);
  if not Enabled then begin
    if TM.ThemeUsed = utLight then
      LAccentColor := $CCCCCC
    else
      LAccentColor := $333333;
    LBackColor := LAccentColor;
    LCurColor := LAccentColor;
    Exit;
  end;
  //
  LAccentColor := SelectAccentColor(TM, clNone);
  LBackColor := BackColor.GetColor(TM.ThemeUsed, ControlState);
  if ControlState = csNone then
    LCurColor := LAccentColor
  else
    LCurColor := CurColor.GetColor(TM.ThemeUsed, ControlState);
end;

procedure TUSlider.UpdateRects;
begin
  if Orientation = oHorizontal then begin
    LActiveRect.Left := 0;
    LActiveRect.Top := (Height - LBarHeight) div 2;
    LActiveRect.Right := Round((Width - LCurWidth) * (Value - Min) / (Max - Min));
    LActiveRect.Bottom := LActiveRect.Top + LBarHeight;

    LNormalRect.Left := LActiveRect.Right + 1;
    LNormalRect.Top := LActiveRect.Top;
    LNormalRect.Right := Width;
    LNormalRect.Bottom := LActiveRect.Bottom;

    LCurRect.Left := LActiveRect.Right;
    LCurRect.Top := Height div 2 - LCurHeight div 2;
    LCurRect.Right := LCurRect.Left + LCurWidth;
    LCurRect.Bottom := LCurRect.Top + LCurHeight;
  end
  else begin
    LNormalRect.Left := (Width - LBarHeight) div 2;
    LNormalRect.Top := 0;
    LNormalRect.Right := LNormalRect.Left + LBarHeight;
    LNormalRect.Bottom := Round((Height - LCurHeight) * ({Value - Min}Max - Value) / (Max - Min));

    LActiveRect.Left := LNormalRect.Left;
    LActiveRect.Top := LNormalRect.Bottom + 1;
    LActiveRect.Right := LNormalRect.Right;
    LActiveRect.Bottom := Height;

    LCurRect.Left := (Width - LCurWidth) div 2;
    LCurRect.Top := LNormalRect.Bottom;
    LCurRect.Right := LCurRect.Left + LCurWidth;
    LCurRect.Bottom := LCurRect.Top + LCurHeight;
  end;
end;

//  SETTERS

procedure TUSlider.SetControlState(const Value: TUControlState);
begin
  if Value <> FControlState then begin
    FControlState := Value;
    UpdateColors;
    Repaint;
  end;
end;

procedure TUSlider.SetOrientation(const Value: TUOrientation);
var
  TempSize: Integer;
begin
  if Value <> FOrientation then begin
    FOrientation := Value;

    //  Switch CurWidth and CurHeight
    TempSize := LCurWidth;
    LCurWidth := LCurHeight;
    LCurHeight := TempSize;

    UpdateRects;
    Repaint;
  end;
end;

procedure TUSlider.SetMin(const Value: Integer);
begin
  if Value <> FMin then begin
    FMin := Value;
    UpdateRects;
    Repaint;
  end;
end;

procedure TUSlider.SetMax(const Value: Integer);
begin
  if Value <> FMax then begin
    FMax := Value;
    UpdateRects;
    Repaint;
  end;
end;

procedure TUSlider.SetValue(const Value: Integer);
begin
  if Value <> FValue then begin
    FValue := Value;
    if Assigned(FOnChange) then
      FOnChange(Self);
    UpdateRects;
    Repaint;
  end;
end;

procedure TUSlider.Paint;
begin
//  inherited;

  //  Paint active part
  Canvas.Brush.Handle := CreateSolidBrushWithAlpha(LAccentColor, 255);
  Canvas.FillRect(LActiveRect);

  //  Paint normal part
  Canvas.Brush.Handle := CreateSolidBrushWithAlpha(LBackColor, 255);
  Canvas.FillRect(LNormalRect);

  //  Paint cursor
  Canvas.Pen.Color := LCurColor;
  Canvas.Brush.Handle := CreateSolidBrushWithAlpha(LCurColor, 255);
  Canvas.RoundRect(LCurRect, LCurCorner, LCurCorner);
  Canvas.FloodFill(LCurRect.Left + LCurRect.Width div 2, LCurRect.Top + LCurRect.Height div 2, LCurColor, fsSurface);
end;

procedure TUSlider.Resize;
begin
  inherited;
  UpdateTheme;
end;

procedure TUSlider.ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND});
begin
  inherited;
  LCurWidth  := MulDiv(LCurWidth, M, D);
  LCurHeight := MulDiv(LCurHeight, M, D);
  LCurCorner := MulDiv(LCurCorner, M, D);
  LBarHeight := MulDiv(LBarHeight, M, D);
  UpdateTheme;
end;

//  MESSAGES

procedure TUSlider.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;
  if not Enabled then
    ControlState := csDisabled
  else
    ControlState := csNone;
end;

procedure TUSlider.CMMouseEnter(var Msg: TMessage);
begin
  if not Enabled then
    Exit;
  //
  ControlState := csHover;
  inherited;
end;

procedure TUSlider.CMMouseLeave(var Msg: TMessage);
begin
  if Enabled then
    Exit;
  //
  ControlState := csNone;
  inherited;
end;

procedure TUSlider.WMLButtonDown(var Msg: TWMLButtonDown);
var
  TempValue: Integer;
begin
  if not Enabled then
    Exit;

  FControlState := csPress;
  UpdateColors;
  FIsSliding := True;

  //  If press in cursor
  if (Msg.XPos < LCurRect.Left) or (Msg.XPos > LCurRect.Right) or (Msg.YPos < LCurRect.Top) or (Msg.YPos > LCurRect.Bottom) then begin
    //  Change Value by click position, click point is center of cursor
    if Orientation = oHorizontal then
      TempValue := Min + Round((Msg.XPos - LCurWidth div 2) * (Max - Min) / (Width - LCurWidth))
    else
      TempValue := Max - Round((Msg.YPos - LCurHeight div 2) * (Max - Min) / (Height - LCurHeight));

    //  Keep value in range [Min..Max]
    if TempValue < Min then
      TempValue := Min
    else if TempValue > Max then
      TempValue := Max;

    Value := TempValue;
  end
  else
    Invalidate;

  inherited;
end;

procedure TUSlider.WMMouseMove(var Msg: TWMMouseMove);
var
  TempValue: Integer;
begin
  if not Enabled then
    Exit;

  if FIsSliding then begin
    if Orientation = oHorizontal then
      TempValue := Min + Round((Msg.XPos - LCurWidth div 2) * (Max - Min) / (Width - LCurWidth))
    else
      TempValue := Max - Round((Msg.YPos - LCurHeight div 2) * (Max - Min) / (Height - LCurHeight));

    //  Keep value in range [Min..Max]
    if TempValue < Min then
      TempValue := Min
    else if TempValue > Max then
      TempValue := Max;

    Value := TempValue;
  end;

  inherited;
end;

procedure TUSlider.WMLButtonUp(var Msg: TWMLButtonUp);
begin
  if not Enabled then
    Exit;
  //
  ControlState := csNone;
  FIsSliding := False;
  inherited;
end;

procedure TUSlider.BackColor_OnChange(Sender: TObject);
begin
  UpdateTheme;
end;

procedure TUSlider.CurColor_OnChange(Sender: TObject);
begin
  UpdateTheme;
end;

end.
