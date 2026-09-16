unit UCL.PopupMenu;

interface

{$IF CompilerVersion > 29}
  {$LEGACYIFEND ON}
{$IFEND}

uses
  Classes,
  Types,
  Windows,
  Forms,
  Controls,
  Menus,
  Graphics,
  Dialogs,
  UCL.IntAnimation,
  UCL.IntAnimation.Helpers,
  UCL.Classes,
  UCL.Types,
  UCL.Utils,
  UCL.Graphics,
  UCL.ThemeManager,
  UCL.Form,
  UCL.SymbolButton;

type
  TIndexNotifyEvent = procedure(Sender: TObject; Index: Integer) of object;

type
  TUPopupMenu = class;

  {
    One visible level of the popup hierarchy.

    Root level:
      FParentLevel = nil

    Submenu:
      FParentLevel = level containing the parent menu item
      FParentItem  = menu item which owns this submenu
  }
  TUPopupLevel = class
  public
    Menu: TUPopupMenu;
    Form: TUForm;

    ParentLevel: TUPopupLevel;
    ParentItem: TMenuItem;
    ParentIndex: Integer;

    ChildLevel: TUPopupLevel;

    Items: TList;

    // Index of the currently highlighted item
    //   -1 means no item is active
    ActiveIndex: Integer;
    Closing: Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

  TUPopupMenu = class(TPopupMenu, IUThemedComponent)
  private var
    BackColor: TColor;

  private
    FThemeManager: TUThemeManager;
    FIconFont: TFont;
    FTextFont: TFont;
    FDetailFont: TFont;
    FAniSet: TIntAniSet;
    FOnItemClick: TIndexNotifyEvent;

    FItemWidth: Integer;
    FItemHeight: Integer;
    FTopSpace: Integer;
    FImageKind: TUImageKind;
    FCloseAnimation: Boolean;

    FUpdating: Boolean;

    FRootLevel: TUPopupLevel;

    FMouseHook: HHOOK;
    FKeyboardHook: HHOOK;
    FHookThreadID: DWORD;

    FOpening: Boolean;
    FClosing: Boolean;

    procedure SetThemeManager(const Value: TUThemeManager);
    procedure SetIconFont(const Value: TFont);
    procedure SetTextFont(const Value: TFont);
    procedure SetDetailFont(const Value: TFont);
    procedure SetActiveIndex(ALevel: TUPopupLevel; AIndex: Integer);
    procedure FontChange(Sender: TObject);

    procedure PopupItem_OnClick(Sender: TObject);

    procedure InstallHooks;
    procedure RemoveHooks;

    procedure CloseLevel(ALevel: TUPopupLevel; AAnimate: Boolean);
    procedure CloseFromLevel(ALevel: TUPopupLevel; AAnimate: Boolean);
    procedure CloseAll(AAnimate: Boolean);

    function CreateLevel(AParentLevel: TUPopupLevel; AParentItem: TMenuItem; AParentIndex: Integer; X, Y: Integer): TUPopupLevel;

    procedure OpenSubMenu(AParentLevel: TUPopupLevel; AParentItem: TMenuItem; AParentIndex: Integer; AButton: TUSymbolButton);

    procedure MoveActive(ALevel: TUPopupLevel; ADelta: Integer);
    procedure ActivateCurrentItem(ALevel: TUPopupLevel);
    function GetDeepestLevel: TUPopupLevel;
    function GetMenuItem(ALevel: TUPopupLevel; AIndex: Integer): TMenuItem;
    function GetButton(ALevel: TUPopupLevel; AIndex: Integer): TUSymbolButton;

    function FindLevelForForm(AForm: THandle): TUPopupLevel;
    function FindButtonFromWindow(AWnd: HWND): TUSymbolButton;
    function FindLevelFromButton(AButton: TUSymbolButton): TUPopupLevel;

    function IsPointInsideLevel(ALevel: TUPopupLevel; const P: TPoint): Boolean;

    function IsPointInsideHierarchy(const P: TPoint): Boolean;

    procedure MouseMove(const P: TPoint);
    procedure MouseButtonDown(const P: TPoint);
    procedure KeyDown(AKey: Integer);

    procedure StartOpenAnimation(ALevel: TUPopupLevel);
    procedure StartCloseAnimation(ALevel: TUPopupLevel);

    class function MouseHookProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall; static;
    class function KeyboardHookProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall; static;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function MeasureItems(const ParentItems: TMenuItem): Integer;
    function MeasureTextWidth(const AFont: TFont; const AText: String): Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // IUThemedComponent
    procedure UpdateTheme;
    function IsCustomThemed: Boolean;
    function CustomThemeManager: TUCustomThemeManager;

    procedure Popup(X, Y: Integer); override;
    procedure PopupAtPoint(P: TPoint); overload;
    procedure PopupAtMouse; overload;

    procedure ExtractPackedContent(Input: String; out Icon, Text, Detail: String);

    procedure ClosePopup;
  published
    property ThemeManager: TUThemeManager read FThemeManager write SetThemeManager;
    property IconFont: TFont read FIconFont write SetIconFont;
    property TextFont: TFont read FTextFont write SetTextFont;
    property DetailFont: TFont read FDetailFont write SetDetailFont;
    property AniSet: TIntAniSet read FAniSet write FAniSet;
    property OnItemClick: TIndexNotifyEvent read FOnItemClick write FOnItemClick;
    property ItemWidth: Integer read FItemWidth write FItemWidth default -1;
    property ItemHeight: Integer read FItemHeight write FItemHeight default 32;
    property TopSpace: Integer read FTopSpace write FTopSpace default 5;
    property ImageKind: TUImageKind read FImageKind write FImageKind default ikFontIcon;
    property CloseAnimation: Boolean read FCloseAnimation write FCloseAnimation default False;
  end;

