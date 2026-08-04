unit UCL.ManagerColors;

interface

uses
  SysUtils,
  Classes,
  Controls,
  Graphics,
  UCL.Types,
  UCL.Colors,
  UCL.ColorTypes,
  UCL.ControlColors;

type
  TUControlColors  = class;
  TUButtonColors = class;
  TUItemButtonColors = class;

  TUManagerColors = class(TPersistent)
  private
    FThemeManager: TUBaseThemeManager;
    FButtonColors: TUButtonColors;
    FItemButtonColors: TUItemButtonColors;
    //FCaptionBarColors:
    FOnChange: TNotifyEvent;
    FLoadingConfig: Boolean;

    procedure SetButtonColors(Value: TUButtonColors);
    procedure SetItemButtonColors(Value: TUItemButtonColors);

  protected
    procedure Changed(Sender: TObject); virtual;
    procedure DoChange;

  public
    constructor Create(const ThemeManager: TUBaseThemeManager); virtual;
    destructor Destroy; override;
    procedure AfterConstruction; override;

    procedure Assign(Source: TPersistent); override;
    procedure SaveTo(const List: TStrings); virtual;
    procedure LoadFrom(const List: TStrings); virtual;

  published
    property ButtonColors: TUButtonColors read FButtonColors write SetButtonColors;
    property ItemButtonColors: TUItemButtonColors read FItemButtonColors write SetItemButtonColors;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TUControlColors = class(TUCustomControlColors)
  private
    FAllowCustomColors: Boolean;
    FUpdating: Boolean;
    FOnChange: TNotifyEvent;
    //
    procedure SetAllowCustomColors(Value: Boolean);

  protected
    procedure Changed(Sender: TObject); virtual;
    //
    procedure SaveTo(const SetName: String; const List: TStrings); virtual; abstract;
    procedure LoadFrom(const SetName: String; const List: TStrings); virtual; abstract;

  public
    constructor Create(const Owner: TComponent); override;
    procedure AfterConstruction; override;

    procedure Assign(Source: TPersistent); overload; override;

  published
    property AllowCustomColors: Boolean read FAllowCustomColors write SetAllowCustomColors default True;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TUButtonColors = class(TUControlColors)
  private
    FBackColors: TUThemeButtonStateColorSet;
    FBorderColors: TUThemeButtonStateColorSet;
    FTextColors: TUThemeButtonStateColorSet;

    procedure SetBackColors(Value: TUThemeButtonStateColorSet);
    procedure SetBorderColors(Value: TUThemeButtonStateColorSet);
    procedure SetTextColors(Value: TUThemeButtonStateColorSet);

  protected
    procedure SaveTo(const SetName: String; const List: TStrings); override;
    procedure LoadFrom(const SetName: String; const List: TStrings); override;

  public
    constructor Create(const Owner: TComponent); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); overload; override;
    procedure Assign(Source: TUButtonControlColors); overload;

    procedure GetColors(const ButtonState: TUControlState; const CustomColors: TUButtonColorSet; var BackColor, BorderColor, TextColor: TColor);

  published
    property BackColors: TUThemeButtonStateColorSet read FBackColors write SetBackColors;
    property BorderColors: TUThemeButtonStateColorSet read FBorderColors write SetBorderColors;
    property TextColors: TUThemeButtonStateColorSet read FTextColors write SetTextColors;
  end;

  TUItemButtonColors = class(TUButtonColors)
  private
    FDetailColors: TUThemeButtonStateColorSet;
    FActiveColors: TUThemeButtonStateColorSet;

    procedure SetDetailColors(Value: TUThemeButtonStateColorSet);
    procedure SetActiveColors(Value: TUThemeButtonStateColorSet);

  protected
    procedure SaveTo(const SetName: String; const List: TStrings); override;
    procedure LoadFrom(const SetName: String; const List: TStrings); override;

  public
    constructor Create(const Owner: TComponent); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); overload; override;
    procedure Assign(Source: TUItemButtonControlColors); overload;

    procedure GetColors(const ButtonState: TUControlState; const CustomColors: TUItemButtonColorSet; var BackColor, BorderColor, TextColor, DetailColor, ActiveColor: TColor);

  published
    property DetailColors: TUThemeButtonStateColorSet read FDetailColors write SetDetailColors;
    property ActiveColors: TUThemeButtonStateColorSet read FActiveColors write SetActiveColors;
  end;

implementation

