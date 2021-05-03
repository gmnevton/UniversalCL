unit Form.Demo;

interface

{$IF CompilerVersion > 29}
  {$LEGACYIFEND ON}
{$IFEND}

uses
  SysUtils,
  Classes,
  Types,
  Windows,
  Messages,
{$IF CompilerVersion > 29}
  ImageList,
{$IFEND}
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  Menus,
  Buttons,
  ImgList,
  pngimage,
  jpeg,
  //  UCL units
  UCL.ThemeManager,
  UCL.IntAnimation,
  UCL.IntAnimation.Helpers,
  UCL.Utils,
  UCL.Classes,
  UCL.SystemSettings,
  UCL.Form,
  UCL.FormOverlay,
  UCL.ScrollBox,
  UCL.CheckBox,
  UCL.ProgressBar,
  UCL.HyperLink,
  UCL.Panel,
  UCL.SymbolButton,
  UCL.Button,
  UCL.Text,
  UCL.CaptionBar,
  UCL.Slider,
  UCL.Separator,
  UCL.Edit,
  UCL.ItemButton,
  UCL.QuickButton,
  UCL.PopupMenu,
  UCL.RadioButton,
  UCL.Shadow;

type
  TformDemo = class(TUForm)
    drawerNavigation: TUPanel;
    buttonOpenMenu: TUSymbolButton;
    buttonMenuSettings: TUSymbolButton;
    buttonMenuProfile: TUSymbolButton;
    buttonMenuSave: TUSymbolButton;
    buttonMenuOpen: TUSymbolButton;
    buttonMenuRate: TUSymbolButton;
    captionBarMain: TUCaptionBar;
    dialogSelectColor: TColorDialog;
    panelRibbon: TUScrollBox;
    buttonGoBack: TUSymbolButton;
    separator1: TUSeparator;
    buttonGoHome: TUSymbolButton;
    buttonNewDoc: TUSymbolButton;
    buttonOpenDoc: TUSymbolButton;
    buttonLoginForm: TUSymbolButton;
    buttonSaveDoc: TUSymbolButton;
    separator2: TUSeparator;
    linkConnected: TUHyperLink;
    linkCustomColor: TUHyperLink;
    linkDisabled: TUHyperLink;
    buttonNoFocus: TUButton;
    buttonCanFocus: TUButton;
    buttonCustomColor: TUButton;
    buttonReloadSettings: TUSymbolButton;
    buttonHighlight: TUButton;
    buttonDisabled: TUButton;
    buttonToggled: TUButton;
    radioA1: TURadioButton;
    radioA2: TURadioButton;
    radioA3: TURadioButton;
    radioB1: TURadioButton;
    radioB2: TURadioButton;
    check2State: TUCheckBox;
    check3State: TUCheckBox;
    itembuttonImage: TUItemButton;
    itembuttonFontIcon: TUItemButton;
    symbolButtonOpenDisabled: TUSymbolButton;
    symbolbuttonSaveHorz: TUSymbolButton;
    symbolbuttonSaveVert: TUSymbolButton;
    progressVert: TUProgressBar;
    buttonRandomProgress: TUButton;
    progressCustomColor: TUProgressBar;
    progressConnected: TUProgressBar;
    textDescription: TUText;
    textNormal: TUText;
    textEntry: TUText;
    textHeading: TUText;
    textTitle: TUText;
    buttonRunning: TButton;
    buttonAniToRight: TButton;
    buttonAniToLeft: TButton;
    buttonWithImage: TUButton;
    sliderHorz: TUSlider;
    sliderDisabled: TUSlider;
    sliderVert: TUSlider;
    buttonAppBack: TUQuickButton;
    buttonWinClose: TUQuickButton;
    buttonWinMax: TUQuickButton;
    buttonWinMin: TUQuickButton;
    comboAppDPI: TComboBox;
    boxSettings: TUScrollBox;
    headingSettings: TUText;
    entryAppTheme: TUText;
    radioSystemTheme: TURadioButton;
    radioLightTheme: TURadioButton;
    radioDarkTheme: TURadioButton;
    panelSelectAccentColor: TUPanel;
    checkColorBorder: TUCheckBox;
    entryUserProfile: TUText;
    imgAvatar: TImage;
    checkAutoSync: TUCheckBox;
    checkKeepEmailPrivate: TUCheckBox;
    checkSendEmail: TUCheckBox;
    buttonDeleteAccount: TUButton;
    entryAccountType: TUText;
    radioFreeAccount: TURadioButton;
    radioProAccount: TURadioButton;
    radioDevAccount: TURadioButton;
    desAccountHint: TUText;
    buttonUpgradeAccount: TUButton;
    entryStorage: TUText;
    desStorageHint: TUText;
    progressStorageUsed: TUProgressBar;
    headingAbout: TUText;
    buttonCheckUpdate: TUButton;
    desAppVersion: TUText;
    desFlashVersion: TUText;
    desChromiumVersion: TUText;
    linkEmbarcadero: TUHyperLink;
    separatorLastBox: TUSeparator;
    editAccountName: TUEdit;
    comboAppBorderStyle: TComboBox;
    buttonImageForm: TUSymbolButton;
    popupEdit: TUPopupMenu;
    CutCtrlX1: TMenuItem;
    CopyCtrlC1: TMenuItem;
    PasteCtrlV1: TMenuItem;
    buttonAppListForm: TUSymbolButton;
    buttonBlurForm: TUQuickButton;
    buttonFullScreen: TUQuickButton;
    radioC1: TURadioButton;
    procedure buttonReloadSettingsClick(Sender: TObject);
    procedure buttonAniToRightClick(Sender: TObject);
    procedure buttonRandomProgressClick(Sender: TObject);
    procedure buttonAniToLeftClick(Sender: TObject);
    procedure buttonOpenMenuClick(Sender: TObject);
    procedure panelSelectAccentColorClick(Sender: TObject);
    procedure buttonMenuSettingsClick(Sender: TObject);
    procedure sliderHorzChange(Sender: TObject);
    procedure comboAppDPIChange(Sender: TObject);
    procedure itembuttonImageClick(Sender: TObject);
    procedure buttonLoginFormClick(Sender: TObject);
    procedure comboAppBorderStyleChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure popupEditItemClick(Sender: TObject; Index: Integer);
    procedure buttonImageFormClick(Sender: TObject);
    procedure buttonHighlightClick(Sender: TObject);
    procedure buttonAppListFormClick(Sender: TObject);
    procedure buttonBlurFormClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure buttonFullScreenClick(Sender: TObject);
    procedure radioSystemThemeChange(Sender: TObject);
    procedure radioLightThemeChange(Sender: TObject);
    procedure radioDarkThemeChange(Sender: TObject);

  private
    procedure AppThemeBeforeUpdate(Sender: TObject);
    procedure AppThemeAfterUpdate(Sender: TObject);
  public
  end;

