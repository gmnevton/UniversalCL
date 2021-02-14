unit UCL.SymbolButton;

interface

uses
  Classes,
  Types,
  Messages,
  Windows,
  Controls,
  Graphics,
  ImgList,
  UCL.Classes,
  UCL.Types,
  UCL.SystemSettings,
  UCL.Utils,
  UCL.Graphics;

type
  TUSymbolButtonToggleEvent = procedure (Sender: TObject; State: Boolean) of object;

  TUSymbolButton = class(TUCustomControl)
  private var
    BorderThickness: Integer;
    BackColor, BorderColor, TextColor, DetailColor: TColor;
    IconRect, TextRect, DetailRect: TRect;
  
  private
    FSymbolFont: TFont;
    FDetailFont: TFont;

    FImageIndex: Integer;
    FImageKind: TUImageKind;
    FImages: TCustomImageList;

    FButtonState: TUControlState;
    FOrientation: TUOrientation;
    FSymbolChar: string;
    FText: string;
    FTextOffset: Integer;
    FDetail: string;
    FDetailRightOffset: Integer;

    FShowIcon: Boolean;
    FShowDetail: Boolean;
    FTransparent: Boolean;
    FIsToggleButton: Boolean;
    FIsToggled: Boolean;
    FKeepOrginalColor: Boolean;
    FToggleEvent: TUSymbolButtonToggleEvent;

    // Internal
    procedure UpdateColors;
    procedure UpdateRects;
    procedure DoToggle;

    // Setters
    procedure SetButtonState(const Value: TUControlState);
    procedure SetOrientation(const Value: TUOrientation);
    procedure SetSymbolChar(const Value: string);
    procedure SetText(const Value: string);
    procedure SetTextOffset(const Value: Integer);
    procedure SetDetail(const Value: string);
    procedure SetDetailRightOffset(const Value: Integer);
    procedure SetShowIcon(const Value: Boolean);
    procedure SetShowDetail(const Value: Boolean);
    procedure SetTransparent(const Value: Boolean);
    procedure SetIsToggled(const Value: Boolean);
    procedure SetImageIndex(const Value: Integer);
    procedure SetImageKind(const Value: TUImageKind);
    procedure SetKeepOrginalColor(const Value: Boolean);

    // Messages
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMMouseMove(var Msg: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure CMFontChanged(var Msg: TMessage); message CM_FONTCHANGED;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;

  protected
    procedure Paint; override;
    procedure Resize; override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DoChangeScale(M, D: Integer); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // IUThemedComponent
    procedure UpdateTheme; override;

  published
    property SymbolFont: TFont read FSymbolFont write FSymbolFont;
    property DetailFont: TFont read FDetailFont write FDetailFont;

    property ImageIndex: Integer read FImageIndex write SetImageIndex default -1;
    property ImageKind: TUImageKind read FImageKind write SetImageKind default ikFontIcon;
    property Images: TCustomImageList read FImages write FImages;

    property ButtonState: TUControlState read FButtonState write SetButtonState default csNone;
    property Orientation: TUOrientation read FOrientation write SetOrientation default oHorizontal;
    property SymbolChar: string read FSymbolChar write SetSymbolChar;
    property Text: string read FText write SetText;
    property TextOffset: Integer read FTextOffset write SetTextOffset default 40;
    property Detail: string read FDetail write SetDetail;
    property DetailRightOffset: Integer read FDetailRightOffset write SetDetailRightOffset default 10;
    property ShowIcon: Boolean read FShowIcon write SetShowIcon default true;
    property ShowDetail: Boolean read FShowDetail write SetShowDetail default true;
    property Transparent: Boolean read FTransparent write SetTransparent default false;
    property IsToggleButton: Boolean read FIsToggleButton write FIsToggleButton default false;
    property IsToggled: Boolean read FIsToggled write SetIsToggled default false;
    property KeepOrginalColor: Boolean read FKeepOrginalColor write SetKeepOrginalColor;

    property Caption;
//    property Color;
    property TabOrder;
    property TabStop default true;
    property Height default 40;
    property Width default 250;

    property OnToggle: TUSymbolButtonToggleEvent read FToggleEvent write FToggleEvent;
  end;

implementation

uses
  SysUtils,
  Forms,
  UCL.ThemeManager,
  UCL.Colors,
  UCL.CaptionBar,
  UCL.FontIcons;

{ TUSymbolButton }

//  MAIN CLASS

constructor TUSymbolButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csDoubleClicks];

  BorderThickness := 1;

  FImageIndex := -1;
  FImageKind := ikFontIcon;

  FSymbolFont := TFont.Create;
  FSymbolFont.Name := 'Segoe MDL2 Assets';
  FSymbolFont.Size := 12;

  FDetailFont := TFont.Create;
  FDetailFont.Name := Font.Name;
