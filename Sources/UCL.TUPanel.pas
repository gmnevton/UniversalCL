unit UCL.TUPanel;

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
  ExtCtrls,
  Graphics,
  UCL.Classes,
  UCL.Colors,
  UCL.Utils,
  UCL.SystemSettings,
  UCL.TUThemeManager;

type
  TUPanel = class(TPanel, IUThemeComponent)
    private
      FThemeManager: TUThemeManager;
      FBackColor: TUThemeControlColorSet;

      //  Child events
      procedure BackColor_OnChange(Sender: TObject);
      
      //  Setters
      procedure SetThemeManager; // (const Value: TUThemeManager);

      //  Messages
      procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;

    protected
      //procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      procedure UpdateTheme;

    published
      property ThemeManager: TUThemeManager read FThemeManager; // write SetThemeManager;
      property BackColor: TUThemeControlColorSet read FBackColor write FBackColor;

      property BevelOuter default bvNone;
      property ParentColor default false;
      property ParentBackground default false;
  end;

implementation

uses
  Types,
  Forms,
  UCL.TUForm;

type
  TUFormAccess = class(TUForm);

{ TUPanel }

//  THEME

procedure TUPanel.SetThemeManager; // (const Value: TUThemeManager);
begin
  FThemeManager := GetCommonThemeManager;
  UpdateTheme;
end;

procedure TUPanel.UpdateTheme;
var
  Back: TUThemeControlColorSet;
begin
  if ThemeManager = Nil then begin // do nothing
//    Color := CustomBackColor;
//    Font.Color := CustomTextColor;
  end
  else begin
    //  Select default or custom style
    if not BackColor.Enabled then
      Back := PANEL_BACK
    else
      Back := BackColor;

    Color := Back.GetColor(ThemeManager);
    Font.Color := GetTextColorFromBackground(Color);
  end;  

  //  Repaint
  //  Do not repaint, because it does not override Paint method
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
    if ParentForm is TUForm then
      BorderSpace:=TUFormAccess(ParentForm).GetBorderSpace(bsDefault);
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
{
procedure TUPanel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FThemeManager) then
    FThemeManager := nil;
end;
}

//  MAIN CLASS

constructor TUPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FThemeManager := Nil;

  //  Old properties
  BevelOuter := bvNone;
  ParentColor := false;
  ParentBackground := false;
//  Font.Name := 'Segoe UI';
//  Font.Size := 9;

  //  Objects
  FBackColor := TUThemeControlColorSet.Create;
  FBackColor.OnChange := BackColor_OnChange;
  FBackColor.Assign(PANEL_BACK);

  if GetCommonThemeManager <> Nil then
    GetCommonThemeManager.Connect(Self);

//  UpdateTheme;
end;

destructor TUPanel.Destroy;
begin
  FBackColor.Free;
  if FThemeManager <> Nil then
    FThemeManager.Disconnect(Self);
  inherited;
end;

//  CHILD EVENTS

procedure TUPanel.BackColor_OnChange(Sender: TObject);
begin
  UpdateTheme;
end;

end.
