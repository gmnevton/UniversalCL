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
  TIndexNotifyEvent = procedure (Sender: TObject; Index: Integer) of object;

  TUPopupMenu = class(TPopupMenu, IUThemedComponent)
  private var
    BackColor: TColor;

  private
    FThemeManager: TUThemeManager;
    FAniSet: TIntAniSet;
    FOnItemClick: TIndexNotifyEvent;

    FItemWidth: Integer;
    FItemHeight: Integer;
    FTopSpace: Integer;
    FImageKind: TUImageKind;
    FCloseAnimation: Boolean;

    procedure SetThemeManager(const Value: TUThemeManager);

    procedure PopupForm_OnDeactivate(Sender: TObject);
    procedure PopupItem_OnClick(Sender: TObject);

  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    // IUThemedComponent
    procedure UpdateTheme;
    function IsCustomThemed: Boolean;
    function CustomThemeManager: TUCustomThemeManager;

    procedure Popup(X, Y: Integer); override;
    procedure PopupAtPoint(P: TPoint); overload;
    procedure PopupAtMouse; overload;

    procedure ExtractPackedContent(Input: string; out Icon, Text, Detail: string);

  published
    property ThemeManager: TUThemeManager read FThemeManager write SetThemeManager;
    property AniSet: TIntAniSet read FAniSet write FAniSet;
    property OnItemClick: TIndexNotifyEvent read FOnItemClick write FOnItemClick;

    property ItemWidth: Integer read FItemWidth write FItemWidth default 200;
    property ItemHeight: Integer read FItemHeight write FItemHeight default 32;
    property TopSpace: Integer read FTopSpace write FTopSpace default 5;
    property ImageKind: TUImageKind read FImageKind write FImageKind default ikFontIcon;
    property CloseAnimation: Boolean read FCloseAnimation write FCloseAnimation default false;
  end;

implementation

uses
  UCL.Colors;

{ TUPopupMenu }

//  MAIN CLASS

constructor TUPopupMenu.Create(aOwner: TComponent);
begin
  inherited;
  FThemeManager := Nil;

  BackColor := $E6E6E6;

  FItemWidth := 200;
  FItemHeight := 32;
  FTopSpace := 5;
  FImageKind := ikFontIcon;
  FCloseAnimation := false;

  FAniSet := TIntAniSet.Create;
  FAniSet.QuickAssign(akOut, afkQuartic, 0, 120, 20);

  if GetCommonThemeManager <> Nil then
    GetCommonThemeManager.Connect(Self);
end;

destructor TUPopupMenu.Destroy;
var
  TM: TUCustomThemeManager;
begin
  FAniSet.Free;
  TM:=SelectThemeManager(Self);
  TM.Disconnect(Self);
  inherited;
end;

{ Other }

procedure TUPopupMenu.PopupForm_OnDeactivate(Sender: TObject);
var
  Form: TUForm;
  Ani: TIntAni;
begin
  if not ((Sender <> Nil) and (Sender is TForm)) then
    Exit;

  Form := (Sender as TUForm);

  if not CloseAnimation then begin
    Form.Free;
    Exit;
  end;

  Ani := TIntAni.Create(Form.ClientHeight, -Form.ClientHeight,
    procedure (Value: Integer)
    begin
      Form.Height := Value;
    end,
    procedure
    begin
      Form.Close;
    end);
  Ani.AniSet.Assign(Self.AniSet);
  Ani.Start;
end;

procedure TUPopupMenu.PopupItem_OnClick(Sender: TObject);
begin
  if (Sender is TUSymbolButton) and Assigned(FOnItemClick) then
    FOnItemClick(Self, (Sender as TUSymbolButton).Tag);
end;

//  THEME

procedure TUPopupMenu.SetThemeManager(const Value: TUThemeManager);
begin
  if (Value <> Nil) and (FThemeManager = Nil) then
    GetCommonThemeManager.Disconnect(Self);

  if (Value = Nil) and (FThemeManager <> Nil) then
    FThemeManager.Disconnect(Self);

  FThemeManager := Value;

  if FThemeManager <> Nil then
    FThemeManager.Connect(Self);

  if FThemeManager = Nil then
    GetCommonThemeManager.Connect(Self);

  UpdateTheme;
end;

procedure TUPopupMenu.UpdateTheme;
var
  TM: TUCustomThemeManager;
