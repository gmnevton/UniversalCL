unit UCL.ProgressBar;

interface

uses
  Classes,
  Types,
  Messages,
  Controls,
  Graphics,
  UCL.Classes,
  UCL.Types,
  UCL.Colors,
  UCL.Utils,
  UCL.IntAnimation;

type
  TUProgressBar = class;

  TUWaterMarkPositionEvent = procedure (Sender: TUProgressBar; var WaterMarkX, WaterMarkY: Integer; var Streatch: Boolean; var StreatchWidth, StreatchHeight: Integer) of object;
  TUProgressBarPaintEvent = procedure (Sender: TUProgressBar; const Canvas: TCanvas) of object;

  TUProgressBar = class(TUCustomControl)
  private var
    FFillColor: TUThemeControlColorSet;
    FBackColor: TUThemeControlColorSet;
    Fill_Color: TColor;
    Back_Color: TColor;
    FillRect: TRect;
    BackRect: TRect;

  private
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
    procedure SetWaterMark(const Value: TPicture);
    procedure SetValue(const Value: Integer);
    procedure SetOrientation(const Value: TUOrientation);

    //  Child events
    procedure FillColor_OnChange(Sender: TObject);
    procedure BackColor_OnChange(Sender: TObject);

  protected
    procedure Paint; override;
    procedure Resize; override;
    procedure DoChangeScale(M, D: Integer); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // IUThemedComponent
    procedure UpdateTheme; override;

    procedure GoToValue(Value: Integer);

  published
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
  SysUtils,
  UITypes,
  UCL.ThemeManager;

type
  TGraphicAccess = class(TGraphic);

{ TUProgressBar }

//  MAIN CLASS

constructor TUProgressBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
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

  UpdateColors;
  UpdateRects;
end;

destructor TUProgressBar.Destroy;
begin
  FAniSet.Free;
  FWaterMark.Free;
  FFillColor.Free;
  FBackColor.Free;
  inherited;
end;

//  THEME

procedure TUProgressBar.UpdateTheme;
begin
  if csCreating in ControlState then
    Exit;
  //
  UpdateColors;
  UpdateRects;
  Repaint;
end;

//  INTERNAL

procedure TUProgressBar.UpdateColors;
var
  TM: TUCustomThemeManager;
begin
  if csCreating in ControlState then
    Exit;
  //
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

procedure TUProgressBar.DoChangeScale(M, D: Integer);
begin
  UpdateRects;
  Invalidate;
end;

end.
