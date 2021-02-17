unit UCL.Classes;

interface

{$IF CompilerVersion > 29}
  {$LEGACYIFEND ON}
{$IFEND}

uses
  SysUtils,
  Messages,
  Classes,
  Controls,
  StdCtrls,
  ExtCtrls,
  Forms,
  UCL.ThemeManager;

type
  IUIDEAware = interface ['{5DA6292C-87B7-4434-93CD-BFDF4852DA4B}']
    function IsCreating: Boolean;
    function IsDestroying: Boolean;
    function IsLoading: Boolean;
    function IsDesigning: Boolean;
  end;
(*
  IUDragReorderControl = interface ['{B9828BC2-CA4A-437E-866C-CBB5015F1412}']
    function GetDragFloating: Boolean;
    procedure StoreAlign;
    procedure StorePosition;
    procedure DragFloat(X, Y: Integer);
    procedure RestoreAlign;
    procedure RestorePosition;
    property DragFloating: Boolean read GetDragFloating;
  end;
*)
  TUCustomControl = class(TCustomControl, IUThemedComponent, IUIDEAware)
  protected
    FThemeManager: TUThemeManager;
    mulScale: Integer;
  {$IF CompilerVersion < 30}
    FCurrentPPI: Integer;
    FIsScaling: Boolean;
    //
    function GetDesignDpi: Integer; virtual;
    function GetParentCurrentDpi: Integer; virtual;
  {$IFEND}
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND}); override;
    procedure DoChangeScale(M, D: Integer); virtual;
    procedure UpdateScale(var Scale: Integer; M, D: Integer); virtual;
    //
    procedure SetThemeManager(const Value: TUThemeManager); virtual;
    // IUThemedComponent
    procedure UpdateTheme; virtual;
    function IsCustomThemed: Boolean; virtual;
    function CustomThemeManager: TUCustomThemeManager; virtual;
    // IUIDEAware
    function IsCreating: Boolean; inline;
    function IsDestroying: Boolean; inline;
    function IsLoading: Boolean; inline;
    function IsDesigning: Boolean; inline;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //
    procedure AfterConstruction; override;
  {$IF CompilerVersion < 30}
    procedure ScaleForPPI(NewPPI: Integer); virtual;
  {$IFEND}
    //
    property OnStartDock;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    //
    property OnStartDrag;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;

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
    property TabOrder;
    property TabStop;
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
    property OnGesture;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
  end;

  TUGraphicControl = class(TGraphicControl, IUThemedComponent, IUIDEAware)
  private
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;

  protected
    FThemeManager: TUThemeManager;
  {$IF CompilerVersion < 30}
    FCurrentPPI: Integer;
    FIsScaling: Boolean;
    //
    function GetDesignDpi: Integer; virtual;
    function GetParentCurrentDpi: Integer; virtual;
  {$IFEND}
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND}); override;
    procedure DoChangeScale(M, D: Integer); virtual;
    //
    procedure SetThemeManager(const Value: TUThemeManager); virtual;
    // IUThemedComponent
    procedure UpdateTheme; virtual;
    function IsCustomThemed: Boolean; virtual;
    function CustomThemeManager: TUCustomThemeManager; virtual;
    // IUIDEAware
    function IsCreating: Boolean; inline;
    function IsDestroying: Boolean; inline;
    function IsLoading: Boolean; inline;
    function IsDesigning: Boolean; inline;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //
    procedure AfterConstruction; override;
  {$IF CompilerVersion < 30}
    procedure ScaleForPPI(NewPPI: Integer); virtual;
  {$IFEND}
    //
    property OnStartDock;
    //property OnDockDrop;
    //property OnDockOver;
    property OnEndDock;
    //
    property OnStartDrag;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;

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
    property OnGesture;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
  end;

