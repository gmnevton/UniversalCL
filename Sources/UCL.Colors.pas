unit UCL.Colors;

interface

uses
  Classes,
  SysUtils,
  Graphics,
  UCL.Classes,
  UCL.TUThemeManager;
  
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

  TUThemeCaptionBarColorSet = class(TUThemeControlColorSet)
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

var
  MINI_SB_COLOR_NIL,
  MINI_SB_COLOR_LIGHT,
  MINI_SB_COLOR_DARK: TColor;
  //SCROLLBOX_BACK_NIL,
  //SCROLLBOX_BACK_LIGHT,
  //SCROLLBOX_BACK_DARK: TColor;

  TOOLTIP_SHADOW: Boolean;
  TOOLTIP_BORDER_THICKNESS: Byte;
  TOOLTIP_BACK: TUThemeControlColorSet;
  TOOLTIP_BORDER: TUThemeControlColorSet;

  FORM_BACK: TUThemeControlColorSet;
  PANEL_BACK: TUThemeControlColorSet;
  SCROLLBOX_BACK: TUThemeControlColorSet;
  CAPTIONBAR_BACK: TUThemeCaptionBarColorSet;

  DETAIL_COLOR: TColor;
  DETAIL_COLOR_HIGHLIGHED: TColor;

implementation

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

{ TUThemeCaptionBarColorSet }

constructor TUThemeCaptionBarColorSet.Create;
begin
  inherited;
  SetColors;
end;

constructor TUThemeCaptionBarColorSet.Create(Color, LightColor, DarkColor, FocusedLightColor, FocusedDarkColor: TColor);
begin
  Create;
  SetColors(Color, LightColor, DarkColor);
  SetColors(FocusedLightColor, FocusedDarkColor);
end;

procedure TUThemeCaptionBarColorSet.Assign(Source: TPersistent);
begin
  if Source is TUThemeCaptionBarColorSet then begin
    FFocusedLightColor := (Source as TUThemeCaptionBarColorSet).FocusedLightColor;
    FFocusedDarkColor  := (Source as TUThemeCaptionBarColorSet).FocusedDarkColor;
  end;
  inherited Assign(Source); // must be last - changed is called here
end;

procedure TUThemeCaptionBarColorSet.SetColors;
begin
  inherited;
  FFocusedLightColor := $00000000;
  FFocusedDarkColor  := $00000000;
end;

procedure TUThemeCaptionBarColorSet.SetColors(FocusedLightColor, FocusedDarkColor: TColor);
begin
  FFocusedLightColor := FocusedLightColor;
  FFocusedDarkColor  := FocusedDarkColor;
end;

procedure TUThemeCaptionBarColorSet.SetColor(Index: Integer; const Value: TColor);
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

function TUThemeCaptionBarColorSet.GetColor(const TM: TUThemeManager; const Focused: Boolean): TColor;
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
  MINI_SB_COLOR_NIL   := $1A1A1A;
  MINI_SB_COLOR_LIGHT := $1A1A1A;
  MINI_SB_COLOR_DARK  := $7A7A7A;

//  SCROLLBOX_BACK_NIL   := $E6E6E6;
//  SCROLLBOX_BACK_LIGHT := $E6E6E6;
//  SCROLLBOX_BACK_DARK  := $1F1F1F;

  TOOLTIP_SHADOW := false;
  TOOLTIP_BORDER_THICKNESS := 1;
  TOOLTIP_BACK := TUThemeControlColorSet.Create(0, $F2F2F2, $2B2B2B);
  TOOLTIP_BORDER := TUThemeControlColorSet.Create(0, $CCCCCC, $767676);

  FORM_BACK := TUThemeControlColorSet.Create(0, $FFFFFF, $000000);
  PANEL_BACK := TUThemeControlColorSet.Create(0, $E6E6E6, $1F1F1F);
  SCROLLBOX_BACK := TUThemeControlColorSet.Create(0, $E6E6E6, $1F1F1F);
  CAPTIONBAR_BACK := TUThemeCaptionBarColorSet.Create(0, $F2F2F2, $2B2B2B, $D77800, $174800);

  DETAIL_COLOR := $808080;  //  Both light & dark
  DETAIL_COLOR_HIGHLIGHED := $C0C0C0;   //  Using when background is solid color

finalization
  TOOLTIP_BACK.Free;
  TOOLTIP_BORDER.Free;
  FORM_BACK.Free;
  PANEL_BACK.Free;
  SCROLLBOX_BACK.Free;
  CAPTIONBAR_BACK.Free;

end.