implementation

uses
  SysUtils,
  Messages,
  UCL.Colors;

var
  GPopupMenu: TUPopupMenu = nil;

{ TUPopupLevel }

constructor TUPopupLevel.Create;
begin
  inherited Create;

  Menu := nil;
  Form := nil;
  ParentLevel := nil;
  ParentItem := nil;
  ParentIndex := -1;
  ChildLevel := nil;
  Items := TList.Create;
  ActiveIndex := -1;
  Closing := False;
end;

destructor TUPopupLevel.Destroy;
begin
  Items.Free;

  if Assigned(Form) then
    Form.Free;

  inherited;
end;

{ TUPopupMenu }

constructor TUPopupMenu.Create(AOwner: TComponent);
begin
  inherited;

  FThemeManager := nil;

  FIconFont := TFont.Create;
  FIconFont.Name := 'Segoe MDL2 Assets';
  FIconFont.Size := 12;
  FIconFont.OnChange := FontChange;

  FTextFont := TFont.Create;
  FTextFont.Name := 'Segoe UI';
  FTextFont.Size := 10;
  FTextFont.OnChange := FontChange;

  FDetailFont := TFont.Create;
  FDetailFont.Name := 'Segoe UI';
  FDetailFont.Size := 10;
  FDetailFont.OnChange := FontChange;

  BackColor := $E6E6E6;

  FItemWidth := -1;
  FItemHeight := 32;
  FTopSpace := 5;
  FImageKind := ikFontIcon;
  FCloseAnimation := False;

  FUpdating := False;

  FRootLevel := nil;

  FMouseHook := 0;
  FKeyboardHook := 0;
  FHookThreadID := 0;

  FOpening := False;
  FClosing := False;

  FAniSet := TIntAniSet.Create;
  FAniSet.QuickAssign(akOut, afkQuartic, 0, 120, 20);

  if GetCommonThemeManager <> nil then
    GetCommonThemeManager.Connect(Self);
end;

destructor TUPopupMenu.Destroy;
var
  TM: TUCustomThemeManager;
begin
  ClosePopup;

  RemoveHooks;

  if GPopupMenu = Self then
    GPopupMenu := nil;

  FIconFont.Free;
  FTextFont.Free;
  FDetailFont.Free;
  FAniSet.Free;

  TM := SelectThemeManager(Self);
  if TM <> nil then
    TM.Disconnect(Self);

  inherited;
end;

{ Theme }

procedure TUPopupMenu.SetThemeManager(const Value: TUThemeManager);
begin
  if (Value <> nil) and (FThemeManager = nil) then
    GetCommonThemeManager.Disconnect(Self);

  if (Value = nil) and (FThemeManager <> nil) then
    FThemeManager.Disconnect(Self);

  FThemeManager := Value;

  if FThemeManager <> nil then
    FThemeManager.Connect(Self);

  if FThemeManager = nil then
    GetCommonThemeManager.Connect(Self);

  UpdateTheme;
