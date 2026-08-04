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
  UCL.Graphics,
  UCL.ControlColors;

type
  TUItemButton = class;

  TUItemButtonCheckType = (ctCheckBox, ctRadioBtn);

  TUItemObjectKind = (iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon);
  TUItemButtonObjects = set of TUItemObjectKind;

  TUItemButtonCanToggleEvent = procedure (Sender: TUItemButton; var ToggleAllowed: Boolean) of object;
  TUItemButtonToggleEvent = procedure (Sender: TUItemButton; State: Boolean) of object;

  TUItemButtonDrawTextEvent = procedure (Sender: TUItemButton; const TargetCanvas: TCanvas; TargetRect: TRect; TargetText: String) of object;

  TUItemButton = class(TUCustomControl)
  private var
    FBorderThickness: Integer;
    BackColor, BorderColor, TextColor, DetailColor, ActiveColor: TColor;
    CheckBoxRect, LeftIconRect, RightIconRect, DetailRect, TextRect: TRect;

  private
    FCustomColors: TUItemButtonColorSet;
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
    FLeftIcon: String;
    FText: String;
    FDetail: String;
    FRightIcon: String;

    FAlignSpace: Integer;

    FCheckBoxWidth: Integer;
    FLeftIconWidth: Integer;
    FRightIconWidth: Integer;

    //FCustomActiveColor: TColor;
    FTransparent: Boolean;
    FIsToggleButton: Boolean;
    FIsToggled: Boolean;
    FCanToggleEvent: TUItemButtonCanToggleEvent;
    FToggleEvent: TUItemButtonToggleEvent;
    FAcceptControls: Boolean;
    FCheckType: TUItemButtonCheckType;
    FRadioGroup: String;
    FDrawDetailEvent: TUItemButtonDrawTextEvent;
    FDrawTextEvent: TUItemButtonDrawTextEvent;

    // Internal
    procedure UpdateColors;
    procedure UpdateRects;
    function  DoCanToggle: Boolean;
    procedure DoToggle;
    procedure DoDrawDetail(const ACanvas: TCanvas; ARect: TRect; AText: String);
    procedure DoDrawText(const ACanvas: TCanvas; ARect: TRect; AText: String);

    // Setters
    procedure SetCustomColors(Value: TUItemButtonColorSet);
    procedure SetAcceptControls(const Value: Boolean);
    procedure SetCheckType(const Value: TUItemButtonCheckType);
    procedure SetBorderThickness(Value: Integer);
    procedure SetButtonState(const Value: TUControlState);
    procedure SetImageLeftIndex(const Value: Integer);
    procedure SetImageRightIndex(const Value: Integer);

    procedure SetObjectsVisible(const Value: TUItemButtonObjects);
    procedure SetObjectWidth(const Index: Integer; const Value: Integer);

    procedure SetIsChecked(const Value: Boolean);
    procedure SetLeftIcon(const Value: String);
    procedure SetText(const Value: String);
    procedure SetDetail(const Value: String);
    procedure SetRightIcon(Const Value: String);

    procedure SetAlignSpace(const Value: Integer);
    //procedure SetCustomActiveColor(const Value: TColor);
    procedure SetTransparent(const Value: Boolean);
    procedure SetLeftIconKind(const Value: TUImageKind);
    procedure SetRightIconKind(const Value: TUImageKind);
    procedure SetIsToggled(const Value: Boolean);

    // Messages
