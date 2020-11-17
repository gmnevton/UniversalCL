unit UCL.Classes;

interface

{$IF CompilerVersion > 29}
  {$LEGACYIFEND ON}
{$IFEND}

uses
  SysUtils,
  Classes,
  Controls,
  StdCtrls,
  Forms,
  UCL.ThemeManager;

type
  TUCustomControl = class(TCustomControl, IUThemedComponent)
  protected
    FThemeManager: TUThemeManager;
    procedure SetThemeManager(const Value: TUThemeManager); virtual;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    // IUThemedComponent
    procedure UpdateTheme; virtual;
    function IsCustomThemed: Boolean; virtual;
    function CustomThemeManager: TUCustomThemeManager; virtual;

  published
    property ThemeManager: TUThemeManager read FThemeManager write SetThemeManager;
    //
    property Align;
    property Anchors;
    property AutoSize;
    property BiDiMode;
    //property Caption;
    //property Color;
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

  TUGraphicControl = class(TGraphicControl, IUThemedComponent)
  protected
    FThemeManager: TUThemeManager;
    procedure SetThemeManager(const Value: TUThemeManager); virtual;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    // IUThemedComponent
    procedure UpdateTheme; virtual;
    function IsCustomThemed: Boolean; virtual;
    function CustomThemeManager: TUCustomThemeManager; virtual;

  published
    property ThemeManager: TUThemeManager read FThemeManager write SetThemeManager;
    //
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

  TUCustomEdit = class(TCustomEdit, IUThemedComponent)
//  private
//    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
//    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
  public
    // IUThemedComponent
    procedure UpdateTheme; virtual; abstract;
    function IsCustomThemed: Boolean; virtual;
    function CustomThemeManager: TUCustomThemeManager; virtual;

  published
    // Chenged properties
    property Align default alNone;
    property AutoSize default False;
    property BorderStyle default bsNone;
    property BevelKind default bkFlat;
    property Ctl3D default False;
    property ParentColor default True;
    property ParentFont default True;
    property Height default 30;
    //
    property Alignment;
    property Anchors;
    property AutoSelect;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property CharCase;
    property Color;
    property Constraints;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font stored False;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property NumbersOnly;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property PasswordChar;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property TextHint;
    property Touch;
    property Visible;
    property StyleElements;
    //
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

{ TUCustomControl }

constructor TUCustomControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FThemeManager := Nil;
  //
  if GetCommonThemeManager <> Nil then
    GetCommonThemeManager.Connect(Self);
end;

destructor TUCustomControl.Destroy;
var
  TM: TUCustomThemeManager;
begin
  TM:=SelectThemeManager(Self);
  TM.Disconnect(Self);
  inherited;
end;

procedure TUCustomControl.SetThemeManager(const Value: TUThemeManager);
begin
  if (Value <> Nil) and (FThemeManager = Nil) then
    GetCommonThemeManager.Disconnect(Self);

  if (Value = Nil) and (FThemeManager <> Nil) then
    FThemeManager.Disconnect(Self);

  FThemeManager := Value;

  if FThemeManager <> Nil then
    FThemeManager.Connect(Self)
  else
    GetCommonThemeManager.Connect(Self);

  UpdateTheme;
end;

procedure TUCustomControl.UpdateTheme;
begin
// nothing here
end;

function TUCustomControl.IsCustomThemed: Boolean;
begin
  Result:=(FThemeManager <> Nil);
end;

function TUCustomControl.CustomThemeManager: TUCustomThemeManager;
begin
  Result:=FThemeManager;
end;

end.
