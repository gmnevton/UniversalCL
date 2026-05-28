unit UCL.FormOverlay;

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
  UCL.ThemeManager;

type
  TUOverlayType = (otNone, otTransparent, otSplash);

  // TIP:
  // AlphaBlend only works for top-level windows in Windows 7 and below,
  // to make it work we need to science the sh*t out of it.
  // In Windows 8 and up it works for top-level and child windows as well - no need to do anything.

  TUFormOverlay = class(TForm)
  private
    FOverlayType: TUOverlayType;
    FCaptionBarHeight: Integer;
    FAllowMove: Boolean;
    FParent: TWinControl;
    FTransparentValue: SmallInt; // percent; -1 - default, 0-100%

    //  Setters
    procedure SetOverlayType(const Value: TUOverlayType);
    procedure SetTransparentValue(const Value: SmallInt);

    // Internal
    procedure SetTransparent;

    //  Messages
    procedure WM_NCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;

  public
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    procedure AssignToForm(Form: TForm);

  published
    property OverlayType: TUOverlayType read FOverlayType write SetOverlayType default otNone;
    property CaptionBarHeight: Integer read FCaptionBarHeight write FCaptionBarHeight default 32;
    property AllowMove: Boolean read FAllowMove write FAllowMove default True;
    property TransparentPercent: SmallInt read FTransparentValue write SetTransparentValue;
  end;

implementation

uses
  Themes,
  Dwmapi,
  Menus,
  UCL.Form,
  UCL.CaptionBar,
  UCL.Utils;

const
  DefaultAlphaBlendValue = 180;

{ TUFormOverlay }

constructor TUFormOverlay.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited CreateNew(AOwner, Dummy);
{$IF CompilerVersion > 29}
  StyleElements := [];
{$IFEND}

  FOverlayType := otNone;
  FCaptionBarHeight := 32;
  FAllowMove := True;
  FParent := Nil;
  FTransparentValue := -1;

  BorderStyle := bsNone;
  Color := $FFFFFF;
  DoubleBuffered := True;
  Anchors := [akLeft, akTop, akRight, akBottom];
  Visible := False;

  AlphaBlend := False;
  AlphaBlendValue := DefaultAlphaBlendValue;
end;

procedure TUFormOverlay.AssignToForm(Form: TForm);
//var
//  P: TPoint;
begin
  Parent := Nil;
  HandleNeeded;
  if CheckMaxWin32Version(6, 1) then begin // less-equal to win 7
  // NOTE: this is a test - probably not working at all
  {$IF CompilerVersion < 30}
    if HandleAllocated and ThemeServices.ThemesEnabled and DwmCompositionEnabled and BlurAvailable then
  {$ELSE}
    if HandleAllocated and StyleServices.Enabled and DwmCompositionEnabled and BlurAvailable then
  {$IFEND}
      EnableBlur(Handle);

//  FParent:=Form;
//  //BoundsRect := Form.BoundsRect;
//  P := ClientToScreen(Form.BoundsRect.TopLeft);
//  SetWindowLong(Handle, GWL_HWNDPARENT, Form.Handle);
//  //SetWindowPos(Handle, Form.Handle, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE);
//  SetBounds(P.X, P.Y, Form.ClientWidth, Form.ClientHeight);
//  SetBounds(0, 0, Form.ClientWidth, Form.ClientHeight);
    Parent := Form;
    SetBounds(0, 0, Form.ClientWidth, Form.ClientHeight);
  end
  else begin
    Parent := Form;
    SetBounds(0, 0, Form.ClientWidth, Form.ClientHeight);
  end;
end;

procedure TUFormOverlay.SetOverlayType(const Value: TUOverlayType);
var
  LParent: TWinControl;
//  LMenu: TMainMenu;
begin
  if Value <> FOverlayType then begin
    FOverlayType := Value;

    //  Reset properties
    LParent := Nil;
    if Parent <> Nil then
      LParent := Parent
    else if FParent <> Nil then
      LParent := FParent;

    if (LParent <> Nil) and (LParent is TForm) then begin
      Color := TForm(LParent).Color;
//      if CheckMaxWin32Version(6, 1) then // less-equal to win 7
        TransparentColorValue := Color;
//      else
//        TransparentColorValue := 0;
    end;

    //  Apply changes
    case FOverlayType of
      otNone: begin
        AlphaBlend := False;
        Visible := False;
        if (LParent is TUForm) and (TUForm(LParent).CaptionBar is TUCaptionBar) and (TUCaptionBar(TUForm(LParent).CaptionBar).Menu <> Nil) then begin
          TUCaptionBar(TUForm(LParent).CaptionBar).MenuController.Enabled := True;
        end;
      end;

      otTransparent: begin
        if (LParent is TUForm) and (TUForm(LParent).CaptionBar is TUCaptionBar) and (TUCaptionBar(TUForm(LParent).CaptionBar).Menu <> Nil) then begin
          TUCaptionBar(TUForm(LParent).CaptionBar).MenuController.Enabled := False;
        end;
        //AlphaBlendValue := 220;
        SetTransparent;
        AlphaBlend := True;
        //UpdateLayeredWindowIndirect
        Visible := True;
        //Repaint;
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

procedure TUFormOverlay.SetTransparentValue(const Value: SmallInt);
begin
  if Value <> FTransparentValue then begin
    FTransparentValue := Value;

    if FTransparentValue < -1 then
      FTransparentValue := -1
    else if FTransparentValue > 100 then
      FTransparentValue := 100;
  end;
  //
  SetTransparent;
end;

procedure TUFormOverlay.SetTransparent;
begin
  if FTransparentValue = -1 then
    AlphaBlendValue := DefaultAlphaBlendValue
  else
    AlphaBlendValue := 255 - Round(255 * (FTransparentValue / 100));
end;

procedure TUFormOverlay.WM_NCHitTest(var Msg: TWMNCHitTest);
begin
  inherited;

  case OverlayType of
    otNone: Msg.Result := HTTRANSPARENT;

    otTransparent: begin
      if AllowMove and (Parent <> Nil) then
        if Msg.YPos - Parent.BoundsRect.Top <= CaptionBarHeight then
          Msg.Result := HTTRANSPARENT;
    end;

    otSplash: begin
    end;
  end;
end;

end.
