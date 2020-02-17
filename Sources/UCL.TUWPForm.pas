unit UCL.TUWPForm;

interface

uses
  Classes,
  SysUtils,
  Windows,
  Messages,
  Forms,
  Controls,
  ExtCtrls,
  Graphics,
  UCL.Classes,
  UCL.TUThemeManager,
  UCL.TUTooltip;

type
  TUWPForm = class(TForm, IUThemeComponent)
  public type
    TBorderSide = (bsDefault, bsTop, bsLeft, bsBottom, bsRight);
  public const
    DEFAULT_BORDERCOLOR_ACTIVE_LIGHT = $707070;
    DEFAULT_BORDERCOLOR_ACTIVE_DARK = $242424;
    DEFAULT_BORDERCOLOR_INACTIVE_LIGHT = $9B9B9B;
    DEFAULT_BORDERCOLOR_INACTIVE_DARK = $414141;

  protected var
    BorderColor: TColor;

  protected
    FThemeManager: TUThemeManager;
    FResizable: Boolean;
    FPPI: Integer;
    FIsActive: Boolean;
    FFitDesktopForPopup: Boolean;
    FDrawBorder: Boolean;

    //  Setters
    //procedure SetThemeManager(const Value: TUThemeManager);

  private
    //  Messages
    procedure WMActivate(var Msg: TWMActivate); message WM_ACTIVATE;
    procedure WMDPIChanged(var Msg: TWMDpi); message WM_DPICHANGED;
    procedure WMDWMColorizationColorChanged(var Msg: TMessage); message WM_DWMCOLORIZATIONCOLORCHANGED;
    //procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMNCPaint(var Msg: TWMNCPaint); message WM_NCPAINT;
    procedure WMNCCalcSize(var Msg: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;

  protected
    //  Internal
    function IsLEWin7: Boolean; virtual; // LE - less equal than
    function IsResizeable: Boolean; virtual;
    function IsBorderless: Boolean; virtual;
    function HasBorder: Boolean; virtual;
    function GetBorderSpace(const Side: TBorderSide): Integer; virtual;
    function GetBorderSpaceWin7(const Side: TBorderSide): Integer; virtual;

    procedure SetThemeManager; virtual; // IUThemeControl

    function CanDrawBorder: Boolean; virtual;
    procedure UpdateBorderColor; virtual;
    procedure DoDrawBorder; virtual;

  protected
  {$IF CompilerVersion < 30}
    FCurrentPPI: Integer;
    FIsScaling: Boolean;
    function GetDesignDpi: Integer; virtual;
    function GetParentCurrentDpi: Integer; virtual;
  {$IFEND}
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure Resize; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure UpdateTheme; virtual; // IUThemeControl
  {$IF CompilerVersion < 30}
    procedure ScaleForPPI(NewPPI: Integer); virtual;
  {$IFEND}

  published
    property ThemeManager: TUThemeManager read FThemeManager; // write SetThemeManager;
    property PPI: Integer read FPPI write FPPI default 96;
    property IsActive: Boolean read FIsActive default True;
    property FitDesktopForPopup: Boolean read FFitDesktopForPopup write FFitDesktopForPopup default False;
    property DrawBorder: Boolean read FDrawBorder write FDrawBorder default True;
    property Padding stored False;
    property Resizable: Boolean read FResizable write FResizable default True;
  end;

implementation

uses
  Themes,
  Dwmapi,
  UCL.SystemSettings,
  UCL.Types,
  UCL.Utils;

{ TUWPForm }

constructor TUWPForm.Create(AOwner: TComponent);
var
  CurrentScreen: TMonitor;
begin
  inherited Create(AOwner);

  //  New props
  FIsActive := True;
  FFitDesktopForPopup := False;
  FDrawBorder := True;
  FResizable := True;

  //  Get PPI from current screen
  CurrentScreen := Screen.MonitorFromWindow(Handle);
  FPPI := CurrentScreen.PixelsPerInch;
{$IF CompilerVersion < 30}
  FIsScaling := False;
  FCurrentPPI := FPPI;
{$IFEND}

  //  Common props
  Font.Name := 'Segoe UI';
  Font.Size := 10;

  if GetCommonThemeManager = Nil then
    TUThemeManager.Create(Self);
  FThemeManager := GetCommonThemeManager;
  FThemeManager.Connect(Self);

//  UpdateTheme;
end;

destructor TUWPForm.Destroy;
begin
  if FThemeManager <> Nil then
    FThemeManager.Disconnect(Self);
  inherited;
end;

procedure TUWPForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  //
  //Params.Style := Params.Style or WS_OVERLAPPEDWINDOW;  //  Enabled aerosnap
{.$IF CompilerVersion < 30}
//  with Params do
//    WindowClass.Style := WindowClass.Style or CS_DROPSHADOW;
{.$IFEND}
  //
  Params.WindowClass.style := Params.WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
end;

procedure TUWPForm.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FThemeManager) then
    FThemeManager := Nil;
