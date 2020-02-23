unit UCL.TUButton;

interface

{$IF CompilerVersion > 29}
  {$LEGACYIFEND ON}
{$IFEND}

uses
  SysUtils,
  Windows,
  Messages,
  Classes,
  Types,
  Controls,
  Graphics,
  ImgList,
  UCL.Classes,
  UCL.TUThemeManager,
  UCL.Utils,
  UCL.Graphics;

type
  TUCustomButton = class(TCustomControl, IUThemeComponent)
  private const
    DefBackColor: TDefColor = (
      ($CCCCCC, $CCCCCC, $999999, $CCCCCC, $CCCCCC),
      ($333333, $333333, $666666, $333333, $333333)
    );
    DefBorderColor: TDefColor = (
      ($CCCCCC, $7A7A7A, $999999, $CCCCCC, $7A7A7A),
      ($333333, $858585, $666666, $333333, $858585)
    );
    DefTextColor: TDefColor = (
      ($000000, $000000, $000000, $666666, $000000),
      ($FFFFFF, $FFFFFF, $FFFFFF, $666666, $FFFFFF)
    );

  private var
    BorderThickness: Integer;
    BorderColor, BackColor, TextColor: TColor;
    ImgRect, TextRect: TRect;

  private
    //  Theme
    FThemeManager: TUThemeManager;
    FCustomBorderColors: TControlStateColors;
    FCustomBackColors: TControlStateColors;
    FCustomTextColors: TControlStateColors;

    //  Fields
    FButtonState: TUControlState;
    FAlignment: TAlignment;
    FImageIndex: Integer;
    FImages: TCustomImageList;
    FAllowFocus: Boolean;
    FHighlight: Boolean;
    FIsToggleButton: Boolean;
    FIsToggled: Boolean;
    FTransparent: Boolean;
    FMouseInClient: Boolean;

    //  Internal
    procedure UpdateColors;
    procedure UpdateRects;

    //  Setters
    procedure SetThemeManager; // (const Value: TUThemeManager);
    procedure SetButtonState(const Value: TUControlState);
    procedure SetAlignment(const Value: TAlignment);
    procedure SetImageIndex(const Value: Integer);
    procedure SetHighlight(const Value: Boolean);
    procedure SetTransparent(const Value: Boolean);

    //  Messages
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;

    procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMMouseMove(var Msg: TWMMouseMove); message WM_MOUSEMOVE;

    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
    procedure CMDialogKey(var Msg: TCMDialogKey); message CM_DIALOGKEY;

    //  Group property change
    procedure DoCustomBorderColorsChange(Sender: TObject);
    procedure DoCustomBackColorsChange(Sender: TObject);
    procedure DoCustomTextColorsChange(Sender: TObject);

  protected
    //procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure Resize; override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND}); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateTheme;

  published
    property ThemeManager: TUThemeManager read FThemeManager; // write SetThemeManager;
    property CustomBorderColors: TControlStateColors read FCustomBorderColors write FCustomBorderColors;
    property CustomBackColors: TControlStateColors read FCustomBackColors write FCustomBackColors;
    property CustomTextColors: TControlStateColors read FCustomTextColors write FCustomTextColors;

    property ButtonState: TUControlState read FButtonState write SetButtonState default csNone;
    property Alignment: TAlignment read FAlignment write SetAlignment default taCenter;
    property ImageIndex: Integer read FImageIndex write SetImageIndex default -1;
    property Images: TCustomImageList read FImages write FImages;
    property AllowFocus: Boolean read FAllowFocus write FAllowFocus default true;
    property Highlight: Boolean read FHighlight write SetHighlight default false;
    property IsToggleButton: Boolean read FIsToggleButton write FIsToggleButton default false;
    property IsToggled: Boolean read FIsToggled write FIsToggled default false;
    property Transparent: Boolean read FTransparent write SetTransparent default false;

    property Height default 30;
    property Width default 135;
    property TabStop default True;
  end;

  TUButton = class(TUCustomButton)
  published
    property Align;
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Caption;
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

{ TUCustomButton }

//  THEME

procedure TUCustomButton.SetThemeManager; // (const Value: TUThemeManager);
begin
  FThemeManager := GetCommonThemeManager;
  UpdateTheme;
end;

procedure TUCustomButton.UpdateTheme;
begin
  UpdateColors;
  UpdateRects;
  Repaint;
end;
{
procedure TUCustomButton.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FThemeManager) then
    FThemeManager := nil;