//  FDetailFont.Name := 'Segoe UI';
//  FDetailFont.Size := 10;

  FButtonState := csNone;
  FOrientation := oHorizontal;
  FSymbolChar := UF_HOME;
  FText := 'Some text';
  FTextOffset := 40;
  FDetail := 'Detail';
  FDetailRightOffset := 10;
  FShowIcon := True;
  FShowDetail := True;
  FTransparent := False;
  FIsToggleButton := False;
  FIsToggled := False;

  TabStop := True;
  Height := 40;
  Width := 250;

  InitBumpMap;
end;

destructor TUSymbolButton.Destroy;
begin
  FSymbolFont.Free;
  FDetailFont.Free;
  inherited;
end;

//  THEME

procedure TUSymbolButton.UpdateTheme;
begin
  UpdateColors;
  UpdateRects;
  Repaint;
end;

//  INTERNAL

procedure TUSymbolButton.UpdateColors;
var
  TM: TUCustomThemeManager;
  ParentControl: TWinControl;
begin
  TM:=SelectThemeManager(Self);
  ParentControl:=Self.Parent;

  // Disabled
  if not Enabled then begin
    BackColor := BUTTON_BACK.GetColor(TM.ThemeUsed, csDisabled);
    BorderColor := BackColor;
    TextColor := clGray;
    DetailColor := clGray;
    Exit;
  end
  else if Enabled and FKeepOrginalColor and (Color <> clNone) and (Color <> clDefault) then begin
    ParentColor := False;
    BackColor := Color;
    TextColor := GetTextColorFromBackground(Color);
    DetailColor := $808080;
    if ButtonState in [csNone, csHover, csFocused] then begin
      if TM.ThemeUsed = utLight then
        BackColor := BrightenColor(BackColor, 25)
      else
        BackColor := BrightenColor(BackColor, -25);
    end;
  end
  else begin
    // Transparent enabled
    if (ButtonState = csNone) and Transparent then begin
      ParentColor := True;
      BackColor := Color;
      TextColor := GetTextColorFromBackground(Color);
      DetailColor := $808080;
    end
    // Highlight enabled
    else if (IsToggleButton and IsToggled) and (ButtonState in [csNone, csHover, csFocused]) then begin
      BackColor := TM.AccentColor;
      TextColor := GetTextColorFromBackground(BackColor);
      DetailColor := clSilver;
    end
    // Default colors
    else begin
      if (ParentControl <> Nil) and (ParentControl is TUCaptionBar) then begin
        BackColor := TUCaptionBar(ParentControl).Color;
        TextColor := GetTextColorFromBackground(BackColor);
        DetailColor := $808080;
      end
      else begin
        if IsToggled then
          BackColor := TM.AccentColor
        else
          BackColor := BUTTON_BACK.GetColor(TM.ThemeUsed, ButtonState);
        //TextColor := BUTTON_TEXT.GetColor(TempTheme, ButtonState);
        TextColor := GetTextColorFromBackground(BackColor);
        DetailColor := $808080;
      end;
    end;
  end;
  //
  BorderColor := BackColor;
  if (ButtonState in [csHover, csFocused]) then
    BorderColor := $AAAAAA;
  //
  if (ButtonState = csPress) then begin
    if TM.ThemeUsed = utLight then
      BackColor := BrightenColor(BackColor, 25)
    else
      BackColor := BrightenColor(BackColor, -25);
    TextColor := GetTextColorFromBackground(BackColor);
  end;
end;

procedure TUSymbolButton.UpdateRects;
var
  TempW, TempH: Integer;
