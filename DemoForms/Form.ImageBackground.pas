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
  UCL.TUThemeManager,
  UCL.TUForm,
  UCL.TUEdit,
  UCL.TUButton,
  UCL.TUPanel,
  UCL.TUSymbolButton,
  UCL.TUProgressBar,
  UCL.TUQuickButton,
  UCL.TUText,
  UCL.TURadioButton,
  UCL.TUSlider,
  UCL.TUTitleBar,
  UCL.TUShadow;

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
begin
  ThemeManager.UseSystemTheme := True;
  ThemeManager.Reload;
end;

procedure TformImageBackground.radioLightThemeClick(Sender: TObject);
begin
  ThemeManager.CustomTheme := utLight;
  ThemeManager.UseSystemTheme := False;
  ThemeManager.Reload;
end;

procedure TformImageBackground.radioDarkThemeClick(Sender: TObject);
begin
  ThemeManager.CustomTheme := utDark;
  ThemeManager.UseSystemTheme := False;
  ThemeManager.Reload;
end;

end.
