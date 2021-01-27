unit UCL.DragReorder;

interface

uses
  Classes,
  SysUtils,
  Controls,
  CommCtrl,
  Graphics,
  Types,
  Windows,
  Variants,
  StdCtrls,
  ExtCtrls,
  UCL.Classes;

type
  TUDragObject = class(TDragObjectEx)
  private
    FDragImages: TDragImageList;
    FControl: TWinControl;

  protected
    function GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor; override;
    function GetDragImages: TDragImageList; override;

  public
    constructor Create(AControl: TWinControl);
    destructor Destroy; override;

    property Control: TWinControl read FControl write FControl;
  end;

  TUCustomDragHandler = class
  private
    Control: TControl;
    MousePressed: Boolean;
  public
    procedure OnStartDrag(Sender: TObject; var DragObject: TDragObject); virtual;
    procedure OnDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); virtual;
    procedure OnDragDrop(Sender, Source: TObject; X, Y: Integer); virtual; abstract;
    procedure OnEndDrag(Sender, Target: TObject; X, Y: Integer); virtual;
    //
    procedure OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure OnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer); virtual;
    procedure OnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
  end;

  TUVerticalDragHandler = class(TUCustomDragHandler)
  public
    procedure OnDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    procedure OnDragDrop(Sender, Source: TObject; X, Y: Integer); override;
  end;

  TUHorizontalDragHandler = class(TUCustomDragHandler)
  public
    procedure OnDragDrop(Sender, Source: TObject; X, Y: Integer); override;
  end;

  TUDockObject = class(TDragDockObjectEx)
  private
    FDragImages: TDragImageList;

  protected
    function GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor; override;
    function GetDragImages: TDragImageList; override;
    function GetFrameWidth: Integer; override;

  public
    destructor Destroy; override;
  end;

  TUCustomDockHandler = class
  private
    Control: TControl;
    MousePressed: Boolean;
  public
    procedure OnStartDock(Sender: TObject; var DragObject: TDragDockObject); virtual;
    procedure OnDockOver(Sender: TObject; Source: TDragDockObject; X, Y: Integer; State: TDragState; var Accept: Boolean); virtual;
    procedure OnDockDrop(Sender: TObject; Source: TDragDockObject; X, Y: Integer); virtual;
    procedure OnEndDock(Sender, Target: TObject; X, Y: Integer); virtual;
    //
    procedure OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure OnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer); virtual;
    procedure OnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
  end;

  TUDockHandler = class(TUCustomDockHandler);

var
  DragReorderObject: TUDragObject;
  VertDragHandler: TUVerticalDragHandler;
  HorzDragHandler: TUHorizontalDragHandler;
  //
  DockReorderObject: TUDockObject;
  DockHandler: TUDockHandler;

// Dragging
function IsDraggingSupported(const Control: TControl): Boolean; inline;
procedure AssignVertDragHandler(const Control: TControl; Handler: TUCustomDragHandler = Nil);
procedure AssignHorzDragHandler(const Control: TControl; Handler: TUCustomDragHandler = Nil);
procedure RemoveDragHandler(const Control: TControl);
//
function IsDragReorderAvailable(const Comp: TComponent): Boolean; inline;

// Docking
function IsDockingSupported(const Control: TControl): Boolean; inline;
procedure AssignDockHandler(const Control: TControl; const DockSiteClass: TWinControlClass; Handler: TUCustomDockHandler = Nil);
procedure RemoveDockHandler(const Control: TControl);

implementation

uses
//  TypInfo,
  UCL.ThemeManager,
  UCL.Utils;

type
  TControlAccess = class(TControl);
  TWinControlAccess = class(TWinControl);

{ Utils }

function IsDraggingSupported(const Control: TControl): Boolean;
begin
  Result := TUCustomThemeManager.IsThemingAvailable(Control) and
//            IsPublishedProp(Control, 'OnStartDrag') and
            IsPropAvailable(Control, 'OnStartDrag') and
            IsPropAvailable(Control, 'OnDragOver') and
            IsPropAvailable(Control, 'OnDragDrop') and
            IsPropAvailable(Control, 'OnEndDrag') and
            IsPropAvailable(Control, 'OnMouseDown') and
            IsPropAvailable(Control, 'OnMouseMove') and
            IsPropAvailable(Control, 'OnMouseUp');
end;

