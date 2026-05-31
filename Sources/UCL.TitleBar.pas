unit UCL.TitleBar;

interface

uses
  Classes,
  Windows,
  Messages,
  Controls,
  Graphics,
  Forms,
  UCL.Classes,
  UCL.Colors,
  UCL.Utils,
  UCL.Graphics;

type
  TUTitleBar = class(TUGraphicControl)
  private var
    BackColor, TextColor: TColor;

  private
    FBackColors: TUThemeCaptionBarColorSet;
    FTextPosition: Integer;
    FAlignment: TAlignment;
    FDoubleClick: Boolean;
    FDragMovement: Boolean;
    FEnableSystemMenu: Boolean;
    FUseSystemCaptionColor: Boolean;

    // Internal
    procedure UpdateColors;

    // Setters
    procedure SetUseSystemCaptionColor(const Value: Boolean);

    // Child events
    procedure BackColor_OnChange(Sender: TObject);

    //  Mesages
    procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMRButtonUp(var Msg: TMessage); message WM_RBUTTONUP;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure SetBackColors(const Value: TUThemeCaptionBarColorSet);

  protected
    procedure Paint; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // IUThemedComponent
    procedure UpdateTheme; override;

  published
    property BackColors: TUThemeCaptionBarColorSet read FBackColors write SetBackColors;
    property TextPosition: Integer read FTextPosition write FTextPosition default 12;
    property Alignment: TAlignment read FAlignment write FAlignment default taLeftJustify;
    property DoubleClick: Boolean read FDoubleClick write FDoubleClick default True;
    property DragMovement: Boolean read FDragMovement write FDragMovement default True;
    property EnableSystemMenu: Boolean read FEnableSystemMenu write FEnableSystemMenu default True;
    property UseSystemCaptionColor: Boolean read FUseSystemCaptionColor write SetUseSystemCaptionColor default False;

    property Caption;
    property Height default 32;
  end;

implementation

uses
  SysUtils,
  Types,
  UCL.SystemSettings,
  UCL.ThemeManager,
  UCL.Types;

{ TUTitleBar }

//  MAIN CLASS

constructor TUTitleBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FTextPosition := 12;
  FAlignment := taLeftJustify;
  FDoubleClick := True;
  FDragMovement := True;
  FEnableSystemMenu := True;
  FUseSystemCaptionColor := False;

  FBackColors := TUThemeCaptionBarColorSet.Create;
  FBackColors.Assign(CAPTIONBAR_BACK);
  FBackColors.OnChange := BackColor_OnChange;

//  Font.Name := 'Segoe UI';
//  Font.Size := 9;
  Height := 32;
//  Width := 400;
end;

destructor TUTitleBar.Destroy;
begin
  inherited;
end;

procedure TUTitleBar.UpdateColors;
var
  TM: TUCustomThemeManager;
  ColorSet: TUThemeCaptionBarColorSet;
  ParentForm: TCustomForm;
begin
  TM := SelectThemeManager(Self);
  ParentForm := GetParentForm(Self, True);

  //  Select default or custom style
  if UseSystemCaptionColor and IsColorOnBorderEnabled then begin
    if (ParentForm <> Nil) and (ParentForm is TForm) then begin
      if ParentForm.Active then
        BackColor := GetAccentColor
      else begin
        if BackColors.Enabled then
          BackColor := BackColors.Color
        else begin
          ColorSet := BackColors;

          BackColor := ColorSet.GetColor(TM, False);
        end;
      end;
    end
    else
      BackColor := GetAccentColor;
  end
  else begin
    if BackColors.Enabled then
      BackColor := BackColors.Color
    else begin
      ColorSet := BackColors;

      if (ParentForm <> Nil) and (ParentForm is TForm) then
        BackColor := ColorSet.GetColor(TM, ParentForm.Active)
      else
        BackColor := ColorSet.GetColor(TM, False);
    end;
  end;
