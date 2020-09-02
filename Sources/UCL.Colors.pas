unit UCL.Colors;

interface

uses
  SysUtils,
  Classes,
  Controls,
  Graphics,
  UCL.Classes,
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
    function GetColor(const TM: TUThemeManager): TColor; overload; virtual; abstract;

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
    function GetColor(const TM: TUThemeManager): TColor; override;

  published
    property Color: TColor index 0 read FColor write SetColor;
    property LightColor: TColor index 1 read FLightColor write SetColor;
    property DarkColor: TColor index 2 read FDarkColor write SetColor;
  end;

  TUThemeButtonStateColorSet = class(TUThemeColorSet)
  private
    FColor: TColor;
    FHover: TColor;
    FPress: TColor;
    FSelectedColor: TColor;
    FSelectedHover: TColor;
    FSelectedPress: TColor;

  protected
    procedure SetColor(Index: Integer; const Value: TColor); override;

  public
    constructor Create; override;
    constructor Create(Color, Hover, Press, SelColor, SelHover, SelPress: TColor); overload;

    procedure Assign(Source: TPersistent); override;
    procedure SetColors; overload; override; // set defaults
    procedure SetColors(Color, Hover, Press, SelColor, SelHover, SelPress: TColor); overload;
    function GetColor(State: TUButtonState): TColor; overload;

  published
    property Color: TColor index 0 read FColor write SetColor;
    property Hover: TColor index 1 read FHover write SetColor;
    property Press: TColor index 2 read FPress write SetColor;
    property SelectedColor: TColor index 3 read FSelectedColor write SetColor;
    property SelectedHover: TColor index 4 read FSelectedHover write SetColor;
    property SelectedPress: TColor index 5 read FSelectedPress write SetColor;
  end;

  TUThemeControlWithFocusColorSet = class(TUThemeControlColorSet)
  private
    FFocusedLightColor: TColor;
    FFocusedDarkColor: TColor;

  protected
    procedure SetColor(Index: Integer; const Value: TColor); override;

  public
    constructor Create; override;
    constructor Create(Color, LightColor, DarkColor, FocusedLightColor, FocusedDarkColor: TColor); overload;

    procedure Assign(Source: TPersistent); override;
    procedure SetColors; overload; override; // set defaults
    procedure SetColors(FocusedLightColor, FocusedDarkColor: TColor); overload;
    function GetColor(const TM: TUThemeManager; const Focused: Boolean): TColor; overload;

  published
    property FocusedLightColor: TColor index 3 read FFocusedLightColor write SetColor;
    property FocusedDarkColor: TColor index 4 read FFocusedDarkColor write SetColor;
  end;

  TUThemeCaptionBarColorSet = class(TUThemeControlWithFocusColorSet);

var
  MINI_SB_COLOR,
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
  SLIDER_BACK: TUThemeControlColorSet;
  SLIDER_CURSOR: TUThemeControlColorSet;

  // Hyperlink
  HYPERLINK_FONT_NAME: String;
  HYPERLINK_FONT_SIZE: Byte;
  HYPERLINK_TEXT: TUThemeControlColorSet;

  // Edit
  EDIT_BACK: TUThemeControlWithFocusColorSet;
  EDIT_BORDER: TUThemeControlWithFocusColorSet;

  DETAIL_COLOR: TColor;
  DETAIL_COLOR_HIGHLIGHED: TColor;

function SelectThemeManager(Control: TControl): TUThemeManager;

implementation

uses
  Forms,
  UCL.Form;

function SelectThemeManager(Control: TControl): TUThemeManager;
var
  ParentForm: TCustomForm;
begin
  ParentForm := GetParentForm(Control, true);
  if (ParentForm <> Nil) and (ParentForm is TUForm) then
    Result := (ParentForm as TUForm).ThemeManager
  else
    Result := Nil;
