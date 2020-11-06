unit UCL.Edit;

interface

{$IF CompilerVersion > 29}
  {$LEGACYIFEND ON}
{$IFEND}

uses
  SysUtils,
  Classes,
  Windows,
  Messages,
  Controls,
  StdCtrls,
  ExtCtrls,
  Graphics,
  Forms,
  UCL.Classes,
  UCL.Types,
  UCL.Colors,
  UCL.ThemeManager,
  UCL.Utils;

const
  UM_SUBEDIT_SETFOCUS = WM_USER + 1;
  UM_SUBEDIT_KILLFOCUS = WM_USER + 2;

type
  TUSubEdit = class(TCustomEdit)
  private
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;

  published
    property Align default alClient;
    property BorderStyle default bsNone;
    property AutoSize default true;
    property ParentColor default true;
    property ParentFont default true;
    property Height default 20;

    property Alignment;
    property CharCase;
    property Enabled;
    property Font stored false;
    property MaxLength;
    property NumbersOnly;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property Text;
    property TextHint;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

  TUEdit = class(TPanel, IUThemedComponent)
//  private const
//    DefBorderColor: TDefColor = (
//      ($999999, $666666, $D77800, $CCCCCC, $D77800),
//      ($666666, $999999, $D77800, $CCCCCC, $D77800));

  private var
    BorderThickness: Integer;
    Border_Color: TColor;
    BackColor: TColor;
    TextColor: TColor;

  private
    FThemeManager: TUThemeManager;
    FBorderColor: TUThemeControlWithFocusColorSet;
    //FEditColor: TUThemeControlWithFocusColorSet;
    FControlState: TUControlState;
    FEdit: TUSubEdit;

    FTransparent: Boolean;

    //  Internal
    procedure UpdateColors;

    //  Setters
    procedure SetThemeManager(const Value: TUThemeManager);
    procedure SetControlState(const Value: TUControlState);
    procedure SetTransparent(const Value: Boolean);

    //  Child events
    procedure BorderColor_OnChange(Sender: TObject);

    //  Messages
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;

    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;

    procedure UMSubEditSetFocus(var Msg: TMessage); message UM_SUBEDIT_SETFOCUS;
    procedure UMSubEditKillFocus(var Msg: TMessage); message UM_SUBEDIT_KILLFOCUS;

  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND}); override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    // IUThemedComponent
    procedure UpdateTheme;
    function IsCustomThemed: Boolean;
    function CustomThemeManager: TUCustomThemeManager;

  published
    property ThemeManager: TUThemeManager read FThemeManager write SetThemeManager;
    property BorderColor: TUThemeControlWithFocusColorSet read FBorderColor write FBorderColor;
    property Edit: TUSubEdit read FEdit write FEdit;
    property ControlState: TUControlState read FControlState write SetControlState default csNone;

    property Transparent: Boolean read FTransparent write SetTransparent default false;

    property Padding stored false;
    property Alignment default taLeftJustify;
    property ShowCaption default false;
    property BevelOuter default bvNone;
    property Height default 29;
  end;

implementation

{ TUSubEdit }

//  MESSAGES

procedure TUSubEdit.WMSetFocus(var Msg: TWMSetFocus);
begin
  PostMessage(Parent.Handle, UM_SUBEDIT_SETFOCUS, 0, 0);
  inherited;
end;

procedure TUSubEdit.WMKillFocus(var Msg: TWMKillFocus);
begin
  PostMessage(Parent.Handle, UM_SUBEDIT_KILLFOCUS, 0, 0);
  inherited;
end;

{ TUEdit }

//  MAIN CLASS

constructor TUEdit.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FThemeManager := Nil;

  BorderThickness := 2;

  FControlState := csNone;
  FTransparent := False;

  Alignment := taLeftJustify;
  ShowCaption := False;
  Height := 29;
  BevelOuter := bvNone;
  Caption := '';
  Padding.SetBounds(5, 5, 4, 4);
//  Font.Name := 'Segoe UI';
//  Font.Size := 10;

  FEdit := TUSubEdit.Create(Self);
  FEdit.Parent := Self;
  FEdit.ParentFont := True;
  FEdit.Name := 'SubEdit';
  FEdit.Text := '';
  FEdit.BorderStyle := bsNone;
  FEdit.AutoSize := True;
  FEdit.ParentColor := True;
  FEdit.Height := 20;

  FEdit.Align := alClient;
  FEdit.SetSubComponent(True);

  FBorderColor := TUThemeControlWithFocusColorSet.Create;
  FBorderColor.Assign(EDIT_BORDER);
  FBorderColor.OnChange := BorderColor_OnChange;

  if GetCommonThemeManager <> Nil then
    GetCommonThemeManager.Connect(Self);
end;

procedure TUEdit.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  UpdateColors;
end;

destructor TUEdit.Destroy;
var
  TM: TUCustomThemeManager;
begin
  FBorderColor.Free;
  TM:=SelectThemeManager(Self);
  TM.Disconnect(Self);
  inherited;
end;

//  THEME