end;

procedure TUPopupMenu.SetIconFont(const Value: TFont);
begin
  FIconFont.Assign(Value);
end;

procedure TUPopupMenu.SetTextFont(const Value: TFont);
begin
  FTextFont.Assign(Value);
end;

procedure TUPopupMenu.SetDetailFont(const Value: TFont);
begin
  FDetailFont.Assign(Value);
end;

procedure TUPopupMenu.SetActiveIndex(ALevel: TUPopupLevel; AIndex: Integer);
var
  OldButton: TUSymbolButton;
  NewButton: TUSymbolButton;
begin
  if ALevel = nil then
    Exit;

  if AIndex < -1 then
    AIndex := -1;

  if AIndex >= ALevel.Items.Count then
    AIndex := ALevel.Items.Count - 1;

  if ALevel.ActiveIndex = AIndex then
    Exit;

  OldButton := GetButton(ALevel, ALevel.ActiveIndex);
  NewButton := GetButton(ALevel, AIndex);

  // Remove active state from old button
  if OldButton <> nil then begin
    // CHANGE THIS to whatever TUSymbolButton uses to display its highlighted/hovered state
    //   For example:
    //     OldButton.Active := False;
    //   or
    //     OldButton.Hovered := False;
    //   or call a method implemented by TUSymbolButton
    OldButton.ButtonState := csNone;
  end;

  ALevel.ActiveIndex := AIndex;

  // Apply active state to new button
  if NewButton <> nil then begin
    NewButton.ButtonState := csHover;
  end;
end;

procedure TUPopupMenu.FontChange(Sender: TObject);
begin
  UpdateTheme;
end;

procedure TUPopupMenu.UpdateTheme;
var
  TM: TUCustomThemeManager;
begin
  if FUpdating then
    Exit;

  TM := SelectThemeManager(Self);

  if TM.ThemeUsed = utLight then
    BackColor := $E6E6E6
  else
    BackColor := $1F1F1F;

  try
    FUpdating := True;

    IconFont.Color := GetTextColorFromBackground(BackColor);
    TextFont.Color := GetTextColorFromBackground(BackColor);
    DetailFont.Color := $808080;
  finally
    FUpdating := False;
  end;
end;

function TUPopupMenu.IsCustomThemed: Boolean;
begin
  Result := FThemeManager <> nil;
end;

function TUPopupMenu.CustomThemeManager: TUCustomThemeManager;
begin
  Result := FThemeManager;
end;

procedure TUPopupMenu.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FThemeManager) then begin
    ThemeManager := nil;
    Exit;
  end;

  inherited;
end;

{ Measurement }

function TUPopupMenu.MeasureItems(const ParentItems: TMenuItem): Integer;
var
  I: Integer;
  ItemCount: Integer;
  TextWidth: Integer;
  LItems: TMenuItem;
  MenuItem: TMenuItem;
  Icon: string;
  Text: string;
  Detail: string;
begin
  Result := 0;

  if ParentItems = Nil then
    LItems := Items
  else
    LItems := ParentItems;

  ItemCount := LItems.Count;

  for I := 0 to ItemCount - 1 do begin
    MenuItem := LItems[I];
    ExtractPackedContent(MenuItem.Caption, Icon, Text, Detail);
    TextWidth := MeasureTextWidth(FIconFont, Icon) + MeasureTextWidth(FTextFont, Text) + MeasureTextWidth(FDetailFont, Detail) + 60;
    // Leave additional room for a submenu arrow
    if MenuItem.Count > 0 then
      Inc(TextWidth, 18);

    if TextWidth > Result then
      Result := TextWidth;
  end;
end;

function TUPopupMenu.MeasureTextWidth(const AFont: TFont; const AText: String): Integer;
var
  DC: HDC;
  Canvas: TCanvas;
begin
  Result := 0;

  DC := GetDC(0);
  if DC = 0 then
    Exit;

  Canvas := TCanvas.Create;
  try
    Canvas.Handle := DC;
    Canvas.Font.Assign(AFont);

    Result := Canvas.TextWidth(AText);
  finally
    Canvas.Handle := 0;
    Canvas.Free;

    ReleaseDC(0, DC);
  end;
end;

{ Packed menu caption }

procedure TUPopupMenu.ExtractPackedContent(Input: String; out Icon, Text, Detail: String);
var
  SeparatorPos: Integer;
  StartPos: Integer;