end;

procedure TUWPForm.Paint;
begin
  inherited;

  if CanDrawBorder and not IsLEWin7 then
    DoDrawBorder;
end;

procedure TUWPForm.Resize;
var
  Space: Integer;
  CurrentScreen: TMonitor;
begin
  inherited;

  if CanDrawBorder and not IsLEWin7 then begin
    Padding.Top := 1;
    if IsLEWin7 then begin
      Padding.Left := 1;
      Padding.Right := 1;
      Padding.Bottom := 1;
    end;
  end
  else begin
    Padding.Top := 0;
    if IsLEWin7 then begin
      Padding.Left := 0;
      Padding.Right := 0;
      Padding.Bottom := 0;
    end;
  end;

  //  Fit window to desktop - for WS_POPUP window style
  //  If not, if not, window fill full screen when maximized
  if FitDesktopForPopup and (WindowState = wsMaximized) and (BorderStyle in [bsDialog, bsSizeToolWin, bsToolWindow]) then begin
    CurrentScreen := Screen.MonitorFromWindow(Handle);
    Space := GetBorderSpace(bsTop);

    Top := - Space;
    Left :=  - Space;
    Width := CurrentScreen.WorkareaRect.Width + 2 * Space;
    Height := CurrentScreen.WorkAreaRect.Height + 2 * Space;
  end;
end;

procedure TUWPForm.SetThemeManager;
begin
  // do nothing here
end;

procedure TUWPForm.UpdateTheme;
begin
  //  Background color & tooltip
  if ThemeManager = Nil then begin
    Color := $FFFFFF;
    HintWindowClass := TULightTooltip; //  Light tooltip
  end
  else if ThemeManager.Theme = utLight then begin
    Color := $FFFFFF;
    HintWindowClass := TULightTooltip;
  end
  else begin
    Color := $000000;
    HintWindowClass := TUDarkTooltip;
  end;

  UpdateBorderColor;
  Invalidate;
end;
{
procedure TUWPForm.SetThemeManager(const Value: TUThemeManager);
begin
//  if Value <> FThemeManager then begin
//    //  Disconnect current TM
//    if FThemeManager <> Nil then
//      FThemeManager.Disconnect(Self);
//    //
//    FThemeManager := Value;
//    //  Connect to new TM
//    if Value <> Nil then begin
//      Value.Connect(Self);
//      Value.FreeNotification(Self);
//    end;
//    UpdateTheme;
//  end;
end;
}
{$REGION 'Messages handling'}
procedure TUWPForm.WMActivate(var Msg: TWMActivate);
begin
  inherited;
  FIsActive := (Msg.Active <> WA_INACTIVE);

  //  Redraw border
  if CanDrawBorder and not IsLEWin7 then
    DoDrawBorder;
end;

procedure TUWPForm.WMDPIChanged(var Msg: TWMDpi);
begin
  PixelsPerInch := Msg.XDpi;
  PPI := Msg.XDpi;
  inherited;
  ScaleForPPI(PPI);
end;

