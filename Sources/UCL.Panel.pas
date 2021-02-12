unit UCL.Panel;

interface

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
  UCL.SystemSettings;

type
  TUPanel = class(TUCustomPanel)
  private
    FBackColor: TUThemeControlColorSet;

    //  Child events
    procedure BackColor_OnChange(Sender: TObject);

    //  Messages
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;

  protected

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Canvas;

    // IUThemedComponent
    procedure UpdateTheme; override;

  published
    property BackColor: TUThemeControlColorSet read FBackColor write FBackColor;

    property BevelOuter default bvNone;
    property ParentColor default False;
    property ParentBackground default False;
  end;

implementation

uses
  Types,
  Forms,
  UCL.ThemeManager,
  UCL.Form;

type
  TUFormAccess = class(TUForm);

{ TUPanel }

//  MAIN CLASS

constructor TUPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  //  Old properties
  BevelOuter := bvNone;
  ParentColor := False;
  ParentBackground := False;
//  Font.Name := 'Segoe UI';
//  Font.Size := 9;

  //  Objects
  FBackColor := TUThemeControlColorSet.Create;
  FBackColor.Assign(PANEL_BACK);
  FBackColor.OnChange := BackColor_OnChange;
end;

destructor TUPanel.Destroy;
begin
  FBackColor.Free;
  inherited;
end;

//  THEME

procedure TUPanel.UpdateTheme;
var
  TM: TUCustomThemeManager;
  ColorSet: TUThemeControlColorSet;
begin
  TM:=SelectThemeManager(Self);
  // Select default or custom style
  if BackColor.Enabled then
    ColorSet := BackColor
  else
    ColorSet := PANEL_BACK;

  Color := ColorSet.GetColor(TM);
  Font.Color := GetTextColorFromBackground(Color);

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

//  CHILD EVENTS

procedure TUPanel.BackColor_OnChange(Sender: TObject);
begin
  UpdateTheme;
end;

end.
