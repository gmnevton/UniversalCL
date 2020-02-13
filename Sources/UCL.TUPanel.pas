unit UCL.TUPanel;

interface

{$IF CompilerVersion > 29}
  {$LEGACYIFEND ON}
{$IFEND}

uses
  UCL.Classes, UCL.Utils, UCL.SystemSettings, UCL.TUThemeManager,
  Windows, Messages,
  Classes, SysUtils,
  Controls, ExtCtrls, Graphics;

type
  TUPanel = class(TPanel, IUThemeComponent)
    private
      FThemeManager: TUThemeManager;

      FHitTest: Boolean;
      FCustomTextColor: TColor;
      FCustomBackColor: TColor;

      //  Setters
      procedure SetThemeManager; // (const Value: TUThemeManager);
      procedure SetCustomBackColor(const Value: TColor);
      procedure SetCustomTextColor(const Value: TColor);

      //  Messages
      procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;

    protected
      procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    public
      constructor Create(aOwner: TComponent); override;
      procedure UpdateTheme;

    published
      property ThemeManager: TUThemeManager read FThemeManager; // write SetThemeManager;

      property HitTest: Boolean read FHitTest write FHitTest default true;
      property CustomTextColor: TColor read FCustomTextColor write SetCustomTextColor;
      property CustomBackColor: TColor read FCustomBackColor write SetCustomBackColor;
  end;

implementation

uses
  Forms,
  UCL.TUWPForm;

type
  TUWPFormAccess = class(TUWPForm);

{ TUPanel }

//  THEME

procedure TUPanel.SetThemeManager; // (const Value: TUThemeManager);
begin
//  if Value <> FThemeManager then begin
//    if FThemeManager <> Nil then
//      FThemeManager.Disconnect(Self);
//
//    FThemeManager := Value;
//
//    if Value <> Nil then begin
//      Value.Connect(Self);
//      Value.FreeNotification(Self);
//    end;
//
//    UpdateTheme;
//  end;
  FThemeManager := GetCommonThemeManager;
end;

procedure TUPanel.UpdateTheme;
begin
  if ThemeManager = Nil then begin
    Color := CustomBackColor;
    Font.Color := CustomTextColor;
  end
  else if ThemeManager.Theme = utLight then begin
    Color := $00E6E6E6;
    Font.Color := GetTextColorFromBackground(Color);
  end
  else begin
    Color := $001F1F1F;
    Font.Color := GetTextColorFromBackground(Color);
  end;
end;

procedure TUPanel.WMNCHitTest(var Msg: TWMNCHitTest);
var
  P: TPoint;
  ParentForm: TCustomForm;
  BorderSpace: Integer;
begin
  inherited;

  ParentForm := GetParentForm(Self, True);
  if (ParentForm.WindowState = wsNormal) and (Align <> alNone) then begin
    if Align = alCustom then
      Exit;
    //
    P := Point(Msg.Pos.x, Msg.Pos.y);
    P := ScreenToClient(P);
    BorderSpace:=5;
    if ParentForm is TUWPForm then
      BorderSpace:=TUWPFormAccess(ParentForm).GetBorderSpace(bsDefault);
    //  Send event to parent
    case Align of
      alTop: begin
        // we need to check top, left and right borders
        if (P.Y < BorderSpace) or (P.X < BorderSpace) or (Width - P.X < BorderSpace) then
          Msg.Result := HTTRANSPARENT;
      end;
      alBottom: begin
        // we need to check bottom, left and right borders
        if (Height - P.Y < BorderSpace) or (P.X < BorderSpace) or (Width - P.X < BorderSpace) then
          Msg.Result := HTTRANSPARENT;
      end;
      alLeft: begin
        // we need to check left, top and bottom borders
        if (P.X < BorderSpace) or (P.Y < BorderSpace) or (Height - P.Y < BorderSpace) then
          Msg.Result := HTTRANSPARENT;
      end;
      alRight: begin
        // we need to check right, top and bottom borders
        if (Width - P.X < BorderSpace) or (P.Y < BorderSpace) or (Height - P.Y < BorderSpace) then
          Msg.Result := HTTRANSPARENT;
      end;
    end;
  end;
end;

procedure TUPanel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FThemeManager) then
    FThemeManager := nil;
end;

//  SETTERS

procedure TUPanel.SetCustomBackColor(const Value: TColor);
begin
  if FCustomBackColor <> Value then
    begin
      FCustomBackColor := Value;
      UpdateTheme;
    end;
end;

procedure TUPanel.SetCustomTextColor(const Value: TColor);
begin
  if FCustomTextColor <> Value then
    begin
      FCustomTextColor := Value;
      UpdateTheme;
    end;
end;

//  MAIN CLASS

constructor TUPanel.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  //  Old properties
  BevelOuter := bvNone;
  Font.Name := 'Segoe UI';
  Font.Size := 9;

  FHitTest := true;
  FCustomTextColor := $00000000;
  FCustomBackColor := $00E6E6E6;

  UpdateTheme;
end;

end.
