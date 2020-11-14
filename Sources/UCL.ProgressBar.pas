unit UCL.ProgressBar;

interface

{$IF CompilerVersion > 29}
  {$LEGACYIFEND ON}
{$IFEND}

uses
  Classes,
  Types,
  Messages,
  Controls,
  Graphics,
  UCL.Classes,
  UCL.Types,
  UCL.Colors,
  UCL.ThemeManager,
  UCL.Utils,
  UCL.IntAnimation;

type
  TUProgressBar = class;

  TUWaterMarkPositionEvent = procedure (Sender: TUProgressBar; var WaterMarkX, WaterMarkY: Integer; var Streatch: Boolean; var StreatchWidth, StreatchHeight: Integer) of object;
  TUProgressBarPaintEvent = procedure (Sender: TUProgressBar; const Canvas: TCanvas) of object;

  TUProgressBar = class(TUCustomControl, IUThemedComponent)
  private var
    FFillColor: TUThemeControlColorSet;
    FBackColor: TUThemeControlColorSet;
    Fill_Color: TColor;
    Back_Color: TColor;
    FillRect: TRect;
    BackRect: TRect;

  private
    FThemeManager: TUThemeManager;
    FAniSet: TIntAniSet;

    FValue: Integer;
    FOrientation: TUOrientation;
    //FCustomFillColor: TColor;
    //FCustomBackColor: TColor;
    FWaterMark: TPicture;
    FOnWaterMarkPosition: TUWaterMarkPositionEvent;
    FOnPaint: TUProgressBarPaintEvent;

    //  Internal
    procedure UpdateColors;
    procedure UpdateRects;

    //  Setters
    procedure SetThemeManager(const Value: TUThemeManager);
    procedure SetWaterMark(const Value: TPicture);
    procedure SetValue(const Value: Integer);
    procedure SetOrientation(const Value: TUOrientation);

    //  Child events
    procedure FillColor_OnChange(Sender: TObject);
    procedure BackColor_OnChange(Sender: TObject);

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

    procedure GoToValue(Value: Integer);

  published
    property ThemeManager: TUThemeManager read FThemeManager write SetThemeManager;
    property AniSet: TIntAniSet read FAniSet write FAniSet;

    property FillColor: TUThemeControlColorSet read FFillColor; // read only subcomponent declaration, but its internal properties can be modified
    property BackColor: TUThemeControlColorSet read FBackColor; // read only subcomponent declaration, but its internal properties can be modified
    property Value: Integer read FValue write SetValue;
    property Orientation: TUOrientation read FOrientation write SetOrientation;

    property WaterMark: TPicture read FWaterMark write SetWaterMark;
    property OnGetWaterMarkPosition: TUWaterMarkPositionEvent read FOnWaterMarkPosition write FOnWaterMarkPosition;
    property OnPaint: TUProgressBarPaintEvent read FOnPaint write FOnPaint;

    property Caption;
    property Height default 5;
    property Width default 100;
  end;

implementation

uses
  SysUtils;

type
  TGraphicAccess = class(TGraphic);

{ TUProgressBar }

//  MAIN CLASS

constructor TUProgressBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FThemeManager := Nil;
  FWaterMark := TPicture.Create;

  //  Parent properties
  Height := 5;
  Width := 100;

  //  Fields
  FValue := 0;
  FFillColor := TUThemeControlColorSet.Create;
  FFillColor.Assign(PROGRESSBAR_BACK);
  FFillColor.OnChange := FillColor_OnChange;
  FBackColor := TUThemeControlColorSet.Create;
  FBackColor.Assign(PROGRESSBAR_BACK);
  FBackColor.OnChange := BackColor_OnChange;

  //  Custom AniSet
  FAniSet := TIntAniSet.Create;
  FAniSet.QuickAssign(akOut, afkQuartic, 0, 250, 25);

  if GetCommonThemeManager <> Nil then
    GetCommonThemeManager.Connect(Self);

  UpdateColors;
  UpdateRects;
end;

destructor TUProgressBar.Destroy;
var
  TM: TUCustomThemeManager;
begin
  FAniSet.Free;
  FWaterMark.Free;
  FFillColor.Free;
  FBackColor.Free;
  TM:=SelectThemeManager(Self);
  TM.Disconnect(Self);
  inherited;
end;

//  THEME

procedure TUProgressBar.SetThemeManager(const Value: TUThemeManager);
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

procedure TUProgressBar.UpdateTheme;
begin
  UpdateColors;
  UpdateRects;
  Repaint;
end;

function TUProgressBar.IsCustomThemed: Boolean;
begin
  Result:=(FThemeManager <> Nil);
end;

function TUProgressBar.CustomThemeManager: TUCustomThemeManager;
begin
  Result:=FThemeManager;
end;

procedure TUProgressBar.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FThemeManager) then begin
    ThemeManager:=Nil;
    Exit;
  end;
  inherited Notification(AComponent, Operation);