//    procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMMouseMove(var Msg: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;

    // Childs property change events
    procedure ColorsChange(Sender: TObject);

  protected
    procedure Paint; override;
    procedure Resize; override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DoChangeScale(M, D: Integer); override;
    function GetDragImages: TDragImageList; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // IUThemedComponent
    procedure UpdateTheme; override;
    // IUDragReorderControl
{    function GetDragFloating: Boolean;
    procedure StoreAlign;
    procedure StorePosition;
    procedure DragFloat(X, Y: Integer);
    procedure RestoreAlign;
    procedure RestorePosition;
    property DragFloating: Boolean read GetDragFloating;}
    //
    property ObjectSelected: TUItemObjectKind read FObjectSelected default iokNone;

  published
    property CustomColors: TUItemButtonColorSet read FCustomColors write SetCustomColors;
    property AcceptControls: Boolean read FAcceptControls write SetAcceptControls default False;

    property BorderThickness: Integer read FBorderThickness write SetBorderThickness default -1;
    property ButtonState: TUControlState read FButtonState write SetButtonState default csNone;

    // Image
    property Images: TCustomImageList read FImages write FImages;
    property ImageLeftIndex: Integer read FImageLeftIndex write SetImageLeftIndex default -1;
    property ImageRightIndex: Integer read FImageRightIndex write SetImageRightIndex default -1;

    // Font
    property IconFont: TFont read FIconFont write FIconFont;
    property DetailFont: TFont read FDetailFont write FDetailFont;

    // Object visible
    property ObjectsVisible: TUItemButtonObjects read FObjectsVisible write SetObjectsVisible
      default [iokNone, iokLeftIcon, iokText, iokDetail];

    // Objects property
    property IsChecked: Boolean read FIsChecked write SetIsChecked default False;
    property LeftIcon: string read FLeftIcon write SetLeftIcon;
    property Text: string read FText write SetText;
    property Detail: string read FDetail write SetDetail;
    property RightIcon: string read FRightIcon write SetRightIcon;

    // Objects size
    property CheckBoxWidth: Integer index 0 read FCheckBoxWidth write SetObjectWidth default 40;
    property LeftIconWidth: Integer index 1 read FLeftIconWidth write SetObjectWidth default 40;
    property RightIconWidth: Integer index 2 read FRightIconWidth write SetObjectWidth default 40;

    // Additional
    property AlignSpace: Integer read FAlignSpace write SetAlignSpace default 5;
    //property CustomActiveColor: TColor read FCustomActiveColor write SetCustomActiveColor;
    property Transparent: Boolean read FTransparent write SetTransparent default False;
    property LeftIconKind: TUImageKind read FLeftIconKind write SetLeftIconKind default ikFontIcon;
    property RightIconKind: TUImageKind read FRightIconKind write SetRightIconKind default ikFontIcon;
    property IsToggleButton: Boolean read FIsToggleButton write FIsToggleButton default False;
    property IsToggled: Boolean read FIsToggled write SetIsToggled default False;
    property CheckType: TUItemButtonCheckType read FCheckType write SetCheckType default ctCheckBox;
    property RadioGroup: String read FRadioGroup write FRadioGroup;

    property Caption;
//    property Color;
    property TabStop default True;
    property Height default 40;
    property Width default 250;

    property OnCanToggle: TUItemButtonCanToggleEvent read FCanToggleEvent write FCanToggleEvent;
    property OnToggle: TUItemButtonToggleEvent read FToggleEvent write FToggleEvent;
    property OnDrawText: TUItemButtonDrawTextEvent read FDrawTextEvent write FDrawTextEvent;
    property OnDrawDetail: TUItemButtonDrawTextEvent read FDrawDetailEvent write FDrawDetailEvent;
  end;

implementation

uses
  SysUtils,
  UCL.ThemeManager,
  UCL.Colors,
  UCL.FontIcons,
  UCL.ColorTypes;

{ TUItemButton }

//  MAIN CLASS

constructor TUItemButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csDoubleClicks];

  FCustomColors := TUItemButtonColorSet.Create(Self);
  FCustomColors.Assign(Item_Button_Colors);
  FCustomColors.OnChange := ColorsChange;

  FAcceptControls := False;
  FBorderThickness := -1;

  DragCursor:=crDefault;

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

  FIsChecked := False;
  FLeftIcon := UF_LIKE;
  FText := 'Text';
  FDetail := 'Detail';
  FRightIcon := UF_CHECKMARK;

  FCheckBoxWidth := 40;
  FLeftIconWidth := 40;
  FRightIconWidth := 40;

  FAlignSpace := 5;
//  FCustomActiveColor := $D77800;
  //FCustomActiveColor := clNone;
  FTransparent := False;
  FLeftIconKind := ikFontIcon;
  FRightIconKind := ikFontIcon;
  FIsToggleButton := False;
  FIsToggled := False;

  //  Common properties
  TabStop := True;
  Height := 40;
  Width := 250;

  InitBumpMap;
  UpdateTheme;
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
{
function TUItemButton.GetDragFloating: Boolean;
begin
  Result := FDragFloating;
end;

procedure TUItemButton.StoreAlign;
begin
  FOrgAlign:=Align;
  Align:=alNone;
end;

procedure TUItemButton.StorePosition;
begin
  if FOrgPosition = EmptyPoint then
    FOrgPosition:=Point(Left, Top);
end;

procedure TUItemButton.DragFloat(X, Y: Integer);
begin
  FDragFloating:=True;
  Left:=X;
  Top:=Y;
end;

procedure TUItemButton.RestoreAlign;
begin
  if FOrgAlign <> alNone then begin
    Align:=FOrgAlign;
    FOrgAlign:=alNone;
  end;
end;

procedure TUItemButton.RestorePosition;
begin
  if FOrgPosition <> EmptyPoint then begin
    Left:=FOrgPosition.X;
    Top:=FOrgPosition.Y;
    FOrgPosition:=EmptyPoint;
    FDragFloating:=False;
  end;
end;
}
//  INTERNAL

