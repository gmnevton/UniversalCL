unit UCL.Colors;

interface

uses
  SysUtils,
  Classes,
  Controls,
  Graphics,
  UCL.Types,
  UCL.ThemeManager;
  
type
  TUThemeColorSet = class(TPersistent)
  private
    FEnabled: Boolean;
    FOnChange: TNotifyEvent;

    procedure SetEnabled(const Value: Boolean);

  protected
    procedure SetColor(Index: Integer; const Value: TColor); virtual; abstract;
    procedure Changed; virtual;

  public
    constructor Create; overload; virtual;
    procedure AfterConstruction; override;

    procedure Assign(Source: TPersistent); override;
    procedure SetColors; overload; virtual; abstract; // set defaults
    function GetColor(const TM: TUCustomThemeManager): TColor; overload; virtual; abstract;

  published
    property Enabled: Boolean read FEnabled write SetEnabled;   //  No default
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TUThemeControlColorSet = class(TUThemeColorSet)
  private
    FColor: TColor;
    FLightColor: TColor;
    FDarkColor: TColor;

  protected
    procedure SetColor(Index: Integer; const Value: TColor); override;

  public
    constructor Create; override;
    constructor Create(Color, LightColor, DarkColor: TColor); overload;

    procedure Assign(Source: TPersistent); override;
    procedure SetColors; overload; override; // set defaults
    procedure SetColors(Color, LightColor, DarkColor: TColor); overload;
    function GetColor(const TM: TUCustomThemeManager): TColor; override;

  published
    property Color: TColor index 0 read FColor write SetColor;
    property LightColor: TColor index 1 read FLightColor write SetColor;
    property DarkColor: TColor index 2 read FDarkColor write SetColor;
  end;

  TUStateColorsSet = record
    Color: TColor;
    Hover: TColor;
    Press: TColor;
    SelectedColor: TColor;
    SelectedHover: TColor;
    SelectedPress: TColor;
  end;

  TUThemeControlStateColors = class(TUThemeColorSet)
  private
    FLightSet: TUStateColorsSet;
    FDarkSet : TUStateColorsSet;

  protected
    procedure SetColor(Index: Integer; const Value: TColor); override;

  public
    constructor Create; override;

    procedure Assign(Source: TPersistent); override;
    procedure SetColors; overload; override; // set defaults
    procedure SetColors(const Theme: TUTheme; Color, Hover, Press, SelColor, SelHover, SelPress: TColor); overload;
    function GetColor(const Theme: TUTheme; State: TUControlState; Selected: Boolean): TColor; overload;

  published
    property LightColor: TColor index 0 read FLightSet.Color write SetColor;
    property LightHover: TColor index 1 read FLightSet.Hover write SetColor;
    property LightPress: TColor index 2 read FLightSet.Press write SetColor;
    property LightSelectedColor: TColor index 3 read FLightSet.SelectedColor write SetColor;
    property LightSelectedHover: TColor index 4 read FLightSet.SelectedHover write SetColor;
    property LightSelectedPress: TColor index 5 read FLightSet.SelectedPress write SetColor;
    //
    property DarkColor: TColor index 6 read FDarkSet.Color write SetColor;
    property DarkHover: TColor index 7 read FDarkSet.Hover write SetColor;
    property DarkPress: TColor index 8 read FDarkSet.Press write SetColor;
    property DarkSelectedColor: TColor index 9 read FDarkSet.SelectedColor write SetColor;
    property DarkSelectedHover: TColor index 10 read FDarkSet.SelectedHover write SetColor;
    property DarkSelectedPress: TColor index 11 read FDarkSet.SelectedPress write SetColor;
  end;

  TUControlStateColorSet = record
    Color: TColor;
    Hover: TColor;
    Press: TColor;
    Disabled: TColor;
    Focused: TColor;
  end;

  TUThemeFocusableControlStateColors = class(TUThemeColorSet)
  private
    FLightSet: TUControlStateColorSet;
    FDarkSet : TUControlStateColorSet;

  protected
    procedure SetColor(Index: Integer; const Value: TColor); override;

  public
    constructor Create; override;
    //constructor Create(Color, Hover, Press, SelColor, SelHover, SelPress: TColor); overload;

    procedure Assign(Source: TPersistent); override;
    procedure SetColors; overload; override; // set defaults
    procedure SetColors(const Theme: TUTheme; Color, Hover, Press, Disabled, Focused: TColor); overload;
    function GetColor(const Theme: TUTheme; const State: TUControlState): TColor; overload;

  published
    property LightColor: TColor index 0 read FLightSet.Color write SetColor;
    property LightHover: TColor index 1 read FLightSet.Hover write SetColor;
    property LightPress: TColor index 2 read FLightSet.Press write SetColor;
    property LightDisabled: TColor index 3 read FLightSet.Disabled write SetColor;
    property LightFocused: TColor index 4 read FLightSet.Focused write SetColor;
    //
    property DarkColor: TColor index 5 read FDarkSet.Color write SetColor;
    property DarkHover: TColor index 6 read FDarkSet.Hover write SetColor;
    property DarkPress: TColor index 7 read FDarkSet.Press write SetColor;
    property DarkDisabled: TColor index 8 read FDarkSet.Disabled write SetColor;
    property DarkFocused: TColor index 9 read FDarkSet.Focused write SetColor;
  end;

  TUThemeButtonStateColorSet = class(TUThemeFocusableControlStateColors);

  TUThemeControlWithFocusColorSet = class(TUThemeControlColorSet)
  private
    FFocusedLightColor: TColor;
    FFocusedDarkColor: TColor;

  protected
    procedure SetColor(Index: Integer; const Value: TColor); override;

  public
    constructor Create; override;
    //constructor Create(Color, LightColor, DarkColor, FocusedLightColor, FocusedDarkColor: TColor); overload;

    procedure Assign(Source: TPersistent); override;
    procedure SetColors; overload; override; // set defaults
    procedure SetColors(Color, LightColor, DarkColor, FocusedLightColor, FocusedDarkColor: TColor); overload;
    procedure SetColors(FocusedLightColor, FocusedDarkColor: TColor); overload;
    function GetColor(const TM: TUCustomThemeManager; const Focused: Boolean): TColor; overload;

  published
    property FocusedLightColor: TColor index 3 read FFocusedLightColor write SetColor;
    property FocusedDarkColor: TColor index 4 read FFocusedDarkColor write SetColor;
  end;

  TUThemeCaptionBarColorSet = class(TUThemeControlWithFocusColorSet);