end;

//  INTERNAL

procedure TUProgressBar.UpdateColors;
var
  TM: TUCustomThemeManager;
begin
  TM:=SelectThemeManager(Self);
  // Background & fill color
  if BackColor.Enabled then
    Back_Color := BackColor.Color
  else
    Back_Color := BackColor.GetColor(TM);
  //
  if FillColor.Enabled then
    Fill_Color := FillColor.Color
  else begin
    Fill_Color := SelectAccentColor(TM, clNone);
    if (Fill_Color = clNone) or (Fill_Color = clDefault) then
      Fill_Color := FillColor.GetColor(TM);
  end;
end;

procedure TUProgressBar.UpdateRects;
begin
  //  Background & fill area
  if Orientation = oHorizontal then begin
    FillRect := Rect(0, 0, Round(Value / 100 * Width), Height);
    BackRect := Rect(FillRect.Right, 0, Width, Height);
  end
  else begin
    BackRect := Rect(0, 0, Width, Round(Value / 100 * Height));
    FillRect := Rect(0, BackRect.Bottom, Width, Height);
  end;
end;

//  SETTERS

procedure TUProgressBar.SetWaterMark(const Value: TPicture);
begin
  FWaterMark.Assign(Value);
  UpdateRects;
  Repaint;
end;

procedure TUProgressBar.SetValue(const Value: Integer);
begin
  if FValue <> Value then begin
    FValue := Value;
    UpdateRects;
    Repaint;
  end;
end;

procedure TUProgressBar.SetOrientation(const Value: TUOrientation);
begin
  if FOrientation <> Value then begin
    FOrientation := Value;
    UpdateRects;
    Repaint;
  end;
end;

procedure TUProgressBar.FillColor_OnChange(Sender: TObject);
begin
  UpdateTheme;
end;

procedure TUProgressBar.BackColor_OnChange(Sender: TObject);
begin
  UpdateTheme;
end;

procedure TUProgressBar.GoToValue(Value: Integer);
var
  Ani: TIntAni;
begin
  if not Enabled then
    Exit;

  Ani := TIntAni.Create(FValue, Value - FValue,
    procedure (V: Integer)
    begin
      Self.Value := V;
    end, Nil);
  Ani.AniSet.Assign(Self.AniSet);
  Ani.Start;
end;

//  CUSTOM METHODS

procedure TUProgressBar.Paint;
var
  WaterMarkX, WaterMarkY: Integer;
  Streach: Boolean;
  StreatchWidth, StreatchHeight: Integer;
//  bmp: TBitmap;
begin
//  inherited;

  //  Paint background
  Canvas.Brush.Handle := CreateSolidBrushWithAlpha(Back_Color, 255);
  Canvas.FillRect(BackRect);

  //  Paint Fillround
  Canvas.Brush.Handle := CreateSolidBrushWithAlpha(Fill_Color, 255);
  Canvas.FillRect(FillRect);

  if FWaterMark.Graphic <> Nil then begin
    WaterMarkX:=Width - FWaterMark.Width;
    WaterMarkY:=0;
    Streach:=False;
    StreatchWidth:=-1;
    StreatchHeight:=-1;
    if Assigned(FOnWaterMarkPosition) then
      FOnWaterMarkPosition(Self, WaterMarkX, WaterMarkY, Streach, StreatchWidth, StreatchHeight);
    if Streach and (StreatchWidth > 0) and (StreatchHeight > 0) then begin
//      bmp:=TBitmap.Create;
//      try
//        bmp.PixelFormat:=pf32bit;
//        bmp.SetSize(FWaterMark.Width, FWaterMark.Height);
//        TGraphicAccess(WaterMark.Graphic).Draw(bmp.Canvas, Rect(0, 0, FWaterMark.Width, FWaterMark.Height));
//        bmp.TransparentMode:=tmAuto;
//        bmp.Transparent:=True;
//        Canvas.StretchDraw(Rect(WaterMarkX, WaterMarkY, WaterMarkX + StreatchWidth, WaterMarkY + StreatchHeight), bmp);
//      finally
//        bmp.Free;
//      end;
      TGraphicAccess(WaterMark.Graphic).Draw(Canvas, Rect(WaterMarkX, WaterMarkY, WaterMarkX + StreatchWidth, WaterMarkY + StreatchHeight));
    end
    else
      TGraphicAccess(WaterMark.Graphic).Draw(Canvas, Rect(WaterMarkX, WaterMarkY, WaterMarkX + FWaterMark.Width, WaterMarkY + FWaterMark.Height));
  end;

  if Assigned(FOnPaint) then
    FOnPaint(Self, Canvas);
end;

procedure TUProgressBar.Resize;
begin
  inherited;
  UpdateRects;
  Invalidate;
end;

procedure TUProgressBar.ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND});
begin
  inherited;
  UpdateRects;
  Invalidate;
end;

end.