begin
  if not HandleAllocated then
    Exit;

  //  Calc rects
  if ShowIcon then begin
    if Orientation = oHorizontal then
      IconRect := Rect(0, 0, TextOffset, Height)
    else
      IconRect := Rect(0, 0, Width, TextOffset);
  end
  else
    IconRect := TRect.Empty;

  if ShowDetail then begin
    Canvas.Font := DetailFont;
    TempW := Canvas.TextWidth(Detail);
    TempH := Canvas.TextHeight(Detail);
    if Orientation = oHorizontal then
      DetailRect := Rect(Width - TempW - DetailRightOffset, 0, Width - DetailRightOffset, Height)
    else
      DetailRect := Rect(0, Height - TempH - DetailRightOffset, Width, Height - DetailRightOffset);
  end
  else
    DetailRect := TRect.Empty;

  if Orientation = oHorizontal then
    TextRect := Rect(IconRect.Width, 0, Width - DetailRect.Width, Height)
  else
    TextRect := Rect(0, IconRect.Height, Width, Height - DetailRect.Height);
end;

procedure TUSymbolButton.DoToggle;
begin
  if Assigned(FToggleEvent) then
    FToggleEvent(Self, FIsToggled);
end;

//  SETTERS

procedure TUSymbolButton.SetButtonState(const Value: TUControlState);
begin
  if Value <> FButtonState then begin
    FButtonState := Value;
    UpdateColors;
    Repaint;
  end;
end;

procedure TUSymbolButton.SetOrientation(const Value: TUOrientation);
begin
  if Value <> FOrientation then begin
    FOrientation := Value;
    UpdateRects;
    Repaint;
  end;
end;

procedure TUSymbolButton.SetSymbolChar(const Value: string);
begin
  if Value <> FSymbolChar then begin
    FSymbolChar := Value;
    Repaint;
  end;
end;

procedure TUSymbolButton.SetText(const Value: string);
begin
  if Value <> FText then begin
    FText := Value;
    UpdateRects;
    Repaint;
  end;
end;

procedure TUSymbolButton.SetTextOffset(const Value: Integer);
begin
  if Value <> FTextOffset then begin
    FTextOffset := Value;
    UpdateRects;
    Repaint;
  end;
end;

procedure TUSymbolButton.SetDetail(const Value: string);
begin
  if Value <> FDetail then begin
    FDetail := Value;
    UpdateRects;
    Repaint;
  end;
end;

procedure TUSymbolButton.SetDetailRightOffset(const Value: Integer);
begin
  if Value <> FDetailRightOffset then begin
    FDetailRightOffset := Value;
    UpdateRects;
    Repaint;
  end;
end;

procedure TUSymbolButton.SetShowIcon(const Value: Boolean);
begin
  if Value <> FShowIcon then begin
    FShowIcon := Value;
    UpdateRects;
    Repaint;
  end;
end;

procedure TUSymbolButton.SetShowDetail(const Value: Boolean);
begin
  if Value <> FShowDetail then begin
    FShowDetail := Value;
    UpdateRects;
    Repaint;
  end;
end;

procedure TUSymbolButton.SetTransparent(const Value: Boolean);
begin
  if Value <> FTransparent then begin
    FTransparent := Value;
    UpdateColors;
    Repaint;
  end;
end;

procedure TUSymbolButton.SetIsToggled(const Value: Boolean);
begin
  if Value <> FIsToggled then begin
    FIsToggled := Value;
    UpdateColors;
    Repaint;
    DoToggle;
  end;
end;

procedure TUSymbolButton.SetImageIndex(const Value: Integer);
begin
  if Value <> FImageIndex then begin
    FImageIndex := Value;
    Repaint;
  end;
end;

procedure TUSymbolButton.SetImageKind(const Value: TUImageKind);
begin
  if Value <> FImageKind then begin
    FImageKind := Value;
    Repaint;
  end;
end;

procedure TUSymbolButton.SetKeepOrginalColor(const Value: Boolean);
begin
  if Value <> FKeepOrginalColor then begin
    FKeepOrginalColor := Value;
    UpdateColors;
    Repaint;
  end;
end;

//  CUSTOM METHODS

procedure TUSymbolButton.Paint;
var
  TM: TUCustomThemeManager;
  ImgX, ImgY: Integer;
  bmp: TBitmap;
  P: TPoint;
