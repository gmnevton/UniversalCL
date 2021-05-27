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
  UCL.Utils,
  UCL.Graphics;

type
  TUTitleBar = class(TUGraphicControl)
  private
    FTextPosition: Integer;
    FAlignment: TAlignment;
    FDragMovement: Boolean;
    FEnableSystemMenu: Boolean;

    //  Mesages
    procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMRButtonUp(var Msg: TMessage); message WM_RBUTTONUP;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;

  protected
    procedure Paint; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // IUThemedComponent
    procedure UpdateTheme; override;

  published
    property TextPosition: Integer read FTextPosition write FTextPosition default 12;
    property Alignment: TAlignment read FAlignment write FAlignment default taLeftJustify;
    property DragMovement: Boolean read FDragMovement write FDragMovement default True;
    property EnableSystemMenu: Boolean read FEnableSystemMenu write FEnableSystemMenu default True;

    property Caption;
    property Height default 32;
  end;

implementation

uses
  SysUtils,
  Types,
  UCL.ThemeManager,
  UCL.Colors;

{ TUTitleBar }

//  MAIN CLASS

constructor TUTitleBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FTextPosition := 12;
  FAlignment := taLeftJustify;
  FDragMovement := True;
  FEnableSystemMenu := True;

//  Font.Name := 'Segoe UI';
//  Font.Size := 9;
  Height := 32;
//  Width := 400;
end;

destructor TUTitleBar.Destroy;
begin
  inherited;
end;

//  THEME

procedure TUTitleBar.UpdateTheme;
var
  TM: TUCustomThemeManager;
begin
  TM:=SelectThemeManager(Self);
  if TM.ThemeUsed = utLight then
    Font.Color := $000000
  else
    Font.Color := $FFFFFF;
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
  Canvas.Brush.Style := bsClear;
  Canvas.Font.Assign(Font);

  //  Draw text
  TextRect := Rect(TextPosition, 0, Width, Height);
  DrawTextRect(Canvas, Alignment, taVerticalCenter, TextRect, Caption, False, True);
end;

procedure TUTitleBar.WMLButtonDblClk(var Msg: TWMLButtonDblClk);
var
  ParentForm: TCustomForm;
begin
  inherited;

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

end.
