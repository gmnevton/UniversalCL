unit UCL.TUSmoothBox;

interface

uses
  Classes,
  Types,
  Windows,
  Messages,
  FlatSB,
  Controls,
  StdCtrls,
  Forms,
  Dialogs,
  ExtCtrls,
  Graphics,
  UCL.IntAnimation,
  UCL.Classes,
  UCL.Utils,
  UCL.TUThemeManager;

type
  TUScrollBarStyle = (sbsMini, sbsFull, sbsNo);

  TUMiniScrollBar = class(TCustomPanel)
  private
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;

  public
    constructor Create(AOwner: TComponent); override;

  published
    property Visible default False;
  end;

  TUSmoothBox = class(TScrollBox, IUThemeComponent)
  private var
    MiniSB: TUMiniScrollBar;
    MINI_SB_THICKNESS: Byte;
    MINI_SB_MARGIN: Byte;
    //MINI_SB_COLOR: TColor;
    MouseLeave: Boolean;
    canMouseEnter: Boolean;

  private
    FThemeManager: TUThemeManager;
    FAniSet: TIntAniSet;

    FScrollCount: Integer;
    FScrollOrientation: TUOrientation;
    FScrollBarStyle: TUScrollBarStyle;
    FLengthPerStep: Integer;
    FMaxScrollCount: Integer;

    //  Setters
    procedure SetThemeManager; //(const Value: TUThemeManager);

    //  Messages
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure CMMouseWheel(var Msg: TCMMouseWheel); message CM_MOUSEWHEEL;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;

  protected
    //procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND}); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure UpdateTheme;

    procedure SetOldSBVisible(IsVisible: Boolean);
    procedure UpdateMiniSB;
    procedure SetMiniSBVisible(IsVisible: Boolean);

  published
    property ThemeManager: TUThemeManager read FThemeManager; // write SetThemeManager;
    property AniSet: TIntAniSet read FAniSet write FAniSet;

    property ScrollCount: Integer read FScrollCount;
    property ScrollOrientation: TUOrientation read FScrollOrientation write FScrollOrientation default oVertical;
    property ScrollBarStyle: TUScrollBarStyle read FScrollBarStyle write FScrollBarStyle default sbsMini;
    property LengthPerStep: Integer read FLengthPerStep write FLengthPerStep default 4;
    property MaxScrollCount: Integer read FMaxScrollCount write FMaxScrollCount default 8;
  end;

implementation

uses
  SysUtils,
  UCL.Colors,
  UCL.TUWPForm;

type
  TUWPFormAccess = class(TUWPForm);

{ TUSmoothBox }

//  THEME

procedure TUSmoothBox.SetThemeManager; // (const Value: TUThemeManager);
begin
  FThemeManager := GetCommonThemeManager;
  UpdateTheme;
end;

procedure TUSmoothBox.UpdateTheme;
begin
  //  Background color
//  if ThemeManager = nil then
//    Color := $E6E6E6
//  else if ThemeManager.Theme = utLight then
//    Color := $E6E6E6
//  else
//    Color := $1F1F1F;

  if ThemeManager = Nil then begin
    Color := SCROLLBOX_BACK_NIL;
    MiniSB.Color := MINI_SB_COLOR_NIL;
  end
  else if ThemeManager.Theme = utLight then begin
    Color := SCROLLBOX_BACK_LIGHT;
    MiniSB.Color := MINI_SB_COLOR_LIGHT;
  end
  else begin
    Color := SCROLLBOX_BACK_DARK;
    MiniSB.Color := MINI_SB_COLOR_DARK;
  end;
end;
{
procedure TUSmoothBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FThemeManager) then
    FThemeManager := nil;
end;
}
//  MAIN CLASS

constructor TUSmoothBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FThemeManager := Nil;

  //  Internal
  MouseLeave := True;
  canMouseEnter := True;
  MINI_SB_THICKNESS := 2;
  MINI_SB_MARGIN := 3;
  //MINI_SB_COLOR := $7A7A7A;

  //  Parent properties
  BorderStyle := bsNone;
  VertScrollBar.Tracking := True;
  HorzScrollBar.Tracking := True;

  //  Fields
  FScrollCount := 0;
  FScrollOrientation := oVertical;
  FScrollBarStyle := sbsMini;
  FLengthPerStep := 4;
  FMaxScrollCount := 8;

  //  Mini scrollbar
  MiniSB := TUMiniScrollBar.Create(Self);
  MiniSB.Color := MINI_SB_COLOR_NIL;
  MiniSB.Parent := Self;
  MiniSB.SetSubComponent(true);
  MiniSB.Visible := False;
  MiniSB.Width := 0;

  //  Custom AniSet
  FAniSet := TIntAniSet.Create;
  FAniSet.QuickAssign(akOut, afkCubic, 0, 120, 10);

  if GetCommonThemeManager <> Nil then
    GetCommonThemeManager.Connect(Self);