var
//  MINI_SB_COLOR,
  MINI_SB_COLOR_LIGHT,
  MINI_SB_COLOR_DARK: TColor;
  //SCROLLBOX_BACK,
  //SCROLLBOX_BACK_LIGHT,
  //SCROLLBOX_BACK_DARK: TColor;

  // Tooltip
  TOOLTIP_SHADOW: Boolean;
  TOOLTIP_BORDER_THICKNESS: Byte;
  TOOLTIP_FONT_NAME: String;
  TOOLTIP_FONT_SIZE: Byte;
  TOOLTIP_BACK: TUThemeControlColorSet;
  TOOLTIP_BORDER: TUThemeControlColorSet;

  // Form
  FORM_FONT_NAME: String;
  FORM_FONT_SIZE: Byte;
  FORM_BACK: TUThemeControlColorSet;

  // Popup menu
  POPUP_BACK: TUThemeControlColorSet;

  // Progress bar
  PROGRESSBAR_BACK: TUThemeControlColorSet;

  // Panel
  PANEL_BACK: TUThemeControlColorSet;
  
  // Scrollbox
  SCROLLBOX_BACK: TUThemeControlColorSet;
  
  // Caption bar
  CAPTIONBAR_BACK: TUThemeCaptionBarColorSet;

  // Button
  BUTTON_BACK: TUThemeButtonStateColorSet;
  BUTTON_BORDER: TUThemeButtonStateColorSet;
  
  // List button
  LISTBUTTON_BACK: TUThemeControlColorSet;

  // Quick button
  QUICKBUTTON_BACK: TUThemeControlColorSet;

  // Slider
  SLIDER_BACK: TUThemeFocusableControlStateColors;
  SLIDER_CURSOR: TUThemeFocusableControlStateColors;

  // Hyperlink
  HYPERLINK_FONT_NAME: String;
  HYPERLINK_FONT_SIZE: Byte;
  HYPERLINK_TEXT: TUThemeControlColorSet;

  // Edit
  EDIT_BACK: TUThemeControlWithFocusColorSet;
  EDIT_BORDER: TUThemeControlWithFocusColorSet;

  DETAIL_COLOR: TColor;
  DETAIL_COLOR_HIGHLIGHED: TColor;