end;

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
begin
  if Source is TUThemeControlColorSet then begin
    FColor      := (Source as TUThemeControlColorSet).Color;
    FLightColor := (Source as TUThemeControlColorSet).LightColor;
    FDarkColor  := (Source as TUThemeControlColorSet).DarkColor;
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

function TUThemeControlColorSet.GetColor(const TM: TUThemeManager): TColor;
begin
  if TM = Nil then
    Result := Color
  else begin
    if TM.Theme = utLight then
      Result := LightColor
    else
      Result := DarkColor;
  end;
end;

{ TUThemeButtonStateColorSet }

constructor TUThemeButtonStateColorSet.Create;
begin
  inherited;
  SetColors;
end;

constructor TUThemeButtonStateColorSet.Create(Color, Hover, Press, SelColor, SelHover, SelPress: TColor);
begin
  Create;
  SetColors(Color, Hover, Press, SelColor, SelHover, SelPress);
end;

procedure TUThemeButtonStateColorSet.Assign(Source: TPersistent);
begin
  if Source is TUThemeButtonStateColorSet then begin
    FColor := (Source as TUThemeButtonStateColorSet).Color;
    FHover := (Source as TUThemeButtonStateColorSet).Hover;
    FPress := (Source as TUThemeButtonStateColorSet).Press;
    FSelectedColor := (Source as TUThemeButtonStateColorSet).SelectedColor;
    FSelectedHover := (Source as TUThemeButtonStateColorSet).SelectedHover;
    FSelectedPress := (Source as TUThemeButtonStateColorSet).SelectedPress;
  end;
  inherited Assign(Source); // must be last - changed is called here
end;

procedure TUThemeButtonStateColorSet.SetColors;
begin
  FColor := $00000000;
  FHover := $00000000;
  FPress := $00000000;
  FSelectedColor := $00000000;
  FSelectedHover := $00000000;
  FSelectedPress := $00000000;
end;

procedure TUThemeButtonStateColorSet.SetColors(Color, Hover, Press, SelColor, SelHover, SelPress: TColor);
begin
  FColor := Color;
  FHover := Hover;
  FPress := Press;
  FSelectedColor := SelColor;
  FSelectedHover := SelHover;
  FSelectedPress := SelPress;
end;

procedure TUThemeButtonStateColorSet.SetColor(Index: Integer; const Value: TColor);
begin
  case Index of
    0: if Value <> FColor then begin
      FColor := Value;
    end
    else
      Exit;

    1: if Value <> FHover then begin
      FHover := Value;
    end
    else
      Exit;

    2: if Value <> FPress then begin
      FPress := Value;
    end
    else
      Exit;

    3: if Value <> FSelectedColor then begin
      FSelectedColor := Value;
    end
    else
      Exit;

    4: if Value <> FSelectedHover then begin
      FSelectedHover := Value;
    end
    else
      Exit;

    5: if Value <> FSelectedPress then begin
      FSelectedPress := Value;
    end
    else
      Exit;
  end;
  Changed;
end;

function TUThemeButtonStateColorSet.GetColor(State: TUButtonState): TColor;
begin
  Result := clNone; // satisfy compiler
  case State of
    ubsNone : Result := Color;

    ubsHover: Result := Hover;

    ubsPress: Result := Press;

    ubsSelectedNone : Result := SelectedColor;

    ubsSelectedHover: Result := SelectedHover;

    ubsSelectedPress: Result := SelectedPress;
  end;
end;

{ TUThemeControlWithFocusColorSet }

constructor TUThemeControlWithFocusColorSet.Create;
begin
  inherited;
  SetColors;
end;

constructor TUThemeControlWithFocusColorSet.Create(Color, LightColor, DarkColor, FocusedLightColor, FocusedDarkColor: TColor);
begin
  Create;
  SetColors(Color, LightColor, DarkColor);
  SetColors(FocusedLightColor, FocusedDarkColor);
end;

