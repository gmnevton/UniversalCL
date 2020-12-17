unit UCL.CheckBox;

interface

uses
  Classes,
  Messages,
  Windows,
  Controls,
  Graphics,
  UCL.Classes,
  UCL.Utils,
  UCL.Graphics;

type
  TUCheckBoxState = (cbsChecked, cbsUnchecked, cbsGrayed);

  TUCheckBox = class(TUGraphicControl)
  const
    ICON_CHECKED = '';
    ICON_UNCHECKED = '';
    ICON_GRAYED = '';

  private
    var ActiveColor, TextColor: TColor;
    var IconRect, TextRect: TRect;

    FIconFont: TFont;

    FAutoSize: Boolean;
    FAllowGrayed: Boolean;
    FTextOnGlass: Boolean;

    FState: TUCheckBoxState;
    FCustomActiveColor: TColor;

    //  Internal
    procedure UpdateColors;
    procedure UpdateRects;

    //  Setters
    procedure SetAutoSize(const Value: Boolean); reintroduce;
    procedure SetTextOnGlass(const Value: Boolean);
    procedure SetAllowGrayed(const Value: Boolean);
    procedure SetState(const Value: TUCheckBoxState);

    //  Messages
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;

  protected
    procedure Paint; override;
    procedure Resize; override;
    procedure DoChangeScale(M, D: Integer); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // IUThemedComponent
    procedure UpdateTheme; override;

  published
    property IconFont: TFont read FIconFont write FIconFont;

    property AutoSize: Boolean read FAutoSize write SetAutoSize default false;
    property AllowGrayed: Boolean read FAllowGrayed write SetAllowGrayed default false;
    property TextOnGlass: Boolean read FTextOnGlass write SetTextOnGlass default false;

    property State: TUCheckBoxState read FState write SetState default cbsUnchecked;
    property CustomActiveColor: TColor read FCustomActiveColor write FCustomActiveColor default clDefault;

    property Caption;
    property Color;
    property ParentColor default True;
    property Height default 30;
    property Width default 180;
  end;

implementation

uses
  SysUtils,
  UITypes,
  UCL.ThemeManager,
  UCL.Colors;

{ TUCheckBox }

//  MAIN CLASS

constructor TUCheckBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FIconFont := TFont.Create;
  FIconFont.Name := 'Segoe MDL2 Assets';
  FIconFont.Size := 15;

  FAutoSize := false;
  FAllowGrayed := false;
  FTextOnGlass := false;
  FState := cbsUnchecked;
  FCustomActiveColor := clDefault; // $D77800 // Default blue

  ParentColor := true;
  //Font.Name := 'Segoe UI';
  //Font.Size := 10;

  Height := 30;
  Width := 180;

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
  if not Enabled then begin
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
  if csDesigning in Self.ComponentState then
    TextColor := GetTextColorFromBackground(Color);
end;

procedure TUCheckBox.UpdateRects;
begin
  IconRect := Rect(0, 0, Height, Height);
  TextRect := Rect(Height, 0, Width, Height);
end;

//  SETTERS

procedure TUCheckBox.SetState(const Value: TUCheckBoxState);
begin
  if Value <> FState then begin
    if (not AllowGrayed) and (Value = cbsGrayed) then
      FState := cbsUnchecked
    else
      FState := Value;
    Repaint;
  end;
end;

procedure TUCheckBox.SetAllowGrayed(const Value: Boolean);
begin
  if Value <> FAllowGrayed then begin
    FAllowGrayed := Value;
    if (not FAllowGrayed) and (FState = cbsGrayed) then
      FState := cbsUnchecked;
    Repaint;
  end;
end;

procedure TUCheckBox.SetAutoSize(const Value: Boolean);
begin
  if Value <> FAutoSize then begin
    FAutoSize := Value;
    Resize;
  end;
end;

procedure TUCheckBox.SetTextOnGlass(const Value: Boolean);
begin
  if Value <> FTextOnGlass then begin
    FTextOnGlass := Value;
    Repaint;
  end;
end;

//  CUSTOM METHODS

procedure TUCheckBox.Paint;
begin
//  inherited;

  //  Paint background
  if not TextOnGlass then begin
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Handle := CreateSolidBrushWithAlpha(Color, 255);
    Canvas.FillRect(Rect(0, 0, Width, Height));
  end;

  //  Paint text
  Canvas.Brush.Style := bsClear;
  Canvas.Font.Assign(Font);
  Canvas.Font.Color := TextColor;
  DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, TextRect, Caption, TextOnGlass);

  //  Paint icon
  Canvas.Font.Assign(IconFont);
  case State of
    cbsChecked: begin
      Canvas.Font.Color := ActiveColor;
      DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, IconRect, ICON_CHECKED, TextOnGlass);
    end;

    cbsUnchecked: begin
      Canvas.Font.Color := TextColor;
      DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, IconRect, ICON_UNCHECKED, TextOnGlass);
    end;

    cbsGrayed: begin
      Canvas.Font.Color := ActiveColor;
      DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, IconRect, ICON_UNCHECKED, TextOnGlass);

      Canvas.Font.Color := TextColor;
      DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, IconRect, ICON_GRAYED, TextOnGlass);
    end;
  end;
end;

procedure TUCheckBox.Resize;
var
  Space: Integer;
begin
  if AutoSize and (Align = alNone) then begin
    Space := 5;
    Canvas.Font.Assign(IconFont);
    Height := 2 * Space + Canvas.TextHeight(ICON_UNCHECKED);
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

//  MESSAGES

procedure TUCheckBox.WMLButtonUp(var Msg: TWMLButtonUp);
begin
  if Enabled then
    if AllowGrayed then   //  Unchecked > Checked > Grayed > ...
      case State of
        cbsUnchecked: State := cbsChecked;
        cbsChecked  : State := cbsGrayed;
        cbsGrayed   : State := cbsUnchecked;
      end
    else
      case State of
        cbsUnchecked: State := cbsChecked;
        cbsChecked  : State := cbsUnchecked;
        cbsGrayed   : State := cbsUnchecked;
      end;

  inherited;
end;

procedure TUCheckBox.CMEnabledChanged(var Msg: TMessage);
begin
  UpdateColors;
  Repaint;
end;

end.
