unit UCL.ItemButton;

interface

uses
  Classes,
  Types,
  Windows,
  Messages,
  Controls,
  Graphics,
  ImgList,
  UCL.Classes,
  UCL.Types,
  UCL.Utils,
  UCL.Graphics;

type
  TUItemButton = class;

  TUItemObjectKind = (iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon);
  TUItemButtonObjects = set of TUItemObjectKind;

  TUItemButtonCanToggleEvent = procedure (Sender: TUItemButton; var ToggleAllowed: Boolean) of object;
  TUItemButtonToggleEvent = procedure (Sender: TUItemButton; State: Boolean) of object;

  TUItemButton = class(TUCustomControl)
  private const
    ICON_CHECKED = '';
    ICON_UNCHECKED = '';

//    DefBackColor: TDefColor = (
//      ($00E6E6E6, $00CFCFCF, $00B8B8B8, $00CCCCCC, $00CFCFCF),
//      ($001F1F1F, $00353535, $004C4C4C, $00333333, $00353535));
//    DefTextColor: TDefColor = (
//      ($00000000, $00000000, $00000000, $00666666, $00000000),
//      ($00FFFFFF, $00FFFFFF, $00FFFFFF, $00666666, $00FFFFFF));

  private var
    BackColor, TextColor, DetailColor, ActiveColor: TColor;
    CheckBoxRect, LeftIconRect, RightIconRect, DetailRect, TextRect: TRect;

  private
    FObjectSelected: TUItemObjectKind;
    FButtonState: TUControlState;
    FLeftIconKind: TUImageKind;
    FRightIconKind: TUImageKind;

    FImages: TCustomImageList;
    FImageLeftIndex: Integer;
    FImageRightIndex: Integer;

    FIconFont: TFont;
    FDetailFont: TFont;

    FObjectsVisible: TUItemButtonObjects;

    FIsChecked: Boolean;
    FLeftIcon: string;
    FText: string;
    FDetail: string;
    FRightIcon: string;

    FAlignSpace: Integer;

    FCheckBoxWidth: Integer;
    FLeftIconWidth: Integer;
    FRightIconWidth: Integer;

    FCustomActiveColor: TColor;
    FTransparent: Boolean;
    FIsToggleButton: Boolean;
    FIsToggled: Boolean;
    FMouseInClient: Boolean;
    FCanToggleEvent: TUItemButtonCanToggleEvent;
    FToggleEvent: TUItemButtonToggleEvent;

    //  Internal
    procedure UpdateColors;
    procedure UpdateRects;
    function  DoCanToggle: Boolean;
    procedure DoToggle;

    //  Setters
    procedure SetButtonState(const Value: TUControlState);
    procedure SetImageLeftIndex(const Value: Integer);
    procedure SetImageRightIndex(const Value: Integer);

    procedure SetObjectsVisible(const Value: TUItemButtonObjects);
    procedure SetObjectWidth(const Index: Integer; const Value: Integer);

    procedure SetIsChecked(const Value: Boolean);
    procedure SetLeftIcon(const Value: string);
    procedure SetText(const Value: string);
    procedure SetDetail(const Value: string);
    procedure SetRightIcon(Const Value: string);

    procedure SetAlignSpace(const Value: Integer);
    procedure SetCustomActiveColor(const Value: TColor);
    procedure SetTransparent(const Value: Boolean);
    procedure SetLeftIconKind(const Value: TUImageKind);
    procedure SetRightIconKind(const Value: TUImageKind);
    procedure SetIsToggled(const Value: Boolean);

    //  Messages
    procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMMouseMove(var Msg: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
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
    //
    property ObjectSelected: TUItemObjectKind read FObjectSelected default iokNone;

  published
    property ButtonState: TUControlState read FButtonState write SetButtonState default csNone;

    //  Image
    property Images: TCustomImageList read FImages write FImages;
    property ImageLeftIndex: Integer read FImageLeftIndex write SetImageLeftIndex default -1;
    property ImageRightIndex: Integer read FImageRightIndex write SetImageRightIndex default -1;

    //  Font
    property IconFont: TFont read FIconFont write FIconFont;
    property DetailFont: TFont read FDetailFont write FDetailFont;

    //  Object visible
    property ObjectsVisible: TUItemButtonObjects read FObjectsVisible write SetObjectsVisible
      default [iokNone, iokLeftIcon, iokText, iokDetail];

    //  Objects property
    property IsChecked: Boolean read FIsChecked write SetIsChecked default false;
    property LeftIcon: string read FLeftIcon write SetLeftIcon;
    property Text: string read FText write SetText;
    property Detail: string read FDetail write SetDetail;
    property RightIcon: string read FRightIcon write SetRightIcon;

    //  Objects size
    property CheckBoxWidth: Integer index 0 read FCheckBoxWidth write SetObjectWidth default 40;
    property LeftIconWidth: Integer index 1 read FLeftIconWidth write SetObjectWidth default 40;
    property RightIconWidth: Integer index 2 read FRightIconWidth write SetObjectWidth default 40;

    //  Additional
    property AlignSpace: Integer read FAlignSpace write SetAlignSpace default 5;
    property CustomActiveColor: TColor read FCustomActiveColor write SetCustomActiveColor;
    property Transparent: Boolean read FTransparent write SetTransparent default false;
    property LeftIconKind: TUImageKind read FLeftIconKind write SetLeftIconKind default ikFontIcon;
    property RightIconKind: TUImageKind read FRightIconKind write SetRightIconKind default ikFontIcon;
    property IsToggleButton: Boolean read FIsToggleButton write FIsToggleButton default false;
    property IsToggled: Boolean read FIsToggled write SetIsToggled default false;

    property Caption;
//    property Color;
    property TabStop default true;
    property Height default 40;
    property Width default 250;

    property OnCanToggle: TUItemButtonCanToggleEvent read FCanToggleEvent write FCanToggleEvent;
    property OnToggle: TUItemButtonToggleEvent read FToggleEvent write FToggleEvent;
  end;

implementation

uses
  SysUtils,
  UCL.ThemeManager,
  UCL.Colors;

{ TUItemButton }

//  MAIN CLASS

constructor TUItemButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FObjectSelected := iokNone;
  FButtonState := csNone;
  FImageLeftIndex := -1;
  FImageRightIndex := -1;

  //  Init text font
//  Font.Name := 'Segoe UI';
//  Font.Size := 10;

  //  Init icon font
  FIconFont := TFont.Create;
  FIconFont.Name := 'Segoe MDL2 Assets';
  FIconFont.Size := 15;

  //  Init detail font
  FDetailFont := TFont.Create;
//  FDetailFont.Name := 'Segoe UI';
//  FDetailFont.Size := 10;

  FObjectsVisible := [iokNone, iokLeftIcon, iokText, iokDetail];

  FIsChecked := false;
  FLeftIcon := '';
  FText := 'Text';
  FDetail := 'Detail';
  FRightIcon := '';

  FCheckBoxWidth := 40;
  FLeftIconWidth := 40;
  FRightIconWidth := 40;

  FAlignSpace := 5;
  FCustomActiveColor := $D77800;
  FTransparent := false;
  FLeftIconKind := ikFontIcon;
  FRightIconKind := ikFontIcon;
  FIsToggleButton := false;
  FIsToggled := false;

  //  Common properties
  TabStop := True;
  Height := 40;
  Width := 250;

  InitBumpMap;
end;

destructor TUItemButton.Destroy;
begin
  FIconFont.Free;
  FDetailFont.Free;
  inherited;
end;

//  THEME

procedure TUItemButton.UpdateTheme;
begin
  UpdateColors;
  UpdateRects;
  Repaint;
end;

//  INTERNAL

procedure TUItemButton.UpdateColors;
var
  TM: TUCustomThemeManager;
begin
  TM:=SelectThemeManager(Self);

  //  Transparent enabled
  if (ButtonState = csNone) and Transparent then begin
    ParentColor := true;
    BackColor := Color;
    TextColor := GetTextColorFromBackground(Color);
    DetailColor := $808080;
  end
  //  Highlight enabled
  else if (IsToggleButton and IsToggled) and (ButtonState in [csNone, csHover, csFocused]) then begin
    BackColor := TM.AccentColor;
    TextColor := GetTextColorFromBackground(BackColor);
    DetailColor := clSilver;
  end
  //  Default colors
  else begin
    if IsToggled then
      BackColor := TM.AccentColor
    else
      BackColor := BUTTON_BACK.GetColor(TM.ThemeUsed, ButtonState);
    //TextColor := BUTTON_TEXT.GetColor(TempTheme, ButtonState);
    TextColor := GetTextColorFromBackground(BackColor);
    DetailColor := $808080;
  end;

  //  Active color
  if not TM.UseSystemAccentColor then
    ActiveColor := CustomActiveColor
  else
    ActiveColor := TM.AccentColor;
end;

procedure TUItemButton.UpdateRects;
var
  LPos, RPos: Integer;
  TempWidth: Integer;
begin
  if not HandleAllocated then
    Exit;

  LPos := 0;
  RPos := Width;

  if iokCheckBox in ObjectsVisible then
    CheckBoxRect := Rect(0, 0, CheckBoxWidth, Height)
  else
    CheckBoxRect := TRect.Empty;
  Inc(LPos, CheckBoxRect.Width);

  if iokLeftIcon in ObjectsVisible then
    LeftIconRect := Rect(LPos, 0, LPos + LeftIconWidth, Height)
  else
    LeftIconRect := TRect.Empty;
  Inc(LPos, LeftIconRect.Width);

  if iokRightIcon in ObjectsVisible then
    RightIconRect := Rect(RPos - RightIconWidth, 0, RPos, Height)
  else
    RightIconRect := TRect.Empty;
  Dec(RPos, RightIconRect.Width);

  if iokDetail in ObjectsVisible then begin
    Canvas.Font := DetailFont;
    TempWidth := Canvas.TextWidth(Detail);
    DetailRect := Rect(RPos - AlignSpace - TempWidth, 0, RPos, Height);
  end
  else
    DetailRect := TRect.Empty;
  Dec(RPos, DetailRect.Width);

  if iokText in ObjectsVisible then
    TextRect := Rect(LPos + AlignSpace, 0, RPos - AlignSpace, Height)
  else
    TextRect := TRect.Empty;
end;

function TUItemButton.DoCanToggle: Boolean;
begin
  Result:=True;
  if Assigned(FCanToggleEvent) then
    FCanToggleEvent(Self, Result);
end;

procedure TUItemButton.DoToggle;
begin
  if Assigned(FToggleEvent) then
    FToggleEvent(Self, FIsToggled);
end;

//  SETTERS

procedure TUItemButton.SetButtonState(const Value: TUControlState);
begin
  if Value <> FButtonState then begin
    FButtonState := Value;
    UpdateColors;
    Repaint;
  end;
end;

procedure TUItemButton.SetImageLeftIndex(const Value: Integer);
begin
  if Value <> FImageLeftIndex then begin
    FImageLeftIndex := Value;
    Repaint;
  end;
end;

procedure TUItemButton.SetImageRightIndex(const Value: Integer);
begin
  if Value <> FImageRightIndex then begin
    FImageRightIndex := Value;
    Repaint;
  end;
end;

procedure TUItemButton.SetObjectsVisible(const Value: TUItemButtonObjects);
begin
  if Value <> FObjectsVisible then begin
    FObjectsVisible := Value;
    UpdateRects;
    Repaint;
  end;
end;

procedure TUItemButton.SetObjectWidth(const Index: Integer; const Value: Integer);
begin
  case Index of
    0: if Value <> FCheckBoxWidth then begin
      FCheckBoxWidth := Value;
      UpdateRects;
      Repaint;
    end;

    1: if Value <> FLeftIconWidth then begin
      FLeftIconWidth := Value;
      UpdateRects;
      Repaint;
    end;

    2: if Value <> FRightIconWidth then begin
      FRightIconWidth := Value;
      UpdateRects;
      Repaint;
    end;
  end;
end;

procedure TUItemButton.SetIsChecked(const Value: Boolean);
begin
  if Value <> FIsChecked then begin
    FIsChecked := Value;
    Repaint;
  end;
end;

procedure TUItemButton.SetLeftIcon(const Value: string);
begin
  if Value <> FLeftIcon then begin
    FLeftIcon := Value;
    Repaint;
  end;
end;

procedure TUItemButton.SetText(const Value: string);
begin
  if Value <> FText then begin
    FText := Value;
    Repaint;
  end;
end;

procedure TUItemButton.SetDetail(const Value: string);
begin
  if Value <> FDetail then begin
    FDetail := Value;
    Repaint;
  end;
end;

procedure TUItemButton.SetRightIcon(Const Value: string);
begin
  if Value <> FRightIcon then begin
    FRightIcon := Value;
    Repaint;
  end;
end;

procedure TUItemButton.SetAlignSpace(const Value: Integer);
begin
  if Value <> FAlignSpace then begin
    FAlignSpace := Value;
    UpdateRects;
    Repaint;
  end;
end;

procedure TUItemButton.SetCustomActiveColor(const Value: TColor);
begin
  if Value <> FCustomActiveColor then begin
    FCustomActiveColor := Value;
    UpdateColors;
    Repaint;
  end;
end;

procedure TUItemButton.SetTransparent(const Value: Boolean);
begin
  if Value <> FTransparent then begin
    FTransparent := Value;
    UpdateColors;
    Repaint;
  end;
end;

procedure TUItemButton.SetLeftIconKind(const Value: TUImageKind);
begin
  if Value <> FLeftIconKind then begin
    FLeftIconKind := Value;
    Repaint;
  end;
end;

procedure TUItemButton.SetRightIconKind(const Value: TUImageKind);
begin
  if Value <> FRightIconKind then begin
    FRightIconKind := Value;
    Repaint;
  end;
end;

procedure TUItemButton.SetIsToggled(const Value: Boolean);
begin
  if FIsToggleButton and (Value <> FIsToggled) and DoCanToggle then begin
    FIsToggled := Value;
    UpdateColors;
    Repaint;
    DoToggle;
  end;
end;

//  CUSTOM METHODS

procedure TUItemButton.Paint;
var
  TM: TUCustomThemeManager;
  ImgX, ImgY: Integer;
  bmp: TBitmap;
  P: TPoint;
begin
//  inherited;
//  if csPaintCopy in ControlState then
//    UpdateColors;
  TM:=SelectThemeManager(Self);
  bmp := TBitmap.Create;
  try
    bmp.SetSize(Width, Height);
    //bmp.Canvas.Assign(Canvas);

    //  Paint background
    bmp.Canvas.Brush.Style := bsSolid;
    bmp.Canvas.Brush.Handle := CreateSolidBrushWithAlpha(BackColor, 255);
    bmp.Canvas.FillRect(Rect(0, 0, Width, Height));

    bmp.Canvas.Font := IconFont;

    P:=Mouse.CursorPos;
    P:=ScreenToClient(P);

    if Enabled and FMouseInClient and not (csPaintCopy in ControlState) then
//      DrawBumpMap(bmp.Canvas, P.X, Height div 2, TM.ThemeUsed = utDark);
      DrawBumpMap(bmp.Canvas, P.X, P.Y, TM.ThemeUsed = utDark);

    //  Paint checkbox
    if iokCheckBox in ObjectsVisible then begin
      if IsChecked then begin
        bmp.Canvas.Font.Color := ActiveColor;
        DrawTextRect(bmp.Canvas, taCenter, taVerticalCenter, CheckBoxRect, ICON_CHECKED, false);
      end
      else begin
        bmp.Canvas.Font.Color := TextColor;
        DrawTextRect(bmp.Canvas, taCenter, taVerticalCenter, CheckBoxRect, ICON_UNCHECKED, false);
      end;
    end;

    bmp.Canvas.Font.Color := TextColor;

    //  Paint left icon
    if iokLeftIcon in ObjectsVisible then begin
      if LeftIconKind = ikFontIcon then
        DrawTextRect(bmp.Canvas, taCenter, taVerticalCenter, LeftIconRect, LeftIcon, false)
      else if Images <> Nil then begin
        GetCenterPos(Images.Width, Images.Height, LeftIconRect, ImgX, ImgY);
        Images.Draw(bmp.Canvas, ImgX, ImgY, ImageLeftIndex, Enabled);
      end;
    end;

    //  Paint right icon
    if iokRightIcon in ObjectsVisible then begin
      if RightIconKind = ikFontIcon then
        DrawTextRect(bmp.Canvas, taCenter, taVerticalCenter, RightIconRect, RightIcon, false)
      else if Images <> Nil then begin
        GetCenterPos(Images.Width, Images.Height, RightIconRect, ImgX, ImgY);
        Images.Draw(bmp.Canvas, ImgX, ImgY, ImageRightIndex, Enabled);
      end;
    end;

    //  Paint detail
    if iokDetail in ObjectsVisible then begin
      bmp.Canvas.Font := DetailFont;
      bmp.Canvas.Font.Color := DetailColor;
      DrawTextRect(bmp.Canvas, taLeftJustify, taVerticalCenter, DetailRect, Detail, false);
    end;

    //  Paint text
    if iokText in ObjectsVisible then begin
      bmp.Canvas.Font := Font;
      bmp.Canvas.Font.Color := TextColor;
      DrawTextRect(bmp.Canvas, taLeftJustify, taVerticalCenter, TextRect, Text, false);
    end;

    //
    Canvas.Draw(0, 0, bmp);
  finally
    bmp.Free;
  end;
end;

procedure TUItemButton.Resize;
begin
  inherited;
  UpdateRects;
end;

procedure TUItemButton.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  UpdateColors;
end;

procedure TUItemButton.DoChangeScale(M, D: Integer);
begin
  inherited;

  IconFont.Height := MulDiv(IconFont.Height, M, D);
  DetailFont.Height := MulDiv(DetailFont.Height, M, D);

  CheckBoxWidth := MulDiv(CheckBoxWidth, M, D);
  LeftIconWidth := MulDiv(LeftIconWidth, M, D);
  RightIconWidth := MulDiv(RightIconWidth, M, D);
  AlignSpace := MulDiv(AlignSpace, M, D);

  UpdateRects;
end;

//  MESSAGES

procedure TUItemButton.WMLButtonDblClk(var Msg: TWMLButtonDblClk);
begin
  if Enabled then begin
    ButtonState := csPress;
    inherited;
  end;
end;

procedure TUItemButton.WMLButtonDown(var Msg: TWMLButtonDown);
begin
  if Enabled then begin
    ButtonState := csPress;
    inherited;
  end;
end;

procedure TUItemButton.WMLButtonUp(var Msg: TWMLButtonUp);
var
  OldState: Boolean;
begin
  if csPrintClient in ControlState then begin
    inherited;
    Exit;
  end;
  if Enabled then begin
//      if Msg.XPos < CheckBoxWidth then
//        FObjectSelected := iokCheckBox
//      else if Msg.XPos < CheckBoxWidth + LeftIconWidth then
//        FObjectSelected := iokLeftIcon
//      else if Msg.XPos > Width - RightIconWidth then
//        FObjectSelected := iokRightIcon
//      else if Msg.XPos > Width - RightIconWidth - Canvas.TextWidth(Detail) - AlignSpace then
//        FObjectSelected := iokDetail
//      else
//        FObjectSelected := iokText;

    if PointInRect(Msg.Pos, CheckBoxRect) then
      FObjectSelected := iokCheckBox
    else if PointInRect(Msg.Pos, LeftIconRect) then
      FObjectSelected := iokLeftIcon
    else if PointInRect(Msg.Pos, RightIconRect) then
      FObjectSelected := iokRightIcon
    else if PointInRect(Msg.Pos, DetailRect) then
      FObjectSelected := iokDetail
    else if PointInRect(Msg.Pos, TextRect) then
      FObjectSelected := iokText
    else
      FObjectSelected := iokNone;

    case FObjectSelected of
      iokNone: ;
      iokCheckBox:
        IsChecked := not IsChecked;
      iokLeftIcon: ;
      iokText: ;
      iokDetail: ;
      iokRightIcon: ;
    end;

    //  Switch toggle state
    OldState:=FIsToggled;
    if IsToggleButton and (FObjectSelected <> iokCheckBox) and DoCanToggle then
      FIsToggled := not FIsToggled;

    ButtonState := csHover;
    inherited;
    if IsToggleButton and (FObjectSelected <> iokCheckBox) and (FIsToggled <> OldState) then
      DoToggle;
  end;
end;

procedure TUItemButton.WMMouseMove(var Msg: TWMMouseMove);
begin
  if Enabled then
    Repaint;
  inherited;
end;

procedure TUItemButton.WMSetFocus(var Msg: TWMSetFocus);
begin
  if Enabled then begin
    ButtonState := csFocused;
    inherited;
  end;
end;

procedure TUItemButton.WMKillFocus(var Msg: TWMKillFocus);
begin
  if Enabled then begin
    ButtonState := csNone;
    inherited;
  end;
end;

procedure TUItemButton.CMMouseEnter(var Msg: TMessage);
begin
  FMouseInClient := True;
  if Enabled then begin
    ButtonState := csHover;
    inherited;
  end;
end;

procedure TUItemButton.CMMouseLeave(var Msg: TMessage);
begin
  FMouseInClient := False;
  if Enabled then begin
    ButtonState := csNone;
    inherited;
  end;
end;

procedure TUItemButton.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;
  if not Enabled then
    FButtonState := csDisabled
  else
    FButtonState := csNone;
  UpdateTheme;
end;

end.
