unit UCL.Graphics;

interface

{$IF CompilerVersion > 29}
  {$LEGACYIFEND ON}
{$IFEND}

uses
  Classes,
  Controls,
  Types,
  Windows,
  Graphics,
  Themes;

{$REGION 'Older Delphi versions'}
{$IF CompilerVersion <= 30}
type
  // Note: tfComposited only supported by ThemeServices.DrawText
  TTextFormats = (tfBottom, tfCalcRect, tfCenter, tfEditControl, tfEndEllipsis,
    tfPathEllipsis, tfExpandTabs, tfExternalLeading, tfLeft, tfModifyString,
    tfNoClip, tfNoPrefix, tfRight, tfRtlReading, tfSingleLine, tfTop,
    tfVerticalCenter, tfWordBreak, tfHidePrefix, tfNoFullWidthCharBreak,
    tfPrefixOnly, tfTabStop, tfWordEllipsis, tfComposited);
  TTextFormat = set of TTextFormats;

const
  DT_NOFULLWIDTHCHARBREAK = $0080000;
  // MASK for tfComposited
  MASK_TF_COMPOSITED      = $00800000;
{$IFEND}  
{$ENDREGION}

function PointInRect(const X, Y: Integer; const Rect: TRect): Boolean; overload;
function PointInRect(const p: TPoint; const Rect: TRect): Boolean; overload;
function PointInRect(const p: TSmallPoint; const Rect: TRect): Boolean; overload;
procedure GetCenterPos(Width, Height: Integer; Rect: TRect; out X, Y: Integer);
procedure MeasureTextRect(const Canvas: TCanvas; HAlign: TAlignment; VAlign: TVerticalAlignment; var Rect: TRect; Text: String; Multiline, TextOnGlass: Boolean);
procedure DrawTextRect(const Canvas: TCanvas; HAlign: TAlignment; VAlign: TVerticalAlignment; Rect: TRect; Text: String; Multiline, TextOnGlass: Boolean);
procedure DrawBorder(const Canvas: TCanvas; R: TRect; Color: TColor; Thickness: Integer; const Overlay: Boolean = False);
procedure DrawFocusRect(const Canvas: TCanvas; R: TRect; Color: TColor);
procedure DrawParentImage(Control: TControl; DC: HDC; InvalidateParent: Boolean = False);
procedure InitBumpMap;
procedure DrawBumpMap(const Canvas: TCanvas; X, Y: Integer; Add: Boolean);

var
  DEFAULT_GLASSTEXT_GLOWSIZE: Byte;

implementation

uses
  SysUtils,
  Forms,
  Messages,
  DwmApi,
  UxTheme,
  UITypes,
  UCL.Classes,
  UCL.Types,
  UCL.Utils;

{$REGION 'Older Delphi versions'}
{$IF CompilerVersion <= 30}
type
  TStyleTextFlag = (stfTextColor, stfBorderColor, stfBorderSize, stfShadowColor, stfShadowOffset, stfGlowSize);
  TStyleTextFlags = set of TStyleTextFlag;

  TStyleTextOptions = record
    Flags: TStyleTextFlags;
    TextColor: TColor;
    BorderColor: TColor;
    BorderSize: Integer;
    ShadowColor: TColor;
    ShadowOffset: TPoint;
    GlowSize: Integer;
  end;

const
  COptions: Array[TStyleTextFlag] of Cardinal = (DTT_TEXTCOLOR, DTT_BORDERCOLOR, DTT_BORDERSIZE, DTT_SHADOWCOLOR, DTT_SHADOWOFFSET, DTT_GLOWSIZE);
{$IFEND}
{$ENDREGION}

const
  HAlignments: Array[TAlignment] of Cardinal = (DT_LEFT, DT_RIGHT, DT_CENTER);
  VAlignments: Array[TVerticalAlignment] of Cardinal = (DT_TOP, DT_BOTTOM, DT_VCENTER);
{$IF CompilerVersion > 29}
  CStates: Array[Boolean] of TThemedTextLabel = (ttlTextLabelDisabled, ttlTextLabelNormal);
{$IFEND}
  BumpMapSize = 320;

