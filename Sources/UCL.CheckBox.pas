unit UCL.CheckBox;

interface

{$IF CompilerVersion > 29}
  {$LEGACYIFEND ON}
{$IFEND}

uses
  Classes,
  Messages,
  Windows,
  Controls,
  Graphics,
  UCL.Classes,
  UCL.ThemeManager,
  UCL.Utils,
  UCL.Graphics;

type
  TUCheckBoxState = (cbsChecked, cbsUnchecked, cbsGrayed);

  TUCheckBox = class(TUGraphicControl, IUThemedComponent)
  const
    ICON_CHECKED = '';
    ICON_UNCHECKED = '';
    ICON_GRAYED = '';

  private
    var ActiveColor, TextColor: TColor;
    var IconRect, TextRect: TRect;

    FThemeManager: TUThemeManager;
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
    procedure SetThemeManager(const Value: TUThemeManager);
    procedure SetAutoSize(const Value: Boolean); reintroduce;
    procedure SetTextOnGlass(const Value: Boolean);
    procedure SetAllowGrayed(const Value: Boolean);
    procedure SetState(const Value: TUCheckBoxState);

    //  Messages
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;

  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure Resize; override;
    procedure ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND}); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // IUThemedComponent
    procedure UpdateTheme;
    function IsCustomThemed: Boolean;
    function CustomThemeManager: TUCustomThemeManager;

  published
    property ThemeManager: TUThemeManager read FThemeManager write SetThemeManager;
    property IconFont: TFont read FIconFont write FIconFont;

    property AutoSize: Boolean read FAutoSize write SetAutoSize default false;
    property AllowGrayed: Boolean read FAllowGrayed write SetAllowGrayed default false;
    property TextOnGlass: Boolean read FTextOnGlass write SetTextOnGlass default false;

    property State: TUCheckBoxState read FState write SetState default cbsUnchecked;
    property CustomActiveColor: TColor read FCustomActiveColor write FCustomActiveColor default $D77800;

    property Caption;
    property Color;
    property ParentColor default True;
    property Height default 30;
    property Width default 180;
  end;

implementation

uses
  UCL.Colors;

{ TUCheckBox }

//  MAIN CLASS

constructor TUCheckBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FThemeManager := Nil;

  FIconFont := TFont.Create;
  FIconFont.Name := 'Segoe MDL2 Assets';
  FIconFont.Size := 15;

  FAutoSize := false;
  FAllowGrayed := false;
  FTextOnGlass := false;
  FState := cbsUnchecked;
  FCustomActiveColor := $D77800;  //  Default blue

  ParentColor := true;
  //Font.Name := 'Segoe UI';
  //Font.Size := 10;

  Height := 30;
  Width := 180;

  if GetCommonThemeManager <> Nil then
    GetCommonThemeManager.Connect(Self);

  UpdateColors;
  UpdateRects;
end;

destructor TUCheckBox.Destroy;
var
  TM: TUCustomThemeManager;
begin
  FIconFont.Free;
  TM:=SelectThemeManager(Self);
  TM.Disconnect(Self);
  inherited;
end;

//  THEME

procedure TUCheckBox.SetThemeManager(const Value: TUThemeManager);
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

procedure TUCheckBox.UpdateTheme;
begin
  UpdateColors;
  UpdateRects;
  Repaint;
end;

function TUCheckBox.IsCustomThemed: Boolean;
begin
  Result:=(FThemeManager <> Nil);
end;

function TUCheckBox.CustomThemeManager: TUCustomThemeManager;
begin
  Result:=FThemeManager;
end;

procedure TUCheckBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FThemeManager) then begin
    ThemeManager:=Nil;
    Exit;
  end;
  inherited Notification(AComponent, Operation);
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
  if CustomActiveColor <> clNone then begin
    ActiveColor := CustomActiveColor;
    if TM.ThemeUsed = utLight then
      TextColor := $000000
    else
      TextColor := $FFFFFF;
  end
  else if CustomActiveColor = clDefault then begin
    if TM.UseSystemAccentColor then
      ActiveColor := TM.SystemAccentColor
    else
      ActiveColor := TM.AccentColor;
    if TM.ThemeUsed = utLight then
      TextColor := $000000
    else
      TextColor := $FFFFFF;
  end
  else if TM.ThemeUsed = utLight then begin
    ActiveColor := TM.AccentColor;
    TextColor := $000000;
  end
  else begin
    ActiveColor := TM.AccentColor;
    TextColor := $FFFFFF;
  end;
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

procedure TUCheckBox.ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND});
begin
  inherited;
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
