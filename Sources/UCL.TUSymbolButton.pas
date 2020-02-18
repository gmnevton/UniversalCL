unit UCL.TUSymbolButton;

interface

{$IF CompilerVersion > 29}
  {$LEGACYIFEND ON}
{$IFEND}

uses
  Classes,
  Types,
  Messages,
  Windows,
  Controls,
  Graphics,
  ImgList,
  UCL.Classes,
  UCL.SystemSettings,
  UCL.TUThemeManager,
  UCL.Utils,
  UCL.Graphics;

type
  TUCustomSymbolButton = class(TCustomControl, IUThemeComponent)
  private const
    DefBackColor: TDefColor = (
      ($00E6E6E6, $00CFCFCF, $00B8B8B8, $00CCCCCC, $00CFCFCF),
      ($001F1F1F, $00353535, $004C4C4C, $00333333, $00353535)
    );
    DefTextColor: TDefColor = (
      ($00000000, $00000000, $00000000, $00666666, $00000000),
      ($00FFFFFF, $00FFFFFF, $00FFFFFF, $00666666, $00FFFFFF)
    );

  private var
    BackColor, TextColor, DetailColor: TColor;
    IconRect, TextRect, DetailRect: TRect;
  
  private  
    FThemeManager: TUThemeManager;

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

    //  Internal
    procedure UpdateColors;
    procedure UpdateRects;

    //  Setters
    procedure SetThemeManager; // (const Value: TUThemeManager);
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

    //  Messages
    procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;

    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure CMFontChanged(var Msg: TMessage); message CM_FONTCHANGED;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;

  protected
    //procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure Resize; override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND}); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure UpdateTheme;

  published
    property ThemeManager: TUThemeManager read FThemeManager; // write SetThemeManager;

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

    property TabStop default true;
    property Height default 40;
    property Width default 250;
  end;

  TUSymbolButton = class(TUCustomSymbolButton)
  published
    property Align;
    property Anchors;
    property AutoSize;
    property BiDiMode;
    //property Caption;
    property Color;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Touch;
    property Visible;
  {$IF CompilerVersion > 29}
    property StyleElements;
  {$IFEND}

    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnGesture;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses
  UCL.Types;

{ TUCustomSymbolButton }

//  THEME

procedure TUCustomSymbolButton.SetThemeManager; // (const Value: TUThemeManager);
begin
  FThemeManager := GetCommonThemeManager;
  UpdateTheme;
end;

procedure TUCustomSymbolButton.UpdateTheme;
begin
  UpdateColors;
  UpdateRects;
  Repaint;
end;
{
procedure TUCustomSymbolButton.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FThemeManager) then
    FThemeManager := nil;
end;
}
//  INTERNAL

procedure TUCustomSymbolButton.UpdateColors;
var
  TempTheme: TUTheme;
begin
  if ThemeManager = Nil then
    TempTheme := utLight
  else
    TempTheme := ThemeManager.Theme;

  //  Transparent enabled
  if (ButtonState = csNone) and Transparent then begin
    ParentColor := true;
    BackColor := Color;
    TextColor := GetTextColorFromBackground(Color);
    DetailColor := $808080;
  end
  //  Highlight enabled
  else if (ThemeManager <> Nil) and (IsToggleButton and IsToggled) and (ButtonState in [csNone, csHover, csFocused]) then begin
    BackColor := ThemeManager.AccentColor;
    TextColor := GetTextColorFromBackground(BackColor);
    DetailColor := clSilver;
  end
  //  Default colors
  else begin
    BackColor := DefBackColor[TempTheme, ButtonState];
    TextColor := DefTextColor[TempTheme, ButtonState];
    DetailColor := $808080;
  end;
end;

procedure TUCustomSymbolButton.UpdateRects;
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

//  SETTERS

procedure TUCustomSymbolButton.SetButtonState(const Value: TUControlState);
begin
  if Value <> FButtonState then begin
    FButtonState := Value;
    UpdateColors;
    Repaint;
  end;
end;

procedure TUCustomSymbolButton.SetOrientation(const Value: TUOrientation);
begin
  if Value <> FOrientation then begin
    FOrientation := Value;
    UpdateRects;
    Repaint;
  end;
end;

procedure TUCustomSymbolButton.SetSymbolChar(const Value: string);
begin
  if Value <> FSymbolChar then begin
    FSymbolChar := Value;
    Repaint;
  end;
end;

procedure TUCustomSymbolButton.SetText(const Value: string);
begin
  if Value <> FText then begin
    FText := Value;
    UpdateRects;
    Repaint;
  end;
end;

procedure TUCustomSymbolButton.SetTextOffset(const Value: Integer);
begin
  if Value <> FTextOffset then begin
    FTextOffset := Value;
    UpdateRects;
    Repaint;
  end;
end;

procedure TUCustomSymbolButton.SetDetail(const Value: string);
begin
  if Value <> FDetail then begin
    FDetail := Value;
    UpdateRects;
    Repaint;
  end;
end;

procedure TUCustomSymbolButton.SetDetailRightOffset(const Value: Integer);
begin
  if Value <> FDetailRightOffset then begin
    FDetailRightOffset := Value;
    UpdateRects;
    Repaint;
  end;