var
  BumpMap: Array [0..BumpMapSize - 1, 0..BumpMapSize - 1] of Byte;
  BumpMapInited: Boolean;

function PointInRect(const X, Y: Integer; const Rect: TRect): Boolean;
begin
  Result := (X >= Rect.Left) and (X <= Rect.Right) and
            (Y >= Rect.Top ) and (Y <= Rect.Bottom);
end;

function PointInRect(const p: TPoint; const Rect: TRect): Boolean;
begin
  Result := PointInRect(p.X, p.Y, Rect);
end;

function PointInRect(const p: TSmallPoint; const Rect: TRect): Boolean;
begin
  Result := PointInRect(p.x, p.y, Rect);
end;

procedure GetCenterPos(Width, Height: Integer; Rect: TRect; out X, Y: Integer);
begin
  X := Rect.Left + (Rect.Width - Width) div 2;
  Y := Rect.Top + (Rect.Height - Height) div 2;
end;

{$REGION 'Older Delphi versions'}
{$IF CompilerVersion <= 30}
function TextFlagsToTextFormat(Value: Cardinal): TTextFormat;
begin
  Result := [];
  if (Value and DT_BOTTOM) = DT_BOTTOM then
    Include(Result, tfBottom);
  if (Value and DT_CALCRECT) = DT_CALCRECT then
    Include(Result, tfCalcRect);
  if (Value and DT_CENTER) = DT_CENTER then
    Include(Result, tfCenter);
  if (Value and DT_EDITCONTROL) = DT_EDITCONTROL then
    Include(Result, tfEditControl);
  if (Value and DT_END_ELLIPSIS) = DT_END_ELLIPSIS then
    Include(Result, tfEndEllipsis);
  if (Value and DT_PATH_ELLIPSIS) = DT_PATH_ELLIPSIS then
    Include(Result, tfPathEllipsis);
  if (Value and DT_EXPANDTABS) = DT_EXPANDTABS then
    Include(Result, tfExpandTabs);
  if (Value and DT_EXTERNALLEADING) = DT_EXTERNALLEADING then
    Include(Result, tfExternalLeading);
  if (Value and DT_LEFT) = DT_LEFT then
    Include(Result, tfLeft);
  if (Value and DT_MODIFYSTRING) = DT_MODIFYSTRING then
    Include(Result, tfModifyString);
  if (Value and DT_NOCLIP) = DT_NOCLIP then
    Include(Result, tfNoClip);
  if (Value and DT_NOPREFIX) = DT_NOPREFIX then
    Include(Result, tfNoPrefix);
  if (Value and DT_RIGHT) = DT_RIGHT then
    Include(Result, tfRight);
  if (Value and DT_RTLREADING) = DT_RTLREADING then
    Include(Result, tfRtlReading);
  if (Value and DT_SINGLELINE) = DT_SINGLELINE then
    Include(Result, tfSingleLine);
  if (Value and DT_TOP) = DT_TOP then
    Include(Result, tfTop);
  if (Value and DT_VCENTER) = DT_VCENTER then
    Include(Result, tfVerticalCenter);
  if (Value and DT_WORDBREAK) = DT_WORDBREAK then
    Include(Result, tfWordBreak);
  if (Value and DT_HIDEPREFIX) = DT_HIDEPREFIX then
    Include(Result, tfHidePrefix);
  if (Value and DT_NOFULLWIDTHCHARBREAK) = DT_NOFULLWIDTHCHARBREAK then
    Include(Result, tfNoFullWidthCharBreak);
  if (Value and DT_PREFIXONLY) = DT_PREFIXONLY then
    Include(Result, tfPrefixOnly);
  if (Value and DT_TABSTOP) = DT_TABSTOP then
    Include(Result, tfTabStop);
  if (Value and DT_WORD_ELLIPSIS) = DT_WORD_ELLIPSIS then
    Include(Result, tfWordEllipsis);
  if (Value and MASK_TF_COMPOSITED) = MASK_TF_COMPOSITED then
    Include(Result, tfComposited);
