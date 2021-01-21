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
    procedure OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure OnStartDrag(Sender: TObject; var DragObject: TDragObject); virtual;
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
  DragReorderObject: TDragObject;
  VertDragHandler: TUVerticalDragHandler;
  HorzDragHandler: TUHorizontalDragHandler;

function IsDraggingSupported(const Control: TObject): Boolean;
procedure AssignVertDragHandler(const Control: TUCustomPanel; const Handler: TUCustomDragHandler = Nil);
procedure AssignHorzDragHandler(const Control: TUCustomPanel; const Handler: TUCustomDragHandler = Nil);
procedure RemoveDragHandler(const Control: TUCustomPanel);

implementation

uses
  UCL.ThemeManager;

{ Utils }

function IsDraggingSupported(const Control: TObject): Boolean;
begin
  Result := TUCustomThemeManager.IsThemingAvailable(Control) and
            IsPublishedProp(Control, 'OnDragDrop') and
            IsPublishedProp(Control, 'OnDragOver') and
            IsPublishedProp(Control, 'OnStartDrag') and
            IsPublishedProp(Control, 'OnMouseDown');
end;

procedure AssignVertDragHandler(const Control: TUCustomPanel; const Handler: TUCustomDragHandler = Nil);
var
  LHandler: TUCustomDragHandler;
begin
  LHandler:= VertDragHandler;
  if Handler = Nil then
    LHandler:= Handler;
  //
  Control.OnDragDrop := LHandler.OnDragDrop;
  Control.OnDragOver := LHandler.OnDragOver;
  Control.OnStartDrag := LHandler.OnStartDrag;
  Control.OnMouseDown := LHandler.OnMouseDown;
end;

procedure AssignDragHorzHandle(const Control: TPanel);
begin
  Control.OnDragDrop := DragHorzHandle.OnDragDrop;
  Control.OnDragOver := DragHorzHandle.OnDragOver;
  Control.OnMouseDown := DragHorzHandle.OnMouseDown;
  Control.OnStartDrag := DragHorzHandle.OnStartDrag;
end;

procedure RemoveDragHandle(Control: TPanel);
begin
  Control.OnDragDrop := nil;
  Control.OnDragOver := nil;
  Control.OnMouseDown := nil;
  Control.OnStartDrag := nil;
end;

{ TUDragObject }

//  MAIN CLASS

constructor TUDragObject.Create(aControl: TWinControl);
begin
  inherited Create;
  FControl := aControl;
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
  Pt: TPoint;
begin
  //  Create images
  if not Assigned(FDragImages) then
    begin
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

        FDragImages := TDragImageList.Create(nil);
        FDragImages.Width := Bmp.Width;
        FDragImages.Height := Bmp.Height;
        Pt := Mouse.CursorPos;
        MapWindowPoints(HWND_DESKTOP, FControl.Handle, Pt, 1);
        FDragImages.DragHotspot := Pt;
        FDragImages.Masked := True;
        FDragImages.AddMasked(Bmp, clFuchsia);
      finally
        Bmp.Free;
      end;
    end;

  Result := FDragImages;
end;

{ TUDragHandle }

procedure TUDragHandle.OnDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := true;
end;

procedure TUDragHandle.OnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Sender = nil) or (not (Sender is TWinControl)) then
    exit;

  (Sender as TWinControl).BeginDrag(false);
  ImageList_SetDragCursorImage(
    (DragReorderObject as TUDragObject).GetDragImages.Handle, 1, 0, 0);
end;

procedure TUDragHandle.OnStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  if (Sender = nil) or (not (Sender is TWinControl)) then
    exit;

  DragObject := TUDragObject.Create(Sender as TWinControl);
  DragObject.AlwaysShowDragImages := true;
  DragReorderObject := DragObject;
end;

{ TUDragVertHandle }

procedure TUDragVertHandle.OnDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  Src, Dest: TControl;
begin
  if
    (Sender = nil) or (Source = nil) or
    (not (Sender is TControl)) or (not (Source is TUDragObject))
  then
    exit;

  Src := (Source as TUDragObject).Control;
  Dest := Sender as TControl;
  if Dest.Top < Src.Top then
    Src.Top := Dest.Top
  else
    Src.Top := Dest.Top + Dest.Height;
end;

{ TUDragHorzHandle }

procedure TUDragHorzHandle.OnDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  Src, Dest: TControl;
begin
  if
    (Sender = nil) or (Source = nil) or
    (not (Sender is TControl)) or (not (Source is TUDragObject))
  then
    exit;

  Src := (Source as TUDragObject).Control;
  Dest := Sender as TControl;
  if Dest.Left < Src.Left then
    Src.Left := Dest.Left
  else
    Src.Left := Dest.Left + Dest.Width;
end;

initialization
  DragVertHandle := TUDragVertHandle.Create;
  DragHorzHandle := TUDragHorzHandle.Create;

finalization
  DragVertHandle.Free;
  DragHorzHandle.Free;

end.