//  TUCustomCheckBox = class(TCustomCheckBox, IUThemedComponent)
//
//  end;

  TUCustomEdit = class(TCustomEdit, IUThemedComponent, IUIDEAware)
  protected
    FThemeManager: TUThemeManager;
  {$IF CompilerVersion < 30}
    FCurrentPPI: Integer;
    FIsScaling: Boolean;
    //
    function GetDesignDpi: Integer; virtual;
    function GetParentCurrentDpi: Integer; virtual;
  {$IFEND}
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND}); override;
    procedure DoChangeScale(M, D: Integer); virtual;
    //
    procedure SetThemeManager(const Value: TUThemeManager); virtual;
    // IUThemedComponent
    procedure UpdateTheme; virtual;
    function IsCustomThemed: Boolean; virtual;
    function CustomThemeManager: TUCustomThemeManager; virtual;
    // IUIDEAware
    function IsCreating: Boolean; inline;
    function IsDestroying: Boolean; inline;
    function IsLoading: Boolean; inline;
    function IsDesigning: Boolean; inline;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //
    procedure AfterConstruction; override;
  {$IF CompilerVersion < 30}
    procedure ScaleForPPI(NewPPI: Integer); virtual;
  {$IFEND}
    //
    property OnStartDock;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    //
    property OnStartDrag;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;

  published
    property ThemeManager: TUThemeManager read FThemeManager write SetThemeManager;
    //
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
  end;

  TUCustomPanel = class(TCustomPanel, IUThemedComponent, IUIDEAware)
  private
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;

  protected
    FThemeManager: TUThemeManager;
  {$IF CompilerVersion < 30}
    FCurrentPPI: Integer;
    FIsScaling: Boolean;
    //
    function GetDesignDpi: Integer; virtual;
    function GetParentCurrentDpi: Integer; virtual;
  {$IFEND}
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND}); override;
    procedure DoChangeScale(M, D: Integer); virtual;
    //
    procedure SetThemeManager(const Value: TUThemeManager); virtual;
    // IUThemedComponent
    procedure UpdateTheme; virtual;
    function IsCustomThemed: Boolean; virtual;
    function CustomThemeManager: TUCustomThemeManager; virtual;
    // IUIDEAware
    function IsCreating: Boolean; inline;
    function IsDestroying: Boolean; inline;
    function IsLoading: Boolean; inline;
    function IsDesigning: Boolean; inline;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //
    procedure AfterConstruction; override;
  {$IF CompilerVersion < 30}
    procedure ScaleForPPI(NewPPI: Integer); virtual;
  {$IFEND}
    //
    property Color;
    //
    property OnStartDock;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    //
    property OnStartDrag;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;

  published
    property ThemeManager: TUThemeManager read FThemeManager write SetThemeManager;
    //
    property Align;
    property Alignment;
    property Anchors;
    property Caption;
    property Constraints;
    property DoubleBuffered;
    property Enabled;
    property FullRepaint;
    property Font;
    property Padding;
    property ParentBackground;
    property ParentColor;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowCaption;
    property TabOrder;
    property TabStop;
    property VerticalAlignment;
    property Visible;
    //
    property OnAlignInsertBefore;
    property OnAlignPosition;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnGetSiteInfo;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
//    property OnUnDock;
  end;

implementation

{ TUCustomControl }

constructor TUCustomControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FThemeManager := Nil;
  mulScale := 1;
end;

destructor TUCustomControl.Destroy;
var
  TM: TUCustomThemeManager;
begin
  TM:=SelectThemeManager(Self);
  TM.Disconnect(Self);
  inherited;
end;

procedure TUCustomControl.AfterConstruction;
begin
  inherited;
  if GetCommonThemeManager <> Nil then
    GetCommonThemeManager.Connect(Self);
end;

function TUCustomControl.IsCreating: Boolean;
begin
  Result := (csCreating in ControlState);
end;

function TUCustomControl.IsDestroying: Boolean;
begin
  Result := (csDestroying in ComponentState);
end;

function TUCustomControl.IsLoading: Boolean;
begin
  Result := (csLoading in ComponentState);