begin
  Icon := '';
  Text := '';
  Detail := '';

  if Length(Input) = 0 then
    Exit;

  StartPos := 1;

  if Integer(Input[1]) > 127 then begin
    Icon := Input[1];
    StartPos := 2;
  end;

  Input := Copy(Input, StartPos, Length(Input) - (StartPos - 1));

  SeparatorPos := Pos('|', Input);
  if SeparatorPos = 0 then begin
    Text := Input;
    Detail := '';
  end
  else begin
    Text := Copy(Input, 1, SeparatorPos - 1);
    Detail := Copy( Input, SeparatorPos + 1, Length(Input) - SeparatorPos);
  end;
end;

{ Popup level creation }

function TUPopupMenu.CreateLevel(AParentLevel: TUPopupLevel; AParentItem: TMenuItem; AParentIndex: Integer; X, Y: Integer): TUPopupLevel;
var
  Form: TUForm;
  I: Integer;
  ItemCount: Integer;
  MenuItem: TMenuItem;
  UItem: TUSymbolButton;

  Icon: string;
  Text: string;
  Detail: string;

  DPI: Integer;
  Ratio: Single;

  TotalItemsHeight: Integer;
  Spacing: Integer;
  ItemW: Integer;
  ItemH: Integer;
begin
  Result := TUPopupLevel.Create;

  Result.Menu := Self;
  Result.ParentLevel := AParentLevel;
  Result.ParentItem := AParentItem;
  Result.ParentIndex := AParentIndex;

  // High DPI
  if Owner is TUForm then
    DPI := (Owner as TUForm).PPI
  else
    DPI := 96;

  Ratio := DPI / 96;

  Spacing := Round(TopSpace * Ratio);

  Form := TUPopupForm.CreateNew(Self);
  Result.Form := Form;

  Form.BorderStyle := bsToolWindow;
  Form.DoubleBuffered := True;
  Form.Color := BackColor;

  Form.Padding.Top := Spacing;
  Form.Padding.Bottom := Spacing;

  // Important:
  //   Calculate the width before creating the controls
  if ItemWidth = -1 then
    ItemW := Round(MeasureItems(AParentItem) * Ratio)
  else
    ItemW := Round(ItemWidth * Ratio);

  Form.ClientWidth := ItemW;

  // Start collapsed
  //   Controls may therefore initially have negative Top values when Align = alBottom. That is expected
  Form.ClientHeight := 0;

  if AParentLevel = nil then
    ItemCount := Items.Count
  else
    ItemCount := AParentItem.Count;

  TotalItemsHeight := 0;

  for I := 0 to ItemCount - 1 do begin
    if AParentLevel = nil then
      MenuItem := Items[I]
    else
      MenuItem := AParentItem.Items[I];

    UItem := TUSymbolButton.Create(Form);
    Result.Items.Add(UItem);

    UItem.Tag := I;
    UItem.Parent := Form;
    UItem.Left := 0;
    UItem.Width := Form.ClientWidth;
    UItem.Align := alBottom;

    UItem.Font.Assign(FTextFont);
    UItem.SymbolFont.Assign(FIconFont);
    UItem.DetailFont.Assign(FDetailFont);

    UItem.OnClick := PopupItem_OnClick;

    UItem.Hint := MenuItem.Hint;
    UItem.Images := Images;
    UItem.ImageIndex := MenuItem.ImageIndex;

    if MenuItem.Caption = '-' then begin
      UItem.SymbolChar := '';
      UItem.Text := '';
      UItem.Detail := '';
      UItem.ImageKind := ikFontIcon;
      UItem.ShowHint := False;
      UItem.Transparent := True;
      UItem.Enabled := False;
      //UItem.KeepOrginalColor := True;
      //UItem.Color := clWebPink;

      ItemH := ItemHeight div 2;
    end
    else begin
      ExtractPackedContent(MenuItem.Caption, Icon, Text, Detail);

      UItem.SymbolChar := Icon;
      UItem.Text := Text;
      UItem.Detail := Detail;
      UItem.ImageKind := ImageKind;
      UItem.ShowHint := True;
      UItem.Transparent := True;
      UItem.Enabled := MenuItem.Enabled;

      ItemH := ItemHeight;
    end;

    UItem.Height := ItemH;

    // Scale before assigning Align
    //   This avoids Align working with the pre-scaled height
    UItem.ScaleForPPI(DPI);
    UItem.Font.Height := MulDiv(UItem.Font.Height, DPI, 96);

    Inc(TotalItemsHeight, UItem.Height);
  end;

  Form.Left := X;
  Form.Top := Y;

  Form.Visible := True;

  Form.Realign;

  // Store the required final height temporarily
  //   We use the form's Tag here only during creation
  Form.Tag := TotalItemsHeight + 2 * Spacing;

  StartOpenAnimation(Result);