end;

destructor TUSmoothBox.Destroy;
begin
  MiniSB.Free;
  FAniSet.Free;
  if FThemeManager <> Nil then
    FThemeManager.Disconnect(Self);
  inherited;
end;

//  CUSTOM METHODS

procedure TUSmoothBox.ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND});
begin
  inherited;
  MINI_SB_THICKNESS := MulDiv(MINI_SB_THICKNESS, M, D);
  MINI_SB_MARGIN := MulDiv(MINI_SB_MARGIN, M, D);
  FLengthPerStep := MulDiv(FLengthPerStep, M, D);
end;

//  UTILS

procedure TUSmoothBox.SetOldSBVisible(IsVisible: Boolean);
begin
  if not (csDesigning in ComponentState) then
    FlatSB_ShowScrollBar(Handle, SB_BOTH, IsVisible);
end;

procedure TUSmoothBox.UpdateMiniSB;
var
  SB: TControlScrollBar;
  ControlSize: Integer;
  ThumbPos, ThumbSize: Integer;
begin
  //  Get orientation values
  if ScrollOrientation = oVertical then begin
    SB := VertScrollBar;
    ControlSize := Height;
  end
  else begin
    SB := HorzScrollBar;
    ControlSize := Width;
  end;

  if (SB.Range = 0) or (SB.Range < ControlSize) then begin
    MiniSB.Visible := False;
    Exit;
  end;

  ThumbSize := Round(ControlSize * ControlSize / SB.Range);
  ThumbPos := Round(ControlSize * SB.Position / SB.Range);

  if ScrollOrientation = oVertical then
    (MiniSB as TControl).SetBounds(Width - MINI_SB_MARGIN - MINI_SB_THICKNESS, ThumbPos, MINI_SB_THICKNESS, ThumbSize)
  else 
    (MiniSB as TControl).SetBounds(ThumbPos, Height - MINI_SB_MARGIN - MINI_SB_THICKNESS, ThumbSize, MINI_SB_THICKNESS);
end;

procedure TUSmoothBox.SetMiniSBVisible(IsVisible: Boolean);
begin
  MiniSB.Visible := IsVisible;
  if IsVisible then begin
    UpdateMiniSB;
    MiniSB.BringToFront;
  end;
end;

//  MESSAGES

procedure TUSmoothBox.WMNCHitTest(var Msg: TWMNCHitTest);

//  procedure SendLeavingMsg;
//  begin
//    PostMessage(Self.Handle, CM_MOUSELEAVE, 0, 1);
//  end;

var
  P: TPoint;
  ParentForm: TCustomForm;
  BorderSpace: Integer;
begin
  inherited;

  ParentForm := GetParentForm(Self, True);
  if (ParentForm.WindowState = wsNormal) and (Align <> alNone) then begin
    if Align = alCustom then
      Exit;
    //
    P := Point(Msg.Pos.x, Msg.Pos.y);
    P := ScreenToClient(P);
    BorderSpace:=5;
    if MiniSB.Visible then
      BorderSpace := MINI_SB_MARGIN
    else if ParentForm is TUWPForm then
      BorderSpace:=TUWPFormAccess(ParentForm).GetBorderSpace(bsDefault);
    //  Send event to parent
    case Align of
      alTop: begin
        // we need to check top, left and right borders
        if (P.Y < BorderSpace) or (P.X < BorderSpace) or (Width - P.X < BorderSpace) then begin
//          SendLeavingMsg;
          Msg.Result := HTTRANSPARENT;
        end;
      end;

      alBottom: begin
        // we need to check bottom, left and right borders
        if (Height - P.Y < BorderSpace) or (P.X < BorderSpace) or (Width - P.X < BorderSpace) then begin
