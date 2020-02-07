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
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  UxTheme,
  Themes,
  Dwmapi;

{ TUBorderlessForm }

constructor TUBorderlessForm.Create(AOwner: TComponent);
var
  wta: WTA_OPTIONS;
  Flag: LongInt;
begin
  inherited Create(AOwner);

  BorderStyle:=bsSizeable;

  // TIP: how to maintain DWM shadow
  // Source: https://stackoverflow.com/a/50580016/2111514

  if HandleAllocated and ThemeServices.ThemesEnabled and DwmCompositionEnabled and IsLEWin7 then begin
    wta.dwFlags := WTNCA_NODRAWCAPTION or WTNCA_NODRAWICON;
    wta.dwMask  := WTNCA_NODRAWCAPTION or WTNCA_NODRAWICON;
    SetWindowThemeAttribute(Self.Handle, WTA_NONCLIENT, @wta, SizeOf(WTA_OPTIONS));

    Flag := DWMNCRP_ENABLED;
    DwmSetWindowAttribute(Handle, DWMWA_ALLOW_NCPAINT, @Flag, SizeOf(Flag));
    SetWindowPos(Self.Handle, 0, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOSENDCHANGING or SWP_FRAMECHANGED);
  end;

  //if IsLEWin7 then begin
    //SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE) and not WS_CAPTION or WS_MINIMIZEBOX);
    //SetWindowPos(Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_DRAWFRAME);
  //end;
end;

procedure TUBorderlessForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

  Params.Style := Params.Style and not WS_DLGFRAME;
end;

end.