end;

{ Opening animation }

procedure TUPopupMenu.StartOpenAnimation(ALevel: TUPopupLevel);
var
  Form: TUForm;
  TargetHeight: Integer;
  Ani: TIntAni;
begin
  if ALevel = nil then
    Exit;

  Form := ALevel.Form;
  if Form = nil then
    Exit;

  TargetHeight := Form.Tag;
  Form.Tag := 0;
  FOpening := True;

  Ani := TIntAni.Create(0, TargetHeight,
    function (V: Integer): Boolean
    begin
      if not Assigned(Form) then begin
        Result := False;
        Exit;
      end;

      Form.ClientHeight := V;
      Form.Realign;

      Result := True;
    end,

    procedure
    begin
      FOpening := False;

      if Assigned(Form) then begin
        Form.ClientHeight := TargetHeight;
        Form.Realign;
      end;
    end
  );

  Ani.AniSet.Assign(Self.AniSet);
  Ani.Start;
end;

{ Close animation }

procedure TUPopupMenu.StartCloseAnimation(ALevel: TUPopupLevel);
var
  Form: TUForm;
  StartHeight: Integer;
  Ani: TIntAni;
begin
  if ALevel = nil then
    Exit;

  if ALevel.Closing then
    Exit;

  Form := ALevel.Form;
  if Form = nil then
    Exit;

  ALevel.Closing := True;
  StartHeight := Form.ClientHeight;

  if not CloseAnimation then begin
    Form.Close;
    Exit;
  end;

  FClosing := True;

  Ani := TIntAni.Create(StartHeight, 0,
    function (V: Integer): Boolean
    begin
      if Form = nil then begin
        Result := False;
        Exit;
      end;

      Form.ClientHeight := V;
      Form.Realign;

      Result := True;
    end,

    procedure
    begin
      FClosing := False;

      if Form <> nil then
        Form.Close;
    end
  );

  Ani.AniSet.Assign(Self.AniSet);
  Ani.Start;
end;

{ Level lookup }

// Since levels are created dynamically, the root level is sufficient for the actual hit testing below
//  // The hierarchy is small, so recursively search it using the item tree
//  function SearchLevel(ALevel: TUPopupLevel): TUPopupLevel;
//  var
//    I: Integer;
//    Candidate: TUPopupLevel;
//    Button: TUSymbolButton;
//  begin
//    Result := nil;
//
//    if ALevel = nil then
//      Exit;
//
//    if (ALevel.Form <> nil) and (ALevel.Form.Handle = AForm) then begin
//      Result := ALevel;
//      Exit;
//    end;
//
//    for I := 0 to ALevel.Items.Count - 1 do begin
//      Button := TUSymbolButton(ALevel.Items[I]);
//      if Button = nil then
//        Continue;
//
//      // Submenus are not directly stored on the button
//      //   Search them through the current hierarchy
//    end;
//  end;

function TUPopupMenu.FindLevelForForm(AForm: THandle): TUPopupLevel;
var
  Level: TUPopupLevel;
begin
  Result := nil;
  if FRootLevel = nil then
    Exit;

  // Walk the hierarchy
  Level := FRootLevel;
  while Level <> nil do begin
    if (Level.Form <> nil) and (Level.Form.Handle = AForm) then begin
      Result := Level;
      Exit;
    end;

    // Find a child level recursively
    Level := Level.ChildLevel;
  end;
end;

function TUPopupMenu.FindButtonFromWindow(AWnd: HWND): TUSymbolButton;
var
  C: TWinControl;
begin
  Result := nil;
  if AWnd = 0 then
    Exit;

  C := FindControl(AWnd);
  while C <> nil do begin
    if C is TUSymbolButton then begin
      Result := TUSymbolButton(C);
      Exit;
    end;

    C := C.Parent;
  end;
end;