end;
}
//  INTERNAL

procedure TUCustomButton.UpdateColors;
begin
  //  Not connect ThemeManager, use custom colors
  if ThemeManager = Nil then begin
    BorderColor := CustomBorderColors.GetStateColor(ButtonState);
    BackColor := CustomBackColors.GetStateColor(ButtonState);
    TextColor := CustomTextColors.GetStateColor(ButtonState);
  end
  //  Highlight button
  else if (Highlight or (IsToggleButton and IsToggled)) and //  Is highlight button, or toggle on
          (ButtonState in [csNone, csHover, csFocused]) then begin //  Highlight only when mouse normal, hover and focused
    BackColor := ThemeManager.AccentColor;
    if ButtonState = csNone then
      BorderColor := BackColor
    else
      BorderColor := MulColor(BackColor, 0.6);
    TextColor := GetTextColorFromBackground(BackColor);
  end
  //  Default colors
  else begin
    BorderColor := DefBorderColor[ThemeManager.Theme, ButtonState];
    BackColor := DefBackColor[ThemeManager.Theme, ButtonState];
    TextColor := DefTextColor[ThemeManager.Theme, ButtonState];
  end;

  //  Transparent
  if (ButtonState = csNone) and (Transparent) then begin
    ParentColor := True;
    BackColor := Color;
    BorderColor := Color; //  The same background, because of button state
    TextColor := GetTextColorFromBackground(Color);
  end;
end;

procedure TUCustomButton.UpdateRects;
begin
  //  Calc rects
  if (Images <> Nil) and (ImageIndex >= 0) then begin
    ImgRect := Rect(0, 0, Height, Height);  //  Square left align
    TextRect := Rect(Height, 0, Width, Height);
  end
  else
    TextRect := Rect(0, 0, Width, Height);
end;

//  SETTERS

procedure TUCustomButton.SetButtonState(const Value: TUControlState);
begin
  if Value <> FButtonState then begin
    FButtonState := Value;
    UpdateColors;
    Repaint;
  end;
end;

procedure TUCustomButton.SetAlignment(const Value: TAlignment);
begin
  if Value <> FAlignment then begin
    FAlignment := Value;
    Repaint;
  end;
end;

procedure TUCustomButton.SetImageIndex(const Value: Integer);
begin
  if Value <> FImageIndex then begin
    FImageIndex := Value;
    UpdateRects;
    Repaint;
  end;
end;

procedure TUCustomButton.SetHighlight(const Value: Boolean);
begin
  if Value <> FHighlight then begin
    FHighlight := Value;
    UpdateColors;
    Repaint;
  end;
end;

procedure TUCustomButton.SetTransparent(const Value: Boolean);
begin
  if Value <> FTransparent then begin
    FTransparent := Value;
    Repaint;
  end;
end;

//  MAIN CLASS

constructor TUCustomButton.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FThemeManager := Nil;

  BorderThickness := 2;

  //  New properties
  FCustomBorderColors := TControlStateColors.Create($F2F2F2, $E6E6E6, $CCCCCC, $F2F2F2, $F2F2F2);
  FCustomBackColors := TControlStateColors.Create($F2F2F2, $E6E6E6, $CCCCCC, $F2F2F2, $F2F2F2);
  FCustomTextColors := TControlStateColors.Create(clBlack, clBlack, clBlack, clGray, clBlack);

  FCustomBorderColors.OnChange := DoCustomBorderColorsChange;
  FCustomBackColors.OnChange := DoCustomBackColorsChange;
  FCustomTextColors.OnChange := DoCustomTextColorsChange;

  FButtonState := csNone;
  FAlignment := taCenter;
  FImageIndex := -1;
  FAllowFocus := True;
  FHighlight := False;
  FIsToggleButton := False;
  FIsToggled := False;
  FTransparent := False;

  //  Property
  Height := 30;
  Width := 135;
//  Font.Name := 'Segoe UI';
//  Font.Size := 10;
  TabStop := True;

  InitBumpMap;

  if GetCommonThemeManager <> Nil then
    GetCommonThemeManager.Connect(Self);
end;

destructor TUCustomButton.Destroy;
begin
  FCustomBorderColors.Free;
  FCustomBackColors.Free;
  FCustomTextColors.Free;
  if FThemeManager <> Nil then
    FThemeManager.Disconnect(Self);
  inherited;
end;

//  CUSTOM METHODS

procedure TUCustomButton.Paint;
var
  ImgX, ImgY: Integer;
  bmp: TBitmap;
  P: TPoint;
