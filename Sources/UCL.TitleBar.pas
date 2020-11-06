unit UCL.TitleBar;

interface

{$IF CompilerVersion > 29}
  {$LEGACYIFEND ON}
{$IFEND}

uses
  Classes,
  Windows,
  Messages,
  Controls,
  Graphics,
  Forms,
  UCL.Classes,
  UCL.ThemeManager,
  UCL.Utils,
  UCL.Graphics;

type
  TUTitleBar = class(TUGraphicControl, IUThemedComponent)
  private
    FThemeManager: TUThemeManager;

    FTextPosition: Integer;
    FAlignment: TAlignment;
    FDragMovement: Boolean;
    FEnableSystemMenu: Boolean;

    //  Setters
    procedure SetThemeManager(const Value: TUThemeManager);

    //  Mesages
    procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMRButtonUp(var Msg: TMessage); message WM_RBUTTONUP;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;

  protected
    //procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // IUThemedComponent
    procedure UpdateTheme;
    function IsCustomThemed: Boolean;
    function CustomThemeManager: TUCustomThemeManager;

  published
    property ThemeManager: TUThemeManager read FThemeManager write SetThemeManager;

    property TextPosition: Integer read FTextPosition write FTextPosition default 12;
    property Alignment: TAlignment read FAlignment write FAlignment default taLeftJustify;
    property DragMovement: Boolean read FDragMovement write FDragMovement default true;
    property EnableSystemMenu: Boolean read FEnableSystemMenu write FEnableSystemMenu default true;

    property Caption;
    property Height default 32;
  end;

implementation

uses
  Types;

{ TUTitleBar }

//  MAIN CLASS

constructor TUTitleBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FThemeManager := Nil;

  FTextPosition := 12;
  FAlignment := taLeftJustify;
  FDragMovement := true;
  FEnableSystemMenu := true;

//  Font.Name := 'Segoe UI';
//  Font.Size := 9;
  Height := 32;
//  Width := 400;

  if GetCommonThemeManager <> Nil then
    GetCommonThemeManager.Connect(Self);
end;

destructor TUTitleBar.Destroy;
begin
  if FThemeManager <> Nil then
    FThemeManager.Disconnect(Self);
  inherited;
end;

//  THEME

procedure TUTitleBar.SetThemeManager(const Value: TUThemeManager);
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

procedure TUTitleBar.UpdateTheme;
var
  IsLightTheme: Boolean;
begin
  if ThemeManager = Nil then
    IsLightTheme := True
  else
    IsLightTheme := ThemeManager.Theme = ttLight;

  if IsLightTheme then
    Font.Color := $000000
  else
    Font.Color := $FFFFFF;
end;

function TUTitleBar.IsCustomThemed: Boolean;
begin
  Result:=(FThemeManager <> Nil);
end;

function TUTitleBar.CustomThemeManager: TUCustomThemeManager;
begin
  Result:=FThemeManager;
end;

{
procedure TUTitleBar.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FThemeManager) then
    FThemeManager := nil;
end;
}

//  CUSTOM METHODS

procedure TUTitleBar.Paint;
var
  TextRect: TRect;
begin
  inherited;

  //  Do not paint background
  Canvas.Brush.Style := bsClear;
  Canvas.Font := Font;

  //  Draw text
  TextRect := Rect(TextPosition, 0, Width, Height);
  DrawTextRect(Canvas, Alignment, taVerticalCenter, TextRect, Caption, true);
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