//  Font.Color := GetTextColorFromBackground(Color);
  TextColor := GetTextColorFromBackground(BackColor);

  //  Update Color for container (let children using ParentColor)
  Color := BackColor;
end;

procedure TUTitleBar.SetBackColors(const Value: TUThemeCaptionBarColorSet);
begin
  FBackColors := Value;
end;

procedure TUTitleBar.SetUseSystemCaptionColor(const Value: Boolean);
begin
  if FUseSystemCaptionColor <> Value then begin
    FUseSystemCaptionColor := Value;
    UpdateTheme;
  end;
end;

//  THEME

procedure TUTitleBar.UpdateTheme;
//var
//  TM: TUCustomThemeManager;
begin
  UpdateColors;
//  TM:=SelectThemeManager(Self);
//  if TM.ThemeUsed = utLight then
//    Font.Color := $000000
//  else
//    Font.Color := $FFFFFF;
  //
  Repaint;
end;

//  CUSTOM METHODS

procedure TUTitleBar.Paint;
var
  TextRect: TRect;
begin
//  inherited;

  //  Do not paint background
//  Canvas.Brush.Style := bsClear;
//  Canvas.Font.Assign(Font);

  if UseSystemCaptionColor and IsColorOnBorderEnabled then begin
    Canvas.Brush.Handle := CreateSolidBrushWithAlpha(BackColor, 255);
    Canvas.FillRect(Rect(0, 0, Width, Height));
  end
  else
    Canvas.Brush.Style := bsClear;

  Canvas.Font.Assign(Font);
  Canvas.Font.Color := TextColor;

  //  Draw text
  TextRect := Rect(TextPosition, 0, Width, Height);
  DrawTextRect(Canvas, Alignment, taVerticalCenter, TextRect, Caption, False, True);
end;

procedure TUTitleBar.WMLButtonDblClk(var Msg: TWMLButtonDblClk);
var
  ParentForm: TCustomForm;
begin
  inherited;

  if DoubleClick then begin
    ParentForm := GetParentForm(Self, True);
    if (ParentForm <> Nil) and (ParentForm is TForm) then begin
      if biMaximize in (ParentForm as TForm).BorderIcons then begin
        if ParentForm.WindowState = wsMaximized then
          ParentForm.WindowState := wsNormal
        else if ParentForm.WindowState = wsNormal then
          ParentForm.WindowState := wsMaximized;
      end;
    end;
  end;
end;

procedure TUTitleBar.WMLButtonDown(var Msg: TWMLButtonDown);
begin
  inherited;
  if DragMovement then begin
    ReleaseCapture;
    Parent.Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

procedure TUTitleBar.WMRButtonUp(var Msg: TMessage);
const
  WM_SYSMENU = 787;
var
  P: TPoint;
begin
  inherited;
  if EnableSystemMenu then begin
    P.X := Msg.LParamLo;
    P.Y := Msg.LParamHi;
    P := ClientToScreen(P);
    Msg.LParamLo := P.X;
    Msg.LParamHi := P.Y;
    PostMessage(Parent.Handle, WM_SYSMENU, 0, Msg.LParam);
  end;
end;

procedure TUTitleBar.WMNCHitTest(var Msg: TWMNCHitTest);
var
  P: TPoint;
  ParentForm: TCustomForm;
begin
  inherited;

  ParentForm := GetParentForm(Self, True);
  if (ParentForm <> Nil) and (ParentForm.WindowState = wsNormal) and (Align = alTop) then begin
    P := Point(Msg.Pos.x, Msg.Pos.y);
    P := ScreenToClient(P);
    if P.Y < 5 then
      Msg.Result := HTTRANSPARENT;  //  Send event to parent
  end;
end;

//  CHILD EVENTS

procedure TUTitleBar.BackColor_OnChange(Sender: TObject);
begin
  UpdateTheme;
end;

end.