procedure TUItemButton.UpdateColors;
var
  TM: TUCustomThemeManager;
  Delta: Integer;
begin
  TM:=SelectThemeManager(Self);

  TM.Colors.ItemButtonColors.GetColors(ButtonState, FCustomColors, BackColor, BorderColor, TextColor, DetailColor, ActiveColor);

  if Transparent then begin
    ParentColor := True;
    BackColor := Color;
    TextColor := GetTextColorFromBackground(Color);
  end;

  //  Transparent enabled
//  if ButtonState = csNone then begin
//    TextColor := GetTextColorFromBackground(Color);
//    //DetailColor := $808080;
//  end
  //  Highlight enabled
//  else
  if (IsToggleButton and IsToggled) and (ButtonState in [csNone, csHover, csFocused]) then begin
    BackColor := TM.AccentColor;
    TextColor := GetTextColorFromBackground(BackColor);
    //DetailColor := clSilver;
  end
  else if (ButtonState = csPress) and (csPrintClient in ControlState) then begin
    BackColor := TM.AccentColor;
    TextColor := GetTextColorFromBackground(BackColor);
    //DetailColor := clSilver;
  end
//  else if ButtonState = csDisabled then begin
//    TextColor := clGray;
//    DetailColor := clSilver;
//  end
  //  Default colors
  else begin
    if IsToggled then
      BackColor := TM.AccentColor;
    //else
      //BackColor := BUTTON_BACK.GetColor(TM.ThemeUsed, ButtonState);
      //TM.Colors.ItemButtonColors.GetColors(ButtonState, FCustomColors, BackColor, BorderColor, TextColor);
    //TextColor := BUTTON_TEXT.GetColor(TempTheme, ButtonState);
    TextColor := GetTextColorFromBackground(BackColor);
    //DetailColor := $808080;
  end;
  //
  Delta := +128;
  if (TM.Theme = ttSystem) then begin
    if TM.ThemeUsed = utDark then
      Delta := -128;
  end
  else if (TM.Theme = ttDark) then
    Delta := -128;
  DetailColor := BrightenColor(TextColor, Delta);
  //
//  BorderColor := BackColor;
//  if (ButtonState in [csHover, csFocused]) then
//    BorderColor := $AAAAAA;

  //  Active color
  if not TM.UseSystemAccentColor and TM.Colors.ItemButtonColors.AllowCustomColors and CustomColors.ActiveColors.Enabled then
    ActiveColor := CustomColors.ActiveColors.GetColor(TM.ThemeUsed, ButtonState)
  else
    ActiveColor := TM.AccentColor;
end;

procedure TUItemButton.UpdateRects;
var
  LPos, RPos: Integer;
  TextWidth: Integer;
  DetailWidth: Integer;
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

  Canvas.Font.Assign(Font);
  TextWidth := Canvas.TextWidth(Text);

  if iokDetail in ObjectsVisible then begin
    Canvas.Font.Assign(DetailFont);
    DetailWidth := Canvas.TextWidth(Detail);
    if TextWidth + DetailWidth > RPos - AlignSpace then begin
      DetailWidth := RPos - AlignSpace - TextWidth;
      if DetailWidth < 0 then
        DetailWidth := 0;
    end;
    if DetailWidth > 0 then
      DetailRect := Rect(RPos - AlignSpace - DetailWidth, 0, RPos, Height)
    else
      DetailRect := TRect.Empty;
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

procedure TUItemButton.DoDrawDetail(const ACanvas: TCanvas; ARect: TRect; AText: String);
begin
  if Assigned(FDrawDetailEvent) then
    FDrawDetailEvent(Self, ACanvas, ARect, AText);
end;

procedure TUItemButton.DoDrawText(const ACanvas: TCanvas; ARect: TRect; AText: String);
begin
  if Assigned(FDrawTextEvent) then
    FDrawTextEvent(Self, ACanvas, ARect, AText);
end;

function TUItemButton.GetDragImages: TDragImageList;
var
  Bmp: Graphics.TBitmap;
  P: TPoint;
