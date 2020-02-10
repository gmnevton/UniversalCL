unit UCL.TUSmoothBox;

interface

uses
  UCL.IntAnimation,
  UCL.Classes, UCL.Utils, UCL.TUThemeManager,
  Classes, Types,
  Windows, Messages, FlatSB,
  Controls, StdCtrls, Forms, Dialogs, ExtCtrls, Graphics;

type
  TUScrollBarStyle = (sbsMini, sbsFull, sbsNo);

  TUMiniScrollBar = class(TCustomPanel)
    private
      procedure WM_NCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;

    public
      constructor Create(aOwner: TComponent); override;

    published
      property Visible default false;
  end;

  TUSmoothBox = class(TScrollBox, IUThemeComponent)
    private
      var MiniSB: TUMiniScrollBar;
      var MINI_SB_THICKNESS: Byte;
      var MINI_SB_MARGIN: Byte;
      //var MINI_SB_COLOR: TColor;
      var MouseLeave: Boolean;
  
      FThemeManager: TUThemeManager;
      FAniSet: TIntAniSet;

      FScrollCount: Integer;
      FScrollOrientation: TUOrientation;      
      FScrollBarStyle: TUScrollBarStyle;
      FLengthPerStep: Integer;
      FMaxScrollCount: Integer;

      //  Setters
      procedure SetThemeManager(const Value: TUThemeManager);

      //  Messages
      procedure WM_Size(var Msg: TWMSize); message WM_SIZE;
      procedure CM_MouseWheel(var Msg: TCMMouseWheel); message CM_MOUSEWHEEL;
      procedure CM_MouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
      procedure CM_MouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
      procedure WM_NCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;

    protected
      procedure Notification(AComponent: TComponent; Operation: TOperation); override;
      procedure ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND}); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;
      procedure UpdateTheme;

      procedure SetOldSBVisible(IsVisible: Boolean);
      procedure UpdateMiniSB;
      procedure SetMiniSBVisible(IsVisible: Boolean);

    published
      property ThemeManager: TUThemeManager read FThemeManager write SetThemeManager;
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

procedure TUSmoothBox.SetThemeManager(const Value: TUThemeManager);
begin
  if Value <> FThemeManager then begin
    if FThemeManager <> Nil then
      FThemeManager.Disconnect(Self);

    FThemeManager := Value;

    if Value <> Nil then begin
      Value.Connect(Self);
      Value.FreeNotification(Self);
    end;

    UpdateTheme;
  end;
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

  if ThemeManager = nil then begin
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

procedure TUSmoothBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FThemeManager) then
    FThemeManager := nil;
end;

//  MAIN CLASS

constructor TUSmoothBox.Create(aOwner: TComponent);
begin
  inherited;

  //  Internal
  MouseLeave := true;
  MINI_SB_THICKNESS := 2;
  MINI_SB_MARGIN := 3;
  //MINI_SB_COLOR := $7A7A7A;

  //  Parent properties
  BorderStyle := bsNone;
  VertScrollBar.Tracking := true;
  HorzScrollBar.Tracking := true;

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
  MiniSB.Visible := false;
  MiniSB.Width := 0;

  //  Custom AniSet
  FAniSet := TIntAniSet.Create;
  FAniSet.QuickAssign(akOut, afkCubic, 0, 120, 10);
end;

destructor TUSmoothBox.Destroy;
begin
  MiniSB.Free;
  FAniSet.Free;
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
    MiniSB.Visible := false;
    exit;
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

procedure TUSmoothBox.WM_NCHitTest(var Msg: TWMNCHitTest);
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
    if ParentForm is TUWPForm then
      BorderSpace:=TUWPFormAccess(ParentForm).GetBorderSpace(bsDefault);
    //  Send event to parent
    case Align of
      alTop: begin
        // we need to check top, left and right borders
        if (P.Y < BorderSpace) or (P.X < BorderSpace) or (Width - P.X < BorderSpace) then
          Msg.Result := HTTRANSPARENT;
      end;
      alBottom: begin
        // we need to check bottom, left and right borders
        if (Height - P.Y < BorderSpace) or (P.X < BorderSpace) or (Width - P.X < BorderSpace) then
          Msg.Result := HTTRANSPARENT;
      end;
      alLeft: begin
        // we need to check left, top and bottom borders
        if (P.X < BorderSpace) or (P.Y < BorderSpace) or (Height - P.Y < BorderSpace) then
          Msg.Result := HTTRANSPARENT;
      end;
      alRight: begin
        // we need to check right, top and bottom borders
        if (Width - P.X < BorderSpace) or (P.Y < BorderSpace) or (Height - P.Y < BorderSpace) then
          Msg.Result := HTTRANSPARENT;
      end;
    end;
  end;
end;

procedure TUSmoothBox.WM_Size(var Msg: TWMSize);
begin
  inherited;
  if ScrollBarStyle <> sbsFull then
    SetOldSBVisible(false);
end;

procedure TUSmoothBox.CM_MouseEnter(var Msg: TMessage);
begin
  if Win32MajorVersion <> 10 then
    SetFocus;

  if MouseLeave and PtInRect(GetClientRect, ScreenToClient(Mouse.CursorPos)) then begin
    if ScrollBarStyle <> sbsFull then
      SetOldSBVisible(false);
    if ScrollBarStyle = sbsMini then
      SetMiniSBVisible(true);
  end;

  inherited;
end;

procedure TUSmoothBox.CM_MouseLeave(var Msg: TMessage);
begin
  if (ScrollBarStyle = sbsMini) and not PtInRect(GetClientRect, ScreenToClient(Mouse.CursorPos)) then begin
    MouseLeave := true;
    SetMiniSBVisible(false);
  end;

  inherited;
end;

procedure TUSmoothBox.CM_MouseWheel(var Msg: TCMMouseWheel);
var
  SB: TControlScrollBar;
  Ani: TIntAni;
  Sign: Integer;
begin
  inherited;

  if not PtInRect(GetClientRect, ScreenToClient(Mouse.CursorPos)) then
    exit;

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

    if FScrollCount = 0 then
      begin
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

constructor TUMiniScrollBar.Create(aOwner: TComponent);
begin
  inherited;

{$IF CompilerVersion > 29}
  StyleElements :=[];
{$IFEND}
  BevelOuter := bvNone;
  FullRepaint := false;
  DoubleBuffered := true;

  Visible := false;
end;

procedure TUMiniScrollBar.WM_NCHitTest(var Msg: TWMNCHitTest);
begin
  Msg.Result := HTTRANSPARENT;
end;

end.