implementation

uses
  Forms,
  UCL.Form;

{ TUThemeColorSet }

constructor TUThemeColorSet.Create;
begin
  inherited Create;
  FEnabled := False;
end;

procedure TUThemeColorSet.AfterConstruction;
begin
  inherited;
  Changed;
end;

procedure TUThemeColorSet.Assign(Source: TPersistent);
begin
  if Source is TUThemeColorSet then begin
    FEnabled := (Source as TUThemeColorSet).Enabled;
    Changed;
  end
  else
    inherited;
end;

procedure TUThemeColorSet.SetEnabled(const Value: Boolean);
begin
  if Value <> FEnabled then begin
    FEnabled := Value;
    Changed;
  end;
end;

procedure TUThemeColorSet.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

{ TUThemeControlColorSet }

constructor TUThemeControlColorSet.Create;
begin
  inherited;
  SetColors;
end;

constructor TUThemeControlColorSet.Create(Color, LightColor, DarkColor: TColor);
begin
  Create;
  SetColors(Color, LightColor, DarkColor);
end;

procedure TUThemeControlColorSet.Assign(Source: TPersistent);
var
  SourceObject: TUThemeControlColorSet;
begin
  if Source is TUThemeControlColorSet then begin
    SourceObject:=TUThemeControlColorSet(Source);
    //
    FColor      := SourceObject.Color;
    FLightColor := SourceObject.LightColor;
    FDarkColor  := SourceObject.DarkColor;
  end;
  inherited Assign(Source); // must be last - changed is called here
end;

procedure TUThemeControlColorSet.SetColors;
begin
  FColor      := $00000000;
  FLightColor := $00000000;
  FDarkColor  := $00000000;
end;

procedure TUThemeControlColorSet.SetColors(Color, LightColor, DarkColor: TColor);
begin
  FColor      := Color;
  FLightColor := LightColor;
  FDarkColor  := DarkColor;
end;

procedure TUThemeControlColorSet.SetColor(Index: Integer; const Value: TColor);
begin
  case Index of
    0: if Value <> FColor then begin
      FColor := Value;
    end
    else
      Exit;

    1: if Value <> FLightColor then begin
      FLightColor := Value;
    end
    else
      Exit;

    2: if Value <> FDarkColor then begin
      FDarkColor := Value;
    end
    else
      Exit;
  else
    Exit;
  end;
  Changed;
end;

function TUThemeControlColorSet.GetColor(const TM: TUCustomThemeManager): TColor;
begin
  if TM = Nil then
    Result := Color
  else begin
    if TM.ThemeUsed = utLight then
      Result := LightColor
    else
      Result := DarkColor;
  end;
end;

{ TUThemeControlStateColors }

constructor TUThemeControlStateColors.Create;
begin
  inherited Create;
  SetColors;
end;

procedure TUThemeControlStateColors.Assign(Source: TPersistent);
var
  SourceObject: TUThemeControlStateColors;
begin
  if Source is TUThemeControlStateColors then begin
    SourceObject:=TUThemeControlStateColors(Source);
    //
    FLightSet := SourceObject.FLightSet;
    FDarkSet  := SourceObject.FDarkSet;
  end;
  inherited Assign(Source); // must be last - changed is called here
end;

procedure TUThemeControlStateColors.SetColors;
begin
  FLightSet.Color    := $00000000;
  FLightSet.Hover    := $00000000;
  FLightSet.Press    := $00000000;
  FLightSet.SelectedColor := $00000000;
  FLightSet.SelectedHover := $00000000;
  FLightSet.SelectedPress := $00000000;
  //
  FDarkSet.Color    := $00000000;
  FDarkSet.Hover    := $00000000;
  FDarkSet.Press    := $00000000;
  FDarkSet.SelectedColor := $00000000;
  FDarkSet.SelectedHover := $00000000;
  FDarkSet.SelectedPress := $00000000;
end;

procedure TUThemeControlStateColors.SetColors(const Theme: TUTheme; Color, Hover, Press, SelColor, SelHover, SelPress: TColor);
begin
  if Theme = utLight then begin
    FLightSet.Color    := Color;
    FLightSet.Hover    := Hover;
    FLightSet.Press    := Press;
    FLightSet.SelectedColor := SelColor;
    FLightSet.SelectedHover := SelHover;
    FLightSet.SelectedPress := SelPress;
  end
  else begin
    FDarkSet.Color    := Color;
    FDarkSet.Hover    := Hover;
    FDarkSet.Press    := Press;
    FDarkSet.SelectedColor := SelColor;
    FDarkSet.SelectedHover := SelHover;
    FDarkSet.SelectedPress := SelPress;
  end;
