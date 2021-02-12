unit UCL.CaptionBar;

interface

uses
  SysUtils,
  Classes,
  Windows,
  Messages,
  Controls,
  Forms,
  Graphics,
  UCL.Classes,
  UCL.Colors,
  UCL.Utils;

type
  TUCaptionBar = class(TUCustomPanel)
  private var
    BackColor, TextColor: TColor;

  private
    FBackColors: TUThemeCaptionBarColorSet;

    FCollapsed: Boolean;
    FDragMovement: Boolean;
    FSystemMenuEnabled: Boolean;
    FUseSystemCaptionColor: Boolean;

    // Internal
    procedure UpdateColors;

    // Setters
    procedure SetBackColors(Value: TUThemeCaptionBarColorSet);
    procedure SetCollapsed(const Value: Boolean);
    procedure SetUseSystemCaptionColor(const Value: Boolean);

    // Child events
    procedure BackColor_OnChange(Sender: TObject);

    // Messages
    procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMRButtonUp(var Msg: TMessage); message WM_RBUTTONUP;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;

  protected
    procedure Paint; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // IUThemedComponent
    procedure UpdateTheme; override;

    //
    procedure UpdateChildControls(const Root: TControl);

  published
    property BackColors: TUThemeCaptionBarColorSet read FBackColors write SetBackColors;

    property Collapsed: Boolean read FCollapsed write SetCollapsed default False;
    property DragMovement: Boolean read FDragMovement write FDragMovement default True;
    property SystemMenuEnabled: Boolean read FSystemMenuEnabled write FSystemMenuEnabled default True;
    property UseSystemCaptionColor: Boolean read FUseSystemCaptionColor write SetUseSystemCaptionColor default False;

    property Align default alTop;
    property Alignment default taLeftJustify;
    property BevelOuter default bvNone;
    property Height default 32;
    property ParentBackground default False;
  end;

implementation

uses
  Types,
  UCL.SystemSettings,
  UCL.ThemeManager,
  UCL.Form,
  UCL.IntAnimation,
  UCL.Graphics;

type
  TUFormAccess = class(TUForm);

{ TUCustomCaptionBar }

// MAIN CLASS

constructor TUCaptionBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  //
  FCollapsed := False;
  FDragMovement := True;
  FSystemMenuEnabled := True;
  FUseSystemCaptionColor := False;

  FBackColors := TUThemeCaptionBarColorSet.Create;
  FBackColors.Assign(CAPTIONBAR_BACK);
  FBackColors.OnChange := BackColor_OnChange;

  Align := alTop;
  Alignment := taLeftJustify;
  Caption := '   Caption bar';
  BevelOuter := bvNone;
//  TabStop := False;
  Height := 32;
//  Font.Name := 'Segoe UI';
//  Font.Size := 9;
//  FullRepaint := True;
end;

destructor TUCaptionBar.Destroy;
begin
  FBackColors.Free;
  inherited;
end;

procedure TUCaptionBar.UpdateColors;
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

procedure TUCaptionBar.SetBackColors(Value: TUThemeCaptionBarColorSet);
begin
  FBackColors.Assign(Value);
end;

procedure TUCaptionBar.SetCollapsed(const Value: Boolean);
var
  Ani: TIntAni;
  Delta: Integer;
begin
  if Value <> FCollapsed then begin
    FCollapsed := Value;

    if IsDesigning then
      Exit;

    ShowCaption := not Value;
    if Value then
      Padding.Bottom := 1
    else
      Padding.Bottom := 0;
    if Value then
      Delta := 1 - Height
    else
      Delta := 32 - Height;

    Ani := TIntAni.Create(Height, Delta,
      procedure (V: Integer)
      begin
        Height := V;
      end, Nil);
    Ani.AniSet.QuickAssign(akOut, afkQuartic, 0, 120, 12);
    Ani.Start;
  end;
end;

procedure TUCaptionBar.SetUseSystemCaptionColor(const Value: Boolean);
begin
  if FUseSystemCaptionColor <> Value then begin
    FUseSystemCaptionColor := Value;
    UpdateTheme;
  end;
end;

procedure TUCaptionBar.UpdateTheme;
begin
  UpdateColors;
  Repaint;
  UpdateChildControls(Self);
end;

procedure TUCaptionBar.Paint;
begin
//  if IsDesigning then begin
//    // Do not inherited
//    inherited;
//    Exit;
//  end;
  //  Paint background
  Canvas.Brush.Color := BackColor;
  Canvas.FillRect(Rect(0, 0, Width, Height));

  //  Draw text
  if ShowCaption then begin
    Canvas.Font.Assign(Font);
    Canvas.Font.Color := TextColor;
    DrawTextRect(Canvas, Alignment, VerticalAlignment, Rect(0, 0, Width, Height), Caption, False);
  end;
end;

procedure TUCaptionBar.UpdateChildControls(const Root: TControl);
var
  i: Integer;
  control: TControl;
begin
  if Root is TWinControl then begin
    for i := 0 to TWinControl(Root).ControlCount - 1 do begin
      control := TWinControl(Root).Controls[i];
      if control = Root then
        Continue;
      //
      if TUThemeManager.IsThemingAvailable(control) then
        (control as IUThemedComponent).UpdateTheme;
      //
      if control is TWinControl then begin
        if TWinControl(control).ControlCount > 0 then
          UpdateChildControls(control);
      end
      else if control is TGraphicControl then begin
        TGraphicControl(control).Invalidate;
      end;
    end;
  end
  else if Root is TGraphicControl then begin
    TGraphicControl(Root).Invalidate;
  end;
end;

// MESSAGES

procedure TUCaptionBar.WMLButtonDblClk(var Msg: TWMLButtonDblClk);
var
  ParentForm: TCustomForm;
begin
  inherited;
  if IsDesigning then
    Exit;

  ParentForm := GetParentForm(Self, True);
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
  if IsDesigning then
    Exit;

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
  if IsDesigning then
    Exit;

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
  if IsDesigning then
    Exit;

  ParentForm := GetParentForm(Self, True);
  if (ParentForm.WindowState = wsNormal) and (Align = alTop) then begin
    P := Point(Msg.Pos.x, Msg.Pos.y);
    P := ScreenToClient(P);
    BorderSpace:=8;
    if ParentForm is TUForm then
      BorderSpace:=TUFormAccess(ParentForm).GetBorderSpace(bsTop);
    if P.Y < BorderSpace then
      Msg.Result := HTTRANSPARENT;  //  Send event to parent
  end;
end;

procedure TUCaptionBar.CMMouseEnter(var Msg: TMessage);
var
  ParentForm: TCustomForm;
begin
  inherited;
  if IsDesigning then
    Exit;

  ParentForm := GetParentForm(Self, True);
  if (ParentForm is TUForm) and (ParentForm as TUForm).FullScreen then
    Collapsed := False;
end;

procedure TUCaptionBar.CMMouseLeave(var Msg: TMessage);
var
  ParentForm: TCustomForm;
begin
  inherited;
  if IsDesigning then
    Exit;

  ParentForm := GetParentForm(Self, True);
  if (ParentForm is TUForm) and (ParentForm as TUForm).FullScreen then
    if not PtInRect(GetClientRect, ScreenToClient(Mouse.CursorPos)) then
      Collapsed := True;
end;

//  CHILD EVENTS

procedure TUCaptionBar.BackColor_OnChange(Sender: TObject);
begin
  UpdateTheme;
end;

end.