end;

procedure TUCustomSymbolButton.SetShowIcon(const Value: Boolean);
begin
  if Value <> FShowIcon then begin
    FShowIcon := Value;
    UpdateRects;
    Repaint;
  end;
end;

procedure TUCustomSymbolButton.SetShowDetail(const Value: Boolean);
begin
  if Value <> FShowDetail then begin
    FShowDetail := Value;
    UpdateRects;
    Repaint;
  end;
end;

procedure TUCustomSymbolButton.SetTransparent(const Value: Boolean);
begin
  if Value <> FTransparent then begin
    FTransparent := Value;
    UpdateColors;
    Repaint;
  end;
end;

procedure TUCustomSymbolButton.SetIsToggled(const Value: Boolean);
begin
  if Value <> FIsToggled then begin
    FIsToggled := Value;
    UpdateColors;
    Repaint;
  end;
end;

procedure TUCustomSymbolButton.SetImageIndex(const Value: Integer);
begin
  if Value <> FImageIndex then begin
    FImageIndex := Value;
    Repaint;
  end;
end;

procedure TUCustomSymbolButton.SetImageKind(const Value: TUImageKind);
begin
  if Value <> FImageKind then begin
    FImageKind := Value;
    Repaint;
  end;
end;

//  MAIN CLASS

constructor TUCustomSymbolButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FThemeManager := Nil;

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
  FSymbolChar := '';
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

  if GetCommonThemeManager <> Nil then
    GetCommonThemeManager.Connect(Self);
end;

destructor TUCustomSymbolButton.Destroy;
begin
  FSymbolFont.Free;
  FDetailFont.Free;
  if FThemeManager <> Nil then
    FThemeManager.Disconnect(Self);
  inherited;
end;

//  CUSTOM METHODS

procedure TUCustomSymbolButton.Paint;
var
  ImgX, ImgY: Integer;
begin
  inherited;

  //  Paint background
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Handle := CreateSolidBrushWithAlpha(BackColor, 255);
  Canvas.FillRect(Rect(0, 0, Width, Height));

  //  Paint icon
  if ImageKind = ikFontIcon then begin
    if ShowIcon then begin
      Canvas.Font := SymbolFont;
      Canvas.Font.Color := TextColor;
      DrawTextRect(Canvas, taCenter, taVerticalCenter, IconRect, SymbolChar, False)
    end;
  end
  else begin
    if Images <> Nil then begin
      GetCenterPos(Images.Width, Images.Height, IconRect, ImgX, ImgY);
      Images.Draw(Canvas, ImgX, ImgY, ImageIndex, Enabled);
    end;
  end;

  //  Paint detail
  if ShowDetail then begin
    Canvas.Font := DetailFont;
    Canvas.Font.Color := DetailColor;
    if Orientation = oHorizontal then
      DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, DetailRect, Detail, False)
    else
      DrawTextRect(Canvas, taCenter, taAlignTop, DetailRect, Detail, False);
  end;

  //  Paint text
  Canvas.Font := Font;
  Canvas.Font.Color := TextColor;
  if Orientation = oHorizontal then
    DrawTextRect(Canvas, taLeftJustify, taVerticalCenter, TextRect, Text, False)
  else
    DrawTextRect(Canvas, taCenter, taAlignTop, TextRect, Text, False);
end;

procedure TUCustomSymbolButton.Resize;
begin
  inherited;
  UpdateRects;
end;

procedure TUCustomSymbolButton.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  UpdateColors;
  UpdateRects;
end;

procedure TUCustomSymbolButton.ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND});
begin
  inherited;

  TextOffset := MulDiv(TextOffset, M, D);
  DetailRightOffset := MulDiv(DetailRightOffset, M, D);

  SymbolFont.Height := MulDiv(SymbolFont.Height, M, D);
//  Font.Height := MulDiv(Font.Height, M, D);
  DetailFont.Height := MulDiv(DetailFont.Height, M, D);

  UpdateRects;
end;

//  MESSAGES

procedure TUCustomSymbolButton.WMLButtonDblClk(var Msg: TWMLButtonDblClk);
begin
  if Enabled then begin
    ButtonState := csPress;
    inherited;
  end;
end;

procedure TUCustomSymbolButton.WMLButtonDown(var Msg: TWMLButtonDown);
begin
  if Enabled then begin
    ButtonState := csPress;
    inherited;
  end;
end;

procedure TUCustomSymbolButton.WMLButtonUp(var Msg: TWMLButtonUp);
begin
  if Enabled then begin
    if IsToggleButton then
      FIsToggled := not FIsToggled;
    ButtonState := csHover;
    inherited;
  end;
end;

procedure TUCustomSymbolButton.CMMouseEnter(var Msg: TMessage);
begin
  if Enabled then begin
    ButtonState := csHover;
    inherited;
  end;
end;

procedure TUCustomSymbolButton.CMMouseLeave(var Msg: TMessage);
begin
  if Enabled then begin
    ButtonState := csNone;
    inherited;
  end;
end;

procedure TUCustomSymbolButton.CMFontChanged(var Msg: TMessage);
begin
  Repaint;
end;

procedure TUCustomSymbolButton.CMEnabledChanged(var Msg: TMessage);
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