var
  formDemo: TformDemo;

implementation

uses
  Form.LoginDialog,
  Form.ImageBackground,
  Form.AppList,
  UCL.Colors;

{$R *.dfm}

//  MAIN FORM

procedure TformDemo.FormCreate(Sender: TObject);
var
  TM: TUCustomThemeManager;
begin
  CaptionBar := captionBarMain;
  TM := SelectThemeManager(Self);
  TM.OnBeforeUpdate := AppThemeBeforeUpdate;
  TM.OnAfterUpdate  := AppThemeAfterUpdate;
  TM.ControlsBorderThickness:=1;
  TM.UseStrictControlsBorderThickness:=True; // no rescaling
end;

procedure TformDemo.FormShow(Sender: TObject);
var
  TM: TUCustomThemeManager;
begin
  TM := SelectThemeManager(Self);
  TM.Reload;
end;

procedure TformDemo.AppThemeBeforeUpdate(Sender: TObject);
begin
  if formDemo <> Nil then
    LockWindowUpdate(formDemo.Handle);
  if formLoginDialog <> Nil then
    LockWindowUpdate(formLoginDialog.Handle);
  if formImageBackground <> Nil then
    LockWindowUpdate(formImageBackground.Handle);
end;

procedure TformDemo.AppThemeAfterUpdate(Sender: TObject);
var
  TM: TUCustomThemeManager;