end;

procedure TUThemeControlStateColors.SetColor(Index: Integer; const Value: TColor);
begin
  case Index of
    0: if Value <> FLightSet.Color then begin
      FLightSet.Color := Value;
    end
    else
      Exit;

    1: if Value <> FLightSet.Hover then begin
      FLightSet.Hover := Value;
    end
    else
      Exit;

    2: if Value <> FLightSet.Press then begin
      FLightSet.Press := Value;
    end
    else
      Exit;

    3: if Value <> FLightSet.SelectedColor then begin
      FLightSet.SelectedColor := Value;
    end
    else
      Exit;

    4: if Value <> FLightSet.SelectedHover then begin
      FLightSet.SelectedHover := Value;
    end
    else
      Exit;

    5: if Value <> FLightSet.SelectedPress then begin
      FLightSet.SelectedPress := Value;
    end
    else
      Exit;

    ///////////////////////////////////////////////////////////////

    6: if Value <> FDarkSet.Color then begin
      FDarkSet.Color := Value;
    end
    else
      Exit;

    7: if Value <> FDarkSet.Hover then begin
      FDarkSet.Hover := Value;
    end
    else
      Exit;

    8: if Value <> FDarkSet.Press then begin
      FDarkSet.Press := Value;
    end
    else
      Exit;

    9: if Value <> FDarkSet.SelectedColor then begin
      FDarkSet.SelectedColor := Value;
    end
    else
      Exit;

    10: if Value <> FDarkSet.SelectedHover then begin
      FDarkSet.SelectedHover := Value;
    end
    else
      Exit;

    11: if Value <> FDarkSet.SelectedPress then begin
      FDarkSet.SelectedPress := Value;
    end
    else
      Exit;
  end;
  Changed;
end;

function TUThemeControlStateColors.GetColor(const Theme: TUTheme; State: TUControlState; Selected: Boolean): TColor;
begin
  Result := clNone; // satisfy compiler
  if Theme = utLight then begin
    if not Selected then begin
      case State of
        csNone : Result := FLightSet.Color;
        csHover: Result := FLightSet.Hover;
        csPress: Result := FLightSet.Press;
      end;
    end
    else begin
      case State of
        csNone : Result := FLightSet.SelectedColor;
        csHover: Result := FLightSet.SelectedHover;
        csPress: Result := FLightSet.SelectedPress;
      end;
    end;
  end
  else begin
    if not Selected then begin
      case State of
        csNone : Result := FDarkSet.Color;
        csHover: Result := FDarkSet.Hover;
        csPress: Result := FDarkSet.Press;
      end;
    end
    else begin
      case State of
        csNone : Result := FDarkSet.SelectedColor;
        csHover: Result := FDarkSet.SelectedHover;
        csPress: Result := FDarkSet.SelectedPress;
      end;
    end;
  end
end;

{ TUThemeFocusableControlStateColors }

constructor TUThemeFocusableControlStateColors.Create;
begin
  inherited Create;
  SetColors;
end;

procedure TUThemeFocusableControlStateColors.Assign(Source: TPersistent);
var
  SourceObject: TUThemeFocusableControlStateColors;
begin
  if Source is TUThemeFocusableControlStateColors then begin
    SourceObject:=TUThemeFocusableControlStateColors(Source);
    //
    FLightSet := SourceObject.FLightSet;
    FDarkSet  := SourceObject.FDarkSet;
  end;
  inherited Assign(Source); // must be last - changed is called here
end;

procedure TUThemeFocusableControlStateColors.SetColors;
begin
  FLightSet.Color    := $00000000;
  FLightSet.Hover    := $00000000;
  FLightSet.Press    := $00000000;
  FLightSet.Disabled := $00000000;
  FLightSet.Focused  := $00000000;
  //
  FDarkSet.Color    := $00000000;
  FDarkSet.Hover    := $00000000;
  FDarkSet.Press    := $00000000;
  FDarkSet.Disabled := $00000000;
  FDarkSet.Focused  := $00000000;
end;