function IsDockingSupported(const Control: TControl): Boolean; inline;
begin
  Result := TUCustomThemeManager.IsThemingAvailable(Control) and
            IsPropAvailable(Control, 'OnStartDock') and
            IsPropAvailable(Control, 'OnDockOver') and
            IsPropAvailable(Control, 'OnDockDrop') and
            IsPropAvailable(Control, 'OnEndDock') and
            IsPropAvailable(Control, 'OnMouseDown') and
            IsPropAvailable(Control, 'OnMouseMove') and
            IsPropAvailable(Control, 'OnMouseUp');
end;

procedure AssignVertDragHandler(const Control: TControl; Handler: TUCustomDragHandler = Nil);
begin
  if not IsDraggingSupported(Control) then
    Exit;
  //
  if Handler = Nil then
    Handler := VertDragHandler;
  //
  TControlAccess(Control).DragKind    := dkDrag;
  TControlAccess(Control).OnStartDrag := Handler.OnStartDrag;
  TControlAccess(Control).OnDragOver  := Handler.OnDragOver;
  TControlAccess(Control).OnDragDrop  := Handler.OnDragDrop;
  TControlAccess(Control).OnEndDrag   := Handler.OnEndDrag;
  //
  TControlAccess(Control).OnMouseDown := Handler.OnMouseDown;
  TControlAccess(Control).OnMouseMove := Handler.OnMouseMove;
  TControlAccess(Control).OnMouseUp   := Handler.OnMouseUp;
end;

procedure AssignHorzDragHandler(const Control: TControl; Handler: TUCustomDragHandler = Nil);
begin
  if not IsDraggingSupported(Control) then
    Exit;
  //
  if Handler = Nil then
    Handler := HorzDragHandler;
  //
  TControlAccess(Control).DragKind    := dkDrag;
  TControlAccess(Control).OnStartDrag := Handler.OnStartDrag;
  TControlAccess(Control).OnDragOver  := Handler.OnDragOver;
  TControlAccess(Control).OnDragDrop  := Handler.OnDragDrop;
  TControlAccess(Control).OnEndDrag   := Handler.OnEndDrag;
  //
  TControlAccess(Control).OnMouseDown := Handler.OnMouseDown;
  TControlAccess(Control).OnMouseMove := Handler.OnMouseMove;
  TControlAccess(Control).OnMouseUp   := Handler.OnMouseUp;
end;

procedure RemoveDragHandler(const Control: TControl);
begin
  if not IsDraggingSupported(Control) then
    Exit;
  //
  TControlAccess(Control).DragKind    := dkDrag;
  TControlAccess(Control).OnStartDrag := Nil;
  TControlAccess(Control).OnDragOver  := Nil;
  TControlAccess(Control).OnDragDrop  := Nil;
  TControlAccess(Control).OnEndDrag   := Nil;
  TControlAccess(Control).OnMouseDown := Nil;
  TControlAccess(Control).OnMouseMove := Nil;
  TControlAccess(Control).OnMouseUp   := Nil;
end;

function IsDragReorderAvailable(const Comp: TComponent): Boolean; inline;
begin
  Result := Supports(Comp, IUDragReorderControl) and IsPropAvailable(Comp, 'DragFloating');
end;

procedure AssignDockHandler(const Control: TControl; const DockSiteClass: TWinControlClass; Handler: TUCustomDockHandler = Nil);
begin
  if not IsDockingSupported(Control) or not (Control is TWinControl) then
    Exit;
  //
  if Handler = Nil then
    Handler := DockHandler;
  //
  TWinControlAccess(Control).DragKind    := dkDock;
  TWinControlAccess(Control).FloatingDockSiteClass := DockSiteClass;
  TWinControlAccess(Control).OnStartDock := Handler.OnStartDock;
  TWinControlAccess(Control).OnDockOver  := Handler.OnDockOver;
  TWinControlAccess(Control).OnDockDrop  := Handler.OnDockDrop;
  TWinControlAccess(Control).OnEndDock   := Handler.OnEndDock;
  //
  TControlAccess(Control).OnMouseDown := Handler.OnMouseDown;
  TControlAccess(Control).OnMouseMove := Handler.OnMouseMove;
  TControlAccess(Control).OnMouseUp   := Handler.OnMouseUp;
end;