end;

function StyleTextOptionsToDTTOpts(Options: TStyleTextOptions; Flags: TTextFormat): TDTTOpts;
var
  LTextOption: TStyleTextFlag;
begin
  FillChar(Result, SizeOf(TDTTOpts), 0);
  Result.dwSize := SizeOf(TDTTOpts);
  //
  for LTextOption := Low(TStyleTextFlag) to High(TStyleTextFlag) do begin
    if (LTextOption in Options.Flags) then
      Result.dwFlags := Result.dwFlags or COptions[LTextOption];
  end;
  //
  Result.crText         := Graphics.ColorToRGB(Options.TextColor);
  Result.crBorder       := Graphics.ColorToRGB(Options.BorderColor);
  Result.iBorderSize    := Options.BorderSize;
  Result.crShadow       := Graphics.ColorToRGB(Options.ShadowColor);
  Result.ptShadowOffset := Options.ShadowOffset;
  Result.iGlowSize      := Options.GlowSize;
  if (tfComposited in Flags) then
    Result.dwFlags := Result.dwFlags or DTT_COMPOSITED;
  if (tfCalcRect in Flags) then
    Result.dwFlags := Result.dwFlags or DTT_CALCRECT;
end;

procedure DrawGlassText(Canvas: TCanvas; GlowSize: Integer; var Rect: TRect; var Text: String; Format: DWORD; Options: TStyleTextOptions); overload;
var
  DTTOpts: TDTTOpts;
begin
  if Win32MajorVersion < 6 then begin
    DrawTextW(Canvas.Handle, PWideChar(Text), Length(Text), Rect, Format);
    Exit;
  end;
  DTTOpts:=StyleTextOptionsToDTTOpts(Options, TextFlagsToTextFormat(Format));
  with ThemeServices.GetElementDetails(teEditTextNormal) do
    DrawThemeTextEx(ThemeServices.Theme[teEdit], Canvas.Handle, Part, State, PWideChar(Text), Length(Text), Format, @Rect, DTTOpts);
end;

procedure DrawGlassText(Canvas: TCanvas; GlowSize: Integer; var Rect: TRect; var Text: String; TextFormat: TTextFormat; Options: TStyleTextOptions); overload;
const
  cTextFormats: array[TTextFormats] of DWORD = (
    DT_BOTTOM, DT_CALCRECT, DT_CENTER, DT_EDITCONTROL, DT_END_ELLIPSIS, DT_PATH_ELLIPSIS, DT_EXPANDTABS, DT_EXTERNALLEADING, DT_LEFT,
    DT_MODIFYSTRING, DT_NOCLIP, DT_NOPREFIX, DT_RIGHT, DT_RTLREADING, DT_SINGLELINE, DT_TOP, DT_VCENTER, DT_WORDBREAK, DT_HIDEPREFIX,
    DT_NOFULLWIDTHCHARBREAK, DT_PREFIXONLY, DT_TABSTOP, DT_WORD_ELLIPSIS, MASK_TF_COMPOSITED {tfComposited}
  );
var
  Format: DWORD;
  F: TTextFormats;
begin
  Format := 0;
  for F in TextFormat do
    Format := Format or cTextFormats[F];
  DrawGlassText(Canvas, GlowSize, Rect, Text, Format, Options);
end;
{$IFEND}
{$ENDREGION}

procedure DrawTextFormat(const Canvas: TCanvas; Text: String; var Rect: TRect; TextFlags: Cardinal; TextOnGlass: Boolean);
var
  LFormat: TTextFormat;
  LOptions: TStyleTextOptions;