procedure TUWPForm.WMDWMColorizationColorChanged(var Msg: TMessage);
begin
  if ThemeManager <> Nil then
    ThemeManager.Reload;
  inherited;
end;

//procedure TUWPForm.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
//begin
//  Msg.Result := 0;
//end;

procedure TUWPForm.WMNCPaint(var Msg: TWMNCPaint);
var
  DC: HDC;
  R: TRect;
  WindowStyle: Integer;
begin
  inherited;
  //
  if IsLEWin7 then begin
    DC := GetWindowDC(Handle);
    try
      R := ClientRect;
      OffsetRect(R, 1, 1);
      ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
      WindowStyle := GetWindowLong(Handle, GWL_STYLE);
      if WindowStyle and WS_VSCROLL <> 0 then
        ExcludeClipRect(DC, R.Right, R.Top, R.Right + GetSystemMetrics(SM_CXVSCROLL), R.Bottom);
      if WindowStyle and WS_HSCROLL <> 0 then
        ExcludeClipRect(DC, R.Left, R.Bottom, R.Right, R.Bottom + GetSystemMetrics(SM_CXHSCROLL));
      SetRect(R, 0, 0, Width + BorderWidth, Height + BorderWidth);
      if IsColorOnBorderEnabled then begin
        UpdateBorderColor;
        Brush.Color := BorderColor;
      end
      else
        Brush.Color := Self.Color;
      FillRect(DC, R, Brush.Handle);
    finally
      ReleaseDC(Handle, DC);
    end;
  end;
  Msg.Result := 0;
end;

//  if IsLEWin7 then begin
//    dc := GetWindowDc(Handle);
//    try
//      if Msg.RGN = 1 then begin
//        FillRect(dc, Rect(0, 0, Width, Height), GetStockObject(BLACK_BRUSH));
//      end
//      else begin
//        OffsetRgn(Msg.RGN, -Left, -Top);
//        FillRgn(dc, Msg.RGN, GetStockObject(BLACK_BRUSH));
//        OffsetRgn(Msg.RGN, Left, Top);
//      end;
//    finally
//      ReleaseDC(Handle, dc);
//    end;
//  end;

procedure TUWPForm.WMNCCalcSize(var Msg: TWMNCCalcSize);
var
  CaptionBarHeight: Integer;
  BorderWidth: Integer;
  BorderHeight: Integer;
  defMargin: Integer;
  R: TRect;
begin
  inherited;

  if (BorderStyle = bsNone) or not Msg.CalcValidRects then
    Exit;

  CaptionBarHeight := GetSystemMetrics(SM_CYCAPTION);
  defMargin:=0;
  if ThemeServices.ThemesEnabled and DwmCompositionEnabled and IsLEWin7 then
    defMargin:=-1;

  if WindowState = wsNormal then
    Inc(CaptionBarHeight, GetBorderSpace(bsTop) + defMargin);

  R:=Msg.CalcSize_Params.rgrc[0]; // store values

  Dec(R.Top, CaptionBarHeight); //  Hide caption bar
  if IsLEWin7 then begin
    BorderWidth := GetBorderSpace(bsDefault);
    BorderHeight := GetBorderSpace(bsBottom);
    //
    Dec(R.Left, BorderWidth + defMargin); //  Hide borders
    Inc(R.Right, BorderWidth + defMargin); //  Hide borders
    Inc(R.Bottom, BorderHeight + defMargin); //  Hide borders
  end;

  Msg.CalcSize_Params.rgrc[0]:=R;
end;

procedure TUWPForm.WMNCHitTest(var Msg: TWMNCHitTest);
var
  ResizeSpace: Integer;
  ClientPos: TPoint;
begin
  inherited;

  ClientPos := ScreenToClient(Point(Msg.XPos, Msg.YPos));

  case Msg.Result of
    HTCLIENT,
    HTTRANSPARENT: {to be dealt with below};
    HTMINBUTTON,
    HTMAXBUTTON,
    HTCLOSE: begin
      if ControlAtPos(ClientPos, True) <> Nil then begin
        Msg.Result := HTTRANSPARENT; //
        Exit;
      end;
      Msg.Result := HTNOWHERE; // prevent ghost buttons showing when there is no caption bar on form
      Exit;
    end;
  else
    Exit;
  end;

  ResizeSpace := GetBorderSpace(bsDefault);