end;

function TUCustomControl.IsDesigning: Boolean;
begin
  Result := (csDesigning in ComponentState);
end;

procedure TUCustomControl.UpdateScale(var Scale: Integer; M, D: Integer);
begin
  if M > D then // up size
    Inc(Scale, (M - D) div 24)
  else // down size
    Dec(Scale, (D - M) div 24);
end;

{$REGION 'Compatibility with older Delphi'}
{$IF CompilerVersion < 30}
function TUCustomControl.GetDesignDpi: Integer;
var
  LForm: TCustomForm;
begin
  LForm := GetParentForm(Self);

  if (LForm <> Nil) and (LForm is TForm) then
    Result := TForm(LForm).PixelsPerInch
  else
    Result := Windows.USER_DEFAULT_SCREEN_DPI;
end;

function TUCustomControl.GetParentCurrentDpi: Integer;
begin
//  if Parent <> nil then
//    Result := Parent.GetParentCurrentDpi
//  else
    Result := FCurrentPPI;
end;

procedure TUCustomControl.ScaleForPPI(NewPPI: Integer);
begin
  if not FIsScaling and (NewPPI > 0) then begin
    FIsScaling := True;
    try
      if FCurrentPPI = 0 then
        FCurrentPPI := GetDesignDpi;

      if NewPPI <> FCurrentPPI then begin
        ChangeScale(NewPPI, FCurrentPPI);
        FCurrentPPI := NewPPI;
      end
    finally
      FIsScaling := False;
    end;
  end;
end;
{$IFEND}
{$ENDREGION}

procedure TUCustomControl.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FThemeManager) then begin
    ThemeManager:=Nil;
    Exit;
  end;
  inherited Notification(AComponent, Operation);
end;

procedure TUCustomControl.ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND});
begin
  inherited ChangeScale(M, D{$IF CompilerVersion > 29}, isDpiChange{$IFEND});
  DoChangeScale(M, D);
end;

procedure TUCustomControl.DoChangeScale(M, D: Integer);
begin
  UpdateScale(mulScale, M, D);
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

{ TUGraphicControl }

constructor TUGraphicControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FThemeManager := Nil;
end;

destructor TUGraphicControl.Destroy;
var
  TM: TUCustomThemeManager;
begin
  TM:=SelectThemeManager(Self);
  TM.Disconnect(Self);
  inherited;
end;

procedure TUGraphicControl.AfterConstruction;
begin
  inherited;
  if GetCommonThemeManager <> Nil then
    GetCommonThemeManager.Connect(Self);
end;

function TUGraphicControl.IsCreating: Boolean;
begin
  Result := (csCreating in ControlState);
end;

function TUGraphicControl.IsDestroying: Boolean;
begin
  Result := (csDestroying in ComponentState);
end;

function TUGraphicControl.IsLoading: Boolean;
begin
  Result := (csLoading in ComponentState);
end;

function TUGraphicControl.IsDesigning: Boolean;
begin
  Result := (csDesigning in ComponentState);
end;

procedure TUGraphicControl.CMColorChanged(var Message: TMessage);
begin
  // switch off this message, it calls Invalidate after Color property is modified
  Message.Result := 1;
end;

{$REGION 'Compatibility with older Delphi'}
{$IF CompilerVersion < 30}
function TUGraphicControl.GetDesignDpi: Integer;
var
  LForm: TCustomForm;
begin
  LForm := GetParentForm(Self);

  if (LForm <> Nil) and (LForm is TForm) then
    Result := TForm(LForm).PixelsPerInch
  else
    Result := Windows.USER_DEFAULT_SCREEN_DPI;
end;

function TUGraphicControl.GetParentCurrentDpi: Integer;
begin
//  if Parent <> nil then
//    Result := Parent.GetParentCurrentDpi
//  else
    Result := FCurrentPPI;
end;