procedure TUEdit.SetThemeManager; // (const Value: TUThemeManager);
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

procedure TUEdit.UpdateTheme;
begin
  UpdateColors;
  Repaint;
end;

function TUEdit.IsCustomThemed: Boolean;
begin
  Result:=(FThemeManager <> Nil);
end;

function TUEdit.CustomThemeManager: TUCustomThemeManager;
begin
  Result:=FThemeManager;
end;

procedure TUEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FThemeManager) then begin
    ThemeManager:=Nil;
    Exit;
  end;
  inherited Notification(AComponent, Operation);
end;

//  INTERNAL

procedure TUEdit.UpdateColors;
var
  TM: TUCustomThemeManager;
  ColorSet: TUThemeControlWithFocusColorSet;
begin
  TM:=SelectThemeManager(Self);
  case ControlState of
    csPress, csFocused: begin
      ColorSet := BorderColor;
      if BorderColor.Enabled then
        Border_Color := BorderColor.Color
      else
        Border_Color := ColorSet.GetColor(TM, Focused);
    end
  else
    Border_Color := EDIT_BORDER.GetColor(TM, Focused);
  end;

  if (TM.ThemeUsed = utLight) or (ControlState in [csPress, csFocused]) then
    BackColor := $FFFFFF
  else
    BackColor := $000000;

  //  Transparent edit
  if Transparent and (ControlState = csNone) then begin
    ParentColor := True;
    BackColor := Color;
  end;

  //  Text color
  TextColor := GetTextColorFromBackground(BackColor);

  //  Disabled edit
  if ControlState = csDisabled then begin
    BackColor := $CCCCCC;
    Border_Color := $CCCCCC;
    TextColor := clGray;
  end;
end;

//  SETTERS

procedure TUEdit.SetControlState(const Value: TUControlState);
begin
  if Value <> FControlState then begin
    FControlState := Value;
    UpdateColors;
    Repaint;
  end;
end;

procedure TUEdit.SetTransparent(const Value: Boolean);
begin
  if Value <> FTransparent then begin
    FTransparent := Value;
    UpdateColors;
    Repaint;
  end;
end;

procedure TUEdit.BorderColor_OnChange(Sender: TObject);
begin
  UpdateTheme;
end;

//  CUSTOM METHODS

procedure TUEdit.Paint;
var
  Space: Integer;
begin
  inherited;

  //  Paint border
  Canvas.Brush.Handle := CreateSolidBrushWithAlpha(Border_Color, 255);
  Canvas.FillRect(Rect(0, 0, Width, Height));

  //  Paint background
  Canvas.Brush.Handle := CreateSolidBrushWithAlpha(BackColor, 255);
  Canvas.FillRect(Rect(BorderThickness, BorderThickness, Width - BorderThickness, Height - BorderThickness));

  //  Fit subedit
  Space := (Height - FEdit.Height) div 2;
  Padding.Top := Space + 1;
  Padding.Left := Space + 1;
  Padding.Bottom := Space;
  Padding.Right := Space;

  //  Subedit color
  FEdit.Color := BackColor;
  FEdit.Font.Color := TextColor;
end;

procedure TUEdit.ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND});
begin
  inherited;
  BorderThickness := MulDiv(BorderThickness, M, D);
end;

//  MESSAGES

procedure TUEdit.WMLButtonDown(var Msg: TWMLButtonDown);
begin
  if Enabled then begin
    FEdit.SetFocus;
    ControlState := csPress;
    inherited;
  end;
end;

procedure TUEdit.WMLButtonUp(var Msg: TWMLButtonUp);
begin
  if Enabled then begin
    if Focused or FEdit.Focused then
      ControlState := csFocused
    else
      ControlState := csNone;
    inherited;
  end;
end;

procedure TUEdit.WMSetFocus(var Msg: TWMSetFocus);
begin
  if Enabled then begin
    ControlState := csFocused;
    inherited;
    FEdit.SetFocus;
  end;
end;

procedure TUEdit.WMKillFocus(var Msg: TWMKillFocus);
begin
  if Enabled then begin
    ControlState := csNone;
    inherited;
  end;
end;

procedure TUEdit.UMSubEditSetFocus(var Msg: TMessage);
begin
  if Enabled then
    ControlState := csFocused;
end;

procedure TUEdit.UMSubEditKillFocus(var Msg: TMessage);
begin
  if Enabled then
    ControlState := csNone;
end;

procedure TUEdit.CMMouseEnter(var Msg: TMessage);
begin
  if Enabled then begin
    if Focused or FEdit.Focused then
      ControlState := csFocused
    else
      ControlState := csHover;
    inherited;
  end;
end;

procedure TUEdit.CMMouseLeave(var Msg: TMessage);
begin
  if Enabled then begin
    if (Focused) or (FEdit.Focused) then
      ControlState := csFocused
    else
      ControlState := csNone;
    inherited;
  end;
end;

procedure TUEdit.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;
  if not Enabled then
    FControlState := csDisabled
  else
    FControlState := csNone;
  FEdit.Enabled := Enabled;
  UpdateTheme;
end;

end.
