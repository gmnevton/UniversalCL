unit UCL.TUProgressBar;

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
  UCL.TUThemeManager,
  UCL.Utils,
  UCL.IntAnimation;

type
  TUCustomProgressBar = class;

  TUWaterMarkPositionEvent = procedure (Sender: TUCustomProgressBar; var WaterMarkX, WaterMarkY: Integer; var Streatch: Boolean; var StreatchWidth, StreatchHeight: Integer) of object;
  TUProgressBarPaintEvent = procedure (Sender: TUCustomProgressBar; const Canvas: TCanvas) of object;

  TUCustomProgressBar = class(TCustomControl, IUThemeComponent)
  private var
    FillColor: TColor;
    BackColor: TColor;
    FillRect: TRect;
    BackRect: TRect;

  private
    FThemeManager: TUThemeManager;
    FAniSet: TIntAniSet;

    FValue: Integer;
    FOrientation: TUOrientation;
    FCustomFillColor: TColor;
    FCustomBackColor: TColor;
    FWaterMark: TPicture;
    FOnWaterMarkPosition: TUWaterMarkPositionEvent;
    FOnPaint: TUProgressBarPaintEvent;

    //  Internal
    procedure UpdateColors;
    procedure UpdateRects;

    //  Setters
    procedure SetThemeManager; // (const Value: TUThemeManager);
    procedure SetWaterMark(const Value: TPicture);
    procedure SetValue(const Value: Integer);
    procedure SetOrientation(const Value: TUOrientation);

  protected
    //procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure Resize; override;
    procedure ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND}); override;

  public
    constructor Create(AOnwer: TComponent); override;
    destructor Destroy; override;

    procedure UpdateTheme;

    procedure GoToValue(Value: Integer);

  published
    property ThemeManager: TUThemeManager read FThemeManager; // write SetThemeManager;
    property AniSet: TIntAniSet read FAniSet write FAniSet;

    property Value: Integer read FValue write SetValue;
    property Orientation: TUOrientation read FOrientation write SetOrientation;
    property CustomFillColor: TColor read FCustomFillColor write FCustomFillColor;
    property CustomBackColor: TColor read FCustomBackColor write FCustomBackColor;

    property WaterMark: TPicture read FWaterMark write SetWaterMark;
    property OnGetWaterMarkPosition: TUWaterMarkPositionEvent read FOnWaterMarkPosition write FOnWaterMarkPosition;
    property OnPaint: TUProgressBarPaintEvent read FOnPaint write FOnPaint;

    property Height default 5;
    property Width default 100;
  end;

  TUProgressBar = class(TUCustomProgressBar)
    published
      property Align;
      property Anchors;
      property AutoSize;
      property BiDiMode;
      //property Caption;
      property Color;
      property Constraints;
      property DragCursor;
      property DragKind;
      property DragMode;
      property Enabled;
      property Font;
      property ParentBiDiMode;
      property ParentColor;
      property ParentFont;
      property ParentShowHint;
      property PopupMenu;
      property ShowHint;
      property Touch;
      property Visible;
    {$IF CompilerVersion > 29}
      property StyleElements;
    {$IFEND}

      property OnCanResize;
      property OnClick;
      property OnConstrainedResize;
      property OnContextPopup;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDock;
      property OnEndDrag;
      property OnGesture;
      property OnMouseActivate;
      property OnMouseDown;
      property OnMouseEnter;
      property OnMouseLeave;
      property OnMouseMove;
      property OnMouseUp;
      property OnResize;
      property OnStartDock;
      property OnStartDrag;
  end;

implementation

type
  TGraphicAccess = class(TGraphic);

{ TUCustomProgressBar }

//  THEME

procedure TUCustomProgressBar.SetThemeManager; // (const Value: TUThemeManager);
begin
  FThemeManager := GetCommonThemeManager;
  UpdateTheme;
end;

procedure TUCustomProgressBar.UpdateTheme;
begin
  UpdateColors;
  UpdateRects;
  Repaint;
end;
{
procedure TUCustomProgressBar.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FThemeManager) then
    FThemeManager := nil;
end;
}
//  INTERNAL

procedure TUCustomProgressBar.UpdateColors;
begin
  //  Background & fill color
  if ThemeManager = Nil then begin
    BackColor := FCustomBackColor;
    FillColor := FCustomFillColor;
  end
  else if ThemeManager.Theme = utLight then begin
    BackColor := $CCCCCC;
    FillColor := ThemeManager.AccentColor;
  end
  else begin
    BackColor := $333333;
    FillColor := ThemeManager.AccentColor;
  end;
end;

procedure TUCustomProgressBar.UpdateRects;
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

procedure TUCustomProgressBar.SetWaterMark(const Value: TPicture);
begin
  FWaterMark.Assign(Value);
  UpdateRects;
  Repaint;
end;

procedure TUCustomProgressBar.SetValue(const Value: Integer);
begin
  if FValue <> Value then begin
    FValue := Value;
    UpdateRects;
    Repaint;
  end;
end;

procedure TUCustomProgressBar.SetOrientation(const Value: TUOrientation);
begin
  if FOrientation <> Value then begin
    FOrientation := Value;
    UpdateRects;
    Repaint;
  end;
end;

//  MAIN CLASS

constructor TUCustomProgressBar.Create(AOnwer: TComponent);
begin
  inherited Create(AOnwer);
  FThemeManager := Nil;
  FWaterMark := TPicture.Create;

  //  Parent properties
  Height := 5;
  Width := 100;

  //  Fields
  FValue := 0;
  FCustomFillColor := $25B006;
  FCustomBackColor := $E6E6E6;

  //  Custom AniSet
  FAniSet := TIntAniSet.Create;
  FAniSet.QuickAssign(akOut, afkQuartic, 0, 250, 25);

  if GetCommonThemeManager <> Nil then
    GetCommonThemeManager.Connect(Self);

  UpdateColors;
  UpdateRects;
end;

destructor TUCustomProgressBar.Destroy;
begin
  FAniSet.Free;
  FWaterMark.Free;
  if FThemeManager <> Nil then
    FThemeManager.Disconnect(Self);
  inherited;
end;

procedure TUCustomProgressBar.GoToValue(Value: Integer);
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

procedure TUCustomProgressBar.Paint;
var
  WaterMarkX, WaterMarkY: Integer;
  Streach: Boolean;
  StreatchWidth, StreatchHeight: Integer;
//  bmp: TBitmap;
begin
//  inherited;

  //  Paint background
  Canvas.Brush.Handle := CreateSolidBrushWithAlpha(BackColor, 255);
  Canvas.FillRect(BackRect);

  //  Paint Fillround
  Canvas.Brush.Handle := CreateSolidBrushWithAlpha(FillColor, 255);
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

procedure TUCustomProgressBar.Resize;
begin
  inherited;
  UpdateRects;
  Invalidate;
end;

procedure TUCustomProgressBar.ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND});
begin
  inherited;
  UpdateRects;
  Invalidate;
end;

end.