procedure TUThemeFocusableControlStateColors.SetColors(const Theme: TUTheme; Color, Hover, Press, Disabled, Focused: TColor);
begin
  if Theme = utLight then begin
    FLightSet.Color    := Color;
    FLightSet.Hover    := Hover;
    FLightSet.Press    := Press;
    FLightSet.Disabled := Disabled;
    FLightSet.Focused  := Focused;
  end
  else begin
    FDarkSet.Color    := Color;
    FDarkSet.Hover    := Hover;
    FDarkSet.Press    := Press;
    FDarkSet.Disabled := Disabled;
    FDarkSet.Focused  := Focused;
  end;
end;

procedure TUThemeFocusableControlStateColors.SetColor(Index: Integer; const Value: TColor);
begin
  case Index of
    0: if Value <> FLightSet.Color then begin
      FLightSet.Color := Value;
    end
    else
      Exit;

    1: if Value <> FLightSet.Hover then begin
      FLightSet.Hover := Value;
    end
    else
      Exit;

    2: if Value <> FLightSet.Press then begin
      FLightSet.Press := Value;
    end
    else
      Exit;

    3: if Value <> FLightSet.Disabled then begin
      FLightSet.Disabled := Value;
    end
    else
      Exit;

    4: if Value <> FLightSet.Focused then begin
      FLightSet.Focused := Value;
    end
    else
      Exit;

    ///////////////////////////////////////////////////////////////

    5: if Value <> FDarkSet.Color then begin
      FDarkSet.Color := Value;
    end
    else
      Exit;

    6: if Value <> FDarkSet.Hover then begin
      FDarkSet.Hover := Value;
    end
    else
      Exit;

    7: if Value <> FDarkSet.Press then begin
      FDarkSet.Press := Value;
    end
    else
      Exit;

    8: if Value <> FDarkSet.Disabled then begin
      FDarkSet.Disabled := Value;
    end
    else
      Exit;

    9: if Value <> FDarkSet.Focused then begin
      FDarkSet.Focused := Value;
    end
    else
      Exit;
  end;
  Changed;
end;

function TUThemeFocusableControlStateColors.GetColor(const Theme: TUTheme; const State: TUControlState): TColor;
begin
  Result := clNone; // satisfy compiler
  if Theme = utLight then begin
    case State of
      csNone    : Result := FLightSet.Color;
      csHover   : Result := FLightSet.Hover;
      csPress   : Result := FLightSet.Press;
      csDisabled: Result := FLightSet.Disabled;
      csFocused : Result := FLightSet.Focused;
    end;
  end
  else begin
    case State of
      csNone    : Result := FDarkSet.Color;
      csHover   : Result := FDarkSet.Hover;
      csPress   : Result := FDarkSet.Press;
      csDisabled: Result := FDarkSet.Disabled;
      csFocused : Result := FDarkSet.Focused;
    end;
  end
end;

