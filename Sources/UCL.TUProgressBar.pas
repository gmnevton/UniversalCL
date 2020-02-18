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
  TUCustomProgressBar = class(TCustomControl, IUThemeComponent)
    private
      var FillColor: TColor;
      var BackColor: TColor;
      var FillRect: TRect;
      var BackRect: TRect;

      FThemeManager: TUThemeManager;
      FAniSet: TIntAniSet;

      FValue: Integer;
      FOrientation: TUOrientation;
      FCustomFillColor: TColor;
      FCustomBackColor: TColor;

      //  Internal
      procedure UpdateColors;
      procedure UpdateRects;

      //  Setters
      procedure SetThemeManager; // (const Value: TUThemeManager);
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
begin
  inherited;

  //  Paint background
  Canvas.Brush.Handle := CreateSolidBrushWithAlpha(BackColor, 255);
  Canvas.FillRect(BackRect);

  //  Paint Fillround
  Canvas.Brush.Handle := CreateSolidBrushWithAlpha(FillColor, 255);
  Canvas.FillRect(FillRect);
end;

procedure TUCustomProgressBar.Resize;
begin
  inherited;
  UpdateRects;
end;

procedure TUCustomProgressBar.ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND});
begin
  inherited;
  UpdateRects;
end;

end.