begin
  Result := TDragImageList.Create(Nil);
  //
  Bmp := Graphics.TBitmap.Create;
  try
    Bmp.PixelFormat := pf32bit;
    Bmp.Canvas.Brush.Color := clFuchsia;

    // 2px margin at each side just to show image can have transparency.
    Bmp.Width := Width + 1;
    Bmp.Height := Height + 1;
    Bmp.Canvas.Lock;
    Self.PaintTo(Bmp.Canvas.Handle, 1, 1);
    Bmp.Canvas.Unlock;

    Result.Width := Bmp.Width;
    Result.Height := Bmp.Height;
    P := Mouse.CursorPos;
    MapWindowPoints(HWND_DESKTOP, Self.Handle, P, 1);
    Result.DragHotspot := P;
    Result.Masked := True;
    Result.AddMasked(Bmp, clFuchsia);
    //BmpIdx:=Result.AddMasked(Bmp, clFuchsia);
    //Result.SetDragImage(BmpIdx, 0, 0);
  finally
    Bmp.Free;
  end;
end;

//  SETTERS

procedure TUItemButton.SetCustomColors(Value: TUItemButtonColorSet);
begin
  FCustomColors.Assign(Value);
end;

procedure TUItemButton.SetAcceptControls(const Value: Boolean);
begin
  if FAcceptControls <> Value then begin
    FAcceptControls := Value;
    if Value then
      ControlStyle := ControlStyle + [csAcceptsControls]
    else
      ControlStyle := ControlStyle - [csAcceptsControls];
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TUItemButton.SetBorderThickness(Value: Integer);
begin
  if FBorderThickness <> Value then begin
    if Value < -1 then
      Value := -1;
    FBorderThickness := Value;
    UpdateTheme;
  end;
end;

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

  procedure TurnSiblingsOff;
  var
    I: Integer;
    Sibling: TControl;
  begin
    if Parent <> Nil then begin
      for I:= 0 to Parent.ControlCount - 1 do begin
        Sibling := Parent.Controls[I];
        if (Sibling <> Self) and (Sibling is TUItemButton) and (TUItemButton(Sibling).RadioGroup = RadioGroup) then
          TUItemButton(Sibling).SetIsChecked(False);
      end;
    end;
  end;

begin
  if Value <> FIsChecked then begin
    FIsChecked := Value;
    //  Uncheck all items with the same group
    if (CheckType = ctRadioBtn) and Value then
      TurnSiblingsOff;
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

procedure TUItemButton.SetCheckType(const Value: TUItemButtonCheckType);
begin
  if FCheckType <> Value then begin
    FCheckType := Value;
    Repaint;
  end;
end;

//procedure TUItemButton.SetCustomActiveColor(const Value: TColor);
//begin
//  if Value <> FCustomActiveColor then begin
//    FCustomActiveColor := Value;
//    UpdateColors;
//    Repaint;
//  end;
//end;

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
  if csPaintCopy in ControlState then
    UpdateColors;
  TM:=SelectThemeManager(Self);
  bmp := TBitmap.Create;
  try
    bmp.SetSize(Width, Height);
    //bmp.Canvas.Assign(Canvas);

    // Paint background
    bmp.Canvas.Brush.Style := bsSolid;
    bmp.Canvas.Brush.Handle := CreateSolidBrushWithAlpha(BackColor, 255);
    bmp.Canvas.FillRect(Rect(0, 0, Width, Height));

    bmp.Canvas.Font.Assign(IconFont);

    P:=Mouse.CursorPos;
    P:=ScreenToClient(P);

    // Draw border
    DrawBorder(bmp.Canvas, Rect(0, 0, Width, Height), BorderColor, SelectControlBorderThickness(TM, FBorderThickness, mulScale));

    if Enabled and MouseInClient and not (csPaintCopy in ControlState) and not IsDesigning then