(*
{ TUThemeButtonStateColorSet }

constructor TUThemeButtonStateColorSet.Create;
begin
  inherited;
  SetColors;
end;

{
constructor TUThemeButtonStateColorSet.Create(Color, Hover, Press, SelColor, SelHover, SelPress: TColor);
begin
  Create;
  SetColors(Color, Hover, Press, SelColor, SelHover, SelPress);
end;
}

procedure TUThemeButtonStateColorSet.Assign(Source: TPersistent);
var
  SourceObject: TUThemeButtonStateColorSet;
begin
  if Source is TUThemeButtonStateColorSet then begin
    SourceObject:=TUThemeButtonStateColorSet(Source);
    //
    FLightSet.Color := SourceObject.LightColor;
    FLightSet.Hover := SourceObject.LightHover;
    FLightSet.Press := SourceObject.LightPress;
    FLightSet.SelectedColor := SourceObject.LightSelectedColor;
    FLightSet.SelectedHover := SourceObject.LightSelectedHover;
    FLightSet.SelectedPress := SourceObject.LightSelectedPress;
    //
    FDarkSet.Color := SourceObject.DarkColor;
    FDarkSet.Hover := SourceObject.DarkHover;
    FDarkSet.Press := SourceObject.DarkPress;
    FDarkSet.SelectedColor := SourceObject.DarkSelectedColor;
    FDarkSet.SelectedHover := SourceObject.DarkSelectedHover;
    FDarkSet.SelectedPress := SourceObject.DarkSelectedPress;
  end;
  inherited Assign(Source); // must be last - changed is called here
end;

procedure TUThemeButtonStateColorSet.SetColors;
begin
  FLightSet.Color := $00000000;
  FLightSet.Hover := $00000000;
  FLightSet.Press := $00000000;
  FLightSet.SelectedColor := $00000000;
  FLightSet.SelectedHover := $00000000;
  FLightSet.SelectedPress := $00000000;
  //
  FDarkSet.Color := $00000000;
  FDarkSet.Hover := $00000000;
  FDarkSet.Press := $00000000;
  FDarkSet.SelectedColor := $00000000;
  FDarkSet.SelectedHover := $00000000;
  FDarkSet.SelectedPress := $00000000;
end;

procedure TUThemeButtonStateColorSet.SetColors(const Theme: TUTheme; Color, Hover, Press, SelColor, SelHover, SelPress: TColor);
begin
  if Theme = utLight then begin
    FLightSet.Color := Color;
    FLightSet.Hover := Hover;
    FLightSet.Press := Press;
    FLightSet.SelectedColor := SelColor;
    FLightSet.SelectedHover := SelHover;
    FLightSet.SelectedPress := SelPress;
  end
  else if Theme = utDark then begin
    FDarkSet.Color := Color;
    FDarkSet.Hover := Hover;
    FDarkSet.Press := Press;
    FDarkSet.SelectedColor := SelColor;
    FDarkSet.SelectedHover := SelHover;
    FDarkSet.SelectedPress := SelPress;
  end;
end;

procedure TUThemeButtonStateColorSet.SetColor(Index: Integer; const Value: TColor);
begin
  case Index of
    0: if Value <> FLightSet.Color then begin
      FLightSet.Color := Value;
    end
    else
      Exit;

    1: if Value <> FLightSet.Hover then begin
      FLightSet.Hover := Value;
    end
    else
      Exit;

    2: if Value <> FLightSet.Press then begin
      FLightSet.Press := Value;
    end
    else
      Exit;

    3: if Value <> FLightSet.SelectedColor then begin
      FLightSet.SelectedColor := Value;
    end
    else
      Exit;

    4: if Value <> FLightSet.SelectedHover then begin
      FLightSet.SelectedHover := Value;
    end
    else
      Exit;

    5: if Value <> FLightSet.SelectedPress then begin
      FLightSet.SelectedPress := Value;
    end
    else
      Exit;

    ///////////////////////////////////////////////////////////////

    6: if Value <> FDarkSet.Color then begin
      FDarkSet.Color := Value;
    end
    else
      Exit;

    7: if Value <> FDarkSet.Hover then begin
      FDarkSet.Hover := Value;
    end
    else
      Exit;

    8: if Value <> FDarkSet.Press then begin
      FDarkSet.Press := Value;
    end
    else
      Exit;

    9: if Value <> FDarkSet.SelectedColor then begin
      FDarkSet.SelectedColor := Value;
    end
    else
      Exit;

    10: if Value <> FDarkSet.SelectedHover then begin
      FDarkSet.SelectedHover := Value;
    end
    else
      Exit;

    11: if Value <> FDarkSet.SelectedPress then begin
      FDarkSet.SelectedPress := Value;
    end
    else
      Exit;
  end;
  Changed;
end;

function TUThemeButtonStateColorSet.GetColor(const Theme: TUThemeType; State: TUControlState; Selected: Boolean): TColor;
begin
  Result := clNone; // satisfy compiler
  if ((Theme = ttSystem) and (GetCommonThemeManager.SystemTheme = utLight)) or (Theme = ttLight) then begin
    if not Selected then begin
      case State of
        csNone : Result := FLightSet.Color;
        csHover: Result := FLightSet.Hover;
        csPress: Result := FLightSet.Press;
      end;
    end
    else begin
      case State of
        csNone : Result := FLightSet.SelectedColor;
        csHover: Result := FLightSet.SelectedHover;
        csPress: Result := FLightSet.SelectedPress;
      end;
    end;
  end
  else if ((Theme = ttSystem) and (GetCommonThemeManager.SystemTheme = utDark)) or (Theme = ttDark) then begin
    if not Selected then begin
      case State of
        csNone : Result := FDarkSet.Color;
        csHover: Result := FDarkSet.Hover;
        csPress: Result := FDarkSet.Press;
      end;
    end
    else begin
      case State of
        csNone : Result := FDarkSet.SelectedColor;
        csHover: Result := FDarkSet.SelectedHover;
        csPress: Result := FDarkSet.SelectedPress;
      end;
    end;
  end
end;
*)
{ TUThemeControlWithFocusColorSet }