uses
//  TypInfo,
  UCL.ThemeManager;

{ TUManagerColors }

constructor TUManagerColors.Create(const ThemeManager: TUBaseThemeManager);
begin
  FThemeManager := ThemeManager;
  FLoadingConfig := False;
  //
  FButtonColors := TUButtonColors.Create(ThemeManager);
  FButtonColors.OnChange := Changed;
  //
  FItemButtonColors := TUItemButtonColors.Create(ThemeManager);
  FItemButtonColors.OnChange := Changed;
end;

destructor TUManagerColors.Destroy;
begin
  FItemButtonColors.OnChange := Nil;
  FItemButtonColors.Free;
  FButtonColors.OnChange := Nil;
  FButtonColors.Free;
  inherited;
end;

procedure TUManagerColors.AfterConstruction;
begin
  inherited;
  FOnChange := Nil;
end;

procedure TUManagerColors.Assign(Source: TPersistent);
begin
  if Source is TUManagerColors then begin
    FLoadingConfig := True;
    try
      FButtonColors.Assign((Source as TUManagerColors).ButtonColors);
      FItemButtonColors.Assign((Source as TUManagerColors).ItemButtonColors);
    finally
      FLoadingConfig := False;
      DoChange;
    end;
  end
  else
    inherited;
end;

procedure TUManagerColors.SaveTo(const List: TStrings);
begin
  List.BeginUpdate;
  try
    List.Clear;
    ButtonColors.SaveTo('ButtonColors', List);
    ItemButtonColors.SaveTo('ItemButtonColors', List);
  finally
    List.EndUpdate;
  end;
end;

procedure TUManagerColors.LoadFrom(const List: TStrings);
begin
  FLoadingConfig := True;
  try
    ButtonColors.LoadFrom('ButtonColors', List);
    ItemButtonColors.LoadFrom('ItemButtonColors', List);
  finally
    FLoadingConfig := False;
    DoChange;
  end;
end;

procedure TUManagerColors.Changed(Sender: TObject);
begin
  DoChange;
end;

procedure TUManagerColors.DoChange;
begin
  if Assigned(FOnChange) and not FLoadingConfig then
    FOnChange(Self);
end;

procedure TUManagerColors.SetButtonColors(Value: TUButtonColors);
begin
  FButtonColors.Assign(Value);
end;

procedure TUManagerColors.SetItemButtonColors(Value: TUItemButtonColors);
begin
  FItemButtonColors.Assign(Value);
end;

{ TUControlColors }

constructor TUControlColors.Create(const Owner: TComponent);
begin
  inherited Create(Owner);
  FAllowCustomColors := True;
  FUpdating := False;
  FOnChange := Nil;
end;

procedure TUControlColors.AfterConstruction;
begin
  inherited;
  Changed(Self);
end;

procedure TUControlColors.Assign(Source: TPersistent);
begin
  if Source is TUControlColors then begin
    Changed(Source);
  end
  else
    inherited;
end;

procedure TUControlColors.Changed(Sender: TObject);
begin
  if Assigned(FOnChange) and not FUpdating then
    FOnChange(Sender);
end;

procedure TUControlColors.SetAllowCustomColors(Value: Boolean);
begin
  if FAllowCustomColors <> Value then begin
    FAllowCustomColors := Value;
    Changed(Self);
  end;
end;

{ TUButtonColors }

constructor TUButtonColors.Create(const Owner: TComponent);
begin
  inherited Create(Owner);

  FBackColors := TUThemeButtonStateColorSet.Create;
  FBackColors.SetColors(utLight, $F2F2F2, $E6E6E6, $CCCCCC, $F2F2F2, $F2F2F2);
//  FBackColors.Assign(BUTTON_BACK);

  FBorderColors := TUThemeButtonStateColorSet.Create;
  FBorderColors.SetColors(utLight, $F2F2F2, $E6E6E6, $CCCCCC, $F2F2F2, $F2F2F2);
//  FBorderColors.Assign(BUTTON_BORDER);

  FTextColors := TUThemeButtonStateColorSet.Create;
  FTextColors.SetColors(utLight, clBlack, clBlack, clBlack, clGray, clBlack);
  FTextColors.SetColors(utDark, clWhite, clWhite, clWhite, clGray, clWhite);

  FBackColors.OnChange   := Changed;
  FBorderColors.OnChange := Changed;
  FTextColors.OnChange   := Changed;
