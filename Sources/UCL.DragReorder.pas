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
  TypInfo,
  StdCtrls,
  ExtCtrls,
  UCL.Classes;

type
  TUDragObject = class(TDragObjectEx)
  private
    FDragImages: TDragImageList;
    FControl: TWinControl;

  protected
    function GetDragImages: TDragImageList; override;

  public
    constructor Create(AControl: TWinControl);
    destructor Destroy; override;

    property Control: TWinControl read FControl write FControl;
  end;

  TUCustomDragHandler = class
  public
    procedure OnDragDrop(Sender, Source: TObject; X, Y: Integer); virtual; abstract;
    procedure OnDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); virtual;
    procedure OnStartDrag(Sender: TObject; var DragObject: TDragObject); virtual;
    procedure OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
  end;

  TUVerticalDragHandler = class(TUCustomDragHandler)
  public
    procedure OnDragDrop(Sender, Source: TObject; X, Y: Integer); override;
  end;

  TUHorizontalDragHandler = class(TUCustomDragHandler)
  public
    procedure OnDragDrop(Sender, Source: TObject; X, Y: Integer); override;
  end;

var
  DragReorderObject: TUDragObject;
  VertDragHandler: TUVerticalDragHandler;
  HorzDragHandler: TUHorizontalDragHandler;

function IsDraggingSupported(const Control: TControl): Boolean; inline;
procedure AssignVertDragHandler(const Control: TControl; Handler: TUCustomDragHandler = Nil);
procedure AssignHorzDragHandler(const Control: TControl; Handler: TUCustomDragHandler = Nil);
procedure RemoveDragHandler(const Control: TControl);

implementation

uses
  UCL.ThemeManager;

type
  TControlAccess = class(TControl);

{ Utils }

function IsDraggingSupported(const Control: TControl): Boolean;
begin
  Result := TUCustomThemeManager.IsThemingAvailable(Control) and
            IsPublishedProp(Control, 'OnDragDrop') and
            IsPublishedProp(Control, 'OnDragOver') and
            IsPublishedProp(Control, 'OnStartDrag') and
            IsPublishedProp(Control, 'OnMouseDown');
end;

procedure AssignVertDragHandler(const Control: TControl; Handler: TUCustomDragHandler = Nil);
begin
  if not IsDraggingSupported(Control) then
    Exit;
  //
  if Handler = Nil then
    Handler := VertDragHandler;
  //
  TControlAccess(Control).OnDragDrop  := Handler.OnDragDrop;
  TControlAccess(Control).OnDragOver  := Handler.OnDragOver;
  TControlAccess(Control).OnStartDrag := Handler.OnStartDrag;
  TControlAccess(Control).OnMouseDown := Handler.OnMouseDown;
end;

procedure AssignHorzDragHandler(const Control: TControl; Handler: TUCustomDragHandler = Nil);
begin
  if not IsDraggingSupported(Control) then
    Exit;
  //
  if Handler = Nil then
    Handler := HorzDragHandler;
  //
  TControlAccess(Control).OnDragDrop  := Handler.OnDragDrop;
  TControlAccess(Control).OnDragOver  := Handler.OnDragOver;
  TControlAccess(Control).OnStartDrag := Handler.OnStartDrag;
  TControlAccess(Control).OnMouseDown := Handler.OnMouseDown;
end;

procedure RemoveDragHandler(const Control: TControl);
begin
  TControlAccess(Control).OnDragDrop  := Nil;
  TControlAccess(Control).OnDragOver  := Nil;
  TControlAccess(Control).OnMouseDown := Nil;
  TControlAccess(Control).OnStartDrag := Nil;
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
  FDragImages.Free;
  inherited;
end;

//  CUSTOM METHODS

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

procedure TUCustomDragHandler.OnDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := True;
end;

procedure TUCustomDragHandler.OnStartDrag(Sender: TObject; var DragObject: TDragObject);
begin
  if (Sender = Nil) or not (Sender is TWinControl) then
    Exit;

  DragReorderObject := TUDragObject.Create(TWinControl(Sender));
  DragReorderObject.AlwaysShowDragImages := True;
  DragObject := DragReorderObject;
end;

procedure TUCustomDragHandler.OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  WC: TWinControl;
begin
  if (Sender = Nil) or not (Sender is TWinControl) then
    Exit;

  WC:=TWinControl(Sender);
  WC.BeginDrag(False);
  ImageList_SetDragCursorImage(DragReorderObject.GetDragImages.Handle, 1, 0, 0);
end;

{ TUVerticalDragHandler }

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

initialization
  VertDragHandler := TUVerticalDragHandler.Create;
  HorzDragHandler := TUHorizontalDragHandler.Create;

finalization
  VertDragHandler.Free;
  HorzDragHandler.Free;

end.