begin
  TM := SelectThemeManager(Self);
  //  Handle theme changed for formDemo
  if formDemo <> Nil then begin
    //  Theme changed
    if TM.Theme = ttSystem then
      formDemo.radioSystemTheme.Checked := True
    else if TM.Theme = ttLight then
      formDemo.radioLightTheme.Checked := True
    else
      formDemo.radioDarkTheme.Checked := True;

    //  Accent color changed
    formDemo.panelSelectAccentColor.Color := TM.AccentColor;
    formDemo.panelSelectAccentColor.Font.Color := GetTextColorFromBackground(TM.AccentColor);

    //  Color on border changed
    if TM.UseColorOnBorder then
      formDemo.checkColorBorder.State := cbsChecked
    else
      formDemo.checkColorBorder.State := cbsUnchecked;
  end;

  //  Handle theme changed for formImageBackground
  if formImageBackground <> Nil then begin
    //  Theme changed
    if TM.Theme = ttSystem then
      formImageBackground.radioSystemTheme.Checked := True
    else if TM.Theme = ttLight then
      formImageBackground.radioLightTheme.Checked := True
    else
      formImageBackground.radioDarkTheme.Checked := True;
  end;

  LockWindowUpdate(0);
end;

//  ANIMATION TESTING

procedure TformDemo.buttonAniToRightClick(Sender: TObject);
var
  Delta: Integer;
  Ani: TIntAni;
begin
  Delta := MulDiv(210, PPI, 96);

  Ani := TIntAni.Create(buttonRunning.Left, Delta,
    procedure (V: Integer)
    begin
      buttonRunning.Left := V;
    end,
    procedure
    begin
      buttonRunning.SetFocus;
    end);
  Ani.AniSet.QuickAssign(akOut, afkQuartic, 0, 250, 25);
  Ani.Start;
end;

procedure TformDemo.buttonAniToLeftClick(Sender: TObject);
var
  Delta: Integer;
  Ani: TIntAni;
begin
  Delta := -MulDiv(210, PPI, 96);

  Ani := TIntAni.Create(buttonRunning.Left, Delta,
    procedure (V: Integer)
    begin
      buttonRunning.Left := V;
    end,
    procedure
    begin
      buttonRunning.SetFocus;
    end);
  Ani.AniSet.QuickAssign(akOut, afkQuartic, 0, 250, 25);
  Ani.Start;
end;

procedure TformDemo.buttonOpenMenuClick(Sender: TObject);
var
  Opened: Boolean;
  Delta: Integer;
  Ani: TIntAni;
begin
  Opened := drawerNavigation.Width <> buttonOpenMenu.Width;

  if not Opened then
    Delta := MulDiv(180, PPI, 96)   //  Open
  else
    Delta := -MulDiv(180, PPI, 96); //  Close

  Ani := TIntAni.Create(drawerNavigation.Width, Delta,
    procedure (V: Integer)
    begin
      drawerNavigation.Width := V;
    end, nil);
  Ani.AniSet.QuickAssign(akOut, afkQuartic, 0, 200, 30);
  Ani.Start;
end;

procedure TformDemo.buttonMenuSettingsClick(Sender: TObject);
var
  Delta: Integer;
  Ani: TIntAni;
begin
  boxSettings.DisableAlign;  //  Pause align items for better performance

  if boxSettings.Width = 0 then
    Delta := MulDiv(250, PPI, 96)   //  Open
  else
    Delta := -boxSettings.Width; //  Close

  Ani := TIntAni.Create(boxSettings.Width, Delta,
    procedure (V: Integer)
    begin
      boxSettings.Width := V;
    end,
    procedure
    begin
      boxSettings.EnableAlign;
    end);
  Ani.AniSet.QuickAssign(akOut, afkQuartic, 0, 250, 25);
  Ani.Start;
end;

//  CONTROLS EVENTS

procedure TformDemo.itembuttonImageClick(Sender: TObject);
var
  ObjName: string;
begin
  case itembuttonImage.ObjectSelected of
    iokNone:
      ObjName := 'Background';
    iokCheckBox:
      ObjName := 'Checkbox';
    iokLeftIcon:
      ObjName := 'Left icon';
    iokText:
      ObjName := 'Text';
    iokDetail:
      ObjName := 'Detail';
    iokRightIcon:
      ObjName := 'Right icon';
  end;

  itembuttonImage.Detail := ObjName;
end;

procedure TformDemo.buttonHighlightClick(Sender: TObject);
var
  TM: TUCustomThemeManager;
begin
  TM := SelectThemeManager(Self);
  TM.Disconnect(buttonNoFocus);
end;

procedure TformDemo.sliderHorzChange(Sender: TObject);
begin
  //  Change progress bar value
  progressConnected.Value := sliderHorz.Value;
end;

procedure TformDemo.buttonFullScreenClick(Sender: TObject);
begin
  if not FullScreen then
    FullScreen := True
  else
    FullScreen := False;
end;

