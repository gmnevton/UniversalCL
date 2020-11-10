unit UCL.QuickButton;

interface

{$IF CompilerVersion > 29}
  {$LEGACYIFEND ON}
{$IFEND}

uses
  Classes,
  Types,
  Messages,
  Controls,
  Graphics,
  Forms,
  UCL.Classes,
  UCL.Types,
  UCL.ThemeManager,
  UCL.Utils,
  UCL.Graphics;

type
  TUQuickButtonStyle = (sbsNone, sbsQuit, sbsMax, sbsMin, sbsSysButton, sbsHighlight);

  TUQuickButton = class(TUGraphicControl, IUThemedComponent)
  private var
    BackColor: TColor;
    TextColor: TColor;

  private
    FThemeManager: TUThemeManager;
    FButtonState: TUControlState;
    FButtonStyle: TUQuickButtonStyle;
    FLightColor: TColor;
    FDarkColor: TColor;
    FCustomAccentColor: TColor;
    FPressBrightnessDelta: Integer;
    FTransparent: Boolean;

    //  Internal
    procedure UpdateColors;

    //  Setters
    procedure SetThemeManager(const Value: TUThemeManager);
    procedure SetButtonState(const Value: TUControlState);
    procedure SetButtonStyle(const Value: TUQuickButtonStyle);
    procedure SetTransparent(const Value: Boolean);

    //  Messages
    procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;

  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // IUThemedComponent
    procedure UpdateTheme;
    function IsCustomThemed: Boolean;
    function CustomThemeManager: TUCustomThemeManager;

  published
    property ThemeManager: TUThemeManager read FThemeManager write SetThemeManager;
    property ButtonState: TUControlState read FButtonState write SetButtonState default csNone;
    property ButtonStyle: TUQuickButtonStyle read FButtonStyle write SetButtonStyle default sbsNone;

    property LightColor: TColor read FLightColor write FLightColor default $E6E6E6;
    property DarkColor: TColor read FDarkColor write FDarkColor default $191919;
    property CustomAccentColor: TColor read FCustomAccentColor write FCustomAccentColor default $D77800;
    property PressBrightnessDelta: Integer read FPressBrightnessDelta write FPressBrightnessDelta default 25;
    property Transparent: Boolean read FTransparent write SetTransparent default false;

    property Caption;
    property Height default 32;
    property Width default 45;
  end;

implementation

uses
  SysUtils,
  UCL.Colors;

{ TUQuickButton }

//  MAIN CLASS

constructor TUQuickButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FThemeManager := Nil;

  //  New props
  FButtonState := csNone;
  FLightColor := $E6E6E6;
  FDarkColor := $191919;
  FCustomAccentColor := $D77800;
  FPressBrightnessDelta := 25;
  FTransparent := False;

  //  Old props
  Caption := ''; //  Back icon
  Font.Name := 'Segoe MDL2 Assets';
  Font.Size := 10;
  Height := 32;
  Width := 45;

  if GetCommonThemeManager <> Nil then
    GetCommonThemeManager.Connect(Self);

  UpdateColors;
end;

destructor TUQuickButton.Destroy;
var
  TM: TUCustomThemeManager;
begin
  TM:=SelectThemeManager(Self);
  TM.Disconnect(Self);
  inherited;
end;

//  THEME

procedure TUQuickButton.SetThemeManager(const Value: TUThemeManager);
begin
  if (Value <> Nil) and (FThemeManager = Nil) then
    GetCommonThemeManager.Disconnect(Self);

  if (Value = Nil) and (FThemeManager <> Nil) then
    FThemeManager.Disconnect(Self);

  FThemeManager := Value;

  if FThemeManager <> Nil then
    FThemeManager.Connect(Self);

  if FThemeManager = Nil then
    GetCommonThemeManager.Connect(Self);

  UpdateTheme;
end;

procedure TUQuickButton.UpdateTheme;
begin
  UpdateColors;
  Repaint;
end;

function TUQuickButton.IsCustomThemed: Boolean;
begin
  Result:=(FThemeManager <> Nil);
end;

function TUQuickButton.CustomThemeManager: TUCustomThemeManager;
begin
  Result:=FThemeManager;
end;

procedure TUQuickButton.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FThemeManager) then begin
    ThemeManager:=Nil;
    Exit;
  end;
  inherited Notification(AComponent, Operation);
end;

//  INTERNAL

procedure TUQuickButton.UpdateColors;
var
  TM: TUCustomThemeManager;
