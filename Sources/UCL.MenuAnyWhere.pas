unit UCL.MenuAnyWhere;

interface

uses
  SysUtils,
  Windows,
  Classes,
  Controls,
  Forms,
  Menus,
  Messages,
  Types,
  Graphics,
  ComCtrls,
{$IF CompilerVersion > 29}
  UITypes,
{$IFEND}
  ImgList,
  UCL.Classes,
  UCL.Types,
  UCL.Utils,
  UCL.Graphics,
  UCL.Colors;

type
  TMenuTriggerMode = (mtmUnknown, mtmMouse, mtmKeyboard);

  TUMenuAnyWhere = class;
  TUMenuButton = class;

  TUMenuButtonActionLink = class(TControlActionLink)
  protected
    FClient: TUMenuButton;
    procedure AssignClient(AClient: TObject); override;
    function IsCheckedLinked: Boolean; override;
    function IsDropdownMenuLinked: Boolean; override;
    function IsEnableDropdownLinked: Boolean; override;
    function IsImageIndexLinked: Boolean; override;
    procedure SetChecked(Value: Boolean); override;
    procedure SetDropdownMenu(Value: TPopupMenu); override;
    procedure SetEnableDropdown(Value: Boolean); override;
    procedure SetImageIndex(Value: Integer); override;
  end;

  TUMenuButton = class(TGraphicControl)
  private
    FDown: Boolean;
    FImageIndex: UITypes.TImageIndex; // UITypes
    FMenuItem: TMenuItem;
    FUpdateCount: Integer;
    FMouseInClient: Boolean;
    function  GetIndex: Integer;
    procedure SetDown(Value: Boolean);
    procedure SetImageIndex(Value: UITypes.TImageIndex);
    procedure SetMenuItem(Value: TMenuItem);
    procedure CMHitTest(var Message: TCMHitTest); message CM_HITTEST;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    FMenuController: TUMenuAnyWhere;
    //
    procedure SetParent(AParent: TWinControl); override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure AssignTo(Dest: TPersistent); override;
    procedure BeginUpdate; virtual;
    procedure EndUpdate; virtual;
    function  CheckMenuDropdown: Boolean; dynamic;
    function  GetActionLinkClass: TControlActionLinkClass; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Click; override;
    property Index: Integer read GetIndex;
    property MouseInClient: Boolean read FMouseInClient;
  published
    property Action;
    property Caption;
    property Down: Boolean read FDown write SetDown default False;
//    property DragCursor;
//    property DragKind;
//    property DragMode;
    property Enabled;
    property Height stored False;
    property ImageIndex: UITypes.TImageIndex read FImageIndex write SetImageIndex default -1;
    property MenuItem: TMenuItem read FMenuItem write SetMenuItem;
//    property ParentShowHint;
//    property PopupMenu;
    property ShowHint;
    property Visible;
    property Width;
//    property OnClick;
//    property OnContextPopup;
//    property OnDragDrop;
//    property OnDragOver;
//    property OnEndDock;
//    property OnEndDrag;
//    property OnMouseActivate;
//    property OnMouseDown;
//    property OnMouseEnter;
//    property OnMouseLeave;
//    property OnMouseMove;
//    property OnMouseUp;
//    property OnStartDock;
//    property OnStartDrag;
  end;

  TUMenuButtonSizeCalcEvent = procedure (Sender: TUMenuAnyWhere; var AWidth, AHeight: Integer) of object;

  TUMenuAnyWhere = class(TPersistent)
  private var
    ButtonBackColor,
    ButtonBackHoverColor,
    ButtonBackDisabledColor,
    ButtonTextColor,
    ButtonTextHoverColor,
    ButtonTextDisabledColor: TColor;
    //
    MenuBorderColor,
    MenuBackColor,
    MenuItemBackColor,
    MenuItemHoverColor,
    MenuItemDisabledColor,
    MenuItemTextColor,
    MenuItemTextHoverColor,
    MenuItemTextDisabledColor: TColor;

  private
    FFont: TFont;
    FButtonBackColors: TUThemeControlStateHoveredDisabledColors;
    FButtonTextColors: TUThemeControlStateHoveredDisabledColors;
    FMenuBorderColors: TUThemeControlColorSet;
    FMenuBackColors: TUThemeControlStateHoveredDisabledColors;
    FMenuTextColors: TUThemeControlStateHoveredDisabledColors;
    FUpdating: Boolean;

  private
    FControl: TWinControl;
    FMenu: TMainMenu;
    FPos: TPoint;
    //FBackColor: TColor;
    FEnabled: Boolean;
    FTransparent: Boolean;
    FButtons: TList;
    FButtonWidth: Integer;
    FButtonHeight: Integer;
    FButtonSizeAutoCalc: Boolean;
    FOnButtonSizeCalc: TUMenuButtonSizeCalcEvent;
    FControlWndProcHooked: Boolean;
    FControlWndProcOld: TWndMethod;
    FMenuTriggerMode: TMenuTriggerMode;
    FInMenuLoop: Boolean;
    FCaptureChangeCancels: Boolean;
    FTempMenu: TPopupMenu;
    FMenuResult: Boolean;
    FButtonMenu: TMenuItem;
    FMenuButton: TUMenuButton;
    FMenuDropped: Boolean;
    FHotItem: Integer;
    FMenuAnchorHighLight: Boolean;
    FGlobalHook: HHOOK;
    FOnShortCut: TShortCutEvent;

    // Setters
    procedure SetControl(Value: TWinControl);
    procedure SetMenu(Value: TMainMenu);
    procedure SetButtonSize(Index: Integer; Value: Integer);
    procedure SetButtonSizeAutoCalc(Value: Boolean);
    procedure SetPos(Index: Integer; Value: Integer);
    //procedure SetBackColor(Value: TColor);
    procedure SetEnabled(Value: Boolean);
    procedure SetTransparent(Value: Boolean);
    procedure SetFont(Value: TFont);
    procedure SetButtonBackColors(Value: TUThemeControlStateHoveredDisabledColors);
    procedure SetButtonTextColors(Value: TUThemeControlStateHoveredDisabledColors);
    procedure SetMenuBorderColors(Value: TUThemeControlColorSet);
    procedure SetMenuBackColors(Value: TUThemeControlStateHoveredDisabledColors);
    procedure SetMenuTextColors(Value: TUThemeControlStateHoveredDisabledColors);

    // Getters
    function  GetButton(Index: Integer): TUMenuButton;
    function  GetButtonCount: Integer;
    procedure GetButtonSize(var AWidth, AHeight: Integer);
    function  ControlCanvas: TCanvas;

    //  Internal
    procedure UpdateColors;
    procedure HookWndProc;
    procedure UnHookWndProc;
    procedure HookGlobalWndProc;
    procedure UnHookGlobalWndProc;
    procedure MenuChanged(Sender: TObject; Source: TMenuItem; Rebuild: Boolean);
    procedure FontChanged(Sender: TObject);
    procedure ColorsChange(Sender: TObject);
    //
    procedure CreateButtons;
    procedure DestroyButtons;
    procedure RecreateButtons;
    procedure UpdateButtons(RemakeShortCuts: Boolean);
    procedure InsertButton(AControl: TControl);
    procedure RemoveButton(AControl: TControl);
    function  ButtonIndex(OldIndex, ALeft, ATop: Integer): Integer;
    function  ReorderButton(OldIndex, ALeft, ATop: Integer): Integer;
    function  FindButtonFromAccel(Accel: Word): TUMenuButton;
    procedure SetMenuAnchorHighLight(Active: Boolean);

  protected
    procedure DoButtonSizeCalc; virtual;
    procedure DoChangeScale(M, D: Integer); virtual;
    function IsShortCut(var Message: TWMKey): Boolean; dynamic;
    //
    procedure InitMenu(Button: TUMenuButton); dynamic;
    function  TrackMenu(Button: TUMenuButton): Boolean; dynamic;
    procedure CancelMenu; dynamic;
    procedure ClearTempMenu; dynamic;
    function  CheckMenuDropdown(Button: TUMenuButton): Boolean; dynamic;
    procedure ClickButton(Button: TUMenuButton; DoubleClick: Boolean); dynamic;
    //procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    //
    procedure ControlWndProc(var Message: TMessage); dynamic;
    //
    property ButtonCount: Integer read GetButtonCount;
    property Buttons[Index: Integer]: TUMenuButton read GetButton;

  public
    constructor Create;
    destructor Destroy; override;
    //
    procedure Assign(Source: TPersistent); override;

    procedure UpdateTheme; virtual;
    //
    property Control: TWinControl read FControl write SetControl;
    property Menu: TMainMenu read FMenu write SetMenu;
    property MenuTriggerMode: TMenuTriggerMode read FMenuTriggerMode;
    property MenuAnchorHighLight: Boolean read FMenuAnchorHighLight;
    property HotItem: Integer read FHotItem;

  published
    property ButtonWidth: Integer index 0 read FButtonWidth write SetButtonSize;
    property ButtonHeight: Integer index 1 read FButtonHeight write SetButtonSize;
    property ButtonSizeAutoCalc: Boolean read FButtonSizeAutoCalc write SetButtonSizeAutoCalc default True;
    property PosX: Integer index 0 read FPos.X write SetPos default 0;
    property PosY: Integer index 1 read FPos.Y write SetPos default 0;
    //property BackColor: TColor read FBackColor write SetBackColor default clNone;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Transparent: Boolean read FTransparent write SetTransparent default True;
    property Font: TFont read FFont write SetFont;
    property ButtonBackColors: TUThemeControlStateHoveredDisabledColors read FButtonBackColors write SetButtonBackColors;
    property ButtonTextColors: TUThemeControlStateHoveredDisabledColors read FButtonTextColors write SetButtonTextColors;
    property MenuBorderColors: TUThemeControlColorSet read FMenuBorderColors write SetMenuBorderColors;
    property MenuBackColors: TUThemeControlStateHoveredDisabledColors read FMenuBackColors write SetMenuBackColors;
    property MenuTextColors: TUThemeControlStateHoveredDisabledColors read FMenuTextColors write SetMenuTextColors;

    property OnButtonSizeCalc: TUMenuButtonSizeCalcEvent read FOnButtonSizeCalc write FOnButtonSizeCalc;
    property OnShortCut: TShortCutEvent read FOnShortCut write FOnShortCut;
  end;

  TUCustomMenuAnyWhereController = class(TUCustomComponent)
  private
  protected
  public
  published
  end;

  TUMenuAnyWhereController = class(TUCustomMenuAnyWhereController);

  EUMenuAnyWhere = class(Exception);

implementation

uses
  StrUtils,
  GraphUtil,
  ActnList,
  CommCtrl,
  UCL.ThemeManager; //,
  //uWmMessageToString;

type
  TControlAccess = class(TControl);
  TWinControlAccess = class(TWinControl);
  TMenuAccess = class(TMenu);
  TMenuItemAccess = class(TMenuItem);

  TUPopupMenu = class(TPopupMenu)
  private
    FMenuController: TUMenuAnyWhere;
    FUpdateCnt: Integer;
  protected
    procedure LockUpdate;
    procedure UnlockUpdate;
    function  GetUpdateLocked: Boolean;
    procedure DoDrawText(AItem: TMenuItem; ACanvas: TCanvas; const ACaption: String; var ARect: TRect; ASelected: Boolean; AFlags: Integer);
    procedure MeasureItem(AItem: TMenuItem; ACanvas: TCanvas; var AWidth, AHeight: Integer);
    procedure AdvancedDrawItem(AItem: TMenuItem; ACanvas: TCanvas; ARect: TRect; AState: TOwnerDrawState);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //
    property MenuController: TUMenuAnyWhere read FMenuController write FMenuController;
    property UpdateLocked: Boolean read GetUpdateLocked;
  end;

  TUPopupList = class(TPopupList)
  protected
    procedure WndProc(var Message: TMessage); override;
  end;

//var
//  WmMessageToString: TWmMessageToString;

function GetTimeStamp: String;
begin
  DateTimeToString(Result, {FormatSettings.ShortDateFormat + ' ' + }{$IF CompilerVersion > 29}FormatSettings.{$IFEND}LongTimeFormat + '.zzz', Now);
  Result := Result + ' - ';
end;

function GetWndClassName(Handle: THandle): String;
var
  Buffer: Array[0..MAX_PATH] of Char;
begin
  Windows.GetClassName(Handle, @Buffer, MAX_PATH);
  Result := String(Buffer);
end;

{$REGION 'TUPopupMenu'}
{ TUPopupMenu }

constructor TUPopupMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMenuController := Nil;
  FUpdateCnt := 0;
end;

destructor TUPopupMenu.Destroy;
begin
  FMenuController := Nil;
  inherited;
end;

procedure TUPopupMenu.LockUpdate;
begin
  Inc(FUpdateCnt);
end;

procedure TUPopupMenu.UnlockUpdate;
begin
  Dec(FUpdateCnt);
  if FUpdateCnt < 0 then
    FUpdateCnt := 0;
end;