begin
  if not TextOnGlass then
    DrawText(Canvas.Handle, Text, Length(Text), Rect, TextFlags)
  else begin
  {$IF CompilerVersion <= 30}
    LFormat := TextFlagsToTextFormat(TextFlags);
  {$ELSE}
    LFormat := TTextFormatFlags(TextFlags);
  {$IFEND}

    LOptions.Flags := [stfTextColor, stfGlowSize];
    LOptions.TextColor := Canvas.Font.Color;
    LOptions.GlowSize := DEFAULT_GLASSTEXT_GLOWSIZE;

  {$IF CompilerVersion <= 30}
    //GetThemeInt() // TMT_TEXTGLOWSIZE
    DrawGlassText(Canvas, DEFAULT_GLASSTEXT_GLOWSIZE, Rect, Text, LFormat, LOptions);
  {$ELSE}
    Include(LFormat, tfComposited);
    StyleServices.DrawText(Canvas.Handle, StyleServices.GetElementDetails(ttlTextLabelNormal), Text, Rect, LFormat, LOptions);
  {$IFEND}
  end;
end;

procedure MeasureTextRect(const Canvas: TCanvas; HAlign: TAlignment; VAlign: TVerticalAlignment; var Rect: TRect; Text: String; Multiline, TextOnGlass: Boolean);
const
  LineStyle: Array[Boolean] of Cardinal = (DT_SINGLELINE, 0);
var
  Flags: Cardinal;
begin
  Flags := DT_CALCRECT or DT_EXPANDTABS or LineStyle[Multiline] or HAlignments[HAlign] or VAlignments[VAlign];
  //
  DrawTextFormat(Canvas, Text, Rect, Flags, TextOnGlass);
end;

procedure DrawTextRect(const Canvas: TCanvas; HAlign: TAlignment; VAlign: TVerticalAlignment; Rect: TRect; Text: String; Multiline, TextOnGlass: Boolean);
const
  LineStyle: Array[Boolean] of Cardinal = (DT_SINGLELINE, 0);
var
  Flags: Cardinal;
begin
  Flags := DT_EXPANDTABS or LineStyle[Multiline] or HAlignments[HAlign] or VAlignments[VAlign];
  //
  DrawTextFormat(Canvas, Text, Rect, Flags, TextOnGlass);
end;

procedure DrawBorder(const Canvas: TCanvas; R: TRect; Color: TColor; Thickness: Integer; const Overlay: Boolean = False);
var
  TL, BR: Byte;
  spm: TPenMode;
begin
  if Thickness > 0 then begin
    TL := Thickness div 2;
    if Thickness mod 2 = 0 then
      BR := TL - 1
    else
      BR := TL;

    Canvas.Pen.Color := Color;
    Canvas.Pen.Width := Thickness;
    spm:=pmBlack; // satisfy compiler
    if Overlay then begin
      spm:=Canvas.Pen.Mode;
      Canvas.Pen.Mode:=pmXor;
    end;
    //
    Canvas.Rectangle(Rect(TL, TL, R.Width - BR, R.Height - BR));
    //
    if Overlay then
      Canvas.Pen.Mode:=spm;
  end;
end;

procedure DrawFocusRect(const Canvas: TCanvas; R: TRect; Color: TColor);
//const
//  PenPattern: Array[1..4] of DWORD = (1, 2, 1, 2);
var
  logBrush: TLogBrush;
begin
  //
  Canvas.Pen.Color := GetTextColorFromBackground(Color);
  Canvas.Pen.Width := 1;
  //Canvas.Pen.Style := psDot;
  Canvas.Pen.Style := psUserStyle;
  logBrush.lbStyle := BS_SOLID;
  logBrush.lbColor := Canvas.Pen.Color;
  Canvas.Pen.Handle := ExtCreatePen({PS_GEOMETRIC}PS_COSMETIC or PS_ALTERNATE{ or PS_USERSTYLE}, Canvas.Pen.Width, logBrush, 0, Nil); // Length(PenPattern), @PenPattern);
  Canvas.Rectangle(R);
  Canvas.Pen.Style := psClear;
  Canvas.Pen.Color := Color;