//      DrawBumpMap(bmp.Canvas, P.X, Height div 2, TM.ThemeUsed = utDark);
      DrawBumpMap(bmp.Canvas, P.X, P.Y, TM.ThemeUsed = utDark);

    //  Paint checkbox / radio button
    if iokCheckBox in ObjectsVisible then begin
      if Enabled then
        bmp.Canvas.Font.Color := ActiveColor
      else
        bmp.Canvas.Font.Color := TextColor;
      if IsChecked then begin
        //bmp.Canvas.Font.Color := ActiveColor;
        if CheckType = ctCheckBox then
          DrawTextRect(bmp.Canvas, taCenter, taVerticalCenter, CheckBoxRect, UF_CHECKBOX_CHECKED, False, False)
        else begin
          DrawTextRect(bmp.Canvas, taCenter, taVerticalCenter, CheckBoxRect, UF_RADIO_OUTLINE, False, False);
          //bmp.Canvas.Font.Color := TextColor;
          DrawTextRect(bmp.Canvas, taCenter, taVerticalCenter, CheckBoxRect, UF_RADIO_SMALL, False, False);
        end;
      end
      else begin
        //bmp.Canvas.Font.Color := ActiveColor;
        if CheckType = ctCheckBox then
          DrawTextRect(bmp.Canvas, taCenter, taVerticalCenter, CheckBoxRect, UF_CHECKBOX_OUTLINE, False, False)
        else
          DrawTextRect(bmp.Canvas, taCenter, taVerticalCenter, CheckBoxRect, UF_RADIO_OUTLINE, False, False);
      end;
    end;

    bmp.Canvas.Font.Color := TextColor;

    //  Paint left icon
    if iokLeftIcon in ObjectsVisible then begin
      if LeftIconKind = ikFontIcon then
        DrawTextRect(bmp.Canvas, taCenter, taVerticalCenter, LeftIconRect, LeftIcon, False, False)
      else if Images <> Nil then begin
        GetCenterPos(Images.Width, Images.Height, LeftIconRect, ImgX, ImgY);
        Images.Draw(ImageLeftIndex, bmp.Canvas, ImgX, ImgY, dsTransparent, itImage, Enabled);
      end;
    end;

    //  Paint right icon
    if iokRightIcon in ObjectsVisible then begin
      if RightIconKind = ikFontIcon then
        DrawTextRect(bmp.Canvas, taCenter, taVerticalCenter, RightIconRect, RightIcon, False, False)
      else if Images <> Nil then begin
        GetCenterPos(Images.Width, Images.Height, RightIconRect, ImgX, ImgY);
        Images.Draw(ImageRightIndex, bmp.Canvas, ImgX, ImgY, dsTransparent, itImage, Enabled);
      end;
    end;

    //  Paint detail
    if (iokDetail in ObjectsVisible) and not DetailRect.IsEmpty then begin
      bmp.Canvas.Font.Assign(DetailFont);
      bmp.Canvas.Font.Color := DetailColor;
      if Assigned(FDrawDetailEvent) then
        DoDrawDetail(bmp.Canvas, DetailRect, Detail)
      else
        DrawTextRect(bmp.Canvas, taLeftJustify, taVerticalCenter, DetailRect, Detail, Pos(#13#10, Detail) > 0, False);
    end;

    //  Paint text
    if iokText in ObjectsVisible then begin
      bmp.Canvas.Font.Assign(Font);
      bmp.Canvas.Font.Color := TextColor;
      if Assigned(FDrawTextEvent) then
        DoDrawText(bmp.Canvas, TextRect, Text)
      else
        DrawTextRect(bmp.Canvas, taLeftJustify, taVerticalCenter, TextRect, Text, Pos(#13#10, Text) > 0, False);
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
{
procedure TUItemButton.WMLButtonDblClk(var Msg: TWMLButtonDblClk);
begin
  if Enabled then begin
    ButtonState := csPress;
  end;
  inherited;
end;
}
procedure TUItemButton.WMLButtonDown(var Msg: TWMLButtonDown);
begin
  if Enabled then begin
    ButtonState := csPress;
  end;
  inherited;
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

    if MouseInClient then
      ButtonState := csHover
    else
      ButtonState := csNone;
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
  end;
  inherited;
end;

procedure TUItemButton.WMKillFocus(var Msg: TWMKillFocus);
begin
  if Enabled then begin
    ButtonState := csNone;
  end;
  inherited;
end;

procedure TUItemButton.CMMouseEnter(var Msg: TMessage);
begin
  if Enabled then begin
    ButtonState := csHover;
  end;
  inherited;
end;

procedure TUItemButton.CMMouseLeave(var Msg: TMessage);
begin
  if Enabled then begin
    ButtonState := csNone;
  end;
  inherited;
end;

procedure TUItemButton.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;
  if AcceptControls then
    NotifyControls(CM_ENABLEDCHANGED);
  if not Enabled then
    FButtonState := csDisabled
  else
    FButtonState := csNone;
  UpdateTheme;
end;

procedure TUItemButton.ColorsChange(Sender: TObject);
begin
  UpdateColors;
  Invalidate;
end;

end.