procedure RemoveDockHandler(const Control: TControl);
begin
  if not (Control is TWinControl) then
    Exit;
  TWinControlAccess(Control).DragKind    := dkDrag;
  TWinControlAccess(Control).OnStartDock := Nil;
  TWinControlAccess(Control).OnDockOver  := Nil;
  TWinControlAccess(Control).OnDockDrop  := Nil;
  TWinControlAccess(Control).OnEndDock   := Nil;
  //
  TControlAccess(Control).OnMouseDown := Nil;
  TControlAccess(Control).OnMouseMove := Nil;
  TControlAccess(Control).OnMouseUp   := Nil;
end;

{ TUDragObject }

//  MAIN CLASS

constructor TUDragObject.Create(AControl: TWinControl);
begin
  inherited Create;
  FControl := AControl;
end;

destructor TUDragObject.Destroy;
begin
  if FDragImages <> Nil then
    FDragImages.Free;
  inherited;
end;

//  CUSTOM METHODS

function TUDragObject.GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor;
begin
  if Accepted then
    Result := crDefault
  else
    Result := crNoDrop;
end;

function TUDragObject.GetDragImages: TDragImageList;
var
  Bmp: Graphics.TBitmap;
  P: TPoint;
begin
  //  Create images
  if not Assigned(FDragImages) then begin
    Bmp := Graphics.TBitmap.Create;
    try
      Bmp.PixelFormat := pf32bit;
      Bmp.Canvas.Brush.Color := clFuchsia;

      // 2px margin at each side just to show image can have transparency.
      Bmp.Width := FControl.Width + 4;
      Bmp.Height := FControl.Height + 4;
      Bmp.Canvas.Lock;
      FControl.PaintTo(Bmp.Canvas.Handle, 2, 2);
      Bmp.Canvas.Unlock;

      FDragImages := TDragImageList.Create(Nil);
      FDragImages.Width := Bmp.Width;
      FDragImages.Height := Bmp.Height;
      P := Mouse.CursorPos;
      MapWindowPoints(HWND_DESKTOP, FControl.Handle, P, 1);
      FDragImages.DragHotspot := P;
      FDragImages.Masked := True;
      FDragImages.AddMasked(Bmp, clFuchsia);
    finally
      Bmp.Free;
    end;
  end;

  Result := FDragImages;
end;

{ TUCustomDragHandler }

procedure TUCustomDragHandler.OnStartDrag(Sender: TObject; var DragObject: TDragObject);
begin
  if (Sender = Nil) or not (Sender is TWinControl) then
    Exit;

  DragReorderObject := TUDragObject.Create(TWinControl(Sender));
  DragReorderObject.AlwaysShowDragImages := True;
  DragObject := DragReorderObject;
end;

procedure TUCustomDragHandler.OnDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := True;
end;

procedure TUCustomDragHandler.OnEndDrag(Sender, Target: TObject; X, Y: Integer);
begin
  Control:=Nil;
  MousePressed:=False;
  DragReorderObject := Nil;
end;

procedure TUCustomDragHandler.OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Sender = Nil) or not (Sender is TControl) then
    Exit;
  //
  if Button = mbLeft then begin
    Control:=TControl(Sender);
    MousePressed:=True;
  end;
end;

procedure TUCustomDragHandler.OnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if (Control <> Nil) and (Sender = Control) and MousePressed then begin
    MousePressed:=False;
    IncludeControlState(Control, [csPrintClient]);
    Control.BeginDrag(False);
    ExcludeControlState(DragReorderObject.Control, [csPrintClient]);
    ImageList_SetDragCursorImage(DragReorderObject.GetDragImages.Handle, 1, 0, 0);
  end;
end;

procedure TUCustomDragHandler.OnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Control <> Nil) or MousePressed then begin
    Control:=Nil;
    MousePressed:=False;
  end;
end;

{ TUVerticalDragHandler }

procedure TUVerticalDragHandler.OnDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  Dest: TControl;
  P: TPoint;
begin
  Accept:=True;
  if (Sender = Nil) or not (Sender is TControl) or not IsDragReorderAvailable(Sender) then
    Exit;

  Dest := Sender as TControl;
  P := Point(X, Y);
  P := Dest.ScreenToClient(P);

  (Dest as IUDragReorderControl).

  if Dest.Top < P.Y then
//    Dest.t

end;

procedure TUVerticalDragHandler.OnDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  Src, Dest: TControl;
begin
  if (Sender = Nil) or (Source = Nil) or not (Sender is TControl) or not (Source is TUDragObject) then
    Exit;

  Src := (Source as TUDragObject).Control;
  Dest := Sender as TControl;
  if Dest.Top < Src.Top then
    Src.Top := Dest.Top
  else
    Src.Top := Dest.Top + Dest.Height;