function TUPopupMenu.FindLevelFromButton(AButton: TUSymbolButton): TUPopupLevel;

  function Search(ALevel: TUPopupLevel): TUPopupLevel;
  var
    I: Integer;
    Button: TUSymbolButton;
  begin
    Result := nil;
    if ALevel = nil then
      Exit;

    while ALevel <> Nil do begin
//      for I := 0 to ALevel.Items.Count - 1 do begin
//        Button := TUSymbolButton(ALevel.Items[I]);
//        if Button = AButton then begin
      I := ALevel.Items.IndexOf(AButton);
      if I > -1 then begin
        Result := ALevel;
        Exit;
      end;
      //
      ALevel := ALevel.ChildLevel;
    end;
  end;

begin
  Result := nil;
  if AButton = nil then
    Exit;

  if FRootLevel = nil then
    Exit;

  // The button's parent is the popup form
  //   Find the level recursively
  Result := Search(FRootLevel);
end;

{ Hit testing }

function TUPopupMenu.IsPointInsideLevel(ALevel: TUPopupLevel; const P: TPoint): Boolean;
begin
  Result := (ALevel <> nil) and (ALevel.Form <> nil) and PtInRect(ALevel.Form.BoundsRect, P);
end;

function TUPopupMenu.IsPointInsideHierarchy(const P: TPoint): Boolean;
var
  Level: TUPopupLevel;
begin
  Result := False;
  Level := FRootLevel;

  while Level <> nil do begin
    if IsPointInsideLevel(Level, P) then begin
      Result := True;
      Exit;
    end;

    Level := Level.ChildLevel;
  end;
end;

{ Submenu }

procedure TUPopupMenu.OpenSubMenu(AParentLevel: TUPopupLevel; AParentItem: TMenuItem; AParentIndex: Integer; AButton: TUSymbolButton);
var
  P: TPoint;
  NewLevel: TUPopupLevel;
  ExistingForm: TUForm;
begin
  if (AParentLevel = nil) or (AParentItem = nil) or (AButton = nil) then
    Exit;

  if AParentItem.Count = 0 then
    Exit;

  // Same submenu is already open
  if (AParentLevel.ChildLevel <> nil) and (AParentLevel.ChildLevel.ParentItem = AParentItem) then
    Exit;

  // Close previous sibling submenu
  if AParentLevel.ChildLevel <> nil then begin
    CloseLevel(AParentLevel.ChildLevel, False);
    AParentLevel.ChildLevel := nil;
  end;

  // Position submenu immediately to the right of the parent popup item
  P := AButton.ClientToScreen(Point(AButton.Width - 3, 0));

  // Close any existing deeper branch first
  //   The current implementation has one submenu level associated with each parent level
  //   Therefore the caller should close the old child before opening another one
  NewLevel := CreateLevel(AParentLevel, AParentItem, AParentIndex, P.X, P.Y);
  AParentLevel.ChildLevel := NewLevel;

  // First item becomes active when submenu is opened from the keyboard
  //   For mouse opening you may prefer -1 instead
  SetActiveIndex(NewLevel, -1);
end;

procedure TUPopupMenu.MoveActive(ALevel: TUPopupLevel; ADelta: Integer);
var
  Count: Integer;
  Index: Integer;
  StartIndex: Integer;
  MenuItem: TMenuItem;
begin
  if ALevel = nil then
    Exit;

  Count := ALevel.Items.Count;
  if Count = 0 then
    Exit;

  Index := ALevel.ActiveIndex;
  if Index < 0 then begin
    if ADelta > 0 then
      Index := 0
    else
      Index := Count - 1;

    SetActiveIndex(ALevel, Index);
    Exit;
  end;

  StartIndex := Index;
  repeat
    Inc(Index, ADelta);

    if Index < 0 then
      Index := Count - 1;

    if Index >= Count then
      Index := 0;

    MenuItem := GetMenuItem(ALevel, Index);

    // Skip separators
    if (MenuItem <> nil) and not MenuItem.IsLine then begin
      SetActiveIndex(ALevel, Index);
      Exit;
    end;
  until Index = StartIndex;
end;

procedure TUPopupMenu.ActivateCurrentItem(ALevel: TUPopupLevel);
var
  MenuItem: TMenuItem;
  Button: TUSymbolButton;
