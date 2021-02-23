unit UCL.QuickButton;

interface

uses
  Classes,
  Types,
  Messages,
  Controls,
  Graphics,
  Forms,
  UCL.Classes,
  UCL.Types,
  UCL.Utils,
  UCL.Graphics;

type
  TUQuickButtonStyle = (qbsNone, qbsQuit, qbsMax, qbsMin, qbsSysButton, qbsHighlight);

  TUQuickButton = class(TUGraphicControl)
  private var
    BackColor: TColor;
    TextColor: TColor;

  private
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
    procedure SetButtonState(const Value: TUControlState);
    procedure SetButtonStyle(const Value: TUQuickButtonStyle);
    procedure SetTransparent(const Value: Boolean);

    //  Messages
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;

  protected
    procedure Paint; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // IUThemedComponent
    procedure UpdateTheme; override;

  published
    property ButtonState: TUControlState read FButtonState write SetButtonState default csNone;
    property ButtonStyle: TUQuickButtonStyle read FButtonStyle write SetButtonStyle default qbsSysButton;

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
  Windows,
  UCL.ThemeManager,
  UCL.Colors,
  UCL.FontIcons,
  UCL.Form;

{ TUQuickButton }

//  MAIN CLASS

constructor TUQuickButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csDoubleClicks];

  //  New props
  FButtonState := csNone;
  FButtonStyle := qbsSysButton;
  FLightColor := $E6E6E6;
  FDarkColor := $191919;
  FCustomAccentColor := $D77800;
  FPressBrightnessDelta := 25;
  FTransparent := False;

  //  Old props
  Caption := UF_HOME; // Back icon
  Font.Name := 'Segoe MDL2 Assets';
  Font.Size := 10;
  Height := 32;
  Width := 45;

  UpdateColors;
end;

destructor TUQuickButton.Destroy;
begin
  inherited;
end;

//  THEME

procedure TUQuickButton.UpdateTheme;
begin
  UpdateColors;
  Repaint;
//  Invalidate;
end;

//  INTERNAL

procedure TUQuickButton.UpdateColors;
var
  TM: TUCustomThemeManager;
  IsDark: Boolean;
  BaseColor, AccentColor: TColor;