//  if ClientPos.Y > ResizeSpace then
//    Exit;

  if (WindowState = wsNormal) and (BorderStyle in [bsSizeable, bsSizeToolWin]) then begin
    if (ClientPos.Y <= ResizeSpace) then begin
      if ClientPos.X <= 2 * ResizeSpace then
        Msg.Result := HTTOPLEFT
      else if Width - ClientPos.X <= 2 * ResizeSpace then
        Msg.Result := HTTOPRIGHT
      else
        Msg.Result := HTTOP;
    end
    else if (ClientPos.Y >= Height - ResizeSpace) then begin
      if ClientPos.X <= 2 * ResizeSpace then
        Msg.Result := HTBOTTOMLEFT
      else if Width - ClientPos.X <= 2 * ResizeSpace then
        Msg.Result := HTBOTTOMRIGHT
      else
        Msg.Result := HTBOTTOM;
    end
    else if (ClientPos.X <= ResizeSpace) then begin
      if ClientPos.Y <= 2 * ResizeSpace then
        Msg.Result := HTTOPLEFT
      else if Height - ClientPos.Y <= 2 * ResizeSpace then
        Msg.Result := HTBOTTOMLEFT
      else
        Msg.Result := HTLEFT;
    end
    else if (Width - ClientPos.X <= 2 * ResizeSpace) then begin
      if ClientPos.Y <= 2 * ResizeSpace then
        Msg.Result := HTTOPRIGHT
      else if Height - ClientPos.Y <= 2 * ResizeSpace then
        Msg.Result := HTBOTTOMRIGHT
      else
        Msg.Result := HTRIGHT;
    end;
  end;
  if Msg.Result = HTTRANSPARENT then
    Msg.Result := HTCLIENT;
end;
{$ENDREGION}

{$REGION 'Compatibility with Delphi 2010 plus'}
{$IF CompilerVersion < 30}
function TUWPForm.GetDesignDpi: Integer;
var
  LForm: TCustomForm;
begin
  LForm := GetParentForm(Self);

  if (LForm <> Nil) and (LForm is TForm) then
    Result := TForm(LForm).PixelsPerInch
  else
    Result := Windows.USER_DEFAULT_SCREEN_DPI;
end;

function TUWPForm.GetParentCurrentDpi: Integer;
begin
//  if Parent <> nil then
//    Result := Parent.GetParentCurrentDpi
//  else
    Result := FCurrentPPI;
end;

procedure TUWPForm.ScaleForPPI(NewPPI: Integer);
begin
  if not FIsScaling and (NewPPI > 0) then begin
    FIsScaling := True;
    try
      if FCurrentPPI = 0 then
        FCurrentPPI := GetDesignDpi;

      if NewPPI <> FCurrentPPI then begin
        ChangeScale(NewPPI, FCurrentPPI);
        FCurrentPPI := NewPPI;
      end
    finally
      FIsScaling := False;
    end;
  end;
end;
{$IFEND}
{$ENDREGION}

{$REGION 'Internal functions'}
function TUWPForm.IsLEWin7: Boolean;
begin
  Result := CheckMaxWin32Version(6, 3);
end;

function TUWPForm.IsResizeable: Boolean;
begin
  Result := BorderStyle in [bsSizeable, bsSizeToolWin];
end;

function TUWPForm.IsBorderless: Boolean;
begin
  Result := BorderStyle in [bsNone, bsToolWindow, bsSizeToolWin];
end;

function TUWPForm.HasBorder: Boolean;
begin
  Result := BorderStyle in [bsDialog, bsSingle, bsSizeable];
end;