end;

destructor TUButtonColors.Destroy;
begin
  FBackColors.Free;
  FBorderColors.Free;
  FTextColors.Free;
  inherited;
end;

procedure TUButtonColors.Assign(Source: TPersistent);
var
  SourceObject: TUButtonColorSet;
begin
  if Source is TUButtonColorSet then begin
    SourceObject:=TUButtonColorSet(Source);
    //
    FBackColors.Assign(SourceObject.BackColors);
    FBorderColors.Assign(SourceObject.BorderColors);
    FTextColors.Assign(SourceObject.TextColors);
  end;
  inherited Assign(Source); // must be last - changed is called here
end;

procedure TUButtonColors.Assign(Source: TUButtonControlColors);
begin
  FUpdating := True;
  try
    FBackColors.Assign(Source.BackColors);
    FBorderColors.Assign(Source.BorderColors);
    FTextColors.Assign(Source.TextColors);
  finally
    FUpdating := False;
  end;
  //
  Changed(Self);
end;

procedure TUButtonColors.SetBackColors(Value: TUThemeButtonStateColorSet);
begin
  FBackColors.Assign(Value);
end;

procedure TUButtonColors.SetBorderColors(Value: TUThemeButtonStateColorSet);
begin
  FBorderColors.Assign(Value);
end;

procedure TUButtonColors.SetTextColors(Value: TUThemeButtonStateColorSet);
begin
  FTextColors.Assign(Value);
end;

procedure TUButtonColors.GetColors(const ButtonState: TUControlState; const CustomColors: TUButtonColorSet; var BackColor, BorderColor, TextColor: TColor);
var
  ThemeManager: TUBaseThemeManager;
  ThemedComponent: IUThemedComponent;
begin
  ThemeManager := Nil;
  if Owner is TUBaseThemeManager then
    ThemeManager := TUBaseThemeManager(Owner)
  else if (Owner is TComponent) and IsThemingAvailable(Owner) then begin
    if Supports(Owner, IUThemedComponent, ThemedComponent) and (ThemedComponent <> Nil) then
      ThemeManager := SelectThemeManager(TComponent(ThemedComponent));
  end;
  //
  BackColor := clNone;
  BorderColor := clNone;
  TextColor := clNone;
  //
  if ThemeManager <> Nil then begin
    if ThemeManager.Theme in [ttCustomLight, ttCustomDark] then begin
      BackColor   := CustomColors.BackColors.GetColor(ThemeManager.ThemeUsed, ButtonState);
      BorderColor := CustomColors.BorderColors.GetColor(ThemeManager.ThemeUsed, ButtonState);
      TextColor   := CustomColors.TextColors.GetColor(ThemeManager.ThemeUsed, ButtonState);
    end
    else begin
      BackColor   := BackColors.GetColor(ThemeManager.ThemeUsed, ButtonState);
      BorderColor := BorderColors.GetColor(ThemeManager.ThemeUsed, ButtonState);
      TextColor   := TextColors.GetColor(ThemeManager.ThemeUsed, ButtonState);
    end;
  end;
end;