procedure TformDemo.buttonBlurFormClick(Sender: TObject);
begin
  if OverlayType = otNone then
    OverlayType := otBlur
  else
    OverlayType := otNone;
end;

procedure TformDemo.buttonRandomProgressClick(Sender: TObject);
begin
  buttonRandomProgress.Hint := 'This is line 1' + sLineBreak + 'This is' + sLineBreak + 'Nothing to do here, thanks';

  Randomize;
  progressCustomColor.GoToValue(Random(101));
  progressConnected.GoToValue(Random(101));
  progressVert.GoToValue(Random(101));
end;

//  OPEN FORM

procedure TformDemo.buttonLoginFormClick(Sender: TObject);
begin
  if formLoginDialog = Nil then
    Application.CreateForm(TformLoginDialog, formLoginDialog);
  formLoginDialog.Visible := True;
end;

procedure TformDemo.buttonImageFormClick(Sender: TObject);
begin
  if formImageBackground = Nil then
    Application.CreateForm(TformImageBackground, formImageBackground);
  formImageBackground.Visible := true;
end;

procedure TformDemo.buttonAppListFormClick(Sender: TObject);
begin
  if formAppList = Nil then
    Application.CreateForm(TformAppList, formAppList);
  formAppList.Visible := true;
end;

//  THEME

procedure TformDemo.buttonReloadSettingsClick(Sender: TObject);
var
  TM: TUCustomThemeManager;
begin
  TM := SelectThemeManager(Self);
  TM.Reload;
end;

procedure TformDemo.comboAppBorderStyleChange(Sender: TObject);
begin
  case comboAppBorderStyle.ItemIndex of
    0:  BorderStyle := bsDialog;
    1:  BorderStyle := bsSingle;
    2:  BorderStyle := bsSizeable;
    3:  BorderStyle := bsToolWindow;
    4:  BorderStyle := bsSizeToolWin;
  end;
end;

procedure TformDemo.comboAppDPIChange(Sender: TObject);
var
  NewPPI: Integer;
begin
  // 24 ppi intervals
  case comboAppDPI.ItemIndex of
    1: NewPPI := 120;
    2: NewPPI := 144;
    3: NewPPI := 168;
    4: NewPPI := 192;
    else
      NewPPI := 96;
  end;

  Self.PPI := NewPPI;
  Self.ScaleForPPI(NewPPI);

  if formAppList <> Nil then begin
    formAppList.PPI := NewPPI;
    formAppList.ScaleForPPI(NewPPI);
  end;

  if formLoginDialog <> Nil then begin
    formLoginDialog.PPI := NewPPI;
    formLoginDialog.ScaleForPPI(NewPPI);
  end;

  if formImageBackground <> Nil then begin
    formImageBackground.PPI := NewPPI;
    formImageBackground.ScaleForPPI(NewPPI);
  end;
end;

procedure TformDemo.panelSelectAccentColorClick(Sender: TObject);
var
  TM: TUCustomThemeManager;
  NewColor: TColor;
begin
  TM := SelectThemeManager(Self);
  //  Open dialog
  if dialogSelectColor.Execute then begin
    NewColor := dialogSelectColor.Color;

    //  Change accent color
    TM.UseSystemAccentColor := False;
    TM.AccentColor := NewColor;
//    ThemeManager.Reload;
  end;
end;

procedure TformDemo.radioSystemThemeChange(Sender: TObject);
var
  TM: TUCustomThemeManager;
begin
  TM := SelectThemeManager(Self);
  TM.Theme := ttSystem;
end;

procedure TformDemo.radioLightThemeChange(Sender: TObject);
var
  TM: TUCustomThemeManager;
begin
  TM := SelectThemeManager(Self);
  TM.Theme := ttLight;
end;

procedure TformDemo.radioDarkThemeChange(Sender: TObject);
var
  TM: TUCustomThemeManager;
begin
  TM := SelectThemeManager(Self);
  TM.Theme := ttDark;
end;

//  POPUP MENU

procedure TformDemo.popupEditItemClick(Sender: TObject; Index: Integer);
var
  Edit: TCustomEdit;
begin
  Self.SetFocus;  //  Close popup
  if popupEdit.PopupComponent is TCustomEdit then
    begin
      Edit := popupEdit.PopupComponent as TCustomEdit;
      case Index of
        0: Edit.CutToClipboard; //  Cut

        1: Edit.CopyToClipboard; //  Copy

        2: Edit.PasteFromClipboard; //  Paste
      end;
    end;
end;

end.