procedure TUThemeControlWithFocusColorSet.Assign(Source: TPersistent);
begin
  if Source is TUThemeControlWithFocusColorSet then begin
    FFocusedLightColor := (Source as TUThemeControlWithFocusColorSet).FocusedLightColor;
    FFocusedDarkColor  := (Source as TUThemeControlWithFocusColorSet).FocusedDarkColor;
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

function TUThemeControlWithFocusColorSet.GetColor(const TM: TUThemeManager; const Focused: Boolean): TColor;
begin
  if TM = Nil then
    Result := Color
  else begin
    if TM.Theme = utLight then begin
      if not Focused then
        Result := LightColor
      else
        Result := FocusedLightColor;
    end
    else begin
      if not Focused then
        Result := DarkColor
      else
        Result := FocusedDarkColor;
    end;
  end;
end;

initialization
  MINI_SB_COLOR       := $1A1A1A;
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
  CAPTIONBAR_BACK := TUThemeCaptionBarColorSet.Create(0, $F2F2F2, $2B2B2B, $D77800, $174800);

  // Button
  BUTTON_BACK := TUThemeButtonStateColorSet.Create;
  //BUTTON_BACK.SetLightColor($CCCCCC, $CCCCCC, $999999, $CCCCCC, $CCCCCC, $999999);
  //BUTTON_BACK.SetDarkColor($333333, $333333, $666666, $333333, $333333, $666666);
  BUTTON_BORDER := TUThemeButtonStateColorSet.Create;
  //BUTTON_BORDER.SetLightColor($CCCCCC, $7A7A7A, $999999, $7A7A7A, $7A7A7A, $999999);
  //BUTTON_BORDER.SetDarkColor($333333, $858585, $666666, $858585, $858585, $666666);

  // List button
  LISTBUTTON_BACK := TUThemeControlColorSet.Create;
  //LISTBUTTON_BACK.SetLightColor($E6E6E6, $CFCFCF, $B8B8B8, 127, 103, 89);
  //LISTBUTTON_BACK.SetDarkColor($1F1F1F, $353535, $4C4C4C, 89, 103, 127);

  // Quick button
  QUICKBUTTON_BACK := TUThemeControlColorSet.Create(0, $CFCFCF, $3C3C3C);

  // Slider
  SLIDER_BACK := TUThemeControlColorSet.Create;
  //SLIDER_BACK.SetLightColor($999999, $666666, $999999, $999999, $666666, $999999);
  //SLIDER_BACK.SetDarkColor($666666, $999999, $666666, $666666, $999999, $666666);
  SLIDER_CURSOR := TUThemeControlColorSet.Create;
  //SLIDER_CURSOR.SetLightColor($D77800, $171717, $CCCCCC, $D77800, $171717, $CCCCCC);
  //SLIDER_CURSOR.SetDarkColor($D77800, $F2F2F2, $767676, $D77800, $F2F2F2, $767676);

  // Hyperlink
  HYPERLINK_FONT_NAME := 'Segoe UI';
  HYPERLINK_FONT_SIZE := 10;
  HYPERLINK_TEXT := TUThemeControlColorSet.Create;
  //HYPERLINK_TEXT.SetLightColor($D77800, clGray, clMedGray, $D77800, clGray, clMedGray);
  //HYPERLINK_TEXT.SetDarkColor($D77800, clMedGray, clGray, $D77800, clMedGray, clGray);

  // Edit
  EDIT_BACK := TUThemeControlWithFocusColorSet.Create($FFFFFF, $FFFFFF, $000000);
  EDIT_BORDER := TUThemeControlWithFocusColorSet.Create;
  //EDIT_BORDER.SetLightColor($999999, $666666, $D77800, $D77800, $D77800, $D77800);
  //EDIT_BORDER.SetDarkColor($666666, $999999, $D77800, $D77800, $D77800, $D77800);
  
  EDIT_BORDER := TUThemeControlWithFocusColorSet.Create(0, $999999, $666666, $D77800, $D77800);

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
