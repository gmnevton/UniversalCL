unit UCL.TUFormOverlay;

interface

uses
  SysUtils,
  Classes,
  Types,
  Messages,
  Windows,
  Graphics,
  Controls,
  Forms,
  UCL.Classes,
  UCL.TUThemeManager;

type
  TUOverlayType = (otNone, otBlur, otSplash);

  TUFormOverlay = class(TForm)
  private
    FOverlayType: TUOverlayType;
    FCaptionBarHeight: Integer;
    FAllowMove: Boolean;
    FParent: TWinControl;

    //  Setters
    procedure SetOverlayType(const Value: TUOverlayType);

    //  Messages
    procedure WM_NCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;

  public
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    procedure AssignToForm(Form: TForm);

  published
    property OverlayType: TUOverlayType read FOverlayType write SetOverlayType default otNone;
    property CaptionBarHeight: Integer read FCaptionBarHeight write FCaptionBarHeight default 32;
    property AllowMove: Boolean read FAllowMove write FAllowMove default True;
  end;

implementation

{ TUFormOverlay }

//  SETTERS

procedure TUFormOverlay.SetOverlayType(const Value: TUOverlayType);
var
  LParent: TWinControl;
begin
  if Value <> FOverlayType then begin
    FOverlayType := Value;

    //  Reset properties
    if Parent <> Nil then
      LParent := Parent
    else if FParent <> Nil then
      LParent := FParent;

    if (LParent <> Nil) and (LParent is TForm) then
      Color := TForm(LParent).Color;

    //  Apply changes
    case FOverlayType of
      otNone: begin
        AlphaBlend := False;
        Visible := False;
      end;

      otBlur: begin
        AlphaBlend := True;
        AlphaBlendValue := 150;
        Visible := True;
        BringToFront;
      end;

      otSplash: begin
        AlphaBlend := False;
        Visible := True;
        BringToFront;
      end;
    end;
  end;
end;

//  MAIN CLASS

constructor TUFormOverlay.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited CreateNew(AOwner, Dummy);

  FOverlayType := otNone;
  FCaptionBarHeight := 32;
  FAllowMove := True;
  FParent := Nil;

  BorderStyle := bsNone;
  Color := $FFFFFF;
  Anchors := [akLeft, akTop, akRight, akBottom];
  Visible := False;

  AlphaBlend := False;
  AlphaBlendValue := 150;
end;

procedure TUFormOverlay.AssignToForm(Form: TForm);
var
  P: TPoint;
begin
{$IF CompilerVersion < 30}
  FParent:=Form;
//  BoundsRect := Form.BoundsRect;
  P := ClientToScreen(Form.BoundsRect.TopLeft);
  SetWindowLong(Handle, GWL_HWNDPARENT, Form.Handle);
//  SetWindowPos(Handle, Form.Handle, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE);
  SetBounds(P.X, P.Y, Form.ClientWidth, Form.ClientHeight);
//  SetBounds(0, 0, Form.ClientWidth, Form.ClientHeight);
{$ELSE}
  Parent := Form;
  SetBounds(0, 0, Form.ClientWidth, Form.ClientHeight);
{$IFEND}
end;

//  MESSAGES

procedure TUFormOverlay.WM_NCHitTest(var Msg: TWMNCHitTest);
begin
  inherited;

  case OverlayType of
    otNone: Msg.Result := HTTRANSPARENT;

    otBlur: begin
      if AllowMove and (Parent <> Nil) then
        if Msg.YPos - Parent.BoundsRect.Top <= CaptionBarHeight then
          Msg.Result := HTTRANSPARENT;
    end;

    otSplash: begin
    end;
  end;
end;

end.
