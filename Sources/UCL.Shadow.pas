unit UCL.Shadow;

interface

uses
  Classes,
  Types,
  Windows,
  Controls,
  Graphics,
  ExtCtrls,
  UCL.Classes,
  UCL.Types,
  UCL.Utils,
  UCL.Graphics;

type
  TUShadow = class(TUGraphicControl)
  private var
    Color: TColor;
    BlendFunc: BLENDFUNCTION;
    BlendBmp: TBitmap;

  private
    FLightColor: TColor;
    FDarkColor: TColor;
    FAlphaA: Byte;
    FAlphaB: Byte;
    FDirection: TUDirection;

    //  Setters
    procedure SetAlpha(Index: Integer; const Value: Byte);
    procedure SetColor(Index: Integer; const Value: TColor);
    procedure SetDirection(const Value: TUDirection);

  protected
    procedure Paint; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // IUThemedComponent
    procedure UpdateTheme; override;

  published
    property AlphaA: Byte index 0 read FAlphaA write SetAlpha default 255;
    property AlphaB: Byte index 1 read FAlphaB write SetAlpha default 255;
    property LightColor: TColor index 0 read FLightColor write SetColor default $F2F2F2;
    property DarkColor: TColor index 1 read FDarkColor write SetColor default $2B2B2B;
    property Direction: TUDirection read FDirection write SetDirection default dLeft;
  end;

implementation

uses
  SysUtils,
  UCL.ThemeManager,
  UCL.Colors;

{ TUShadow }

//  MAIN CLASS

constructor TUShadow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FAlphaA := 255;
  FAlphaB := 255;
  FLightColor := $F2F2F2;
  FDarkColor := $2B2B2B;
  FDirection := dLeft;

  Color := $F2F2F2;
  BlendFunc := CreateBlendFunc(255, True);
  BlendBmp := TBitmap.Create;
end;

destructor TUShadow.Destroy;
begin
  BlendBmp.Free;
  inherited;
end;

procedure TUShadow.Paint;
begin
//  inherited;

  BlendBmp.Width := Width;
  BlendBmp.Height := Height;

  AssignGradientBlendBitmap(BlendBmp, Color, AlphaA, AlphaB, Direction);
  PaintBlendBitmap(Canvas, Rect(0, 0, Width, Height), BlendBmp, BlendFunc);
end;

//  THEME

procedure TUShadow.UpdateTheme;
var
  TM: TUCustomThemeManager;
begin
  TM := SelectThemeManager(Self);
  if TM.ThemeUsed = utLight then
    Color := LightColor
  else
    Color := DarkColor;

  Repaint;
end;

//  SETTERS

procedure TUShadow.SetAlpha(Index: Integer; const Value: Byte);
begin
  case Index of
    0: if Value <> FAlphaA then begin
      FAlphaA := Value;
    end;  

    1: if Value <> FAlphaB then begin
      FAlphaB := Value;
    end;
  end;
  Repaint;
end;

procedure TUShadow.SetColor(Index: Integer; const Value: TColor);
begin
  case Index of
    0: if Value <> FLightColor then begin
      FLightColor := Value;
    end;

    1: if Value <> FDarkColor then begin
      FDarkColor := Value;
    end;
  end;
  UpdateTheme;
end;

procedure TUShadow.SetDirection(const Value: TUDirection);
begin
  if Value <> FDirection then begin
    FDirection := Value;
    Repaint;
  end;
end;

end.