constructor TUThemeControlWithFocusColorSet.Create;
begin
  inherited;
  SetColors;
end;

{
constructor TUThemeControlWithFocusColorSet.Create(Color, LightColor, DarkColor, FocusedLightColor, FocusedDarkColor: TColor);
begin
  Create;
  SetColors(Color, LightColor, DarkColor);
  SetColors(FocusedLightColor, FocusedDarkColor);
end;
}

procedure TUThemeControlWithFocusColorSet.Assign(Source: TPersistent);
var
  SourceObject: TUThemeControlWithFocusColorSet;
begin
  if Source is TUThemeControlWithFocusColorSet then begin
    SourceObject := TUThemeControlWithFocusColorSet(Source);
    //
    FFocusedLightColor := SourceObject.FocusedLightColor;
    FFocusedDarkColor  := SourceObject.FocusedDarkColor;
  end;
  inherited Assign(Source); // must be last - changed is called here
end;

procedure TUThemeControlWithFocusColorSet.SetColors;
begin
  inherited;
  FFocusedLightColor := $00000000;
  FFocusedDarkColor  := $00000000;
end;

procedure TUThemeControlWithFocusColorSet.SetColors(FocusedLightColor, FocusedDarkColor: TColor);
begin
  FFocusedLightColor := FocusedLightColor;
  FFocusedDarkColor  := FocusedDarkColor;
end;

procedure TUThemeControlWithFocusColorSet.SetColor(Index: Integer; const Value: TColor);
begin
  inherited SetColor(Index, Value);
  case Index of
    3: if Value <> FFocusedLightColor then begin
      FFocusedLightColor := Value;
    end
    else
      Exit;

    4: if Value <> FFocusedDarkColor then begin
      FFocusedDarkColor := Value;
    end
    else
      Exit;
  else
    Exit;
  end;
  Changed;
end;

procedure TUThemeControlWithFocusColorSet.SetColors(Color, LightColor, DarkColor, FocusedLightColor, FocusedDarkColor: TColor);
begin
  SetColors(Color, LightColor, DarkColor);
  SetColors(FocusedLightColor, FocusedDarkColor);
//  FFocusedLightColor := FocusedLightColor;
//  FFocusedDarkColor  := FocusedDarkColor;
end;

function TUThemeControlWithFocusColorSet.GetColor(const TM: TUCustomThemeManager; const Focused: Boolean): TColor;
begin
//  Result:=clNone;
  if TM = Nil then
    Result := Color
  else begin
    if TM.ThemeUsed = utLight then begin
      if not Focused then
        Result := LightColor
      else
        Result := FocusedLightColor;
    end
    else begin // dark
      if not Focused then
        Result := DarkColor
      else
        Result := FocusedDarkColor;
    end;
  end;
end;

initialization
//  MINI_SB_COLOR       := $1A1A1A;
  MINI_SB_COLOR_LIGHT := $1A1A1A;
  MINI_SB_COLOR_DARK  := $7A7A7A;