procedure TUButtonColors.SaveTo(const SetName: String; const List: TStrings);
begin
  // BackColors
  List.AddPair(SetName + '.BackColors.LightColor'   , ColorToString(BackColors.LightColor));
  List.AddPair(SetName + '.BackColors.LightHover'   , ColorToString(BackColors.LightHover));
  List.AddPair(SetName + '.BackColors.LightPress'   , ColorToString(BackColors.LightPress));
  List.AddPair(SetName + '.BackColors.LightDisabled', ColorToString(BackColors.LightDisabled));
  List.AddPair(SetName + '.BackColors.LightFocused' , ColorToString(BackColors.LightFocused));
  List.AddPair(SetName + '.BackColors.DarkColor'    , ColorToString(BackColors.DarkColor));
  List.AddPair(SetName + '.BackColors.DarkHover'    , ColorToString(BackColors.DarkHover));
  List.AddPair(SetName + '.BackColors.DarkPress'    , ColorToString(BackColors.DarkPress));
  List.AddPair(SetName + '.BackColors.DarkDisabled' , ColorToString(BackColors.DarkDisabled));
  List.AddPair(SetName + '.BackColors.DarkFocused'  , ColorToString(BackColors.DarkFocused));
  // BorderColors
  List.AddPair(SetName + '.BorderColors.LightColor'   , ColorToString(BorderColors.LightColor));
  List.AddPair(SetName + '.BorderColors.LightHover'   , ColorToString(BorderColors.LightHover));
  List.AddPair(SetName + '.BorderColors.LightPress'   , ColorToString(BorderColors.LightPress));
  List.AddPair(SetName + '.BorderColors.LightDisabled', ColorToString(BorderColors.LightDisabled));
  List.AddPair(SetName + '.BorderColors.LightFocused' , ColorToString(BorderColors.LightFocused));
  List.AddPair(SetName + '.BorderColors.DarkColor'    , ColorToString(BorderColors.DarkColor));
  List.AddPair(SetName + '.BorderColors.DarkHover'    , ColorToString(BorderColors.DarkHover));
  List.AddPair(SetName + '.BorderColors.DarkPress'    , ColorToString(BorderColors.DarkPress));
  List.AddPair(SetName + '.BorderColors.DarkDisabled' , ColorToString(BorderColors.DarkDisabled));
  List.AddPair(SetName + '.BorderColors.DarkFocused'  , ColorToString(BorderColors.DarkFocused));
  // TextColors
  List.AddPair(SetName + '.TextColors.LightColor'   , ColorToString(TextColors.LightColor));
  List.AddPair(SetName + '.TextColors.LightHover'   , ColorToString(TextColors.LightHover));
  List.AddPair(SetName + '.TextColors.LightPress'   , ColorToString(TextColors.LightPress));
  List.AddPair(SetName + '.TextColors.LightDisabled', ColorToString(TextColors.LightDisabled));
  List.AddPair(SetName + '.TextColors.LightFocused' , ColorToString(TextColors.LightFocused));
  List.AddPair(SetName + '.TextColors.DarkColor'    , ColorToString(TextColors.DarkColor));
  List.AddPair(SetName + '.TextColors.DarkHover'    , ColorToString(TextColors.DarkHover));
  List.AddPair(SetName + '.TextColors.DarkPress'    , ColorToString(TextColors.DarkPress));
  List.AddPair(SetName + '.TextColors.DarkDisabled' , ColorToString(TextColors.DarkDisabled));
  List.AddPair(SetName + '.TextColors.DarkFocused'  , ColorToString(TextColors.DarkFocused));
end;

procedure TUButtonColors.LoadFrom(const SetName: String; const List: TStrings);
begin
  // BackColors
  LoadProperty(List, SetName, SetName + '.BackColors.LightColor');
  LoadProperty(List, SetName, SetName + '.BackColors.LightHover');
  LoadProperty(List, SetName, SetName + '.BackColors.LightPress');
  LoadProperty(List, SetName, SetName + '.BackColors.LightDisabled');
  LoadProperty(List, SetName, SetName + '.BackColors.LightFocused');
  LoadProperty(List, SetName, SetName + '.BackColors.DarkColor');
  LoadProperty(List, SetName, SetName + '.BackColors.DarkHover');
  LoadProperty(List, SetName, SetName + '.BackColors.DarkPress');
  LoadProperty(List, SetName, SetName + '.BackColors.DarkDisabled');
  LoadProperty(List, SetName, SetName + '.BackColors.DarkFocused');
  // BorderColors
  LoadProperty(List, SetName, SetName + '.BorderColors.LightColor');
  LoadProperty(List, SetName, SetName + '.BorderColors.LightHover');
  LoadProperty(List, SetName, SetName + '.BorderColors.LightPress');
  LoadProperty(List, SetName, SetName + '.BorderColors.LightDisabled');
  LoadProperty(List, SetName, SetName + '.BorderColors.LightFocused');
  LoadProperty(List, SetName, SetName + '.BorderColors.DarkColor');
  LoadProperty(List, SetName, SetName + '.BorderColors.DarkHover');
  LoadProperty(List, SetName, SetName + '.BorderColors.DarkPress');
  LoadProperty(List, SetName, SetName + '.BorderColors.DarkDisabled');
  LoadProperty(List, SetName, SetName + '.BorderColors.DarkFocused');
  // TextColors
  LoadProperty(List, SetName, SetName + '.TextColors.LightColor');
  LoadProperty(List, SetName, SetName + '.TextColors.LightHover');
  LoadProperty(List, SetName, SetName + '.TextColors.LightPress');
  LoadProperty(List, SetName, SetName + '.TextColors.LightDisabled');
  LoadProperty(List, SetName, SetName + '.TextColors.LightFocused');
  LoadProperty(List, SetName, SetName + '.TextColors.DarkColor');
  LoadProperty(List, SetName, SetName + '.TextColors.DarkHover');
  LoadProperty(List, SetName, SetName + '.TextColors.DarkPress');
  LoadProperty(List, SetName, SetName + '.TextColors.DarkDisabled');
  LoadProperty(List, SetName, SetName + '.TextColors.DarkFocused');