begin
  inherited;

  bmp := TBitmap.Create;
  try
    bmp.SetSize(Width, Height);
    //bmp.Canvas.Assign(Canvas);

    //  Paint background
    bmp.Canvas.Brush.Handle := CreateSolidBrushWithAlpha(BackColor, 255);
    bmp.Canvas.FillRect(Rect(0, 0, Width, Height));

    P:=Mouse.CursorPos;
    P:=ScreenToClient(P);

    //  Draw border
    DrawBorder(bmp.Canvas, Rect(0, 0, Width, Height), BorderColor, BorderThickness);

    if Enabled and FMouseInClient then
      DrawBumpMap(bmp.Canvas, P.X, Height div 2);

    //  Paint image
    if (Images <> Nil) and (ImageIndex >= 0) then begin
      GetCenterPos(Images.Width, Images.Height, ImgRect, ImgX, ImgY);
      Images.Draw(bmp.Canvas, ImgX, ImgY, ImageIndex, Enabled);
    end;

    //  Paint text
    bmp.Canvas.Font := Font;
    bmp.Canvas.Font.Color := TextColor;
    DrawTextRect(bmp.Canvas, Alignment, taVerticalCenter, TextRect, Caption, False);

    //
    Canvas.Draw(0, 0, bmp);
  finally
    bmp.Free;
  end;
end;

procedure TUCustomButton.Resize;
begin
  inherited;
  UpdateRects;
end;

procedure TUCustomButton.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  UpdateColors;
  UpdateRects;
end;

procedure TUCustomButton.ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND});
begin
  inherited;
  BorderThickness := MulDiv(BorderThickness, M, D);
  UpdateRects;
end;

//  MESSAGES

procedure TUCustomButton.WMSetFocus(var Msg: TWMSetFocus);
begin
  if Enabled and AllowFocus then begin
    ButtonState := csFocused;
    inherited;
  end;
end;

procedure TUCustomButton.WMKillFocus(var Msg: TWMKillFocus);
begin
  if Enabled then begin
    ButtonState := csNone;
    inherited;
  end;
end;

procedure TUCustomButton.WMLButtonDblClk(var Msg: TWMLButtonDblClk);
begin
  if Enabled then begin
    ButtonState := csPress;
    inherited;
  end;
end;

procedure TUCustomButton.WMLButtonDown(var Msg: TWMLButtonDown);
begin
  if Enabled then begin
    if AllowFocus then
      SetFocus;
    ButtonState := csPress;
    inherited;
  end;
end;

procedure TUCustomButton.WMLButtonUp(var Msg: TWMLButtonUp);
begin
  if Enabled then begin
    if IsToggleButton then
      FIsToggled := not FIsToggled;
    ButtonState := csHover;
    inherited;
  end;
end;

procedure TUCustomButton.WMMouseMove(var Msg: TWMMouseMove);
begin
  if Enabled then
    Repaint;
  inherited;
end;

procedure TUCustomButton.CMMouseEnter(var Msg: TMessage);
begin
  FMouseInClient := True;
  if Enabled then begin
    ButtonState := csHover;
    inherited;
  end;
end;

procedure TUCustomButton.CMMouseLeave(var Msg: TMessage);
begin
  FMouseInClient := False;
  if Enabled then begin
    //  Dont allow focus
    if not AllowFocus then
      ButtonState := csNone //  No keep border

    //  Allow focus
    else if not Focused then
      ButtonState := csNone //  No focus, no border
    else
      ButtonState := csFocused; //  Keep focus border

    inherited;
  end;
end;

procedure TUCustomButton.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;
  if not Enabled then
    FButtonState := csDisabled
  else
    FButtonState := csNone;
  UpdateColors;
  Repaint;
end;

procedure TUCustomButton.CMDialogKey(var Msg: TWMKey);
begin
  if AllowFocus and Focused and (Msg.CharCode = VK_RETURN) then begin
    Click;
    Msg.Result := 1;
  end
  else
    inherited;
end;

//  GROUP PROPERTY CHANGE

procedure TUCustomButton.DoCustomBorderColorsChange(Sender: TObject);
begin
  UpdateColors;
  Repaint;
end;

procedure TUCustomButton.DoCustomBackColorsChange(Sender: TObject);
begin
  UpdateColors;
  Repaint;
end;

procedure TUCustomButton.DoCustomTextColorsChange(Sender: TObject);
begin
  UpdateColors;
  Repaint;
end;

end.