begin
//  inherited;
  TM:=SelectThemeManager(Self);
  bmp := TBitmap.Create;
  try
    bmp.SetSize(Width, Height);
    //bmp.Canvas.Assign(Canvas);

    // Paint background
    bmp.Canvas.Brush.Style := bsSolid;
    bmp.Canvas.Brush.Handle := CreateSolidBrushWithAlpha(BackColor, 255);
    bmp.Canvas.FillRect(Rect(0, 0, Width, Height));

    // Draw border
    DrawBorder(bmp.Canvas, Rect(0, 0, Width, Height), BorderColor, BorderThickness);

    P:=Mouse.CursorPos;
    P:=ScreenToClient(P);

    if Enabled and MouseInClient and not (csPaintCopy in ControlState) then
      DrawBumpMap(bmp.Canvas, P.X, P.Y, TM.ThemeUsed = utDark);

    // Paint icon
    if ImageKind = ikFontIcon then begin
      if ShowIcon then begin
        bmp.Canvas.Font := SymbolFont;
        bmp.Canvas.Font.Color := TextColor;
        DrawTextRect(bmp.Canvas, taCenter, taVerticalCenter, IconRect, SymbolChar, False)
      end;
    end
    else begin
      if Images <> Nil then begin
        GetCenterPos(Images.Width, Images.Height, IconRect, ImgX, ImgY);
        Images.Draw(bmp.Canvas, ImgX, ImgY, ImageIndex, Enabled);
      end;
    end;

    // Paint detail
    if ShowDetail then begin
      bmp.Canvas.Font := DetailFont;
      bmp.Canvas.Font.Color := DetailColor;
      if Orientation = oHorizontal then
        DrawTextRect(bmp.Canvas, taLeftJustify, taVerticalCenter, DetailRect, Detail, False)
      else
        DrawTextRect(bmp.Canvas, taCenter, taAlignTop, DetailRect, Detail, False);
    end;

    // Paint text
    bmp.Canvas.Font := Font;
    bmp.Canvas.Font.Color := TextColor;
    if Orientation = oHorizontal then
      DrawTextRect(bmp.Canvas, taLeftJustify, taVerticalCenter, TextRect, Text, False)
    else
      DrawTextRect(bmp.Canvas, taCenter, taAlignTop, TextRect, Text, False);

    //
    Canvas.Draw(0, 0, bmp);
  finally
    bmp.Free;
  end;
end;

procedure TUSymbolButton.Resize;
begin
  inherited;
  UpdateRects;
end;

procedure TUSymbolButton.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  UpdateColors;
  UpdateRects;
end;

procedure TUSymbolButton.DoChangeScale(M, D: Integer);
begin
  TextOffset := MulDiv(TextOffset, M, D);
  DetailRightOffset := MulDiv(DetailRightOffset, M, D);

  SymbolFont.Height := MulDiv(SymbolFont.Height, M, D);
//  Font.Height := MulDiv(Font.Height, M, D);
  DetailFont.Height := MulDiv(DetailFont.Height, M, D);

  UpdateRects;
end;

//  MESSAGES

procedure TUSymbolButton.WMLButtonDown(var Msg: TWMLButtonDown);
begin
  if Enabled then begin
    ButtonState := csPress;
    inherited;
  end;
end;

procedure TUSymbolButton.WMLButtonUp(var Msg: TWMLButtonUp);
begin
  if Enabled then begin
    if IsToggleButton then
      FIsToggled := not FIsToggled;
    if MouseInClient then
      ButtonState := csHover
    else
      ButtonState := csNone;
    inherited;
    if IsToggleButton then
      DoToggle;
  end;
end;

procedure TUSymbolButton.WMMouseMove(var Msg: TWMMouseMove);
begin
  if Enabled and not IsDesigning then
    Repaint;
  inherited;
end;

procedure TUSymbolButton.WMSetFocus(var Msg: TWMSetFocus);
begin
  if Enabled then begin
    ButtonState := csFocused;
    inherited;
  end;
end;

procedure TUSymbolButton.WMKillFocus(var Msg: TWMKillFocus);
begin
  if Enabled then begin
    ButtonState := csNone;
    inherited;
  end;
end;

procedure TUSymbolButton.CMColorChanged(var Message: TMessage);
begin
  if not IsDesigning then
    UpdateColors;
  inherited;
end;

procedure TUSymbolButton.CMMouseEnter(var Msg: TMessage);
begin
  if Enabled then begin
    ButtonState := csHover;
    inherited;
  end;
end;

procedure TUSymbolButton.CMMouseLeave(var Msg: TMessage);
begin
  if Enabled then begin
    ButtonState := csNone;
    Repaint;
    inherited;
  end;
end;

procedure TUSymbolButton.CMFontChanged(var Msg: TMessage);
begin
  if not IsDesigning then
    Repaint;
end;

procedure TUSymbolButton.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;
  if not Enabled then
    FButtonState := csDisabled
  else
    FButtonState := csNone;
  UpdateColors;
  Repaint;
end;

end.