end;

{ TUItemButtonColors }

constructor TUItemButtonColors.Create(const Owner: TComponent);
begin
  inherited Create(Owner);

  FDetailColors := TUThemeButtonStateColorSet.Create;

  FActiveColors := TUThemeButtonStateColorSet.Create;

  FDetailColors.OnChange  := Changed;
  FActiveColors.OnChange  := Changed;
end;

destructor TUItemButtonColors.Destroy;
begin
  FDetailColors.Free;
  FActiveColors.Free;
  inherited;
end;

procedure TUItemButtonColors.Assign(Source: TPersistent);
var
  SourceObject: TUItemButtonColors;
begin
  if Source is TUItemButtonColors then begin
    SourceObject:=TUItemButtonColors(Source);
    //
    FDetailColors.Assign(SourceObject.DetailColors);
    FActiveColors.Assign(SourceObject.ActiveColors);
  end;
  inherited Assign(Source); // must be last - changed is called here
end;

procedure TUItemButtonColors.Assign(Source: TUItemButtonControlColors);
begin
  FUpdating := True;
  try
    FBackColors.Assign(Source.BackColors);
    FBorderColors.Assign(Source.BorderColors);
    FTextColors.Assign(Source.TextColors);
    FDetailColors.Assign(Source.DetailColors);
    FActiveColors.Assign(Source.ActiveColors);
  finally
    FUpdating := False;
  end;
  //
  Changed(Self);
end;

procedure TUItemButtonColors.SetDetailColors(Value: TUThemeButtonStateColorSet);
begin
  FDetailColors.Assign(Value);
end;

procedure TUItemButtonColors.SetActiveColors(Value: TUThemeButtonStateColorSet);
begin
  FActiveColors.Assign(Value);
end;

procedure TUItemButtonColors.GetColors(const ButtonState: TUControlState; const CustomColors: TUItemButtonColorSet; var BackColor, BorderColor, TextColor, DetailColor, ActiveColor: TColor);
var
  ThemeManager: TUBaseThemeManager;
  ThemedComponent: IUThemedComponent;
begin
  ThemeManager := Nil;
  if Owner is TUBaseThemeManager then
    ThemeManager := TUBaseThemeManager(Owner)
  else if (Owner is TComponent) and IsThemingAvailable(Owner) then begin
    if Supports(Owner, IUThemedComponent, ThemedComponent) and (ThemedComponent <> Nil) then
      ThemeManager := SelectThemeManager(TComponent(ThemedComponent));
  end;
  //
  BackColor   := clNone;
  BorderColor := clNone;
  TextColor   := clNone;
  DetailColor := clNone;
  ActiveColor := clNone;
  //
  if ThemeManager <> Nil then begin
    if ThemeManager.Theme in [ttCustomLight, ttCustomDark] then begin
      BackColor   := CustomColors.BackColors.GetColor(ThemeManager.ThemeUsed, ButtonState);
      BorderColor := CustomColors.BorderColors.GetColor(ThemeManager.ThemeUsed, ButtonState);
      TextColor   := CustomColors.TextColors.GetColor(ThemeManager.ThemeUsed, ButtonState);
      DetailColor := CustomColors.DetailColors.GetColor(ThemeManager.ThemeUsed, ButtonState);
      ActiveColor := CustomColors.ActiveColors.GetColor(ThemeManager.ThemeUsed, ButtonState);
    end
    else begin
      BackColor   := BackColors.GetColor(ThemeManager.ThemeUsed, ButtonState);
      BorderColor := BorderColors.GetColor(ThemeManager.ThemeUsed, ButtonState);
      TextColor   := TextColors.GetColor(ThemeManager.ThemeUsed, ButtonState);
      DetailColor := DetailColors.GetColor(ThemeManager.ThemeUsed, ButtonState);
      ActiveColor := ActiveColors.GetColor(ThemeManager.ThemeUsed, ButtonState);
    end;
  end;
end;