begin
  TM:=SelectThemeManager(Self);
  if TM.ThemeUsed = utLight then
    BackColor := $E6E6E6
  else
    BackColor := $1F1F1F;
end;

function TUPopupMenu.IsCustomThemed: Boolean;
begin
  Result:=(FThemeManager <> Nil);
end;

function TUPopupMenu.CustomThemeManager: TUCustomThemeManager;
begin
  Result:=FThemeManager;
end;

procedure TUPopupMenu.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FThemeManager) then begin
    ThemeManager:=Nil;
    Exit;
  end;
  inherited Notification(AComponent, Operation);
end;

//  UTILS

procedure TUPopupMenu.ExtractPackedContent(Input: string; out Icon, Text, Detail: string);
var
  SeparatorPos: Integer;
begin
  if Length(Input) = 0 then begin
    Icon := '';
    Text := '';
    Detail := '';
  end
  else begin
    Icon := Input[1];
    Input := Copy(Input, 2, Length(Input) - 1);
    SeparatorPos := Pos('|', Input);
    if SeparatorPos = 0 then begin
      Text := Input;
      Detail := '';
    end
    else begin
      Text := Copy(Input, 1, SeparatorPos - 1);
      Detail := Copy(Input, SeparatorPos + 1, Length(Input) - SeparatorPos);
    end;
  end;
end;

procedure TUPopupMenu.Popup(X, Y: Integer);
var
  Form: TUForm;
  i, ItemCount: Integer;
  MenuItem: TMenuItem;
  UItem: TUSymbolButton;
  Icon, Text, Detail: string;
  Ani: TIntAni;

  DPI: Integer;
  Ratio: Single;
  TotalItemsHeight: Integer;
  Spacing: Integer;
  ItemW: Integer;
begin
  //  High DPI
  if Owner is TUForm then
    DPI := (Owner as TUForm).PPI
  else
    DPI := 96;
  Ratio := DPI / 96;

  //  Getting something
  ItemCount := Self.Items.Count;
  if ItemCount = 0 then
    Exit;

  Spacing := Round(TopSpace * Ratio);
  ItemW := Round(ItemWidth * Ratio);

  //  Create popup form
  Form := TUForm.CreateNew(Self);
  Form.OnDeactivate := PopupForm_OnDeactivate;

  Form.DoubleBuffered := true;
  Form.BorderStyle := bsToolWindow;
  Form.Color := BackColor;

  Form.Padding.Bottom := Spacing;
  Form.ClientWidth := ItemW;
  Form.ClientHeight := 0;

    //  Build items
  TotalItemsHeight := 0;
  for i := 0 to ItemCount - 1 do begin
    MenuItem := Self.Items[i];

    UItem := TUSymbolButton.Create(Form);
    UItem.Tag := i;
    UItem.Parent := Form;
    UItem.ParentFont := True;
    UItem.Enabled := MenuItem.Enabled;
    //UItem.ThemeManager := Self.ThemeManager;
    UItem.OnClick := PopupItem_OnClick;

    UItem.Hint := MenuItem.Hint;
    UItem.Images := Self.Images;
    UItem.ImageIndex := MenuItem.ImageIndex;

    ExtractPackedContent(MenuItem.Caption, Icon, Text, Detail);
    UItem.SymbolChar := Icon;
    UItem.Text := Text;
    UItem.Detail := Detail;
    UItem.ImageKind := Self.ImageKind;

    UItem.Align := alBottom;
    UItem.Width := ItemWidth;
    UItem.Height := ItemHeight;
    UItem.ShowHint := true;

    //  Scale item
    UItem.ScaleForPPI(DPI);
    UItem.Font.Height := MulDiv(UItem.Font.Height, DPI, 96);  //  Scaling for text font

    //  Increase total items height
    Inc(TotalItemsHeight, UItem.Height);
  end;

  //  Set popup position (after show)
//  ShowWindow(Form.Handle, SW_SHOWNOACTIVATE);
  Form.Left := X;
  Form.Top := Y;
  Form.Visible := true;

  //  Animation
  Ani := TIntAni.Create(0, TotalItemsHeight + 2 * Spacing,
    procedure (Value: Integer)
    begin
      Form.ClientHeight := Value;
    end, nil);
  Ani.AniSet.Assign(Self.AniSet);
  Ani.Start;
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