//  SCROLLBOX_BACK_NIL   := $E6E6E6;
//  SCROLLBOX_BACK_LIGHT := $E6E6E6;
//  SCROLLBOX_BACK_DARK  := $1F1F1F;

  // Tooltip
  TOOLTIP_SHADOW := False;
  TOOLTIP_BORDER_THICKNESS := 1;
  TOOLTIP_FONT_NAME := 'Segoe UI';
  TOOLTIP_FONT_SIZE := 8;
  TOOLTIP_BACK := TUThemeControlColorSet.Create(0, $F2F2F2, $2B2B2B);
  TOOLTIP_BORDER := TUThemeControlColorSet.Create(0, $CCCCCC, $767676);

  // Form
  FORM_FONT_NAME := 'Segoe UI';
  FORM_FONT_SIZE := 10;
  FORM_BACK := TUThemeControlColorSet.Create(0, $FFFFFF, $000000);

  // Popup menu
  POPUP_BACK := TUThemeControlColorSet.Create($E6E6E6, $E6E6E6, $1F1F1F);

  // Progress bar
  PROGRESSBAR_BACK := TUThemeControlColorSet.Create($E6E6E6, $CCCCCC, $333333);
  
  // Panel
  PANEL_BACK := TUThemeControlColorSet.Create(0, $E6E6E6, $1F1F1F);
  
  // Scrollbox
  SCROLLBOX_BACK := TUThemeControlColorSet.Create(0, $E6E6E6, $1F1F1F);

  // Caption bar
  CAPTIONBAR_BACK := TUThemeCaptionBarColorSet.Create;
  CAPTIONBAR_BACK.SetColors(0, $F2F2F2, $2B2B2B, $D77800, $174800);

  // Button
  BUTTON_BACK := TUThemeButtonStateColorSet.Create;
  BUTTON_BACK.SetColors(utLight, $CCCCCC, $CCCCCC, $999999, $CCCCCC, $CCCCCC{, $999999});
  BUTTON_BACK.SetColors(utDark,  $333333, $333333, $666666, $333333, $333333{, $666666});
  BUTTON_BORDER := TUThemeButtonStateColorSet.Create;
  BUTTON_BORDER.SetColors(utLight, $CCCCCC, $7A7A7A, $999999, $7A7A7A, $7A7A7A{, $999999});
  BUTTON_BORDER.SetColors(utDark,  $333333, $858585, $666666, $858585, $858585{, $666666});

  // List button
  LISTBUTTON_BACK := TUThemeControlColorSet.Create;
  //LISTBUTTON_BACK.SetLightColor($E6E6E6, $CFCFCF, $B8B8B8, 127, 103, 89);
  //LISTBUTTON_BACK.SetDarkColor($1F1F1F, $353535, $4C4C4C, 89, 103, 127);

  // Quick button
  QUICKBUTTON_BACK := TUThemeControlColorSet.Create(0, $CFCFCF, $3C3C3C);

  // Slider
  SLIDER_BACK := TUThemeFocusableControlStateColors.Create;
  SLIDER_BACK.SetColors(utLight, $999999, $666666, $999999, $999999, $666666);
  SLIDER_BACK.SetColors(utDark,  $666666, $999999, $666666, $666666, $999999);
  SLIDER_CURSOR := TUThemeFocusableControlStateColors.Create;
  SLIDER_CURSOR.SetColors(utLight, $D77800, $171717, $CCCCCC, $D77800, $171717);
  SLIDER_CURSOR.SetColors(utDark,  $D77800, $F2F2F2, $767676, $D77800, $F2F2F2);

  // Hyperlink
  HYPERLINK_FONT_NAME := 'Segoe UI';
  HYPERLINK_FONT_SIZE := 10;
  HYPERLINK_TEXT := TUThemeControlColorSet.Create;
  //HYPERLINK_TEXT.SetLightColor($D77800, clGray, clMedGray, $D77800, clGray, clMedGray);
  //HYPERLINK_TEXT.SetDarkColor($D77800, clMedGray, clGray, $D77800, clMedGray, clGray);

  // Edit
  EDIT_BACK := TUThemeControlWithFocusColorSet.Create($FFFFFF, $FFFFFF, $000000);
  EDIT_BORDER := TUThemeControlWithFocusColorSet.Create;
  //EDIT_BORDER.SetColors(utLight, $999999, $666666, $D77800, $D77800, $D77800, $D77800);
  //EDIT_BORDER.SetColors(utDark,  $666666, $999999, $D77800, $D77800, $D77800, $D77800);
  EDIT_BORDER.SetColors(0, $999999, $666666, $D77800, $D77800);

  DETAIL_COLOR := $808080;  //  Both light & dark
  DETAIL_COLOR_HIGHLIGHED := $C0C0C0;   //  Using when background is solid color

finalization
  TOOLTIP_BACK.Free;
  TOOLTIP_BORDER.Free;

  FORM_BACK.Free;

  POPUP_BACK.Free;

  PROGRESSBAR_BACK.Free;

  PANEL_BACK.Free;

  SCROLLBOX_BACK.Free;

  CAPTIONBAR_BACK.Free;

  BUTTON_BACK.Free;
  BUTTON_BORDER.Free;

  LISTBUTTON_BACK.Free;

  QUICKBUTTON_BACK.Free;

  SLIDER_BACK.Free;
  SLIDER_CURSOR.Free;

  HYPERLINK_TEXT.Free;

  EDIT_BACK.Free;
  EDIT_BORDER.Free;

end.