end;

{ TUHorizontalDragHandler }

procedure TUHorizontalDragHandler.OnDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  Src, Dest: TControl;
begin
  if (Sender = Nil) or (Source = Nil) or not (Sender is TControl) or not (Source is TUDragObject) then
    Exit;

  Src := (Source as TUDragObject).Control;
  Dest := Sender as TControl;
  if Dest.Left < Src.Left then
    Src.Left := Dest.Left
  else
    Src.Left := Dest.Left + Dest.Width;
end;

{ TUDockObject }

destructor TUDockObject.Destroy;
begin
  if FDragImages <> Nil then
    FDragImages.Free;
  inherited;
end;

function TUDockObject.GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor;
begin
  if Accepted then
    Result := crDefault
  else
    Result := crNoDrop;
end;

function TUDockObject.GetDragImages: TDragImageList;
var
  Bmp: Graphics.TBitmap;
  P: TPoint;
begin
  //  Create images
  if not Assigned(FDragImages) and (Control is TWinControl) then begin
    Bmp := Graphics.TBitmap.Create;
    try
      Bmp.PixelFormat := pf32bit;
      Bmp.Canvas.Brush.Color := clFuchsia;

      // 2px margin at each side just to show image can have transparency.
      Bmp.Width := Control.Width + 4;
      Bmp.Height := Control.Height + 4;
      Bmp.Canvas.Lock;
      TWinControl(Control).PaintTo(Bmp.Canvas.Handle, 2, 2);
      Bmp.Canvas.Unlock;

      FDragImages := TDragImageList.Create(Nil);
      FDragImages.Width := Bmp.Width;
      FDragImages.Height := Bmp.Height;
      P := Mouse.CursorPos;
      MapWindowPoints(HWND_DESKTOP, TWinControl(Control).Handle, P, 1);
      FDragImages.DragHotspot := P;
      FDragImages.Masked := True;
      FDragImages.AddMasked(Bmp, clFuchsia);
    finally
      Bmp.Free;
    end;
  end;

  Result := FDragImages;
end;

function TUDockObject.GetFrameWidth: Integer;
begin
  Result := 0;
end;

{ TUCustomDockHandler }

procedure TUCustomDockHandler.OnStartDock(Sender: TObject; var DragObject: TDragDockObject);
begin
  if (Sender = Nil) or not (Sender is TWinControl) then
    Exit;

  DockReorderObject := TUDockObject.Create(TWinControl(Sender));
  DockReorderObject.AlwaysShowDragImages := True;
  DragObject := DockReorderObject;
end;

procedure TUCustomDockHandler.OnDockOver(Sender: TObject; Source: TDragDockObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := True;
end;

procedure TUCustomDockHandler.OnDockDrop(Sender: TObject; Source: TDragDockObject; X, Y: Integer);
var
  Src, Dest: TControl;
begin
  if (Sender = Nil) or (Source = Nil) or not (Sender is TControl) or not (Source is TUDockObject) then
    Exit;

  Src := (Source as TUDockObject).Control;
  Dest := Sender as TControl;
  // do something to Dest
  Dest.InsertComponent(Src);
end;

procedure TUCustomDockHandler.OnEndDock(Sender, Target: TObject; X, Y: Integer);
begin
  Control:=Nil;
  MousePressed:=False;
  DockReorderObject := Nil;
end;

procedure TUCustomDockHandler.OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Sender = Nil) or not (Sender is TControl) then
    Exit;
  //
  if Button = mbLeft then begin
    Control:=TControl(Sender);
    MousePressed:=True;
  end;
end;

procedure TUCustomDockHandler.OnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if (Control <> Nil) and (Sender = Control) and MousePressed then begin
    MousePressed:=False;
    Control.BeginDrag(False);
    ImageList_SetDragCursorImage(DockReorderObject.GetDragImages.Handle, 0, 0, 0);
  end;
end;

procedure TUCustomDockHandler.OnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Control <> Nil) or MousePressed then begin
    Control:=Nil;
    MousePressed:=False;
  end;
end;

initialization
  VertDragHandler := TUVerticalDragHandler.Create;
  HorzDragHandler := TUHorizontalDragHandler.Create;
  DockHandler := TUDockHandler.Create;

finalization
  VertDragHandler.Free;
  HorzDragHandler.Free;
  DockHandler.Free;

end.