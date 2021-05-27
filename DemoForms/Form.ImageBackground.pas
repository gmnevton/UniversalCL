unit Form.ImageBackground;

interface

uses
  SysUtils,
  Classes,
  Controls,
  Forms,
  StdCtrls,
  ExtCtrls,
  jpeg,
  UCL.Classes,
  UCL.Utils,
  UCL.ThemeManager,
  UCL.Form,
  UCL.Edit,
  UCL.Button,
  UCL.Panel,
  UCL.SymbolButton,
  UCL.ProgressBar,
  UCL.QuickButton,
  UCL.Text,
  UCL.RadioButton,
  UCL.Slider,
  UCL.TitleBar,
  UCL.Shadow;

type
  TformImageBackground = class(TUForm)
    imgBackground: TImage;
    titlebarMain: TUTitleBar;
    sliderMain: TUSlider;
    buttonOk: TUButton;
    radioSystemTheme: TURadioButton;
    radioLightTheme: TURadioButton;
    progressMain: TUProgressBar;
    radioDarkTheme: TURadioButton;
    buttonSide: TUSymbolButton;
    panelBottom: TUPanel;
    editEmail: TUEdit;
    buttonCancel: TUButton;
    shadowMenu: TUShadow;
    entryChooseTheme: TUText;
    buttonAppQuit: TUQuickButton;
    buttonAppMinimized: TUQuickButton;
    procedure FormCreate(Sender: TObject);
    procedure radioSystemThemeClick(Sender: TObject);
    procedure radioLightThemeClick(Sender: TObject);
    procedure radioDarkThemeClick(Sender: TObject);
  private
  public
  end;

var
  formImageBackground: TformImageBackground;

implementation

{$R *.dfm}

procedure TformImageBackground.FormCreate(Sender: TObject);
begin
//  EnableBlur(Handle, 3);
end;

procedure TformImageBackground.radioSystemThemeClick(Sender: TObject);
var
  TM: TUCustomThemeManager;
begin
  if radioSystemTheme.Checked then begin
    TM := SelectThemeManager(Self);
    TM.Theme := ttSystem;
  end;
end;

procedure TformImageBackground.radioLightThemeClick(Sender: TObject);
var
  TM: TUCustomThemeManager;
begin
  if radioLightTheme.Checked then begin
    TM := SelectThemeManager(Self);
    TM.Theme := ttLight;
  end;
end;

procedure TformImageBackground.radioDarkThemeClick(Sender: TObject);
var
  TM: TUCustomThemeManager;
begin
  if radioDarkTheme.Checked then begin
    TM := SelectThemeManager(Self);
    TM.Theme := ttDark;
  end;
end;

end.