begin
  if ALevel = nil then
    Exit;
  if ALevel.ActiveIndex < 0 then
    Exit;

  MenuItem := GetMenuItem(ALevel, ALevel.ActiveIndex);
  Button := GetButton(ALevel, ALevel.ActiveIndex);

  if (MenuItem = nil) or (Button = nil) then
    Exit;

  if not MenuItem.Enabled then
    Exit;

  if MenuItem.Count > 0 then begin
    OpenSubMenu(ALevel, MenuItem, Button.Tag, Button);
    Exit;
  end;

  CloseAll(False);

  if Assigned(FOnItemClick) then
    FOnItemClick(Self, ALevel.ActiveIndex);
end;

function TUPopupMenu.GetDeepestLevel: TUPopupLevel;
begin
  Result := FRootLevel;

  while (Result <> nil) and (Result.ChildLevel <> nil) do
    Result := Result.ChildLevel;
end;

function TUPopupMenu.GetMenuItem(ALevel: TUPopupLevel; AIndex: Integer): TMenuItem;
begin
  Result := nil;
  if ALevel = nil then
    Exit;
  if AIndex < 0 then
    Exit;

  if ALevel.ParentLevel = nil then begin
    if AIndex < Items.Count then
      Result := Items[AIndex];
  end
  else begin
    if (ALevel.ParentItem <> nil) and (AIndex < ALevel.ParentItem.Count) then
      Result := ALevel.ParentItem.Items[AIndex];
  end;
end;

function TUPopupMenu.GetButton(ALevel: TUPopupLevel; AIndex: Integer): TUSymbolButton;
begin
  Result := nil;
  if ALevel = nil then
    Exit;

  if (AIndex >= 0) and (AIndex < ALevel.Items.Count) then
    Result := TUSymbolButton(ALevel.Items[AIndex]);
end;

{ Mouse handling }

procedure TUPopupMenu.MouseMove(const P: TPoint);
var
  Wnd: HWND;
  Button: TUSymbolButton;
  MenuItem: TMenuItem;
  Level: TUPopupLevel;
  Index: Integer;
begin
  if FRootLevel = nil then
    Exit;

  Wnd := WindowFromPoint(P);
  Button := FindButtonFromWindow(Wnd);
  if Button = nil then
    Exit;

  Level := FindLevelFromButton(Button);
  if Level = nil then
    Exit;

  Index := Button.Tag;
  SetActiveIndex(Level, Index);
  MenuItem := GetMenuItem(Level, Index);
  if MenuItem = nil then
    Exit;

  // The submenu is intentionally opened on hover
  //   A production version may add a hover delay here

  // Open submenu when hovering an item that owns one
  if MenuItem.Count > 0 then begin
    OpenSubMenu(Level, MenuItem, Button.Tag, Button);
  end
  else begin
    // Moving onto a normal item means that any deeper submenu belonging to the previous item should close
    if Level.ChildLevel <> nil then begin
      CloseLevel(Level.ChildLevel, False);
      Level.ChildLevel := nil;
    end;
  end;
end;

procedure TUPopupMenu.MouseButtonDown(const P: TPoint);
begin
  if not IsPointInsideHierarchy(P) then
    CloseAll(True);
end;

procedure TUPopupMenu.KeyDown(AKey: Integer);
var
  Level: TUPopupLevel;
begin
  Level := GetDeepestLevel;
  if Level = nil then
    Exit;

  case AKey of
    VK_ESCAPE: begin
      // ESC closes the deepest submenu first
      if Level.ParentLevel <> nil then
        CloseLevel(Level, True)
      else
        CloseAll(True);
    end;

    VK_UP   : MoveActive(Level, -1);
    VK_DOWN : MoveActive(Level, 1);
    VK_LEFT : begin
      if Level.ParentLevel <> nil then begin
        CloseLevel(Level, True);
        SetActiveIndex(Level.ParentLevel, Level.ParentIndex);
      end;
    end;
    VK_RIGHT: begin
      if Level.ActiveIndex >= 0 then
        ActivateCurrentItem(Level);
    end;
    VK_RETURN,
    VK_SPACE: ActivateCurrentItem(Level);
  end;
end;

{ Hooks }

procedure TUPopupMenu.InstallHooks;
begin
  if FMouseHook <> 0 then
    Exit;

  FHookThreadID := GetCurrentThreadId;

  GPopupMenu := Self;

  FMouseHook := SetWindowsHookEx(WH_MOUSE, @TUPopupMenu.MouseHookProc, 0, FHookThreadID);

  FKeyboardHook := SetWindowsHookEx(WH_KEYBOARD, @TUPopupMenu.KeyboardHookProc, 0, FHookThreadID);