end;

procedure DrawParentImage(Control: TControl; DC: HDC; InvalidateParent: Boolean = False);
var
  SaveIndex: Integer;
  P: TPoint;
begin
  if Control.Parent = Nil then
    Exit;
  //
  SaveIndex := SaveDC(DC);
  GetViewportOrgEx(DC, P);
  SetViewportOrgEx(DC, P.X - Control.Left, P.Y - Control.Top, nil);
  IntersectClipRect(DC, 0, 0, Control.Parent.ClientWidth, Control.Parent.ClientHeight);
  //
  Control.Parent.Perform(WM_ERASEBKGND, DC, 0);
  Control.Parent.Perform(WM_PRINTCLIENT, DC, prf_Client);
  //
  RestoreDC(DC, SaveIndex);
  //
  if InvalidateParent and not (Control.Parent is TCustomControl) and not (Control.Parent is TCustomForm) and not (csDesigning in Control.ComponentState) then
    Control.Parent.Invalidate;
end;

function Mix(A, B: Byte; Sign: Boolean): Byte; inline;
var
  C: Integer;
begin
  if Sign then begin
    C:=A + B;
    if C > 255 then
      C:=255;
  end
  else begin
    C:=A - B;
    if C < 0 then
      C:=0;
  end;
  //
  Result:=C;
end;

procedure MulColor(var AColor: PQuadColor; Base: Byte; Sign: Boolean); inline;
begin
  AColor.Blue  := Mix(AColor.Blue,  Base, Sign);
  AColor.Green := Mix(AColor.Green, Base, Sign);
  AColor.Red   := Mix(AColor.Red,   Base, Sign);
  //AColor.Alpha := AColor.Alpha;
end;

procedure InitBumpMap;
var
  x, y: Integer;
  cx, cy: Integer;
  half_size: Integer;
  sq: Real;
begin
  if BumpMapInited then
    Exit;

  half_size:=BumpMapSize div 2;
  for y:=0 to BumpMapSize - 1 do begin
    for x:=0 to BumpMapSize - 1 do begin
      cx:=x - half_size;
      cy:=y - half_size;
      sq:=Round(sqrt((cx*cx) + (cy*cy)));
      if sq > 120 then
        sq:=120;
      sq:=120 - sq;
      //sq:=sq / 1.75;
      BumpMap[y, x]:=Trunc(sq);
    end;
  end;

  BumpMapInited := True;
end;

procedure DrawBumpMap(const Canvas: TCanvas; X, Y: Integer; Add: Boolean);
var
  bmp: TBitmap;
  ax, ay, half_size: Integer;
  Pixel: PQuadColor;
begin
  bmp:=TBitmap.Create;
  try
    half_size:=BumpMapSize div 2;
    bmp.PixelFormat:=pf32bit;
    bmp.SetSize(BumpMapSize, BumpMapSize);
    bmp.Canvas.CopyMode:=SRCCOPY;
    bmp.Canvas.CopyRect(Rect(0, 0, BumpMapSize, BumpMapSize), Canvas, Rect(X - half_size, Y - half_size, X + half_size, Y + half_size));

    for ay:=0 to BumpMapSize - 1 do begin
      Pixel := bmp.ScanLine[ay];
      for ax:=0 to BumpMapSize - 1 do begin
        MulColor(Pixel, BumpMap[ay, ax], Add);
        Inc(Pixel);
      end;
    end;

    Canvas.Draw(X - half_size, Y - half_size, bmp);
  finally
    bmp.Free;
  end;
end;

initialization
  DEFAULT_GLASSTEXT_GLOWSIZE := 0;
  BumpMapInited := False;

end.