function TUWPForm.GetBorderSpace(const Side: TBorderSide): Integer;

  function TopSize: Integer;
  begin
    Result := 0;
    case BorderStyle of
      bsSingle     : Result := GetSystemMetrics(SM_CYFIXEDFRAME);
      bsDialog,
      bsToolWindow : Result := GetSystemMetrics(SM_CYDLGFRAME);
      bsSizeable,
      bsSizeToolWin: Result := GetSystemMetrics(SM_CYSIZEFRAME) + GetSystemMetrics(SM_CXPADDEDBORDER);
    end;
  end;

  function LeftRightSize: Integer;
  begin
    Result := 0;
    case BorderStyle of
      bsSingle     : Result := GetSystemMetrics(SM_CXFIXEDFRAME);
      bsDialog,
      bsToolWindow : Result := GetSystemMetrics(SM_CXDLGFRAME);
      bsSizeable,
      bsSizeToolWin: Result := GetSystemMetrics(SM_CXSIZEFRAME) + GetSystemMetrics(SM_CXPADDEDBORDER);
    end;
  end;

  function BottomSize: Integer;
  begin
    Result := 0;
    case BorderStyle of
      bsSingle     : Result := GetSystemMetrics(SM_CYFIXEDFRAME);
      bsDialog,
      bsToolWindow : Result := GetSystemMetrics(SM_CYDLGFRAME);
      bsSizeable,
      bsSizeToolWin: Result := GetSystemMetrics(SM_CYSIZEFRAME);
    end;
  end;

begin
  Result := 0;
  case Side of
    bsDefault: Result := LeftRightSize;
    bsTop    : Result := TopSize;
    bsLeft,
    bsRight  : Result := LeftRightSize;
    bsBottom : Result := BottomSize;
  end;
end;

function TUWPForm.GetBorderSpaceWin7(const Side: TBorderSide): Integer;
begin
  Result := 0;
  case BorderStyle of
    bsSingle     : Result := GetSystemMetrics(SM_CYFIXEDFRAME) - 3;
    bsDialog,
    bsToolWindow : Result := GetSystemMetrics(SM_CYDLGFRAME) - 3;
    bsSizeable,
    bsSizeToolWin: Result := GetSystemMetrics(SM_CYSIZEFRAME) + GetSystemMetrics(SM_CXPADDEDBORDER) - 2;
  end;
end;

function TUWPForm.CanDrawBorder: Boolean;
begin
  Result := DrawBorder and (WindowState = wsNormal) and not IsBorderless;
end;

procedure TUWPForm.UpdateBorderColor;
begin
  if ThemeManager = Nil then
    BorderColor := DEFAULT_BORDERCOLOR_ACTIVE_LIGHT
  else if IsActive then begin //  Active window
    if ThemeManager.ColorOnBorder then
      BorderColor := GetAccentColor
    else if ThemeManager.Theme = utLight then
      BorderColor := DEFAULT_BORDERCOLOR_ACTIVE_LIGHT
    else
      BorderColor := DEFAULT_BORDERCOLOR_ACTIVE_DARK;
  end
  else begin //  In active window
    if ThemeManager.Theme = utLight then
      BorderColor := DEFAULT_BORDERCOLOR_INACTIVE_LIGHT
    else
      BorderColor := DEFAULT_BORDERCOLOR_INACTIVE_DARK;
  end;
end;

procedure TUWPForm.DoDrawBorder;
begin
  UpdateBorderColor;
  Canvas.Brush.Handle := CreateSolidBrushWithAlpha(Color, 255);
  Canvas.Pen.Color := BorderColor;
  Canvas.MoveTo(0, 0);
//  Canvas.LineTo(ClientWidth, 0);
  Canvas.LineTo(Width, 0);  //  Paint top border
  if IsLEWin7 then begin // paint other borders
    Canvas.MoveTo(Width - 1, 0);
    Canvas.LineTo(Width - 1, Height);
    Canvas.MoveTo(Width - 1, Height - 1);
    Canvas.LineTo(0, Height - 1);
    Canvas.LineTo(0, 0);
  end;
end;
{$ENDREGION}

end.