begin
  TM := SelectThemeManager(Self);
  case ButtonState of
    csNone:  begin
      if not Transparent then begin
        ParentColor := True;
        BackColor := Color;
      end
      else begin
        TextColor := Font.Color;
        Exit;
      end;
    end;

    csHover: begin
      if not TM.UseSystemAccentColor then
        BackColor := CustomAccentColor
      else if TM.ThemeUsed = utLight then
        BackColor := LightColor
      else
        BackColor := DarkColor;
    end;

    csPress: begin
      if not TM.UseSystemAccentColor then
        BackColor := BrightenColor(LightColor, PressBrightnessDelta)
      else if TM.ThemeUsed = utLight then
        BackColor := BrightenColor(LightColor, PressBrightnessDelta)
      else
        BackColor := BrightenColor(DarkColor, -PressBrightnessDelta);
    end;

    csDisabled: begin
      BackColor := $666666;
    end;

    csFocused: begin
      if not TM.UseSystemAccentColor then
        BackColor := LightColor
      else if TM.ThemeUsed = utLight then
        BackColor := LightColor
      else
        BackColor := DarkColor;
    end;
  end;
  TextColor := GetTextColorFromBackground(BackColor);
end;

//  SETTERS

procedure TUQuickButton.SetButtonState(const Value: TUControlState);
begin
  if Value <> FButtonState then begin
    FButtonState := Value;
    UpdateColors;
    Repaint;
  end;
end;

procedure TUQuickButton.SetButtonStyle(const Value: TUQuickButtonStyle);
var
  TM: TUCustomThemeManager;
begin
  TM := SelectThemeManager(Self);
  if Value <> FButtonStyle then begin
    FButtonStyle := Value;

    case FButtonStyle of
      sbsNone: begin
        FLightColor := $CFCFCF;
        FDarkColor := $3C3C3C;
      end;
      sbsQuit: begin
        FLightColor := $002311E8;
        FDarkColor := $002311E8;
        FPressBrightnessDelta := 32;
        Caption := ''; //  Close icon
      end;
      sbsSysButton,
      sbsMax,
      sbsMin: begin
        FLightColor := $CFCFCF;
        FDarkColor := $3C3C3C;
        FPressBrightnessDelta := -32;
        case FButtonStyle of
          sbsMax      : Caption := '';
          sbsMin      : Caption := '';
          sbsSysButton: Caption := '';
        end;
      end;
      sbsHighlight: begin
        if not TM.UseSystemAccentColor then
          FLightColor := FCustomAccentColor
        else
          FLightColor := TM.AccentColor;
        FDarkColor := FLightColor;
        FPressBrightnessDelta := 25;
        Caption := '';
      end;
    end;

    UpdateTheme;
  end;
end;

procedure TUQuickButton.SetTransparent(const Value: Boolean);
begin
  if Value <> FTransparent then begin
    FTransparent := Value;
    UpdateColors;
    Repaint;
  end;
end;

//  CUSTOM METHODS

procedure TUQuickButton.Paint;
var
  TextRect: TRect;
begin
//  inherited Paint; // no need to call TGraphicControl.Paint, because it is empty procedure

  if not Transparent or (ButtonState <> csNone) then begin //  Paint background
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Handle := CreateSolidBrushWithAlpha(BackColor, 255);
    Canvas.FillRect(Rect(0, 0, Width, Height));
  end;

  //  Draw text
  Canvas.Brush.Style := bsClear;
  Canvas.Font := Font;
  Canvas.Font.Color := TextColor;

  TextRect := Rect(0, 0, Width, Height);
  DrawTextRect(Canvas, taCenter, taVerticalCenter, TextRect, Caption, True);
end;

//  MESSAGES

procedure TUQuickButton.WMLButtonDblClk(var Msg: TWMLButtonDblClk);
begin
  if Enabled then begin
    ButtonState := csPress;
    inherited;
  end;
end;

procedure TUQuickButton.WMLButtonDown(var Msg: TWMLButtonDown);
begin
  if Enabled then begin
    ButtonState := csPress;
    inherited;
  end;
end;

procedure TUQuickButton.WMLButtonUp(var Msg: TWMLButtonUp);
var
  ParentForm: TCustomForm;
begin
  if Enabled then begin
    ButtonState := csHover;

    case ButtonStyle of
      sbsQuit: begin
        ParentForm := GetParentForm(Self, True);
        if ParentForm = Nil then
          Exit;
        ParentForm.Close;
      end;

      sbsMax: begin
        ParentForm := GetParentForm(Self, True);
        if ParentForm = Nil then
          Exit;
        if ParentForm.WindowState = wsMaximized then
          ParentForm.WindowState := wsNormal
        else
          ParentForm.WindowState := wsMaximized;
      end;

      sbsMin: begin
        ParentForm := GetParentForm(Self, True);
        if ParentForm = Nil then
          Exit;
        ParentForm.WindowState := wsMinimized;
      end;
    end;
    inherited;
  end;
end;

procedure TUQuickButton.CMMouseEnter(var Msg: TMessage);
begin
  if Enabled then begin
    ButtonState := csHover;
    inherited;
  end;
end;

procedure TUQuickButton.CMMouseLeave(var Msg: TMessage);
begin
  if Enabled then begin
    ButtonState := csNone;
    inherited;
  end;
end;

end.
