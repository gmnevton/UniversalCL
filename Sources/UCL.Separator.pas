unit UCL.Separator;

interface

uses
  Classes,
  Messages,
  Controls,
  Graphics,
  UCL.Classes,
  UCL.Types,
  UCL.Utils;

type
  TUSeparator = class(TUGraphicControl)
  private var
    LineColor: TColor;

  private
    FCustomColor: TColor;
    FOrientation: TUOrientation;
    FAlignSpace: Integer;
    FLineBetween: Boolean;
    FUseAccentColor: Boolean;

    //  Internal
    procedure UpdateColors;

    //  Setters
    procedure SetCustomColor(const Value: TColor);
    procedure SetOrientation(const Value: TUOrientation);
    procedure SetAlignSpace(const Value: Integer);
    procedure SetLineBetween(const Value: Boolean);
    procedure SetUseAccentColor(const Value: Boolean);

  protected
    procedure Paint; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // IUThemedComponent
    procedure UpdateTheme; override;

  published
    property CustomColor: TColor read FCustomColor write SetCustomColor default clNone;
    property Orientation: TUOrientation read FOrientation write SetOrientation default oVertical;
    property AlignSpace: Integer read FAlignSpace write SetAlignSpace default 10;
    property LineBetween: Boolean read FLineBetween write SetLineBetween default true;
    property UseAccentColor: Boolean read FUseAccentColor write SetUseAccentColor default false;

    property Height default 50;
    property Width default 20;
  end;

implementation

uses
  SysUtils,
  UITypes,
  UCL.ThemeManager,
  UCL.Colors;

{ TUSeparator }

//  MAIN CLASS

constructor TUSeparator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FCustomColor := clNone;
  FOrientation := oVertical;
  FAlignSpace := 10;
  FLineBetween := True;
  FUseAccentColor := False;

  Width := 20;
  Height := 50;

  UpdateColors;
end;

destructor TUSeparator.Destroy;
begin
  inherited;
end;

//  THEME

procedure TUSeparator.UpdateTheme;
begin
  UpdateColors;
  Repaint;
end;

//  INTERNAL

procedure TUSeparator.UpdateColors;
var
  TM: TUCustomThemeManager;
begin
  TM:=SelectThemeManager(Self);
  if CustomColor <> clNone then
    LineColor := CustomColor
  else if UseAccentColor then
    LineColor := SelectAccentColor(TM, $999999)
  else if TM.ThemeUsed = utLight then
    LineColor := $999999
  else
    LineColor := $666666;
end;

//  SETTERS

procedure TUSeparator.SetAlignSpace(const Value: Integer);
begin
  if Value <> FAlignSpace then begin
    FAlignSpace := Value;
    //
    Repaint;
  end;
end;

procedure TUSeparator.SetCustomColor(const Value: TColor);
begin
  if Value <> FCustomColor then begin
    FCustomColor := Value;
    UpdateTheme;
  end;
end;

procedure TUSeparator.SetLineBetween(const Value: Boolean);
begin
  if Value <> FLineBetween then begin
    FLineBetween := Value;
    //
    Repaint;
  end;
end;

procedure TUSeparator.SetOrientation(const Value: TUOrientation);
begin
  if Value <> FOrientation then begin
    FOrientation := Value;
    //
    Repaint;
  end;
end;

procedure TUSeparator.SetUseAccentColor(const Value: Boolean);
begin
  if Value <> FUseAccentColor then begin
    FUseAccentColor := Value;
    UpdateTheme;
  end;
end;

//  CUSTOM METHODS

procedure TUSeparator.Paint;
begin
//  inherited;
  if not LineBetween then
    Exit;

  //  Draw line
  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Color := LineColor;
  if Orientation = oVertical then begin
    Canvas.MoveTo(Width div 2, AlignSpace);
    Canvas.LineTo(Width div 2, Height - AlignSpace);
  end
  else begin
    Canvas.MoveTo(AlignSpace, Height div 2);
    Canvas.LineTo(Width - AlignSpace, Height div 2);
  end;
end;

end.