procedure TUGraphicControl.ScaleForPPI(NewPPI: Integer);
begin
  if not FIsScaling and (NewPPI > 0) then begin
    FIsScaling := True;
    try
      if FCurrentPPI = 0 then
        FCurrentPPI := GetDesignDpi;

      if NewPPI <> FCurrentPPI then begin
        ChangeScale(NewPPI, FCurrentPPI);
        FCurrentPPI := NewPPI;
      end
    finally
      FIsScaling := False;
    end;
  end;
end;
{$IFEND}
{$ENDREGION}

procedure TUGraphicControl.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FThemeManager) then begin
    ThemeManager:=Nil;
    Exit;
  end;
  inherited Notification(AComponent, Operation);
end;

procedure TUGraphicControl.ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND});
begin
  inherited ChangeScale(M, D{$IF CompilerVersion > 29}, isDpiChange{$IFEND});
  DoChangeScale(M, D);
end;

procedure TUGraphicControl.DoChangeScale(M, D: Integer);
begin
// nothing here
end;

procedure TUGraphicControl.SetThemeManager(const Value: TUThemeManager);
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

procedure TUGraphicControl.UpdateTheme;
begin
// nothing here
end;

function TUGraphicControl.IsCustomThemed: Boolean;
begin
  Result:=(FThemeManager <> Nil);
end;

function TUGraphicControl.CustomThemeManager: TUCustomThemeManager;
begin
  Result:=FThemeManager;
end;

{ TUCustomEdit }

constructor TUCustomEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FThemeManager := Nil;
end;

destructor TUCustomEdit.Destroy;
var
  TM: TUCustomThemeManager;
begin
  TM:=SelectThemeManager(Self);
  TM.Disconnect(Self);
  inherited;
end;

procedure TUCustomEdit.AfterConstruction;
begin
  inherited;
  if GetCommonThemeManager <> Nil then
    GetCommonThemeManager.Connect(Self);
end;

function TUCustomEdit.IsCreating: Boolean;
begin
  Result := (csCreating in ControlState);
end;

function TUCustomEdit.IsDestroying: Boolean;
begin
  Result := (csDestroying in ComponentState);
end;

function TUCustomEdit.IsLoading: Boolean;
begin
  Result := (csLoading in ComponentState);
end;

function TUCustomEdit.IsDesigning: Boolean;
begin
  Result := (csDesigning in ComponentState);
end;

{$REGION 'Compatibility with older Delphi'}
{$IF CompilerVersion < 30}
function TUCustomEdit.GetDesignDpi: Integer;
var
  LForm: TCustomForm;
begin
  LForm := GetParentForm(Self);

  if (LForm <> Nil) and (LForm is TForm) then
    Result := TForm(LForm).PixelsPerInch
  else
    Result := Windows.USER_DEFAULT_SCREEN_DPI;
end;

function TUCustomEdit.GetParentCurrentDpi: Integer;
begin
//  if Parent <> nil then
//    Result := Parent.GetParentCurrentDpi
//  else
    Result := FCurrentPPI;
end;

procedure TUCustomEdit.ScaleForPPI(NewPPI: Integer);
begin
  if not FIsScaling and (NewPPI > 0) then begin
    FIsScaling := True;
    try
      if FCurrentPPI = 0 then
        FCurrentPPI := GetDesignDpi;

      if NewPPI <> FCurrentPPI then begin
        ChangeScale(NewPPI, FCurrentPPI);
        FCurrentPPI := NewPPI;
      end
    finally
      FIsScaling := False;
    end;
  end;
end;
{$IFEND}
{$ENDREGION}

procedure TUCustomEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FThemeManager) then begin
    ThemeManager:=Nil;
    Exit;
  end;
  inherited Notification(AComponent, Operation);
end;

procedure TUCustomEdit.ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND});
begin
  inherited ChangeScale(M, D{$IF CompilerVersion > 29}, isDpiChange{$IFEND});
  DoChangeScale(M, D);
end;

