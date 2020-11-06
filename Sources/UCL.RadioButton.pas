unit UCL.RadioButton;

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
  TURadioButton = class(TUGraphicControl, IUThemedComponent)
  private const
    ICON_CIRCLE_BORDER = '';
    ICON_CIRCLE_INSIDE = '';

  private var
    ActiveColor, TextColor: TColor;
    IconRect, TextRect: TRect;

  private
    FThemeManager: TUThemeManager;
    FIconFont: TFont;

    FAutoSize: Boolean;
    FIsChecked: Boolean;
    FGroup: string;
    FCustomActiveColor: TColor;
    FTextOnGlass: Boolean;

    //  Internal
    procedure UpdateColors;
    procedure UpdateRects;

    //  Setters
    procedure SetThemeManager(const Value: TUThemeManager);
    procedure SetAutoSize(const Value: Boolean); reintroduce;
    procedure SetIsChecked(const Value: Boolean);
    procedure SetTextOnGlass(const Value: Boolean);

    //  Messages
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;

  protected
    //procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND}); override;
    procedure Paint; override;
    procedure Resize; override;

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
    property IsChecked: Boolean read FIsChecked write SetIsChecked default false;
    property Group: string read FGroup write FGroup;
    property CustomActiveColor: TColor read FCustomActiveColor write FCustomActiveColor;
    property TextOnGlass: Boolean read FTextOnGlass write SetTextOnGlass default false;

    property Caption;
    property Color;
    property ParentColor default true;
    property Height default 30;
    property Width default 180;
  end;

implementation

{ TURadioButton }

//  MAIN CLASS

constructor TURadioButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FThemeManager := Nil;

  //  New props
  FAutoSize := false;
  FIsChecked := false;
  FCustomActiveColor := $D77800;
  FTextOnGlass := false;

  FIconFont := TFont.Create;
  FIconFont.Name := 'Segoe MDL2 Assets';
  FIconFont.Size := 15;

  ParentColor := true;
//  Font.Name := 'Segoe UI';
//  Font.Size := 10;

  Height := 30;
  Width := 180;

  if GetCommonThemeManager <> Nil then
    GetCommonThemeManager.Connect(Self);

  UpdateColors;
  UpdateRects;
end;

destructor TURadioButton.Destroy;
begin
  FIconFont.Free;
  if FThemeManager <> Nil then
    FThemeManager.Disconnect(Self);
  inherited;
end;

//  THEME

procedure TURadioButton.SetThemeManager(const Value: TUThemeManager);
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

procedure TURadioButton.UpdateTheme;
begin
  UpdateColors;
  UpdateRects;
  Repaint;
end;

function TURadioButton.IsCustomThemed: Boolean;
begin
  Result:=(ThemeManager <> Nil);
end;

function TURadioButton.CustomThemeManager: TUCustomThemeManager;
begin
  Result:=FThemeManager;
end;

{
procedure TURadioButton.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FThemeManager) then
    FThemeManager := nil;
end;
}
//  INTERNAL

procedure TURadioButton.UpdateColors;
begin
  //  Active & text color
  if ThemeManager = Nil then begin
    ActiveColor := CustomActiveColor;
    TextColor := $000000;
  end
  else if ThemeManager.Theme = ttLight then begin
    ActiveColor := ThemeManager.AccentColor;
    TextColor := $000000;
  end
  else begin
    ActiveColor := ThemeManager.AccentColor;
    TextColor := $FFFFFF;
  end;

  //  Disabled
  if not Enabled then begin
    ActiveColor := $808080;
    TextColor := $808080;
  end;
end;

procedure TURadioButton.UpdateRects;
begin
  IconRect := Rect(0, 0, Height, Height);
  TextRect := Rect(Height, 0, Width, Height);
end;

//  SETTERS

procedure TURadioButton.SetAutoSize(const Value: Boolean);
begin
  if Value <> FAutoSize then begin
    FAutoSize := Value;
    Resize;
  end;
end;

procedure TURadioButton.SetIsChecked(const Value: Boolean);
var
  i: Integer;
  control: TControl;
begin
  if Value <> FIsChecked then begin
    FIsChecked := Value;

    //  Uncheck all items with the same group
    if Value then begin
      for i := 0 to Parent.ControlCount - 1 do begin
        control := Parent.Controls[i];
        if (control = Self) or not (control is TURadioButton) then
          Continue;
        if TURadioButton(control).Group = Group then
          TURadioButton(control).IsChecked := False;
      end;
    end;
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

procedure TURadioButton.ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND});
begin
  inherited;
  IconFont.Height := MulDiv(IconFont.Height, M, D);
  Resize;   //  Autosize
  //UpdateRects;  //  Do not update rects, resize already do that
end;

procedure TURadioButton.Paint;
begin
  inherited;

  //  Paint background
  if not TextOnGlass then begin
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Handle := CreateSolidBrushWithAlpha(Color, 255);
    Canvas.FillRect(Rect(0, 0, Width, Height));
  end;

  //  Paint text
  Canvas.Brush.Style := bsClear;
  Canvas.Font := Font;
  Canvas.Font.Color := TextColor;
  DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, TextRect, Caption, TextOnGlass);

  //  Paint icon
  Canvas.Font := IconFont;
  if not IsChecked then begin
    Canvas.Font.Color := TextColor;
    DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, IconRect, ICON_CIRCLE_BORDER, TextOnGlass);
  end
  else begin
    Canvas.Font.Color := ActiveColor;
    DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, IconRect, ICON_CIRCLE_BORDER, TextOnGlass);

    Canvas.Font.Color := TextColor;
    DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, IconRect, ICON_CIRCLE_INSIDE, TextOnGlass);
  end;
end;

procedure TURadioButton.Resize;
var
  Space: Integer;
begin
  if AutoSize and (Align = alNone) then begin
    Space := 5;
    Canvas.Font := IconFont;
    Height := 2 * Space + Canvas.TextHeight(ICON_CIRCLE_BORDER);
    Canvas.Font := Font;
    Width := Height + Canvas.TextWidth(Text) + (Height - Canvas.TextHeight(Text)) div 2;
  end
  else
    inherited;
  UpdateRects;
end;

//  MESSAGES

procedure TURadioButton.WMLButtonUp(var Msg: TWMLButtonUp);
begin
  if Enabled then
    IsChecked := True;

  inherited;
end;

procedure TURadioButton.CMEnabledChanged(var Msg: TMessage);
begin
  UpdateColors;
  Repaint;
end;

end.