end;

procedure TUPopupMenu.RemoveHooks;
begin
  if FMouseHook <> 0 then begin
    UnhookWindowsHookEx(FMouseHook);
    FMouseHook := 0;
  end;

  if FKeyboardHook <> 0 then begin
    UnhookWindowsHookEx(FKeyboardHook);
    FKeyboardHook := 0;
  end;

  FHookThreadID := 0;

  if GPopupMenu = Self then
    GPopupMenu := nil;
end;

class function TUPopupMenu.MouseHookProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  M: PMouseHookStruct;
begin
  Result := CallNextHookEx(0, nCode, wParam, lParam);
  if (nCode < 0) or (GPopupMenu = nil) then
    Exit;

  M := PMouseHookStruct(lParam);
  if M = nil then
    Exit;

  case wParam of
    WM_MOUSEMOVE: GPopupMenu.MouseMove(M^.pt);

    WM_LBUTTONDOWN,
    WM_RBUTTONDOWN,
    WM_MBUTTONDOWN: GPopupMenu.MouseButtonDown(M^.pt);
  end;
end;

class function TUPopupMenu.KeyboardHookProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT;
begin
  Result := CallNextHookEx(0, nCode, wParam, lParam);
  if (nCode < 0) or (GPopupMenu = nil) then
    Exit;

  // WH_KEYBOARD reports the virtual-key code in wParam
  // Do not swallow the key
  //   This is important because the parent application may still want to receive ESC

  // Only react to key-down events
  if (lParam and $80000000) <> 0 then
    Exit;

  case wParam of
    VK_ESCAPE,
    VK_UP,
    VK_DOWN,
    VK_LEFT,
    VK_RIGHT,
    VK_RETURN,
    VK_SPACE: GPopupMenu.KeyDown(wParam);
  end;
end;

{ Closing }

procedure TUPopupMenu.CloseLevel(ALevel: TUPopupLevel; AAnimate: Boolean);
begin
  if ALevel = nil then
    Exit;

  StartCloseAnimation(ALevel);
end;

procedure TUPopupMenu.CloseFromLevel(ALevel: TUPopupLevel; AAnimate: Boolean);
begin
  // The hierarchy can be extended here if desired
  //   For the current implementation the root is closed as a complete popup tree
  CloseAll(AAnimate);
end;

procedure TUPopupMenu.CloseAll(AAnimate: Boolean);
begin
  if FRootLevel = nil then
    Exit;

  RemoveHooks;

  if FRootLevel.Form <> nil then begin
    if AAnimate and CloseAnimation then
      StartCloseAnimation(FRootLevel)
    else
      FRootLevel.Form.Close;
  end;

  FRootLevel := nil;
end;

procedure TUPopupMenu.ClosePopup;
begin
  CloseAll(False);
end;

{ Item click }

procedure TUPopupMenu.PopupItem_OnClick(Sender: TObject);
var
  Button: TUSymbolButton;
  Level: TUPopupLevel;
  Index: Integer;
  MenuItem: TMenuItem;
begin
  if not (Sender is TUSymbolButton) then
    Exit;

  Button := TUSymbolButton(Sender);
  Level := FindLevelFromButton(Button);
  if Level = nil then
    Exit;

  Index := Button.Tag;

  if Level.ParentLevel = nil then
    MenuItem := Items[Index]
  else
    MenuItem := Level.ParentItem.Items[Index];

  // If the item has children, clicking it opens the submenu rather than executing the item
  if MenuItem.Count > 0 then begin
    OpenSubMenu(Level, MenuItem, Button.Tag, Button);
    Exit;
  end;

  // Close the entire hierarchy before notifying the owner
  CloseAll(False);
  if Assigned(FOnItemClick) then
    FOnItemClick(Self, Index);
end;

{ Popup }

procedure TUPopupMenu.Popup(X, Y: Integer);
begin
  ClosePopup;

  DoPopup(Self);

  if Items.Count = 0 then
    Exit;

  FRootLevel := CreateLevel(nil, nil, -1, X, Y);
  InstallHooks;
end;

procedure TUPopupMenu.PopupAtPoint(P: TPoint);
begin
  Popup(P.X, P.Y);
end;

procedure TUPopupMenu.PopupAtMouse;
begin
  Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

end.