begin
  TM := SelectThemeManager(Self);
  IsDark := (TM <> Nil) and (TM.ThemeUsed = utDark);
  AccentColor := SelectAccentColor(TM, CustomAccentColor);

  if ButtonState = csNone then begin
    if not Transparent then begin
      ParentColor := True;
      BackColor := Color;
    end
    else begin
      TextColor := Font.Color;
      Exit;
    end;
  end
  else begin
    BaseColor:=clNone; // satisfy compiler
    // select base color
    case ButtonStyle of
      qbsNone: ;
      qbsQuit: BaseColor := $002311E8;
      qbsHighlight: BaseColor := AccentColor;
      //qbsMax: ;
      //qbsMin: ;
      //qbsSysButton: ;
    else
      begin
        ParentColor := True;
        BaseColor := Color;
      end;
    end;
    //
    // change BaseColor to BackColor
    case ButtonState of
      csHover: begin
        if ButtonStyle in [qbsNone, qbsMax, qbsMin, qbsSysButton] then begin
          BackColor := BrightenColor(BaseColor, PressBrightnessDelta);
        end
        else
          BackColor := BaseColor;
      end;
      csPress: begin
        if ButtonStyle in [qbsQuit, qbsHighlight] then begin
          BackColor := BrightenColor(BaseColor, PressBrightnessDelta);
        end
        else begin
          if IsDark then
            BackColor := ColorChangeLightness(BaseColor, 180)
          else
            BackColor := ColorChangeLightness(BaseColor, 100);
        end;
      end;
    end;
  end;
{
  case ButtonState of
    csHover: begin
      if CustomAccentColor = clDefault then
        BackColor := SelectAccentColor(TM, CustomAccentColor)
      else if CustomAccentColor = clNone then begin
        case ButtonStyle of
          qbsQuit: begin
            //FLightColor := $002311E8;
            //FDarkColor := $002311E8;
            BackColor := $002311E8;
          end;
          qbsMax,
          qbsMin,
          qbsSysButton: begin
            ParentColor := True;
            BackColor := Color;
            BackColor := BrightenColor(BackColor, PressBrightnessDelta);
          end;
          qbsHighlight: begin
            if TM.UseSystemAccentColor then
              BackColor := SelectAccentColor(TM, CustomAccentColor)
            else begin
              if TM.ThemeUsed = utLight then
                BackColor := LightColor
              else
                BackColor := DarkColor;
            end;
          end;
        else
          if TM.ThemeUsed = utLight then
            BackColor := LightColor
          else
            BackColor := DarkColor;
        end;
      end
      else
        BackColor := CustomAccentColor;
    end;

    csPress: begin
//      if not TM.UseSystemAccentColor then
//        BackColor := BrightenColor(LightColor, PressBrightnessDelta)
//      else if TM.ThemeUsed = utLight then
//        BackColor := BrightenColor(LightColor, PressBrightnessDelta)
//      else
//        BackColor := BrightenColor(DarkColor, -PressBrightnessDelta);
      BackColor := BrightenColor(BackColor, PressBrightnessDelta)
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
}
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
      qbsNone: begin
        FLightColor := $CFCFCF;
        FDarkColor := $3C3C3C;
      end;
      qbsQuit: begin
        FLightColor := $002311E8;
        FDarkColor := $002311E8;
        FCustomAccentColor := clNone;
        FPressBrightnessDelta := 32;
        Caption := UF_CLOSE; // Close icon
      end;
      qbsSysButton,
      qbsMax,
      qbsMin: begin
        ParentColor := True;
        FLightColor := Color;
        FDarkColor := Color;
        FCustomAccentColor := clNone;
        FPressBrightnessDelta := 32;
        case FButtonStyle of
          qbsMax      : Caption := UF_MAXIMIZE;
          qbsMin      : Caption := UF_MINIMIZE;
          qbsSysButton: Caption := UF_HOME;
        end;
      end;
      qbsHighlight: begin
        if not TM.UseSystemAccentColor or ((CustomAccentColor <> clNone) and (CustomAccentColor <> clDefault)) then
          FLightColor := CustomAccentColor
        else
          FLightColor := TM.AccentColor;
        FDarkColor := FLightColor;
        FCustomAccentColor := clDefault;
        FPressBrightnessDelta := 25;
        //Caption := UF_BACK;
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
  FullScreen: Boolean;
  MousePoint: TPoint;
  Restore: Boolean;
begin
  if not Enabled then
    Exit;
  //
  ParentForm := GetParentForm(Self, True);
  MousePoint := ScreenToClient(Mouse.CursorPos);
  if PtInRect(GetClientRect, MousePoint) then begin
    //  Default actions for Quit, Max, Min sysbutton
    if ButtonStyle in [qbsQuit, qbsMax, qbsMin] then begin
      if ParentForm is TUForm then
        FullScreen := (ParentForm as TUForm).FullScreen
      else
        FullScreen := False;
      //
      case ButtonStyle of
        qbsQuit: begin
          if ParentForm <> Nil then
            ParentForm.Close;
        end;

        qbsMax: begin
          if (ParentForm <> Nil) and not FullScreen then begin
            ReleaseCapture;
            Restore:=(ParentForm.WindowState <> wsNormal);
            if Restore then
              Caption := UF_MAXIMIZE
            else
              Caption := UF_RESTORE;
            //
            if Restore then
              SendMessage(ParentForm.Handle, WM_SYSCOMMAND, SC_RESTORE, 0)
            else
              SendMessage(ParentForm.Handle, WM_SYSCOMMAND, SC_MAXIMIZE, 0);
          end;
        end;

        qbsMin: begin
          if ParentForm <> Nil then
            ParentForm.WindowState := wsMinimized;
        end;
      end;
    end;
  end;

  ButtonState := csHover;
  inherited;
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