//          SendLeavingMsg;
          Msg.Result := HTTRANSPARENT;
        end;
      end;

      alLeft: begin
        // we need to check left, top and bottom borders
        if (P.X < BorderSpace) or (P.Y < BorderSpace) or (Height - P.Y < BorderSpace) then begin
//          SendLeavingMsg;
          Msg.Result := HTTRANSPARENT;
        end;
      end;

      alRight: begin
        // we need to check right, top and bottom borders
        if (Width - P.X < BorderSpace) or (P.Y < BorderSpace) or (Height - P.Y < BorderSpace) then begin
//          SendLeavingMsg;
          Msg.Result := HTTRANSPARENT;
        end;
      end;
    end;
  end;
end;

procedure TUSmoothBox.WMSize(var Msg: TWMSize);
begin
  inherited;
  if ScrollBarStyle <> sbsFull then
    SetOldSBVisible(false);
end;

procedure TUSmoothBox.CMMouseEnter(var Msg: TMessage);
begin
  if Win32MajorVersion <> 10 then
    SetFocus;

  if MouseLeave and PtInRect(GetClientRect, ScreenToClient(Mouse.CursorPos)) then begin
    if ScrollBarStyle <> sbsFull then
      SetOldSBVisible(False);
    if ScrollBarStyle = sbsMini then
      SetMiniSBVisible(True);
  end;

  inherited;
end;

procedure TUSmoothBox.CMMouseLeave(var Msg: TMessage);
begin
  if (ScrollBarStyle = sbsMini) and (not PtInRect(GetClientRect, ScreenToClient(Mouse.CursorPos)) or (Msg.LParam = 1)) then begin
    if Msg.LParam = 1 then
      Msg.LParam := 0;
    MouseLeave := true;
    SetMiniSBVisible(false);
  end;

  inherited;
end;

procedure TUSmoothBox.CMMouseWheel(var Msg: TCMMouseWheel);
var
  SB: TControlScrollBar;
  Ani: TIntAni;
  Sign: Integer;
begin
  inherited;

  if not PtInRect(GetClientRect, ScreenToClient(Mouse.CursorPos)) then
    Exit;

  if ScrollOrientation = oVertical then
    SB := VertScrollBar
  else 
    SB := HorzScrollBar;
  
  //  Scroll by touchpad
  if (Abs(Msg.WheelDelta) < 100) or (csDesigning in ComponentState) then begin
    if csDesigning in ComponentState then
      Msg.WheelDelta := 10 * Msg.WheelDelta div Abs(Msg.WheelDelta);

    DisableAlign;
    SB.Position := SB.Position - Msg.WheelDelta;
    if ScrollBarStyle = sbsMini then
      UpdateMiniSB;
    EnableAlign;
  end
  else begin //  Scroll by mouse
    if FScrollCount >= MaxScrollCount then
      Exit;

    if FScrollCount = 0 then begin
      DisableAlign;
      Mouse.Capture := Handle;
    end;

    Inc(FScrollCount);
    Sign := Msg.WheelDelta div Abs(Msg.WheelDelta);

    Ani := TIntAni.Create(1, +LengthPerStep, nil, nil);
    Ani.AniSet.Assign(Self.AniSet);

    if ScrollBarStyle = sbsMini then
      Ani.OnSync :=
        procedure (V: Integer)
        begin
          SB.Position := SB.Position - V * Sign;
          UpdateMiniSB;
        end
    else
      Ani.OnSync :=
        procedure (V: Integer)
        begin
          SB.Position := SB.Position - V * Sign;
        end;

    Ani.OnDone :=
      procedure
      begin
        if ScrollBarStyle <> sbsFull then
          SetOldSBVisible(false);
        dec(FScrollCount);
        if FScrollCount = 0 then
          begin
            EnableAlign;
            Mouse.Capture := 0;
          end;
      end;
    Ani.Start;
  end;
end;

{ TUMiniScrollBar }

constructor TUMiniScrollBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

{$IF CompilerVersion > 29}
  StyleElements :=[];
{$IFEND}
  BevelOuter := bvNone;
  BevelInner := bvNone;
  FullRepaint := False;
  DoubleBuffered := True;
  ParentBackground := False;
  ParentColor := False;

  Visible := False;
end;

procedure TUMiniScrollBar.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  Msg.Result := HTTRANSPARENT;
end;

end.
