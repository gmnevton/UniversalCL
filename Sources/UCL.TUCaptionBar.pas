unit UCL.TUCaptionBar;

interface

uses
  SysUtils,
  Classes,
  Windows,
  Messages,
  Controls,
  ExtCtrls,
  Forms,
  Graphics,
  UCL.Classes,
  UCL.TUThemeManager,
  UCL.Utils;

type
  TUCaptionBar = class(TPanel, IUThemeComponent)
  private
    FThemeManager: TUThemeManager;
    FBackColor: TUThemeColorSet;

    FDragMovement: Boolean;
    FSystemMenuEnabled: Boolean;
    FCustomColor: TColor;

    //  Setters
    procedure SetThemeManager; // (const Value: TUThemeManager);

    //  Child events
    procedure BackColor_OnChange(Sender: TObject);

    //  Messages
    procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMRButtonUp(var Msg: TMessage); message WM_RBUTTONUP;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;

  protected
    //procedure Notification(AComponent: TComponent; Operation: TOperation); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure UpdateTheme;

  published
    property ThemeManager: TUThemeManager read FThemeManager; // write SetThemeManager;
    property BackColor: TUThemeColorSet read FBackColor write FBackColor;

    property DragMovement: Boolean read FDragMovement write FDragMovement default true;
    property SystemMenuEnabled: Boolean read FSystemMenuEnabled write FSystemMenuEnabled default true;
    property CustomColor: TColor read FCustomColor write FCustomColor default $D77800;

    property Align default alTop;
    property Alignment default taLeftJustify;
    property BevelOuter default bvNone;
    property Height default 32;
  end;

implementation

uses
  UCL.TUWPForm;

type
  TUWPFormAccess = class(TUWPForm);

{ TUCustomCaptionBar }

//  THEME

procedure TUCaptionBar.SetThemeManager; // (const Value: TUThemeManager);
begin
  FThemeManager := GetCommonThemeManager;
  UpdateTheme;
end;

procedure TUCaptionBar.UpdateTheme;
var
  Back: TUThemeColorSet;
begin
  //  Background color
  if ThemeManager = Nil then
    //Color := CustomColor // do nothing
  else begin
    //  Select default or custom style
    if not BackColor.Enabled then
      Back := CAPTIONBAR_BACK
    else
      Back := BackColor;

    Color := Back.GetColor(ThemeManager);
    Font.Color := GetTextColorFromBackground(Color);
  end;
end;

destructor TUCaptionBar.Destroy;
begin
  if FThemeManager <> Nil then
    FThemeManager.Disconnect(Self);
  inherited;
end;
{
procedure TUCaptionBar.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FThemeManager) then
    FThemeManager := nil;
end;
}
// MAIN CLASS

constructor TUCaptionBar.Create(aOwner: TComponent);
begin
  inherited;
  FThemeManager := Nil;

  FDragMovement := true;
  FSystemMenuEnabled := true;
  FCustomColor := $D77800;

  Align := alTop;
  Alignment := taLeftJustify;
  Caption := '   TUCaptionBar';
  BevelOuter := bvNone;
//  TabStop := False;
  Height := 32;
//  Font.Name := 'Segoe UI';
//  Font.Size := 9;
//  FullRepaint := True;

  FBackColor := TUThemeColorSet.Create;
  FBackColor.OnChange := BackColor_OnChange;
  FBackColor.Assign(CAPTIONBAR_BACK);

  if GetCommonThemeManager <> Nil then
    GetCommonThemeManager.Connect(Self);

//  UpdateTheme;
end;

// MESSAGES

procedure TUCaptionBar.WMLButtonDblClk(var Msg: TWMLButtonDblClk);
var
  ParentForm: TCustomForm;
begin
  inherited;

  ParentForm := GetParentForm(Self, true);
  if (ParentForm is TForm) and (biMaximize in (ParentForm as TForm).BorderIcons) then begin
    if ParentForm.WindowState = wsMaximized then
      ParentForm.WindowState := wsNormal
    else if ParentForm.WindowState = wsNormal then
      ParentForm.WindowState := wsMaximized;
  end;
end;

procedure TUCaptionBar.WMLButtonDown(var Msg: TWMLButtonDown);
begin
  inherited;
  if DragMovement then begin
    ReleaseCapture;
    Parent.Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

procedure TUCaptionBar.WMRButtonUp(var Msg: TMessage);
const
  WM_SYSMENU = 787;
var
  P: TPoint;
begin
  inherited;
  if SystemMenuEnabled then begin
    P.X := Msg.LParamLo;
    P.Y := Msg.LParamHi;
    P := ClientToScreen(P);
    Msg.LParamLo := P.X;
    Msg.LParamHi := P.Y;
    PostMessage(Parent.Handle, WM_SYSMENU, 0, Msg.LParam);
  end;
end;

procedure TUCaptionBar.WMNCHitTest(var Msg: TWMNCHitTest);
var
  P: TPoint;
  ParentForm: TCustomForm;
  BorderSpace: Integer;
begin
  inherited;

  ParentForm := GetParentForm(Self, True);
  if (ParentForm.WindowState = wsNormal) and (Align = alTop) then begin
    P := Point(Msg.Pos.x, Msg.Pos.y);
    P := ScreenToClient(P);
    BorderSpace:=8;
    if ParentForm is TUWPForm then
      BorderSpace:=TUWPFormAccess(ParentForm).GetBorderSpace(bsTop);
    if P.Y < BorderSpace then
      Msg.Result := HTTRANSPARENT;  //  Send event to parent
  end;
end;

//  CHILD EVENTS

procedure TUCaptionBar.BackColor_OnChange(Sender: TObject);
begin
  UpdateTheme;
end;

end.
