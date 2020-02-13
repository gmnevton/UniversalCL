unit UCL.TUCaptionBar;

interface

uses
  UCL.Classes, UCL.TUThemeManager, UCL.Utils,
  Windows, Messages,
  Classes,
  Controls, ExtCtrls, Forms, Graphics;

type
  TUCaptionBar = class(TPanel, IUThemeComponent)
    private
      FThemeManager: TUThemeManager;

      FDragMovement: Boolean;
      FSystemMenuEnabled: Boolean;
      FCustomColor: TColor;

      //  Setters
      procedure SetThemeManager; // (const Value: TUThemeManager);

      //  Messages
      procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
      procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
      procedure WMRButtonUp(var Msg: TMessage); message WM_RBUTTONUP;
      procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;

    protected
      procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    public
      constructor Create(aOwner: TComponent); override;
      procedure UpdateTheme;

    published
      property ThemeManager: TUThemeManager read FThemeManager; // write SetThemeManager;

      property DragMovement: Boolean read FDragMovement write FDragMovement default true;
      property SystemMenuEnabled: Boolean read FSystemMenuEnabled write FSystemMenuEnabled default true;
      property CustomColor: TColor read FCustomColor write FCustomColor default $D77800;
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
//  if Value <> FThemeManager then begin
//    if FThemeManager <> Nil then
//      FThemeManager.Disconnect(Self);
//
//    FThemeManager := Value;
//
//    if Value <> Nil then begin
//      Value.Connect(Self);
//      Value.FreeNotification(Self);
//    end;
//
//    UpdateTheme;
//  end;
  FThemeManager := GetCommonThemeManager;
end;

procedure TUCaptionBar.UpdateTheme;
begin
  //  Background color
  if ThemeManager = nil then
    Color := CustomColor
  else if ThemeManager.Theme = utLight then
    Color := $F2F2F2
  else
    Color := $2B2B2B;

  //  Font color
  Font.Color := GetTextColorFromBackground(Color);
end;

procedure TUCaptionBar.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FThemeManager) then
    FThemeManager := nil;
end;

// MAIN CLASS

constructor TUCaptionBar.Create(aOwner: TComponent);
begin
  inherited;
  FDragMovement := true;
  FSystemMenuEnabled := true;
  FCustomColor := $D77800;

  Align := alTop;
  Alignment := taLeftJustify;
  Caption := '   TUCaptionBar';
  BevelOuter := bvNone;
  TabStop := false;
  Height := 32;
  Font.Name := 'Segoe UI';
  Font.Size := 9;
  FullRepaint := true;

  UpdateTheme;
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

end.