function TUPopupMenu.GetUpdateLocked: Boolean;
begin
  Result := Boolean(FUpdateCnt > 0);
end;

procedure TUPopupMenu.DoDrawText(AItem: TMenuItem; ACanvas: TCanvas; const ACaption: String; var ARect: TRect; ASelected: Boolean; AFlags: Integer);
var
  Text: String;
  R: TRect;
  ParentMenu: TMenu;
begin
  ParentMenu := AItem.GetParentMenu;
  if (ParentMenu <> Nil) and ParentMenu.IsRightToLeft then begin
    if AFlags and DT_LEFT = DT_LEFT then
      AFlags := AFlags and (not DT_LEFT) or DT_RIGHT
    else if AFlags and DT_RIGHT = DT_RIGHT then
      AFlags := AFlags and (not DT_RIGHT) or DT_LEFT;
    AFlags := AFlags or DT_RTLREADING;
  end;
  Text := ACaption;
  if (AFlags and DT_CALCRECT <> 0) and ((Text = '') or (Text[1] = cHotkeyPrefix) and (Text[2] = #0)) then
    Text := Text + ' ';

  if Text = cLineCaption then begin
    if AFlags and DT_CALCRECT = 0 then begin
      R := ARect;
      Inc(R.Top, 4);
      //DrawEdge(Handle, R, EDGE_ETCHED, BF_TOP);
      ACanvas.MoveTo(R.Left, R.Top);
      ACanvas.LineTo(R.Right, R.Top);
    end;
  end
  else begin
    ACanvas.Brush.Style := bsClear;
    if AItem.Default then
      ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];
    if not AItem.Enabled then begin
//      if not ASelected then begin
//        OffsetRect(ARect, 1, 1);
//        ACanvas.Font.Color := MenuController.MenuItemTextDisabledColor;
//        DrawText(ACanvas.Handle, Text, Length(Text), ARect, AFlags);
//        OffsetRect(ARect, -1, -1);
//      end;
//      if ASelected and (ColorToRGB(clHighlight) = ColorToRGB(clBtnShadow)) then
//        ACanvas.Font.Color := clBtnHighlight
//      else
//        ACanvas.Font.Color := clBtnShadow;
      ACanvas.Font.Color := MenuController.MenuItemTextDisabledColor;
    end;
    DrawText(ACanvas.Handle, Text, Length(Text), ARect, AFlags);
  end;
end;

const
  TriangleSize = 17; // size of the _default_ submenu triangle

function GetMenuItemLevel(MenuItem: TMenuItem): Integer;
begin
  // get level of the menu containing menu item (0 for top item)
  Result := -1;
  while Assigned(MenuItem.Parent) do begin
    Inc(Result);
    MenuItem := MenuItem.Parent;
  end;
end;

procedure TUPopupMenu.MeasureItem(AItem: TMenuItem; ACanvas: TCanvas; var AWidth, AHeight: Integer);
const
  Alignments: array[TPopupAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  ImageList: TCustomImageList;
  DrawGlyph: Boolean;
  DrawStyle: Integer;
  Text: String;
  R: TRect;
begin
  ImageList := AItem.GetImageList;
  if AItem.Caption = cLineCaption then begin
    AHeight := 5;
    AWidth := -2;
    DrawGlyph := False;
  end
  else if Assigned(ImageList) then begin
    AWidth := ImageList.Width;
    AHeight := ImageList.Height;
    DrawGlyph := True;
  end
  else if Assigned(AItem.Bitmap) and not AItem.Bitmap.Empty then begin
    AWidth := 16;
    AHeight := 16;
    DrawGlyph := True;
  end
  else begin
    AWidth := -7;
    DrawGlyph := False;
  end;
  if DrawGlyph then
    Inc(AWidth, 15);
  Inc(AHeight, 8);
  R := Rect(0, 0, 0, 0);
  if AItem.ShortCut <> 0 then
    Text := Concat(AItem.Caption, ShortCutToText(AItem.ShortCut))
  else
    Text := AItem.Caption;
  DrawStyle := Alignments[Alignment] or DT_EXPANDTABS or DT_SINGLELINE or DT_NOCLIP or DT_CALCRECT;
  DoDrawText(AItem, ACanvas, Text, R, False, DrawStyle);
  Inc(AWidth, R.Right - R.Left + 7 + TriangleSize + 20);
end;

function MenuWindowProc(Wnd: HWND; uMsg: Integer; WParam: WPARAM; LParam: LPARAM): LRESULT; stdcall;
var
  OldWndProc: Integer;
//  Canvas: TCanvas;
//  R,
//  WindowRect: TRect;
begin
  if uMsg = WM_ERASEBKGND then begin
    Result := 1;
    Exit;
  end;

  OldWndProc := GetWindowLong(Wnd, GWL_USERDATA);

  if ((uMsg = WM_SHOWWINDOW) and (not Boolean(WParam))) or (uMsg = WM_CLOSE) or (uMsg = WM_DESTROY) then begin
    SetWindowRgn(Wnd, 0, True);
    if OldWndProc <> 0 then begin
      SetWindowLong(Wnd, GWL_WNDPROC, OldWndProc);
      SetWindowLong(Wnd, GWL_USERDATA, 0);
    end;
  end;
  if OldWndProc <> 0 then
    Result := CallWindowProc(Pointer(OldWndProc), Wnd, uMsg, WParam, LParam)
  else
    Result := DefWindowProc(Wnd, uMsg, WParam, LParam);
end;

procedure TUPopupMenu.AdvancedDrawItem(AItem: TMenuItem; ACanvas: TCanvas; ARect: TRect; AState: TOwnerDrawState);
const
  Alignments: array[TPopupAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  EdgeStyle: array[Boolean] of Longint = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
var
  ImageList: TCustomImageList;
  Alignment: TPopupAlignment;
  DrawImage, DrawGlyph: Boolean;
  GlyphRect, SaveRect: TRect;
  DrawStyle: Longint;
  Glyph: Graphics.TBitmap;
  OldBrushColor: TColor;
  Selected: Boolean;
  Text: String;

  procedure Draw(BiDiMode: Boolean);
  begin
    if (odSelected in AState) or (odHotLight in AState) then begin
      ACanvas.Brush.Color := MenuController.MenuItemHoverColor;
      ACanvas.Font.Color := MenuController.MenuItemTextHoverColor;
    end
    else begin
      ACanvas.Brush.Color := MenuController.MenuItemBackColor;
      ACanvas.Font.Color := MenuController.MenuItemTextColor;
    end;
    if not Selected then
      ACanvas.FillRect(ARect);
    if not BiDiMode then
      GlyphRect.Left := ARect.Left + 1
    else
      GlyphRect.Right := ARect.Right - 1;
    GlyphRect.Top := ARect.Top + 1;
    if AItem.Caption = cLineCaption then begin
      ACanvas.Pen.Color := MenuController.MenuItemHoverColor;
      ACanvas.FillRect(ARect);
      if not BiDiMode then begin
        GlyphRect.Left := 0;
        GlyphRect.Right := -4;
      end
      else begin
        GlyphRect.Left := GlyphRect.Right + 2;
        GlyphRect.Right := 0;
      end;
      DrawGlyph := False;
    end
    else begin
      DrawImage := (ImageList <> Nil) and ((AItem.ImageIndex > -1) and (AItem.ImageIndex < ImageList.Count) or AItem.Checked and ((AItem.Bitmap = Nil) or AItem.Bitmap.Empty));
      if DrawImage or Assigned(AItem.Bitmap) and not AItem.Bitmap.Empty then begin
        DrawGlyph := True;

        if DrawImage then begin
          if not BiDiMode then begin
            GlyphRect.Right := GlyphRect.Left + ImageList.Width;
            GlyphRect.Bottom := GlyphRect.Top + ImageList.Height;
          end
          else begin
            GlyphRect.Left := GlyphRect.Right - ImageList.Width;
            GlyphRect.Bottom := GlyphRect.Top + ImageList.Height;
          end;
        end
        else begin
          // Need to add BitmapWidth/Height properties for TMenuItem if we're to support them. Right now let's hardcode them to 16x16.
          if not BiDiMode then begin
            GlyphRect.Right := GlyphRect.Left + 16;
            GlyphRect.Bottom := GlyphRect.Top + 16;
          end
          else begin
            GlyphRect.Left := GlyphRect.Right - 16;
            GlyphRect.Bottom := GlyphRect.Top + 16;
          end;
        end;

        { Draw background pattern brush if selected }
        if AItem.Checked then begin
          if not BiDiMode then
            Inc(GlyphRect.Right)
          else
            Dec(GlyphRect.Left);
          Inc(GlyphRect.Bottom);
          OldBrushColor := ACanvas.Brush.Color;
          if not Selected then begin
            ACanvas.Brush.Bitmap := AllocPatternBitmap(MenuController.MenuItemBackColor, MenuController.MenuItemTextColor);
            ACanvas.FillRect(GlyphRect);
          end
          else begin
            ACanvas.Brush.Color := MenuController.MenuItemHoverColor;
            ACanvas.FillRect(GlyphRect);
          end;
          ACanvas.Brush.Color := OldBrushColor;
          if not BiDiMode then
            Inc(GlyphRect.Left)
          else
            Dec(GlyphRect.Right);
          Inc(GlyphRect.Top);
        end;

        if DrawImage then begin
          if (AItem.ImageIndex > -1) and (AItem.ImageIndex < ImageList.Count) then
            ImageList.Draw(ACanvas, GlyphRect.Left, GlyphRect.Top, AItem.ImageIndex, AItem.Enabled)
          else begin
            { Draw a menu check }
            Glyph := Graphics.TBitmap.Create;
            try
              Glyph.Transparent := True;
              Glyph.Handle := LoadBitmap(0, PChar(OBM_CHECK));
              OldBrushColor := ACanvas.Font.Color;
              ACanvas.Font.Color := MenuController.MenuItemBackColor;
              ACanvas.Draw(GlyphRect.Left + (GlyphRect.Right - GlyphRect.Left - Glyph.Width) div 2 + 1,
                           GlyphRect.Top + (GlyphRect.Bottom - GlyphRect.Top - Glyph.Height) div 2 + 1, Glyph);
              ACanvas.Font.Color := OldBrushColor;
            finally
              Glyph.Free;
            end;
          end;
        end
        else begin
          SaveRect := GlyphRect;
          { Make sure image is within glyph bounds }
          if AItem.Bitmap.Width < GlyphRect.Right - GlyphRect.Left then with GlyphRect do begin
            if not BiDiMode then begin
              Left := Left + ((Right - Left) - AItem.Bitmap.Width) div 2 + 1;
              Right := Left + AItem.Bitmap.Width;
            end
            else begin
              Right := Right - ((Right - Left) - AItem.Bitmap.Width) div 2 + 1;
              Left := Right - AItem.Bitmap.Width;
            end;
          end;
          if AItem.Bitmap.Height < GlyphRect.Bottom - GlyphRect.Top then with GlyphRect do begin
            Top := Top + ((Bottom - Top) - AItem.Bitmap.Height) div 2 + 1;
            Bottom := Top + Aitem.Bitmap.Height;
          end;
          ACanvas.StretchDraw(GlyphRect, AItem.Bitmap);
          GlyphRect := SaveRect;
        end;

        if AItem.Checked then begin
          Dec(GlyphRect.Right);
          Dec(GlyphRect.Bottom);
        end;
      end
      else begin
        if ImageList <> Nil then begin
          if not BiDiMode then begin
            GlyphRect.Right := GlyphRect.Left + ImageList.Width;
            GlyphRect.Bottom := GlyphRect.Top + ImageList.Height;
          end
          else begin
            GlyphRect.Left := GlyphRect.Right - ImageList.Width;
            GlyphRect.Bottom := GlyphRect.Top + ImageList.Height;
          end;
        end
        else begin
          if not BiDiMode then begin
            GlyphRect.Right := GlyphRect.Left;
            GlyphRect.Bottom := GlyphRect.Top;
          end
          else begin
            GlyphRect.Left := GlyphRect.Right;
            GlyphRect.Bottom := GlyphRect.Top;
          end;
        end;
        DrawGlyph := False;
      end;
    end;
    with GlyphRect do begin
      Dec(Left);
      Dec(Top);
      Inc(Right, 2);
      Inc(Bottom, 2);
    end;
{
    if AItem.Checked or Selected and DrawGlyph then begin
  //    DrawEdge(Handle, GlyphRect, EdgeStyle[Checked], BF_RECT);
      ACanvas.MoveTo(GlyphRect.Left, GlyphRect.Top);
      ACanvas.LineTo(GlyphRect.Right, GlyphRect.Top);
      ACanvas.MoveTo(GlyphRect.Left, GlyphRect.Bottom);
      ACanvas.LineTo(GlyphRect.Right, GlyphRect.Bottom);
    end;
}
    if Selected then begin
      if DrawGlyph then
        if not BiDiMode then
          ARect.Left := GlyphRect.Right + 1
        else
          ARect.Right := GlyphRect.Left - 1;
      ACanvas.Brush.Color := MenuController.MenuItemHoverColor;
      ACanvas.FillRect(ARect);
    end;

    if not (Selected and DrawGlyph) then
      if not BiDiMode then
        ARect.Left := GlyphRect.Right + 1
      else
        ARect.Right := GlyphRect.Left - 1;
    Inc(ARect.Left, 2);
    Dec(ARect.Right, 1);

    DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or Alignments[Alignment];
    if odNoAccel in AState then
      DrawStyle := DrawStyle or DT_HIDEPREFIX;
    { Calculate vertical layout }
    SaveRect := ARect;
    if odDefault in AState then
      ACanvas.Font.Style := [fsBold];
    DoDrawText(AItem, ACanvas, AItem.Caption, ARect, Selected, DrawStyle or DT_CALCRECT or DT_NOCLIP);
    { the DT_CALCRECT does not take into account alignment }
    if BiDiMode then begin
      ARect.Left := SaveRect.Left;
      ARect.Right := SaveRect.Right;
    end;
    OffsetRect(ARect, 0, ((SaveRect.Bottom - SaveRect.Top) - (ARect.Bottom - ARect.Top)) div 2);

    DoDrawText(AItem, ACanvas, AItem.Caption, ARect, Selected, DrawStyle);
    if (AItem.ShortCut <> 0) and (AItem.Count = 0) then begin
      Text := ShortCutToText(AItem.ShortCut);
      if not BiDiMode then begin
        ARect.Left := ARect.Right;
        ARect.Right := SaveRect.Right - 10 - TriangleSize;
      end
      else begin
        ARect.Left := 10;
        ARect.Right := ARect.Left + ACanvas.TextWidth(Text);
      end;
      DoDrawText(AItem, ACanvas, Text, ARect, Selected, DT_RIGHT);
    end;
    if AItem.Count > 0 then begin
      //ACanvas.Font.Color := MenuController.MenuItemBackColor;
      if AItem.Enabled then
        ACanvas.Pen.Color := GetTextColorFromBackground(MenuController.MenuItemBackColor)
      else
        ACanvas.Pen.Color := MenuController.MenuItemTextDisabledColor;
      if not BiDiMode then begin
        ARect.Left := SaveRect.Right - 10 - TriangleSize;
        ARect.Right := SaveRect.Right;
      end
      else begin
        ARect.Left := 2;
        ARect.Right := 10;
      end;
      if not BiDiMode then
        DrawArrow(ACanvas, sdRight, Point(ARect.Left, ARect.Top - 3 + (ARect.Bottom - ARect.Top) div 2), 4)
      else
        DrawArrow(ACanvas, sdLeft, Point(ARect.Left, ARect.Top - 3 + (ARect.Bottom - ARect.Top) div 2), 4);
    end;
  end;

  procedure DrawBorder;
  var
    WindowHandle: THandle;
    R, WindowRect: TRect;
    WindowRgnMenu: HRGN;
    Level: Integer;
  begin
    WindowHandle := WindowFromDC(ACanvas.Handle);
    if not IsWindow(WindowHandle) then
      Exit;

    Level := GetMenuItemLevel(AItem);
    if AItem.GetParentMenu is TPopupMenu then
      Inc(Level);

    if (GetWindowLong(WindowHandle, GWL_WNDPROC) <> Integer(@MenuWindowProc)) then begin
      SetWindowLong(WindowHandle, GWL_USERDATA, GetWindowLong(WindowHandle, GWL_WNDPROC));
      SetWindowLong(WindowHandle, GWL_WNDPROC, Integer(@MenuWindowProc));
      //
      GetWindowRect(WindowHandle, WindowRect);
      // Modify window region
      R := Rect(0, 0, RectWidth(WindowRect), RectHeight(WindowRect));
      InflateRect(R, -3, -3);
      // Hide default submenu triangle
      if (AItem.GetParentMenu <> Nil) and (TPopupMenu(AItem.GetParentMenu).BiDiMode = bdLeftToRight) then
        Dec(R.Right, TriangleSize);
//      else
//        Inc(R.Left, TriangleSize);
      WindowRgnMenu := CreateRectRgnIndirect(R);
      SetWindowRgn(WindowHandle, WindowRgnMenu, True);
      // Move menu window
      if Level = 1 then begin
        if (AItem.GetParentMenu <> Nil) and (TPopupMenu(AItem.GetParentMenu).BiDiMode = bdLeftToRight) then
          MoveWindow(WindowHandle, WindowRect.Left - 3, WindowRect.Top - 3, RectWidth(WindowRect), RectHeight(WindowRect), True)
        else
          MoveWindow(WindowHandle, WindowRect.Left + 3, WindowRect.Top - 3, RectWidth(WindowRect), RectHeight(WindowRect), True);
      end
      else if Level >= 2 then begin
        if (AItem.GetParentMenu <> Nil) and (TPopupMenu(AItem.GetParentMenu).BiDiMode = bdLeftToRight) then begin
          Dec(WindowRect.Left, TriangleSize);
          MoveWindow(WindowHandle, WindowRect.Left - 3, WindowRect.Top, RectWidth(WindowRect), RectHeight(WindowRect), True);
        end
        else begin
          //Dec(WindowRect.Left, TriangleSize);
          MoveWindow(WindowHandle, WindowRect.Left + 3, WindowRect.Top, RectWidth(WindowRect), RectHeight(WindowRect), True);
        end;
      end;
    end;
    //
//    ACanvas.Font := Screen.MenuFont;
    ACanvas.Brush.Style := bsSolid;
    ACanvas.Brush.Color := MenuController.MenuBackColor;
    //ACanvas.Brush.Color := clRed;
//    ACanvas.Pen.Style := psSolid;
//    ACanvas.Pen.Width := 1;
//    ACanvas.Pen.Color := MenuController.MenuBorderColor;
    //
    GetWindowRect(WindowHandle, WindowRect);
    R := Rect(0, 0, RectWidth(WindowRect) - 6, RectHeight(WindowRect) - 6);
    //InflateRect(R, -1, -1);
    Dec(R.Right, TriangleSize);
    if Level >= 2 then
      Dec(R.Right, TriangleSize);
    //ACanvas.FillRect(Rect(0, 0, R.Width, R.Height));
    //ACanvas.Rectangle(R);
    ACanvas.FrameRect(R);
//    ACanvas.Pen.Color := MenuController.MenuBackColor;
//    InflateRect(R, -1, -1);
//    ACanvas.FrameRect(R);
//    InflateRect(R, -1, -1);
//    ACanvas.FrameRect(R);
  end;

var
  ParentMenu: TMenu;
begin
  ParentMenu := AItem.GetParentMenu;
  ImageList := AItem.GetImageList;
  Selected := odSelected in AState;
  ACanvas.Brush.Style := bsSolid;
  if ParentMenu is TMenu then
    Alignment := paLeft
  else if ParentMenu is TPopupMenu then
    Alignment := TPopupMenu(ParentMenu).Alignment
  else
    Alignment := paLeft;

  if (ParentMenu <> Nil) and ParentMenu.IsRightToLeft then begin
    if Alignment = paLeft then
      Alignment := paRight;
  end;

  Draw((ParentMenu <> Nil) and ParentMenu.IsRightToLeft);
  DrawBorder;
end;
{$ENDREGION}
{$REGION 'TUPopupList'}
{ TUPopupList }

procedure TUPopupList.WndProc(var Message: TMessage);

  procedure DefaultProc;
  begin
    with Message do
      Result := DefWindowProc(Window, Msg, wParam, lParam);
  end;

  function FindParentMenu(AHandle: Integer; AFindKind: TFindItemKind; var Item: TMenuItem): TPopupMenu;
  var
    i: Integer;
  begin
    Result := Nil;
    for i := 0 to Self.Count - 1 do begin
      Item := TPopupMenu(Items[i]).FindItem(AHandle, AFindKind); // fkHandle);
      if Item <> Nil then begin
        Result := TPopupMenu(Items[I]);
        Exit;
      end;
    end;
    Item := Nil;
  end;

type
  TEnumInfo = record
    ProcessID: DWORD;
    Handle: HWND;
    Menu: HMENU;
  end;

  function EnumWindowsProc(Wnd: HWND; var EI: TEnumInfo): Bool; stdcall;
  const
    MN_GETHMENU = $01E1;
  var
    PID: DWORD;
    className: String;
    menu: HMENU;
  begin
    GetWindowThreadProcessID(Wnd, @PID);
    className := GetWndClassName(Wnd);
    Result := (PID = EI.ProcessID) and IsWindow(Wnd) and (className = '#32768');
    if Result then begin
      menu := HMENU(SendMessage(Wnd, MN_GETHMENU, 0, 0));
      Result := (menu <> 0) and (menu = EI.Menu);
    end;
    Result := not Result;
    if not Result then
      EI.Handle:=Wnd; //break on return FALSE
  end;

  function FindMenuWindow(PID: DWORD; Menu: HMENU): HWND;
  var
    EI: TEnumInfo;
  begin
    EI.ProcessID:=PID;
    EI.Handle:=0;
    EI.Menu := Menu;
    Windows.EnumWindows(@EnumWindowsProc, Integer(@EI));
    Result:=EI.Handle;
  end;

var
  I, Item: Integer;
  MenuItem: TMenuItem;
  FindKind: TFindItemKind;
  ContextID: Integer;
  Canvas: TCanvas;
  SaveIndex: Integer;
  DC: HDC;
  LWidth, LHeight: Integer;
  MenuController: TUMenuAnyWhere;
  WMInitMenuPopup: TWMInitMenuPopup;
  DrawItemStruct: TDrawItemStruct;
  Menu: TPopupMenu;
//  MenuWindow: HWND;
begin
//  if (WmMessageToString <> Nil) and (Message.Msg <> WM_ENTERIDLE) then
//    OutputDebugString(PChar(GetTimeStamp + 'TUPopupList.WndProc: ' + WmMessageToString.MsgToString(Message)));
  case Message.Msg of
    WM_COMMAND: begin
      for I := 0 to Count - 1 do
        if TPopupMenu(Items[I]).DispatchCommand(Message.wParam) then
          Exit;
    end;
    WM_INITMENUPOPUP: begin
//      DefaultProc;
      WMInitMenuPopup:=TWMInitMenuPopup(Message);
//      Menu := FindParentMenu(WMInitMenuPopup.MenuPopup, MenuItem);
//      if (Menu <> Nil) and (Menu is TUPopupMenu) then begin
//        if MenuItem.GetParentMenu = Nil then
//          TUPopupMenu(Menu).LockUpdate
//        else begin // send repaint child window message
//          MenuWindow := FindMenuWindow(GetCurrentProcessId, WMInitMenuPopup.MenuPopup);
//          if MenuWindow <> 0 then
////            SendMessage(MenuWindow, )
//            SetWindowPos(MenuWindow, 0, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOZORDER or SWP_FRAMECHANGED);
//        end;
//      end;
      for I := 0 to Self.Count - 1 do
        if TPopupMenu(Items[I]).DispatchPopup(WMInitMenuPopup.MenuPopup) then
            Exit;
//      Exit;
    end;
    WM_MENUSELECT: begin
      MenuItem := Nil;
      with TWMMenuSelect(Message) do begin
        FindKind := fkCommand;
        if MenuFlag and MF_POPUP <> 0 then
          FindKind := fkHandle;
        for I := 0 to Count - 1 do begin
          if FindKind = fkHandle then begin
            if Menu <> 0 then
              Item := GetSubMenu(Menu, IDItem)
            else
              Item := -1;
          end
          else
            Item := IDItem;
          MenuItem := TPopupMenu(Items[I]).FindItem(Item, FindKind);
          if MenuItem <> Nil then
            Application.Hint := GetLongHint(MenuItem.Hint)
        end;
        if MenuItem = Nil then
          Application.Hint := '';
      end;
    end;
    WM_HELP: begin
      with PHelpInfo(Message.LParam)^ do begin
        for I := 0 to Count - 1 do begin
          if HMENU(hItemHandle) = TMenu(Items[I]).Handle then
            MenuItem := TMenu(Items[I]).Items
          else
            MenuItem := TPopupMenu(Items[I]).FindItem(hItemHandle, fkHandle);
          if MenuItem <> Nil then begin
            ContextID := TMenu(Items[I]).GetHelpContext(iCtrlID, True);
            if ContextID = 0 then
              ContextID := TMenu(Items[I]).GetHelpContext(hItemHandle, False);
            if Screen.ActiveForm = Nil then
              Exit;
            if (ContextID = 0) then
              ContextID := Screen.ActiveForm.HelpContext;
            if (biHelp in Screen.ActiveForm.BorderIcons) then
              Application.HelpCommand(HELP_CONTEXTPOPUP, ContextID)
            else
              Application.HelpContext(ContextID);
            Exit;
          end;
        end;
      end;
    end;
    WM_NCPAINT: begin
//      OutputDebugString(PChar(GetTimeStamp + 'TUPopupList.WndProc - WM_NCPAINT'));
    end;
    WM_MEASUREITEM: begin
      with PMeasureItemStruct(Message.LParam)^ do begin
        for I := 0 to Count - 1 do begin
          MenuItem := TPopupMenu(Items[I]).FindItem(itemID, fkCommand);
          if (MenuItem <> Nil) and (MenuItem.GetParentMenu <> Nil) and (MenuItem.GetParentMenu is TUPopupMenu) then begin
            MenuController := TUPopupMenu(MenuItem.GetParentMenu).MenuController;
            DC := GetWindowDC(Window);
            try
              Canvas := TControlCanvas.Create;
              try
                SaveIndex := SaveDC(DC);
                try
                  Canvas.Handle := DC;
                  Canvas.Font := MenuController.Font;
                  LWidth := itemWidth;
                  LHeight := itemHeight;
                  TUPopupMenu(MenuItem.GetParentMenu).MeasureItem(MenuItem, Canvas, LWidth, LHeight);
                  itemWidth := LWidth;
                  itemHeight := LHeight;
                finally
                  Canvas.Handle := 0;
                  RestoreDC(DC, SaveIndex);
                end;
              finally
                Canvas.Free;
              end;
            finally
              ReleaseDC(Window, DC);
            end;
            Exit;
          end;
        end;
      end;
    end;
    WM_DRAWITEM: begin
      DrawItemStruct := PDrawItemStruct(Message.LParam)^;
//        if not IsWindow(Msg.hwnd) then
//          Exit;
//        if Msg.hwnd = MenuController.Control.Handle then // do not paint on menu parent
//          Exit;
//        //
//        GetWindowRect(Msg.hwnd, R);
//        DC := GetWindowDC(Msg.hwnd);
//        try
//          Canvas := TControlCanvas.Create;
//          try
//            SaveIndex := SaveDC(DC);
//            try
//              Canvas.Handle := DC;
//              Canvas.Font := Screen.MenuFont;
//              Canvas.Brush.Style := bsSolid;
//              Canvas.Brush.Color := MenuController.MenuBackColor;
//              Canvas.Pen.Style := psSolid;
//              Canvas.Pen.Width := 1;
//              Canvas.Pen.Color := MenuController.MenuBorderColor;
//              //Canvas.FillRect(Rect(0, 0, R.Width, R.Height));
//              Canvas.Rectangle(Rect(0, 0, R.Width, R.Height));
//            finally
//              Canvas.Handle := 0;
//              RestoreDC(DC, SaveIndex);
//            end;
//          finally
//            Canvas.Free;
//          end;
//        finally
//          ReleaseDC(Msg.hwnd, DC);
//        end;

//      with DrawItemStruct do begin
        //for I := 0 to Count - 1 do begin
          //MenuItem := TPopupMenu(Items[I]).FindItem(itemID, fkCommand);
          Menu := FindParentMenu(DrawItemStruct.itemID, fkCommand, MenuItem);
          if (Menu <> Nil) and (MenuItem <> Nil) and (Menu is TUPopupMenu){ (MenuItem.GetParentMenu <> Nil) and (MenuItem.GetParentMenu is TUPopupMenu)} then begin
            //MenuController := TUPopupMenu(MenuItem.GetParentMenu).MenuController;
            MenuController := TUPopupMenu(Menu).MenuController;
            Canvas := TCanvas.Create;
            try
              SaveIndex := SaveDC(DrawItemStruct.hDC);
              try
                Canvas.Handle := DrawItemStruct.hDC;
                Canvas.Font := MenuController.Font;
                TUPopupMenu(Menu).AdvancedDrawItem(MenuItem, Canvas, DrawItemStruct.rcItem, TOwnerDrawState(LoWord(DrawItemStruct.itemState)));
              finally
                Canvas.Handle := 0;
                RestoreDC(DrawItemStruct.hDC, SaveIndex);
              end;
            finally
              Canvas.Free;
            end;
            Exit;
          end;
        //end;
//      end;
    end;
    WM_MENUCHAR: begin
      for I := 0 to Count - 1 do
        with TPopupMenu(Items[I]) do
          if (Handle = HMENU(Message.LParam)) or (FindItem(Message.LParam, fkHandle) <> Nil) then begin
            ProcessMenuChar(TWMMenuChar(Message));
            Exit;
          end;
    end;
  end;
  DefaultProc;
end;
{$ENDREGION}
{$REGION 'TUMenuButtonActionLink'}
{ TUMenuButtonActionLink }

procedure TUMenuButtonActionLink.AssignClient(AClient: TObject);
begin
  inherited AssignClient(AClient);
  FClient := AClient as TUMenuButton;
end;

function TUMenuButtonActionLink.IsCheckedLinked: Boolean;
begin
  Result := False;
end;

function TUMenuButtonActionLink.IsDropdownMenuLinked: Boolean;
begin
  Result := True;
end;

function TUMenuButtonActionLink.IsEnableDropdownLinked: Boolean;
begin
  Result := False;
end;

function TUMenuButtonActionLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and (FClient.ImageIndex = TCustomAction(Action).ImageIndex);
end;

procedure TUMenuButtonActionLink.SetChecked(Value: Boolean);
begin
  FClient.Down := Value;
end;

procedure TUMenuButtonActionLink.SetDropdownMenu(Value: TPopupMenu);
begin
// nothing here
end;

procedure TUMenuButtonActionLink.SetEnableDropdown(Value: Boolean);
begin
// nothing here
end;

procedure TUMenuButtonActionLink.SetImageIndex(Value: Integer);
begin
  if IsImageIndexLinked then
    FClient.ImageIndex := Value;
end;
{$ENDREGION}
{$REGION 'TUMenuButton'}
{ TUMenuButton }

constructor TUMenuButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csCaptureMouse, csSetCaption, csClickEvents];
  Width := 32;
  Height := 21;
  FImageIndex := -1;
end;

procedure TUMenuButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then begin
    with TCustomAction(Sender) do begin
      if not CheckDefaults or (Self.ImageIndex = -1) then
        Self.ImageIndex := ImageIndex;
    end;
  end;
  if Sender is TControlAction then begin
    with TControlAction(Sender) do begin
      if not CheckDefaults or (Self.PopupMenu = nil) then
        Self.PopupMenu := PopupMenu;
    end;
  end;
end;

procedure TUMenuButton.AssignTo(Dest: TPersistent);
begin
  inherited AssignTo(Dest);
  if Dest is TCustomAction then begin
    with TCustomAction(Dest) do begin
      ImageIndex := Self.ImageIndex;
    end;
  end;
end;

procedure TUMenuButton.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TUMenuButton.EndUpdate;
begin
  Dec(FUpdateCount);
end;

function TUMenuButton.CheckMenuDropdown: Boolean;
begin
  Result := not (csDesigning in ComponentState) and (MenuItem <> Nil) and (FMenuController <> Nil) and FMenuController.CheckMenuDropdown(Self);
end;

function TUMenuButton.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TUMenuButtonActionLink;
end;

procedure TUMenuButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and Enabled then
    Down := not Down;
  inherited MouseDown(Button, Shift, X, Y);
//  if Down then
//    CheckMenuDropdown;
end;

procedure TUMenuButton.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  if MouseCapture then
    Down := (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight);
end;

procedure TUMenuButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if (Button = mbLeft) and (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight) then
    Down := False;
end;

procedure TUMenuButton.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then begin
    if AComponent = MenuItem then
      MenuItem := Nil;
  end;
end;

procedure TUMenuButton.Paint;
const
  XorColor = $00FFD8CE;
  usePrefix: Array[Boolean] of Cardinal = (DT_HIDEPREFIX or DT_NOPREFIX, 0);
var
  R: TRect;
begin
  if FMenuController = Nil then
    Exit;
  //
  if csDesigning in ComponentState then begin
    Canvas.Brush.Style := bsClear;
    Canvas.Brush.Color := XorColor;
    Canvas.Pen.Mode := pmXor;
    Canvas.Pen.Style := psClear;
    Canvas.Pen.Color := XorColor;
    Canvas.Pen.Width := 1;
    Canvas.FillRect(ClientRect);
    Canvas.Font.Color := FMenuController.ButtonTextColor;
  end
  else if MouseInClient or Down or (FMenuController.MenuAnchorHighLight and (FMenuController.HotItem = Index)) then begin
    Canvas.Pen.Mode := pmCopy;
    Canvas.Pen.Style := psSolid;
    Canvas.Pen.Color := XorColor;
    Canvas.Pen.Width := 1;
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := FMenuController.ButtonBackHoverColor;
    if not Enabled then
      Canvas.Brush.Color := FMenuController.ButtonBackDisabledColor;
    Canvas.FillRect(ClientRect);
    Canvas.Font.Color := FMenuController.ButtonTextHoverColor;
  end
  else begin
    Canvas.Pen.Mode := pmCopy;
    Canvas.Pen.Style := psSolid;
    Canvas.Pen.Color := FMenuController.ButtonBackHoverColor;
    if not Enabled then
      Canvas.Brush.Color := FMenuController.ButtonBackDisabledColor;
    Canvas.Pen.Width := 2;
    Canvas.Brush.Style := bsClear;
    Canvas.MoveTo(4, Height - 4);
    Canvas.LineTo(Width - 5, Height - 4);
    Canvas.Font.Color := FMenuController.ButtonTextColor;
  end;
  Canvas.Brush.Style := bsClear;
  if not Enabled then
    Canvas.Font.Color := FMenuController.ButtonTextDisabledColor;

  Caption := MenuItem.Caption;
  if not FMenuController.MenuAnchorHighLight then
    Caption := StripHotkey(Caption);

  R := Rect(8, 0, Width - 8, Height);
  DrawText(Canvas.Handle, Caption, Length(Caption), R, UsePrefix[FMenuController.MenuAnchorHighLight] or DT_NOCLIP or DT_VCENTER or DT_LEFT or DT_SINGLELINE);
end;

procedure TUMenuButton.Click;
begin
  inherited Click;
end;

function TUMenuButton.GetIndex: Integer;
begin
  Result := -1;
  if FMenuController <> Nil then
    Result := FMenuController.FButtons.IndexOf(Self);
end;

procedure TUMenuButton.SetDown(Value: Boolean);
begin
  if FDown <> Value then begin
    FDown := Value;
    Invalidate;
  end;
end;

procedure TUMenuButton.SetImageIndex(Value: UITypes.TImageIndex);
begin
  if FImageIndex <> Value then begin
    FImageIndex := Value;
    if FMenuController <> Nil then
      Invalidate;
  end;
end;

procedure TUMenuButton.SetMenuItem(Value: TMenuItem);
begin
  // Copy all appropriate values from menu item
  if Value <> Nil then begin
    if FMenuItem <> Value then
      Value.FreeNotification(Self);
    Action := Value.Action;
    Caption := Value.Caption;
    Down := Value.Checked;
    Enabled := Value.Enabled;
    Hint := Value.Hint;
    ImageIndex := Value.ImageIndex;
    Visible := Value.Visible;
  end;
  FMenuItem := Value;
end;

procedure TUMenuButton.SetParent(AParent: TWinControl);
begin
  if AParent = Nil then ;
  inherited SetParent(AParent);
end;

procedure TUMenuButton.CMHitTest(var Message: TCMHitTest);
begin
  Message.Result := Ord(not (DragKind = dkDock));
end;

procedure TUMenuButton.CMMouseEnter(var Message: TMessage);
begin
  FMouseInClient := True;
  inherited;
  Invalidate;
end;

procedure TUMenuButton.CMMouseLeave(var Message: TMessage);
begin
  FMouseInClient := False;
  inherited;
  Invalidate;
end;
{$ENDREGION}
{$REGION 'TUMenuAnyWhere'}
{ TUMenuAnyWhere }

constructor TUMenuAnyWhere.Create; // (AOwner: TComponent);
begin
//  SetSubComponent(True);
  inherited Create; // (AOwner);
//  Name := {FControl.Name +} 'UMenuAnyWhere';
  FEnabled := True;
  FButtons := TList.Create;
  FButtonWidth := 0;
  FButtonHeight := 0;
  FButtonSizeAutoCalc := True;
  FMenuTriggerMode := mtmUnknown;
  FInMenuLoop := False;
  FCaptureChangeCancels := False;
  FControlWndProcHooked := False;
  FMenuDropped := False;
  FHotItem := -1;
  FUpdating := False;

  FButtonBackColors := TUThemeControlStateHoveredDisabledColors.Create;
  FButtonBackColors.SetColors(utLight, $F2F2F2, $D77800, clGray); // $F2F2F2, $D77800
  FButtonBackColors.SetColors(utDark, $2B2B2B, $174800, clGray); // $2B2B2B, $174800

  FButtonTextColors := TUThemeControlStateHoveredDisabledColors.Create;
  FButtonTextColors.SetColors(utLight, clBlack, clWhite, clGray);
  FButtonTextColors.SetColors(utDark, clWhite, clWhite, clGray);

  FMenuBorderColors := TUThemeControlColorSet.Create;
  FMenuBorderColors.SetColors(clDefault, clBlack, clSilver);

  FMenuBackColors := TUThemeControlStateHoveredDisabledColors.Create;
  FMenuBackColors.SetColors(utLight, clWhite, clHighlight, clGray);
  FMenuBackColors.SetColors(utDark, clBlack, clHighlight, clGray);

  FMenuTextColors := TUThemeControlStateHoveredDisabledColors.Create;
  FMenuTextColors.SetColors(utLight, clBlack, clBlack, clGray);
  FMenuTextColors.SetColors(utDark, clWhite, clWhite, clGray);

  FButtonBackColors.OnChange := ColorsChange;
  FButtonTextColors.OnChange := ColorsChange;
  FMenuBorderColors.OnChange := ColorsChange;
  FMenuBackColors.OnChange   := ColorsChange;
  FMenuTextColors.OnChange   := ColorsChange;

  FFont := TFont.Create;
  FFont.Assign(Screen.MenuFont);
  //FFont.Name := 'Segoe UI';
  //FFont.Size := 12;
  FFont.OnChange := FontChanged;

  UpdateColors;

  FGlobalHook := 0;
  HookGlobalWndProc;
end;

destructor TUMenuAnyWhere.Destroy;
begin
  DestroyButtons;
  FButtons.Free;
  FButtonBackColors.Free;
  FButtonTextColors.Free;
  FMenuBorderColors.Free;
  FMenuBackColors.Free;
  FMenuTextColors.Free;
  FFont.Free;
  UnHookGlobalWndProc;
  inherited;
end;

procedure TUMenuAnyWhere.SetControl(Value: TWinControl);
begin
  if FControl = Value then
    Exit;
  //
  if Assigned(FControl) then begin
    UnHookWndProc;
    //FControl.RemoveFreeNotification(Self);
  end;
  FControl := Value;
  if Value = Nil then
    Exit;
  //
  //FControl.FreeNotification(Self);
//  Name := {FControl.Name +} 'UMenuAnyWhere';
  HookWndProc;
end;

procedure TUMenuAnyWhere.SetMenu(Value: TMainMenu);
begin
  if FMenu = Value then
    Exit;
  if (FControl = Nil) or not (csAcceptsControls in FControl.ControlStyle) then
    raise EUMenuAnyWhere.Create('Control not set or does not accept other controls as child controls!');
  //
  if not (csDesigning in FControl.ComponentState) then begin
//    OutputDebugString(PChar(GetTimeStamp + 'SetMenu (RecreateWnd)'));
    FControl.ControlStyle := FControl.ControlStyle + [csCaptureMouse, csClickEvents, csDoubleClicks, csMenuEvents{, csSetCaption}, csGestures];
    TWinControlAccess(FControl).RecreateWnd;
  end;
  if Assigned(FMenu) then begin
    DestroyButtons;
    FMenu.OnChange := Nil;
    //FMenu.RemoveFreeNotification(Self);
  end;
  FMenu := Value;
  if not Assigned(FMenu) then
    Exit;
  //
  //FMenu.FreeNotification(Self);
  //
  CreateButtons;
  RecreateButtons;
  FMenu.OnChange := MenuChanged;
end;

procedure TUMenuAnyWhere.SetButtonSize(Index, Value: Integer);
var
  oldButtonWidth, oldButtonHeight: Integer;
begin
  if FButtonSizeAutoCalc then
    Exit;

  oldButtonWidth := FButtonWidth;
  oldButtonHeight := FButtonHeight;
  case Index of
    0: FButtonWidth := Value;
    1: FButtonHeight := Value;
  end;
  if (oldButtonWidth <> FButtonWidth) or (oldButtonHeight <> FButtonHeight) then
    RecreateButtons;
end;

procedure TUMenuAnyWhere.SetButtonSizeAutoCalc(Value: Boolean);
begin
  if FButtonSizeAutoCalc <> Value then begin
    FButtonSizeAutoCalc := Value;
    if FButtonSizeAutoCalc then
      GetButtonSize(FButtonWidth, FButtonHeight);
    RecreateButtons;
  end;
end;

procedure TUMenuAnyWhere.SetPos(Index, Value: Integer);
var
  oldPos: TPoint;
begin
  oldPos := FPos;
  case Index of
    0: FPos.X := Value;
    1: FPos.Y := Value;
  end;
  if (oldPos.X <> FPos.X) or (oldPos.Y <> FPos.Y) then
    RecreateButtons;
end;
{
procedure TUMenuAnyWhere.SetBackColor(Value: TColor);
begin

end;
}
procedure TUMenuAnyWhere.SetButtonBackColors(Value: TUThemeControlStateHoveredDisabledColors);
begin
  FButtonBackColors.Assign(Value);
end;

procedure TUMenuAnyWhere.SetButtonTextColors(Value: TUThemeControlStateHoveredDisabledColors);
begin
  FButtonTextColors.Assign(Value);
end;

procedure TUMenuAnyWhere.SetMenuBorderColors(Value: TUThemeControlColorSet);
begin
  FMenuBorderColors.Assign(Value);
end;

procedure TUMenuAnyWhere.SetMenuBackColors(Value: TUThemeControlStateHoveredDisabledColors);
begin
  FMenuBackColors.Assign(Value);
end;

procedure TUMenuAnyWhere.SetMenuTextColors(Value: TUThemeControlStateHoveredDisabledColors);
begin
  FMenuTextColors.Assign(Value);
end;

procedure TUMenuAnyWhere.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then begin
    FEnabled := Value;
    ColorsChange(Nil);
  end;
end;

procedure TUMenuAnyWhere.SetTransparent(Value: Boolean);
begin
  if FTransparent <> Value then begin
    FTransparent := Value;
    ColorsChange(Nil);
  end;
end;

procedure TUMenuAnyWhere.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

function FindButton(Controller: TUMenuAnyWhere; MenuButtonIndex: Integer; AForward: Boolean): TUMenuButton;
var
  I, J, Count: Integer;
begin
  if Controller <> Nil then begin
    J := MenuButtonIndex;
    I := J;
    Count := Controller.ButtonCount;
    if AForward then begin
      repeat
        if I = Count - 1 then
          I := 0
        else
          Inc(I);
        Result := Controller.Buttons[I];
        if Result.Visible and Result.Enabled then
          Exit;
      until I = J;
    end
    else begin
      repeat
        if I = 0 then
          I := Count - 1
        else
          Dec(I);
        Result := Controller.Buttons[I];
        if Result.Visible and Result.Enabled then
          Exit;
      until I = J;
    end;
  end;
  Result := Nil;
end;

function KeyCodeToString(KeyCode: Integer): String;
begin
  SetLength(Result, 128);
  SetLength(Result, GetKeynameText(KeyCode, @Result[1], Length(Result)));
end;

var
  MenuHook: HHOOK;
  MenuController, MenuController2: TUMenuAnyWhere;
  MenuButtonIndex: Integer;
  LastMenuItem: TMenuItem;
  LastMousePos: TPoint;
  StillModal: Boolean;
  InitDone: Boolean = False;

function MenuGetMsgHook(Code: Integer; WParam: Longint; var Msg: TMsg): Longint; stdcall;

  procedure OpenMenu(AMenuButton: TControl);
  var
    Button: TUMenuButton;
  begin
    if (AMenuButton <> Nil) and (AMenuButton is TUMenuButton) then begin
      Button := TUMenuButton(AMenuButton);
      if (Button.Index <> MenuButtonIndex) and (Button.Parent <> Nil) and Button.Parent.HandleAllocated then begin
//        OutputDebugString(PChar(GetTimeStamp + 'MenuGetMsgHook - OpenMenu'));
        StillModal := True;
        MenuController.FCaptureChangeCancels := False;
        MenuController.ClickButton(Button, True); // postmessage
        // StillModal := False;
      end;
    end;
  end;

const
  RightArrowKey: array[Boolean] of Word = (VK_LEFT, VK_RIGHT);
  LeftArrowKey: array[Boolean] of Word = (VK_RIGHT, VK_LEFT);
var
  P: TPoint;
//  R: TRect;
  Target: TControl;
  Item: Integer;
  FindKind: TFindItemKind;
  ParentMenu: TMenu;
  closeMenu: Boolean;
//  Canvas: TCanvas;
//  SaveIndex: Integer;
//  DC: HDC;
begin
  if LastMenuItem <> Nil then begin
    ParentMenu := LastMenuItem.GetParentMenu;
    if ParentMenu <> Nil then begin
      if ParentMenu.IsRightToLeft then begin
        if Msg.WParam = VK_LEFT then
          Msg.WParam := VK_RIGHT
        else if Msg.WParam = VK_RIGHT then
          Msg.WParam := VK_LEFT;
      end;
    end;
  end;
  Result := CallNextHookEx(MenuHook, Code, WParam, LPARAM(@Msg));
  if Result <> 0 then
    Exit;
  if (Code = MSGF_MENU) then begin
//    if (WmMessageToString <> Nil) and (Msg.Message <> WM_MOUSEFIRST) then
//      OutputDebugString(PChar(GetTimeStamp + 'MenuGetMsgHook: ' + WmMessageToString.MsgToString(Msg) + '; CallNextHookEx.WParam: ' + IntToHex(WParam, 8) + '; CallNextHookEx.Msg.hwnd: ' + IntToHex(Msg.hwnd, 8)));
    //
    Target := Nil;
    if not InitDone then begin
      InitDone := True;
      //if MenuController.FInMenuLoop or (MenuController.FMenuTriggerMode = mtmKeyboard) then begin
      if MenuController.FInMenuLoop then begin
//        OutputDebugString(PChar(GetTimeStamp + 'MenuGetMsgHook - InitDone 1 (FInMenuLoop: ' + BoolToStr(MenuController.FInMenuLoop, True) + ' / FMenuTriggerMode: ' + IntToStr(Ord(MenuController.FMenuTriggerMode)) + ')'));
        PostMessage(Msg.Hwnd, WM_KEYDOWN, VK_DOWN, 0);
      end;
    end;
    case Msg.Message of
      WM_MENUSELECT: begin
        closeMenu := (HiWord(Msg.WParam) = $FFFF) and (Msg.LParam = 0);
//        OutputDebugString(PChar(GetTimeStamp + 'MenuGetMsgHook - WM_MENUSELECT (CloseMenu: ' + BoolToStr(closeMenu, True) + ', StillModal: ' + BoolToStr(StillModal, True) + ')'));
        if closeMenu and not StillModal then begin
          MenuController.CancelMenu;
          Exit;
        end;
//        else
//          StillModal := False;
        FindKind := fkCommand;
        if HiWord(Msg.WParam) and MF_POPUP <> 0 then
          FindKind := fkHandle;
        if FindKind = fkHandle then
          Item := GetSubMenu(Msg.LParam, LoWord(Msg.WParam))
        else
          Item := LoWord(Msg.WParam);
        LastMenuItem := MenuController.FTempMenu.FindItem(Item, FindKind);
//        OutputDebugString(PChar(GetTimeStamp + 'MenuGetMsgHook - WM_MENUSELECT (LastMenuItem: ' + IfThen(LastMenuItem <> Nil, LastMenuItem.Name, 'NULL') + ')'));
      end;
      WM_SYSKEYDOWN: begin
//        OutputDebugString(PChar(GetTimeStamp + 'MenuGetMsgHook - WM_SYSKEYDOWN'));
        if Msg.WParam = VK_MENU then begin
          MenuController.CancelMenu;
          Exit;
        end;
      end;
      WM_KEYDOWN: begin
//        OutputDebugString(PChar(GetTimeStamp + 'MenuGetMsgHook - WM_KEYDOWN (Key: ''' + KeyCodeToString(Msg.lParam) + ''' / KeyCode: ' + IntToStr(Msg.wParam) + ')'));
        if Msg.WParam = VK_RETURN then
          MenuController.FMenuResult := True
        else if Msg.WParam = VK_ESCAPE then
          StillModal := True
        else begin
          if LastMenuItem <> Nil then begin
            if (Msg.WParam = VK_RIGHT) and (LastMenuItem.Count = 0) then
              Target := FindButton(MenuController, MenuButtonIndex, True)
            else begin
              if (Msg.WParam = VK_LEFT) and (LastMenuItem.GetParentComponent is TPopupMenu) then
                Target := FindButton(MenuController, MenuButtonIndex, False)
              else
                Target := Nil;
            end;
//            if Target <> Nil then
//              P := Target.ClientToScreen(Point(0, 0));
//            if Target <> Nil then
//              OutputDebugString(PChar(GetTimeStamp + 'MenuGetMsgHook - WM_KEYDOWN (Target)'));
            OpenMenu(Target);
          end
          else if MenuController.FMenuTriggerMode <> mtmKeyboard then begin
            //MenuController.FMenuTriggerMode := mtmKeyboard;
//            OutputDebugString(PChar(GetTimeStamp + 'MenuGetMsgHook - InitDone 2 (FInMenuLoop: ' + BoolToStr(MenuController.FInMenuLoop, True) + ' / FMenuTriggerMode: ' + IntToStr(Ord(MenuController.FMenuTriggerMode)) + ')'));
//            if (Msg.WParam = VK_LEFT) or (Msg.WParam = VK_RIGHT) then
//              PostMessage(Msg.Hwnd, WM_KEYDOWN, VK_DOWN, 0);
          end;
//            MenuController.SetMenuAnchorHighLight(True);
//            if MenuController.FMenuDropped and (MenuController.FButtonMenu <> Nil) and (MenuController.FTempMenu <> Nil) then begin
//              ParentMenu := MenuController.FButtonMenu.GetParentMenu;
//              if ParentMenu <> Nil then begin
//                ParentMenu.Items.RethinkHotkeys;
//                //TMenuAccess(ParentMenu).UpdateItems;
//                if TMenuAccess(ParentMenu).WindowHandle <> 0 then
//                  RedrawWindow(TMenuAccess(ParentMenu).WindowHandle, Nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_ALLCHILDREN);
//              end;
//              MenuController.FTempMenu.AutoHotkeys := maAutomatic;
//              MenuController.FTempMenu.Items.RethinkHotkeys;
//              //TMenuAccess(MenuController.FTempMenu).UpdateItems;
//              if TMenuAccess(MenuController.FTempMenu).WindowHandle <> 0 then
//                RedrawWindow(TMenuAccess(MenuController.FTempMenu).WindowHandle, Nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_ALLCHILDREN);
//            end;
//          end;
        end;
      end;
      WM_MOUSEMOVE: begin
        P := Msg.pt;
        if (P.X <> LastMousePos.X) or (P.Y <> LastMousePos.Y) then begin
          LastMousePos := P;
          Target := FindDragTarget(P, False);
//          if (Target <> Nil) and (Target is TUMenuButton) then
//            OutputDebugString(PChar(GetTimeStamp + 'MenuGetMsgHook - WM_MOUSEMOVE (Target: MenuButton = ' + TUMenuButton(Target).Caption + ')'));
          OpenMenu(Target);
        end;
      end;
    end;
  end;
end;

procedure InitMenuHooks;
begin
  if MenuHook = 0 then begin
//    OutputDebugString(PChar(GetTimeStamp + 'InitMenuHooks'));
//    StillModal := False;
    GetCursorPos(LastMousePos);
    MenuHook := SetWindowsHookEx(WH_MSGFILTER, @MenuGetMsgHook, 0, GetCurrentThreadID);
  end;
end;

procedure ReleaseMenuHooks;
begin
//  OutputDebugString(PChar(GetTimeStamp + 'ReleaseMenuHooks'));
  if MenuHook <> 0 then
    UnhookWindowsHookEx(MenuHook);
  MenuHook := 0;
  LastMenuItem := Nil;
  MenuController := Nil;
  MenuButtonIndex := -1;
  InitDone := False;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var
  MenuKeyHook: HHOOK;

procedure ReleaseMenuKeyHooks; forward;

function MenuKeyMsgHook(Code: Integer; WParam: Longint; var Msg: TMsg): Longint; stdcall;
begin
  if (Code = HC_ACTION) then begin
//    if (WmMessageToString <> Nil) and (Msg.Message <> WM_MOUSEFIRST) then
//      OutputDebugString(PChar(GetTimeStamp + 'MenuKeyMsgHook: ' + WmMessageToString.MsgToString(Msg)));
    case Msg.Message of
      CM_DEACTIVATE: MenuController2.CancelMenu;
      WM_COMMAND: ReleaseMenuKeyHooks;
//      WM_CREATE: begin
//       if (WmMessageToString <> Nil) then
//         OutputDebugString(PChar(GetTimeStamp + 'MenuKeyMsgHook: ' + WmMessageToString.MsgToString(Msg)));
//      end
    else
      if (MenuHook = 0) and
         ((Msg.Message = WM_CHAR) or (Msg.Message = WM_KEYDOWN) or (Msg.Message = WM_KEYUP) or (Msg.Message = WM_SYSKEYDOWN) or (Msg.Message = WM_SYSKEYUP)) then
        Msg.hwnd := MenuController2.FControl.Handle;
    end;
  end;
  Result := CallNextHookEx(MenuKeyHook, Code, WParam, LPARAM(@Msg))
end;

procedure InitMenuKeyHooks;
begin
  if MenuKeyHook = 0 then
    MenuKeyHook := SetWindowsHookEx(WH_GETMESSAGE, @MenuKeyMsgHook, 0, GetCurrentThreadID);
end;

procedure ReleaseMenuKeyHooks;
begin
  if MenuKeyHook <> 0 then
    UnhookWindowsHookEx(MenuKeyHook);
  MenuKeyHook := 0;
  MenuController2 := Nil;
end;

procedure TUMenuAnyWhere.InitMenu(Button: TUMenuButton);
begin
//  OutputDebugString(PChar(GetTimeStamp + 'InitMenu'));
  MenuController2 := Self;
  TWinControlAccess(FControl).MouseCapture := True;
  InitMenuKeyHooks;
  if Button <> Nil then begin
    FHotItem := Button.Index;
    ClickButton(Button, False);
  end
  else
    FHotItem := 0;
  if Button = Nil then
    FCaptureChangeCancels := True;
  SetMenuAnchorHighLight(True);
end;

function TUMenuAnyWhere.TrackMenu(Button: TUMenuButton): Boolean;
begin
//  OutputDebugString(PChar(GetTimeStamp + 'TrackMenu'));
  // Already in menu loop - click button to drop-down menu
  if FInMenuLoop then begin
    if Button <> Nil then begin
      ClickButton(Button, False);
      Result := True;
    end
    else
      Result := False;
    Exit;
  end;

  InitMenu(Button);
  try
    FInMenuLoop := True;
    repeat
      Application.HandleMessage;
      if Application.Terminated then
        FInMenuLoop := False;
    until not FInMenuLoop;
  finally
    CancelMenu;
  end;
  Result := FMenuResult;
end;

procedure TUMenuAnyWhere.CancelMenu;
begin
//  OutputDebugString(PChar(GetTimeStamp + 'CancelMenu'));
  if FInMenuLoop then begin
    ReleaseMenuKeyHooks;
    TWinControlAccess(FControl).MouseCapture := False;
    SetMenuAnchorHighLight(False);
  end;
  FMenuTriggerMode := mtmUnknown;
  FInMenuLoop := False;
  StillModal := False;
  FCaptureChangeCancels := False;
  FHotItem := -1;
end;

function TUMenuAnyWhere.CheckMenuDropdown(Button: TUMenuButton): Boolean;
var
  Hook: Boolean;
  Item: TMenuItem;
  I: Integer;
  ParentMenu: TMenu;
  APoint: TPoint;
  LMonitor: TMonitor;
begin
  Result := False;
  if not FEnabled or (Button = Nil) or (Button.Parent = Nil){ or (FInMenuLoop and FMenuDropped)} then
    Exit;
//  OutputDebugString(PChar(GetTimeStamp + 'CheckMenuDropdown (FMenuDropped: ' + BoolToStr(FMenuDropped, True) + ')'));
  FCaptureChangeCancels := False;
  FMenuDropped := True;
  try
    if Button.MenuItem <> Nil then begin
      Button.MenuItem.Click;
      ClearTempMenu;
      FTempMenu := TUPopupMenu.Create(FControl);
      TUPopupMenu(FTempMenu).MenuController := Self;
      ParentMenu := Button.MenuItem.GetParentMenu;
      if ParentMenu <> Nil then
        FTempMenu.BiDiMode := ParentMenu.BiDiMode;
      FTempMenu.HelpContext := Button.MenuItem.HelpContext;
      FTempMenu.TrackButton := tbLeftButton;
      if ParentMenu <> Nil then
        FTempMenu.Images := ParentMenu.Images;
      FButtonMenu := Button.MenuItem;
      for I := FButtonMenu.Count - 1 downto 0 do begin
        Item := FButtonMenu.Items[I];
        FButtonMenu.Delete(I);
        FTempMenu.Items.Insert(0, Item);
      end;
      FTempMenu.OwnerDraw := True;
    end
    else begin
//      OutputDebugString(PChar(GetTimeStamp + 'CheckMenuDropdown (Button.MenuItem = Nil)'));
      Exit;
    end;
    if FTempMenu = Nil then
      Exit;
    FTempMenu.PopupComponent := FControl;
    //
    if not FInMenuLoop and not StillModal then
      TWinControlAccess(FControl).SendCancelMode(Nil);
    //
    //ReleaseMenuHooks;
    Hook := (Button.MenuItem <> Nil);
    if Hook then begin
      MenuButtonIndex := Button.Index;
      MenuController := Self;
      InitMenuHooks;
    end;
    FHotItem := -1;
    try
      APoint := Button.ClientToScreen(Point(0, Button.ClientHeight));
      if FTempMenu.IsRightToLeft then
        Inc(APoint.X, Button.Width);
      LMonitor := Screen.MonitorFromPoint(APoint);
      if (LMonitor <> Nil) and ((GetSystemMetrics(SM_CYMENU) * FTempMenu.Items.Count) + APoint.Y > LMonitor.Height) then
        Dec(APoint.Y, Button.Height);
      Button.Down := True;
      Button.Invalidate;
      FTempMenu.Popup(APoint.X, APoint.Y);
    finally
      if Hook then
        ReleaseMenuHooks;
    end;
    FMenuButton := Button;
    if StillModal then
      FHotItem := Button.Index;
    Result := True;
  finally
    PostMessage(FControl.Handle, CN_DROPDOWNCLOSED, 0, 0);
  end;
end;

procedure TUMenuAnyWhere.ClickButton(Button: TUMenuButton; DoubleClick: Boolean);
var
  P: TPoint;
  SmallPt: TSmallPoint;
begin
//  OutputDebugString(PChar(GetTimeStamp + 'ClickButton' + IfThen(DoubleClick, ' (DoubleClick)')));
  FCaptureChangeCancels := False;
  P := Button.ClientToScreen(Point(0, 0));
  SmallPt := PointToSmallPoint(FControl.ScreenToClient(P));
  PostMessage(FControl.Handle, WM_LBUTTONDOWN, MakeLong(MK_LBUTTON, $0080), MakeLong(SmallPt.X, SmallPt.Y));
  if DoubleClick then
    PostMessage(FControl.Handle, WM_LBUTTONDOWN, MakeLong(MK_LBUTTON, $0080), MakeLong(SmallPt.X, SmallPt.Y));
end;
{
procedure TUMenuAnyWhere.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then begin
    if AComponent = FControl then
      Control := Nil;
    if AComponent = FMenu then
      Menu := Nil;
  end;
end;
}
procedure TUMenuAnyWhere.ControlWndProc(var Message: TMessage);

  procedure DefaultProc;
  begin
    FControlWndProcOld(Message);
  end;

  function IsMenuAvailable: Boolean;
  var
    i: Integer;
  begin
    Result := False;
    for i := 0 to FButtons.Count - 1 do begin
      if Assigned(Buttons[i].MenuItem) then begin
        Result := True;
        Break;
      end;
    end;
  end;

  function ContainsActiveControl: Boolean;
  var
    F: TCustomForm;
  begin
    F := GetParentForm(FControl, False);
    if (F <> Nil) and (Screen.ActiveControl <> Nil) then
      Result := (F = Screen.ActiveControl) or F.ContainsControl(Screen.ActiveControl)
    else
      Result := False;
  end;

var
  LControl: TControl;
  CapControl: TControl;
  Msg: TMsg;

  function IsButtonMouseMsg(var Message: TWMMouse): Boolean;
  begin
    if GetCapture = FControl.Handle then begin
      CapControl := GetCaptureControl;
      if (CapControl <> Nil) and (CapControl.Parent <> FControl) then
        CapControl := Nil;
    end
    else
      CapControl := Nil;
    LControl := FControl.ControlAtPos(SmallPointToPoint(Message.Pos), False);
    Result := (LControl <> Nil) and (LControl is TUMenuButton) and not LControl.Dragging;
  end;

  procedure SendDropdownMsg(Button: TUMenuButton); //; MouseUsed: Boolean);
  var
    Msg: TNMToolBar;
  begin
    StillModal := True;
    FillChar(Msg, SizeOf(Msg), 0);
    with Msg, hdr do begin
      hwndFrom := FControl.Handle;
      idFrom := FControl.Handle;
      code := TBN_DROPDOWN;
//      if MouseUsed then
//        code := code or TBN_GETOBJECT;
      iItem := Button.Index;
    end;
    SendStructMessage(FControl.Handle, WM_NOTIFY, FControl.Handle, Msg); // sendmessage
    //StillModal := False;
  end;

var
  WMKey: TWMKey;
  WMKeyDown: TWMKeyDown;
  WMSysCommand: TWMSysCommand;
  WMChar: TWMChar;
  WMNotifyTLB: TWMNotifyTLB;
  CMDialogChar: TCMDialogChar;
  CMControlChange: TCMControlChange;
  Item: Integer;
  Button: TUMenuButton;
  Form: TCustomForm;
begin
  if FMenu = Nil then begin
    DefaultProc;
    Exit;
  end;
  case Message.Msg of
    WM_GETDLGCODE: begin
//      OutputDebugString(PChar(GetTimeStamp + 'WM_GETDLGCODE (FInMenuLoop: ' + BoolToStr(FInMenuLoop, True) + ')'));
      if FInMenuLoop then begin
        DefaultProc; // peek a value from FControl
        Message.Result := Message.Result or DLGC_WANTARROWS;
        Exit;
      end;
    end;
    WM_MOUSEMOVE: begin
      //OutputDebugString(PChar(GetTimeStamp + 'WM_MOUSEMOVE'));
      // Call default wndproc to get buttons to repaint when Flat = True.
      if not (csDesigning in FControl.ComponentState) and IsButtonMouseMsg(TWMMouse(Message)) then begin
        // Prevent painting of flat buttons when they are dock clients }
        if TControlAccess(LControl).DragMode <> dmAutomatic then
          FControl.DefaultHandler(Message);
      end
      else
        FControl.DefaultHandler(Message);
    end;
    WM_LBUTTONUP: begin
//      OutputDebugString(PChar(GetTimeStamp + 'WM_LBUTTONUP'));
      // Update button states after a click.
      if not (csDesigning in FControl.ComponentState) and IsButtonMouseMsg(TWMMouse(Message)) then begin
        FControl.DefaultHandler(Message);
        if (CapControl = LControl) or (LControl is TUMenuButton) then begin
          Button := TUMenuButton(LControl);
          if Button <> Nil then begin
            if Button.Down then
              Button.Down := False;
            Button.Invalidate;
            //UpdateButtonStates;
          end;
        end
        else if CapControl is TUMenuButton then
          Exit;
      end;
    end;
    WM_LBUTTONDOWN,
    WM_LBUTTONDBLCLK: begin
//      OutputDebugString(PChar(GetTimeStamp + IfThen(Message.Msg <> WM_LBUTTONDBLCLK, 'WM_LBUTTONDOWN', 'WM_LBUTTONDBLCLK')));
      if not (csDesigning in FControl.ComponentState) and IsButtonMouseMsg(TWMMouse(Message)) then begin
        if (LControl <> Nil) and not LControl.Dragging then
          FControl.DefaultHandler(Message);
        //
        if (LControl <> Nil) and (TUMenuButton(LControl).MenuItem <> Nil) then begin
          try
            if (FMenuTriggerMode <> mtmMouse) and (Message.WParamHi = 0) then
              FMenuTriggerMode := mtmMouse;
            SendDropDownMsg(TUMenuButton(LControl));
          finally
            // Here we remove WM_LBUTTONDOWN message sent and instead dispatch it as a WM_LBUTTONUP to get a Click fired.
            Msg.Message := 0;
            if PeekMessage(Msg, FControl.Handle, WM_LBUTTONDOWN, WM_LBUTTONDOWN, PM_REMOVE) and (Msg.Message = WM_QUIT) then
              PostQuitMessage(Msg.WParam)
            else begin
              Message.Msg := WM_LBUTTONUP;
              FControl.Dispatch(Message);
            end;
          end;
        end;
        Exit;
      end;
    end;
    WM_KEYDOWN: begin
      WMKeyDown := TWMKeyDown(Message);
//      OutputDebugString(PChar(GetTimeStamp + 'WM_KEYDOWN (Key: ''' + KeyCodeToString(Message.LParam) + ''' / KeyCode: ' + IntToStr(WMKeyDown.CharCode) + ')'));
      if FInMenuLoop then begin
        Item := FHotItem;
        case WMKeyDown.CharCode of
          VK_RETURN, VK_DOWN: begin
            if (Item > -1) and (Item < FButtons.Count) then begin
              Button := TUMenuButton(FButtons[Item]);
              //P := Button.ClientToScreen(Point(1, 1));
              FMenuTriggerMode := mtmKeyboard;
              //ClickButton(Button);
              SendDropDownMsg(Button);
            end;
            // Prevent default processing
            if WMKeyDown.CharCode = VK_DOWN then
              Exit;
          end;
          VK_LEFT,
          VK_RIGHT: begin
            if not FMenuDropped then begin
              Button := FindButton(Self, FHotItem, WMKeyDown.CharCode = VK_RIGHT);
              if Button <> Nil then begin
                FHotItem := Button.Index;
                UpdateButtons(False);
              end;
            end;
          end;
          VK_ESCAPE: CancelMenu;
        end;
      end
      else begin
        if FMenuDropped or (FButtonMenu <> Nil) then begin
          // Prevent default processing
          if WMKeyDown.CharCode = VK_DOWN then
            Exit;
        end;
      end;
    end;
    WM_CAPTURECHANGED: begin
//      OutputDebugString(PChar(GetTimeStamp + 'WM_CAPTURECHANGED'));
      DefaultProc;
      if FInMenuLoop and FCaptureChangeCancels then
        CancelMenu;
      Exit;
    end;
    WM_SIZE: begin
    end;
    WM_SYSCHAR: begin
//      OutputDebugString(PChar(GetTimeStamp + 'WM_SYSCHAR'));
      // Default wndproc doesn't re-route WM_SYSCHAR messages to parent.
      Form := GetParentForm(FControl);
      if Form <> Nil then begin
        Form.Dispatch(Message);
        Exit;
      end
    end;
    WM_SYSCOMMAND: begin
//      OutputDebugString(PChar(GetTimeStamp + 'WM_SYSCOMMAND'));
      // Enter menu loop if only the Alt key is pressed -- ignore Alt-Space and let the default processing show the system menu.
      if not FInMenuLoop and FControl.Enabled and FControl.Showing and IsMenuAvailable then begin
        WMSysCommand := TWMSysCommand(Message);
        if (WMSysCommand.CmdType and $FFF0 = SC_KEYMENU) and (WMSysCommand.Key <> VK_SPACE) and (WMSysCommand.Key <> Word('-')) and (GetCapture = 0) then begin
          if not FEnabled then
            Exit;
          if WMSysCommand.Key = 0 then
            Button := Nil
          else
            Button := FindButtonFromAccel(WMSysCommand.Key);
          if (WMSysCommand.Key = 0) or ((Button <> Nil) and (Button.ImageIndex > -1)) then begin
            TrackMenu(Button);
            Message.Result := 1;
            Exit;
          end;
        end;
      end;
    end;
//    CM_DIALOGKEY: begin
//      OutputDebugString(PChar(GetTimeStamp + 'CM_DIALOGKEY'));
//    end;
    CM_DIALOGCHAR: begin
//      OutputDebugString(PChar(GetTimeStamp + 'CM_DIALOGCHAR'));
      if FControl.Enabled and FControl.Showing and ContainsActiveControl then begin
        CMDialogChar := TCMDialogChar(Message);
        Button := FindButtonFromAccel(CMDialogChar.CharCode);
        if Button = Nil then begin // check short-cuts
          WMKey := TWMKey(Message);
          WMKey.CharCode := WMKey.CharCode + $40; // start from 'A'
          if IsShortCut(WMKey) then begin
            Message.Result := 1;
            Exit;
          end;
//          else
//            Message.Result := 0;
        end;
        if (Button <> Nil) then begin
          if Button.MenuItem <> Nil then
            TrackMenu(Button)
          else
            Button.Click;
          Message.Result := 1;
          Exit;
        end;
      end;
    end;
    CM_FONTCHANGED: begin
    end;
    CM_PARENTCOLORCHANGED: begin
    end;
    CN_CHAR: begin
//      OutputDebugString(PChar(GetTimeStamp + 'CN_CHAR'));
      // We got here through the installed MenuKeyHook
      if FInMenuLoop and not (csDesigning in FControl.ComponentState) then begin
        WMChar := TWMChar(Message);
        if FControl.Perform(CM_DIALOGCHAR, WMChar.CharCode, WMChar.KeyData) <> 0 then
          Message.Result := 1;
      end;
    end;
    CN_SYSKEYDOWN: begin
//      OutputDebugString(PChar(GetTimeStamp + 'CN_SYSKEYDOWN'));
      if (TWMSysKeyDown(Message).CharCode = VK_MENU) then
        CancelMenu;
    end;
    CN_NOTIFY: begin
//      OutputDebugString(PChar(GetTimeStamp + 'CN_NOTIFY'));
      WMNotifyTLB := TWMNotifyTLB(Message);
      case WMNotifyTLB.NMHdr.code of
        TBN_DROPDOWN: begin
          // We can safely assume that a TBN_DROPDOWN message was generated by a TUMenuButton and not any other TControl.
          Item := WMNotifyTLB.NMToolBar^.iItem;
          if (Item > -1) and (Item < FButtons.Count) then begin
            Button := Buttons[Item];
            if Button <> Nil then
              Button.CheckMenuDropDown;
          end;
        end;
      end;
    end;
    CN_DROPDOWNCLOSED: begin
//      if FMenuDropped then begin
//        OutputDebugString(PChar(GetTimeStamp + 'CN_DROPDOWNCLOSED'));
        ClearTempMenu;
        SetMenuAnchorHighLight(False);
//        if FMenuTriggerMode = mtmMouse then begin
//          StillModal := False;
//          FCaptureChangeCancels := False;
//          FHotItem := -1;
//        end;
        FMenuTriggerMode := mtmUnknown;
        FMenuDropped := False;
        FCaptureChangeCancels := True;
//      end
//      else
//        OutputDebugString(PChar(GetTimeStamp + 'CN_DROPDOWNCLOSED (FMenuDropped = False)'));
    end;
    CM_CONTROLCHANGE: begin
      CMControlChange := TCMControlChange(Message);
      if CMControlChange.Inserting then
        InsertButton(CMControlChange.Control)
      else
        RemoveButton(CMControlChange.Control);
    end;
//    CM_ISSHORTCUT: begin
//      WMKey := TWMKey(Message);
//      if IsShortCut(WMKey) then
//        Message.Result := 1
//      else
//        Message.Result := 0;
//    end;
//    CM_APPKEYDOWN: begin
//      if IsShortCut(TWMKey(Message)) then
//        Message.Result := 1;
//    end;
  end;
  DefaultProc;
end;

function TUMenuAnyWhere.GetButton(Index: Integer): TUMenuButton;
begin
  Result := TUMenuButton(FButtons[Index]);
end;

function TUMenuAnyWhere.GetButtonCount: Integer;
begin
  Result := FButtons.Count;
end;

procedure TUMenuAnyWhere.GetButtonSize(var AWidth, AHeight: Integer);
var
  i, size: Integer;
  btn: TUMenuButton;
  canvas: TCanvas;
begin
  AWidth := 0;
  AHeight := FControl.Height;
  canvas:=ControlCanvas;
  try
    for i:=0 to FButtons.Count - 1 do begin
      btn := Buttons[i];
      size := 0;
      if (btn <> Nil) and (btn.MenuItem <> Nil) then
        size := canvas.TextWidth(btn.MenuItem.Caption);
      if size > AWidth then
        AWidth := size;
    end;
    Inc(AWidth, 16);
  finally
    canvas.Free;
  end;
end;

function TUMenuAnyWhere.ControlCanvas: TCanvas;
begin
  Result := TControlCanvas.Create;
  if FControl <> Nil then begin
    TControlCanvas(Result).Control := FControl;
    Result.Handle := GetDC(FControl.Handle);
  end;
end;

procedure TUMenuAnyWhere.ClearTempMenu;
var
  i: Integer;
  Item: TMenuItem;
begin
  if (FButtonMenu <> Nil) and (FMenuButton <> Nil) then begin
    if (FMenuButton.MenuItem <> Nil) and (FTempMenu <> Nil) then begin
      for i:=FTempMenu.Items.Count - 1 downto 0 do begin
        Item := FTempMenu.Items[i];
        FTempMenu.Items.Delete(i);
        FButtonMenu.Insert(0, Item);
      end;
      FTempMenu.Free;
      FTempMenu := Nil;
    end;
    if FMenuButton <> Nil then begin
      FMenuButton.Down := False;
      FMenuButton.Invalidate;
      FMenuButton := Nil;
    end;
    FButtonMenu := Nil;
  end;
end;

procedure TUMenuAnyWhere.HookWndProc;
begin
  if FControl = Nil then
    raise EUMenuAnyWhere.Create('Control not set!');
  //
  if FControlWndProcHooked then
    Exit;
  //
  FControlWndProcOld := FControl.WindowProc;
  FControl.WindowProc := ControlWndProc;
  FControlWndProcHooked := True;
end;

procedure TUMenuAnyWhere.UnHookWndProc;
begin
  if (FControl = Nil) or not FControlWndProcHooked then
    Exit;
  //
  FControl.WindowProc := FControlWndProcOld;
  FControlWndProcHooked := True;
end;

//
function GlobalHookCallWndProc(Code: Integer; WParam: WPARAM; LParam: LPARAM): LRESULT stdcall;
//function GlobalHookCallWndProc(Code: Integer; WParam: Longint; var Msg: TMsg): Longint; stdcall;
var
  cwps: TCWPStruct;
  class_name: String;
begin
  if (Code = HC_ACTION) then begin
//    if (WmMessageToString <> Nil) and (Msg.Message <> WM_MOUSEFIRST) then
//      OutputDebugString(PChar(GetTimeStamp + 'MenuKeyMsgHook: ' + WmMessageToString.MsgToString(Msg)));
    cwps :=  TCWPStruct(Pointer(LParam)^);
    case cwps.Message of
      WM_CREATE: begin
        class_name := GetWndClassName(cwps.hwnd);
//        if (WmMessageToString <> Nil) then
//          OutputDebugString(PChar(GetTimeStamp + 'GlobalHookCallWndProc: ' + WmMessageToString.MsgToString(cwps.Message) + '; class_name: ' + class_name));
        if class_name = '#32768' then begin
          UpdateWindow(cwps.hwnd);
        end;
        class_name := '';
      end
    end;
  end;
  Result := CallNextHookEx(MenuKeyHook, Code, WParam, LParam);
end;

procedure TUMenuAnyWhere.HookGlobalWndProc;
begin
  if FGlobalHook = 0 then begin
//    OutputDebugString(PChar(GetTimeStamp + 'HookGlobalWndProc'));
    FGlobalHook := SetWindowsHookEx(WH_CALLWNDPROC, @GlobalHookCallWndProc, 0, GetCurrentThreadID);
  end;
end;

procedure TUMenuAnyWhere.UnHookGlobalWndProc;
begin
//  OutputDebugString(PChar(GetTimeStamp + 'UnHookGlobalWndProc'));
  if FGlobalHook <> 0 then
    UnhookWindowsHookEx(FGlobalHook);
  FGlobalHook := 0;
end;

procedure TUMenuAnyWhere.MenuChanged(Sender: TObject; Source: TMenuItem; Rebuild: Boolean);
begin
  if FMenuDropped or not (csDesigning in FMenu.ComponentState) then
    Exit;
  DestroyButtons;
  CreateButtons;
  RecreateButtons;
end;

procedure TUMenuAnyWhere.CreateButtons;
var
  i: Integer;
  btn: TUMenuButton;
begin
  for i:=0 to FMenu.Items.Count - 1 do begin
    btn := TUMenuButton.Create(Nil);
    try
      btn.AutoSize := False;
      //btn.Grouped := True;
      btn.Visible := False;
      btn.MenuItem := FMenu.Items[i];
      btn.MenuItem.AutoHotkeys := maManual;
      btn.Parent := FControl;
    except
      btn.Free;
      raise;
    end;
  end;
  if FButtonSizeAutoCalc then
    GetButtonSize(FButtonWidth, FButtonHeight)
  else
    DoButtonSizeCalc;
end;

procedure TUMenuAnyWhere.DestroyButtons;
var
  i: Integer;
begin
//  OutputDebugString(PChar(GetTimeStamp + 'DestroyButtons (ButtonCount: ' + IntToStr(ButtonCount) + ')'));
  for i:=ButtonCount - 1 downto 0 do
    Buttons[i].Free;
end;

procedure TUMenuAnyWhere.DoButtonSizeCalc;
begin
  if Assigned(FOnButtonSizeCalc) then
    FOnButtonSizeCalc(Self, FButtonWidth, FButtonHeight);
end;

procedure TUMenuAnyWhere.DoChangeScale(M, D: Integer);
begin
//  inherited DoChangeScale(M, D);
  if M = D then
    Exit;
  //
  FUpdating := True;
  try
    FButtonWidth := MulDiv(FButtonWidth, M, D);
    FButtonHeight := MulDiv(FButtonHeight, M, D);
    Font.Height := MulDiv(Font.Height, M, D);
    RecreateButtons;
  finally
    FUpdating := False;
  end;
end;

procedure TUMenuAnyWhere.RecreateButtons;
var
  i, pos: Integer;
  btn: TUMenuButton;
begin
  pos := 4;
  for i:=0 to FButtons.Count - 1 do begin
    btn := Buttons[i];
    if (btn = Nil) or not (btn is TUMenuButton) then
      Continue;
    btn.Visible := False; // hide button
    if (btn.MenuItem = Nil) or not btn.MenuItem.Visible then
      Continue;
    //
    btn.SetBounds(PosX + pos, PosY, FButtonWidth, FButtonHeight);
    btn.Visible := True;
    Inc(pos, FButtonWidth + 4);
  end;
end;

procedure TUMenuAnyWhere.UpdateButtons(RemakeShortCuts: Boolean);
var
  i: Integer;
  menuItem: TMenuItem;
  btn: TUMenuButton;
begin
  if RemakeShortCuts and (FMenu.AutoHotkeys = maAutomatic) then begin
    FMenu.Items.RethinkHotkeys;
    FMenu.Items.RethinkLines;
  end;
  for i:=0 to ButtonCount - 1 do begin
    btn := Buttons[i];
    if (btn = Nil) or not (btn is TUMenuButton) then
      Continue;
//    if FEnabled then
//      btn.Enabled := (btn.MenuItem = Nil) and btn.MenuItem.Enabled
//    else
//      btn.Enabled := False;
    btn.Enabled := FEnabled;
    if RemakeShortCuts then begin
      if btn.MenuItem <> Nil then begin
        btn.MenuItem.AutoHotkeys := maAutomatic;
        menuItem := FMenu.Items.Find(btn.MenuItem.Caption);
        btn.MenuItem := menuItem;
      end;
    end
    else if btn.MenuItem <> Nil then
      btn.MenuItem.AutoHotkeys := maManual;
    btn.Invalidate;
  end;
end;

procedure TUMenuAnyWhere.UpdateColors;
var
  TM: TUCustomThemeManager;
  AccentColor: TColor;
begin
  // Prepairing
  if FControl <> Nil then
    TM := SelectThemeManager(FControl)
  else if TMenu <> Nil then
    TM := SelectThemeManager(FMenu)
  else
    TM := GetCommonThemeManager;
  //
  AccentColor := SelectAccentColor(TM, clNone);

  ButtonBackColor := ButtonBackColors.GetColor(TM.ThemeUsed, csNone);
  ButtonBackHoverColor := ButtonBackColors.GetColor(TM.ThemeUsed, csHover);
  ButtonBackDisabledColor := ButtonBackColors.GetColor(TM.ThemeUsed, csDisabled);
  ButtonTextColor := ButtonTextColors.GetColor(TM.ThemeUsed, csNone);
  ButtonTextHoverColor := ButtonTextColors.GetColor(TM.ThemeUsed, csHover);
  ButtonTextDisabledColor := ButtonTextColors.GetColor(TM.ThemeUsed, csDisabled);
    //
  if MenuBorderColors.GetColor(TM) = clDefault then
    MenuBorderColor := AccentColor
  else
    MenuBorderColor := MenuBorderColors.GetColor(TM);
  MenuBackColor := MenuBackColors.GetColor(TM.ThemeUsed, csNone);
  MenuItemBackColor := MenuBackColors.GetColor(TM.ThemeUsed, csNone);
  MenuItemHoverColor := MenuBackColors.GetColor(TM.ThemeUsed, csHover);
  MenuItemDisabledColor := MenuBackColors.GetColor(TM.ThemeUsed, csDisabled);
  MenuItemTextColor := MenuTextColors.GetColor(TM.ThemeUsed, csNone);
  MenuItemTextHoverColor := MenuTextColors.GetColor(TM.ThemeUsed, csHover);
  MenuItemTextDisabledColor := MenuTextColors.GetColor(TM.ThemeUsed, csDisabled);
end;

procedure TUMenuAnyWhere.UpdateTheme;
begin
  UpdateColors;
  UpdateButtons(False);
end;

procedure TUMenuAnyWhere.InsertButton(AControl: TControl);
var
  FromIndex, ToIndex: Integer;
begin
  if AControl is TUMenuButton then
    TUMenuButton(AControl).FMenuController := Self
  else
    Exit;
  if not (csLoading in AControl.ComponentState) then begin
    FromIndex := FButtons.IndexOf(AControl);
    if FromIndex >= 0 then
      ReorderButton(Fromindex, AControl.Left, AControl.Top)
    else begin
      ToIndex := ButtonIndex(FromIndex, AControl.Left, AControl.Top);
      FButtons.Insert(ToIndex, AControl);
    end;
  end
  else
    FButtons.Add(AControl);
end;

function TUMenuAnyWhere.IsShortCut(var Message: TWMKey): Boolean;

  function DispatchShortCut(const Owner: TComponent) : Boolean;
  var
    I: Integer;
    Component: TComponent;
  begin
    Result := False;
    { Dispatch to all children }
    for I := 0 to Owner.ComponentCount - 1 do begin
      Component := Owner.Components[I];
      if Component is TCustomActionList then begin
        if TCustomActionList(Component).IsShortCut(Message) then begin
          Result := True;
          Exit;
        end
      end
      else begin
        Result := DispatchShortCut(Component);
        if Result then
          Break;
      end;
    end;
  end;

begin
  Result := False;
  if Assigned(FOnShortCut) then
    FOnShortCut(Message, Result);
  Result := Result or ((Menu <> Nil) and Menu.IsShortCut(Message)) or DispatchShortCut(GetParentForm(Control, False));
end;

procedure TUMenuAnyWhere.RemoveButton(AControl: TControl);
var
  i: Integer;
begin
  if AControl is TUMenuButton then begin
    TUMenuButton(AControl).FMenuController := Nil;
    i := FButtons.IndexOf(AControl);
    if i >= 0 then
      FButtons.Remove(AControl);
  end;
end;

procedure TUMenuAnyWhere.Assign(Source: TPersistent);
begin
  if Source is TUMenuAnyWhere then begin
    Self.ButtonSizeAutoCalc := TUMenuAnyWhere(Source).ButtonSizeAutoCalc;
    if not Self.ButtonSizeAutoCalc then begin
      Self.ButtonWidth := TUMenuAnyWhere(Source).ButtonWidth;
      Self.ButtonHeight := TUMenuAnyWhere(Source).ButtonHeight;
    end;
    Self.PosX := TUMenuAnyWhere(Source).PosX;
    Self.PosY := TUMenuAnyWhere(Source).PosY;
    Self.Transparent := TUMenuAnyWhere(Source).Transparent;
    Self.Font := TUMenuAnyWhere(Source).Font;
    Self.ButtonBackColors := TUMenuAnyWhere(Source).ButtonBackColors;
    Self.ButtonTextColors := TUMenuAnyWhere(Source).ButtonTextColors;
    Self.MenuBorderColors := TUMenuAnyWhere(Source).MenuBorderColors;
    Self.MenuBackColors := TUMenuAnyWhere(Source).MenuBackColors;
    Self.MenuTextColors := TUMenuAnyWhere(Source).MenuTextColors;
    Self.OnButtonSizeCalc := TUMenuAnyWhere(Source).OnButtonSizeCalc;
  end
  else
    inherited Assign(Source);
end;

function TUMenuAnyWhere.ButtonIndex(OldIndex, ALeft, ATop: Integer): Integer;
begin
  Result := FButtons.Count;
end;

function TUMenuAnyWhere.ReorderButton(OldIndex, ALeft, ATop: Integer): Integer;
var
  AControl: TControl;
begin
  Result := ButtonIndex(OldIndex, ALeft, ATop);
  if Result <> OldIndex then begin
    // If we are inserting to the right of our deletion then account for shift
    if OldIndex < Result then Dec(Result);
    AControl := TControl(FButtons[OldIndex]);
    FButtons.Delete(OldIndex);
    FButtons.Insert(Result, AControl);
  end;
end;

function TUMenuAnyWhere.FindButtonFromAccel(Accel: Word): TUMenuButton;
var
  i: Integer;
begin
  for i:=0 to FButtons.Count - 1 do begin
    Result := Buttons[i];
    if Result.Visible and Result.Enabled and IsAccel(Accel, Result.Caption) then
      Exit;
  end;
  Result := Nil;
end;

procedure TUMenuAnyWhere.FontChanged(Sender: TObject);
begin
  if FUpdating then
    Exit;
  //
  UpdateColors;
  RecreateButtons;
end;

procedure TUMenuAnyWhere.ColorsChange(Sender: TObject);
begin
  UpdateColors;
  UpdateButtons(False);
end;

procedure TUMenuAnyWhere.SetMenuAnchorHighLight(Active: Boolean);
begin
  if FMenuAnchorHighLight <> Active then begin
    FMenuAnchorHighLight := Active;
    UpdateButtons(Active);
  end;
end;
{$ENDREGION}
{$REGION 'TUCustomMenuAnyWhereController'}
{ TUCustomMenuAnyWhereController }

{$ENDREGION}

var
  LPopupList: TPopupList;

initialization
//  WmMessageToString := TWmMessageToString.Create;
  if not ModuleIsPackage and not (PopupList is TUPopupList) then begin
    LPopupList := TUPopupList.Create;
    //LPopupList.Assign(PopupList);
    PopupList.Free;
    PopupList := LPopupList;
    LPopupList := Nil;
  end;

finalization
  if PopupList is TUPopupList then begin
    LPopupList := TPopupList.Create;
    //LPopupList.Assign(PopupList);
    PopupList.Free;
    PopupList := LPopupList;
    LPopupList := Nil;
  end;
//  FreeAndNil(WmMessageToString);

end.