procedure TUItemButtonColors.SaveTo(const SetName: String; const List: TStrings);
begin
  inherited;
  // BackColors
  List.AddPair(SetName + '.DetailColors.LightColor'   , ColorToString(DetailColors.LightColor));
  List.AddPair(SetName + '.DetailColors.LightHover'   , ColorToString(DetailColors.LightHover));
  List.AddPair(SetName + '.DetailColors.LightPress'   , ColorToString(DetailColors.LightPress));
  List.AddPair(SetName + '.DetailColors.LightDisabled', ColorToString(DetailColors.LightDisabled));
  List.AddPair(SetName + '.DetailColors.LightFocused' , ColorToString(DetailColors.LightFocused));
  List.AddPair(SetName + '.DetailColors.DarkColor'    , ColorToString(DetailColors.DarkColor));
  List.AddPair(SetName + '.DetailColors.DarkHover'    , ColorToString(DetailColors.DarkHover));
  List.AddPair(SetName + '.DetailColors.DarkPress'    , ColorToString(DetailColors.DarkPress));
  List.AddPair(SetName + '.DetailColors.DarkDisabled' , ColorToString(DetailColors.DarkDisabled));
  List.AddPair(SetName + '.DetailColors.DarkFocused'  , ColorToString(DetailColors.DarkFocused));
  // BorderColors
  List.AddPair(SetName + '.ActiveColors.LightColor'   , ColorToString(ActiveColors.LightColor));
  List.AddPair(SetName + '.ActiveColors.LightHover'   , ColorToString(ActiveColors.LightHover));
  List.AddPair(SetName + '.ActiveColors.LightPress'   , ColorToString(ActiveColors.LightPress));
  List.AddPair(SetName + '.ActiveColors.LightDisabled', ColorToString(ActiveColors.LightDisabled));
  List.AddPair(SetName + '.ActiveColors.LightFocused' , ColorToString(ActiveColors.LightFocused));
  List.AddPair(SetName + '.ActiveColors.DarkColor'    , ColorToString(ActiveColors.DarkColor));
  List.AddPair(SetName + '.ActiveColors.DarkHover'    , ColorToString(ActiveColors.DarkHover));
  List.AddPair(SetName + '.ActiveColors.DarkPress'    , ColorToString(ActiveColors.DarkPress));
  List.AddPair(SetName + '.ActiveColors.DarkDisabled' , ColorToString(ActiveColors.DarkDisabled));
  List.AddPair(SetName + '.ActiveColors.DarkFocused'  , ColorToString(ActiveColors.DarkFocused));
end;

procedure TUItemButtonColors.LoadFrom(const SetName: String; const List: TStrings);
begin
  inherited;
  // BackColors
  LoadProperty(List, SetName, SetName + '.DetailColors.LightColor');
  LoadProperty(List, SetName, SetName + '.DetailColors.LightHover');
  LoadProperty(List, SetName, SetName + '.DetailColors.LightPress');
  LoadProperty(List, SetName, SetName + '.DetailColors.LightDisabled');
  LoadProperty(List, SetName, SetName + '.DetailColors.LightFocused');
  LoadProperty(List, SetName, SetName + '.DetailColors.DarkColor');
  LoadProperty(List, SetName, SetName + '.DetailColors.DarkHover');
  LoadProperty(List, SetName, SetName + '.DetailColors.DarkPress');
  LoadProperty(List, SetName, SetName + '.DetailColors.DarkDisabled');
  LoadProperty(List, SetName, SetName + '.DetailColors.DarkFocused');
  // BorderColors
  LoadProperty(List, SetName, SetName + '.ActiveColors.LightColor');
  LoadProperty(List, SetName, SetName + '.ActiveColors.LightHover');
  LoadProperty(List, SetName, SetName + '.ActiveColors.LightPress');
  LoadProperty(List, SetName, SetName + '.ActiveColors.LightDisabled');
  LoadProperty(List, SetName, SetName + '.ActiveColors.LightFocused');
  LoadProperty(List, SetName, SetName + '.ActiveColors.DarkColor');
  LoadProperty(List, SetName, SetName + '.ActiveColors.DarkHover');
  LoadProperty(List, SetName, SetName + '.ActiveColors.DarkPress');
  LoadProperty(List, SetName, SetName + '.ActiveColors.DarkDisabled');
  LoadProperty(List, SetName, SetName + '.ActiveColors.DarkFocused');
end;

end.