procedure TUCustomEdit.DoChangeScale(M, D: Integer);
begin
// nothing here
end;

procedure TUCustomEdit.SetThemeManager(const Value: TUThemeManager);
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

procedure TUCustomEdit.UpdateTheme;
begin
// nothing here
end;

function TUCustomEdit.IsCustomThemed: Boolean;
begin
  Result:=(FThemeManager <> Nil);
end;

function TUCustomEdit.CustomThemeManager: TUCustomThemeManager;
begin
  Result:=FThemeManager;
end;

{ TUCustomPanel }

constructor TUCustomPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FThemeManager := Nil;
end;

destructor TUCustomPanel.Destroy;
var
  TM: TUCustomThemeManager;
begin
  TM:=SelectThemeManager(Self);
  TM.Disconnect(Self);
  inherited;
end;

procedure TUCustomPanel.AfterConstruction;
begin
  inherited;
  if GetCommonThemeManager <> Nil then
    GetCommonThemeManager.Connect(Self);
end;

function TUCustomPanel.IsCreating: Boolean;
begin
  Result := (csCreating in ControlState);
end;

function TUCustomPanel.IsDestroying: Boolean;
begin
  Result := (csDestroying in ComponentState);
end;

function TUCustomPanel.IsLoading: Boolean;
begin
  Result := (csLoading in ComponentState);
end;

function TUCustomPanel.IsDesigning: Boolean;
begin
  Result := (csDesigning in ComponentState);
end;

procedure TUCustomPanel.CMColorChanged(var Message: TMessage);
begin
  // switch off this message, it calls Invalidate after Color property is modified
  Brush.Color := Color;
  NotifyControls(CM_PARENTCOLORCHANGED);
  Message.Result := 1;
end;

{$REGION 'Compatibility with older Delphi'}
{$IF CompilerVersion < 30}
function TUCustomPanel.GetDesignDpi: Integer;
var
  LForm: TCustomForm;
begin
  LForm := GetParentForm(Self);

  if (LForm <> Nil) and (LForm is TForm) then
    Result := TForm(LForm).PixelsPerInch
  else
    Result := Windows.USER_DEFAULT_SCREEN_DPI;
end;

function TUCustomPanel.GetParentCurrentDpi: Integer;
begin
//  if Parent <> nil then
//    Result := Parent.GetParentCurrentDpi
//  else
    Result := FCurrentPPI;
end;

procedure TUCustomPanel.ScaleForPPI(NewPPI: Integer);
begin
  if not FIsScaling and (NewPPI > 0) then begin
    FIsScaling := True;
    try
      if FCurrentPPI = 0 then
        FCurrentPPI := GetDesignDpi;

      if NewPPI <> FCurrentPPI then begin
        ChangeScale(NewPPI, FCurrentPPI);
        FCurrentPPI := NewPPI;
      end
    finally
      FIsScaling := False;
    end;
  end;
end;
{$IFEND}
{$ENDREGION}

procedure TUCustomPanel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FThemeManager) then begin
    ThemeManager:=Nil;
    Exit;
  end;
  inherited Notification(AComponent, Operation);
end;

procedure TUCustomPanel.ChangeScale(M, D: Integer{$IF CompilerVersion > 29}; isDpiChange: Boolean{$IFEND});
begin
  inherited ChangeScale(M, D{$IF CompilerVersion > 29}, isDpiChange{$IFEND});
  DoChangeScale(M, D);
end;

procedure TUCustomPanel.DoChangeScale(M, D: Integer);
begin
// nothing here
end;

procedure TUCustomPanel.SetThemeManager(const Value: TUThemeManager);
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

procedure TUCustomPanel.UpdateTheme;
begin
// nothing here
end;

function TUCustomPanel.IsCustomThemed: Boolean;
begin
  Result:=(FThemeManager <> Nil);
end;

function TUCustomPanel.CustomThemeManager: TUCustomThemeManager;
begin
  Result:=FThemeManager;
end;

end.
