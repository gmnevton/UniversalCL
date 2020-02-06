unit UCL.TUBorderlessForm;

interface

uses
  Classes,
  Windows,
  Messages,
  Forms,
  Controls,
  Graphics,
  UCL.TUWPForm;

type
  TUBorderlessForm = class(TUWPForm)
  private
    //  Messages
//    procedure WM_NCCalcSize(var Msg: TWMNCCalcSize); message WM_NCCALCSIZE;
//    procedure WM_NCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;

  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{ TUBorderlessForm }

constructor TUBorderlessForm.Create(AOwner: TComponent);
var
  CurrentScreen: TMonitor;
begin
  inherited Create(AOwner);

  if IsLEWin7 then begin
    SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE) and not WS_CAPTION or WS_MINIMIZEBOX);
    SetWindowPos(Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_DRAWFRAME);
  end;
end;

//procedure TUBorderlessForm.WM_NCCalcSize(var Msg: TWMNCCalcSize);
//var
//  CaptionBarHeight: Integer;
//begin
//  inherited;
//  if BorderStyle = bsNone then
//    Exit;
//
//  if IsLEWin7 then begin
//    if WindowState = wsNormal then
//      CaptionBarHeight := GetBorderSpace(bsTop)
//    else
//      CaptionBarHeight := 0;
//  end
//  else begin
//    CaptionBarHeight := GetSystemMetrics(SM_CYCAPTION);
//    if WindowState = wsNormal then
//      Inc(CaptionBarHeight, GetBorderSpace(bsTop));
//  end;
//
//  Dec(Msg.CalcSize_Params.rgrc[0].Top, CaptionBarHeight);
//end;
//
//procedure TUBorderlessForm.WM_NCHitTest(var Msg: TWMNCHitTest);
//var
//  ResizeSpace: Integer;
//  AllowResize: Boolean;
//begin
//  inherited;
//  ResizeSpace := GetBorderSpace(bsDefault);
//
//  AllowResize := (WindowState = wsNormal) and IsResizeable;
//
//  if AllowResize and (Msg.YPos - BoundsRect.Top <= ResizeSpace) then begin //  Resize top border
//    if Msg.XPos - BoundsRect.Left <= 2 * ResizeSpace then
//      Msg.Result := HTTOPLEFT
//    else if BoundsRect.Right - Msg.XPos <= 2 * ResizeSpace then
//      Msg.Result := HTTOPRIGHT
//    else
//      Msg.Result := HTTOP;
//  end;
//end;

end.
