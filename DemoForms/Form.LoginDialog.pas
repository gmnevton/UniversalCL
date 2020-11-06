unit Form.LoginDialog;

interface

uses
  SysUtils, 
  Classes,
  Windows, 
  Messages,
  Forms, 
  StdCtrls, 
  pngimage, 
  Menus, 
  ExtCtrls, 
  Controls,
  UCL.ThemeManager,
  UCL.Form,
  UCL.Classes,
  UCL.Utils,
  UCL.Text,
  UCL.Edit,
  UCL.QuickButton,
  UCL.Panel,
  UCL.PopupMenu,
  UCL.CheckBox,
  UCL.CaptionBar,
  UCL.Button,
  UCL.ScrollBox;

type
  TformLoginDialog = class(TUForm)
    boxMain: TUScrollBox;
    captionbarMain: TUCaptionBar;
    buttonOk: TUButton;
    buttonCancel: TUButton;
    titleSignin: TUText;
    headingSignin: TUText;
    entryPassword: TUText;
    entryEmail: TUText;
    buttonAppQuit: TUQuickButton;
    buttonAppMinimized: TUQuickButton;
    panelAction: TUPanel;
    textShowMoreOptions: TUText;
    panelMoreOptions: TUPanel;
    checkSendMeNews: TUCheckBox;
    checkKeepLogin: TUCheckBox;
    buttonAppTheme: TUQuickButton;
    editEmail: TUEdit;
    editPassword: TUEdit;
    entryDescription: TUText;
    editDescription: TUEdit;
    popupEdit: TUPopupMenu;
    CutCtrlX1: TMenuItem;
    CopyCtrlC1: TMenuItem;
    PasteCtrlV1: TMenuItem;
    procedure buttonCancelClick(Sender: TObject);
    procedure textShowMoreOptionsClick(Sender: TObject);
    procedure buttonAppThemeClick(Sender: TObject);
    procedure buttonOkClick(Sender: TObject);
    procedure popupEditItemClick(Sender: TObject; Index: Integer);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  formLoginDialog: TformLoginDialog;

implementation

{$R *.dfm}

procedure TformLoginDialog.buttonAppThemeClick(Sender: TObject);
begin
//  if ThemeManager.Theme = ttLight then
//    ThemeManager.CustomTheme := utDark
//  else
//    ThemeManager.CustomTheme := utLight;
//  ThemeManager.UseSystemTheme := False;
  ThemeManager.Reload;
end;

procedure TformLoginDialog.buttonCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TformLoginDialog.buttonOkClick(Sender: TObject);
begin
  Close;
end;

procedure TformLoginDialog.FormCreate(Sender: TObject);
begin
//  EnableBlur(Handle, 3);
end;

procedure TformLoginDialog.popupEditItemClick(Sender: TObject; Index: Integer);
var
  Edit: TCustomEdit;
begin
  Self.SetFocus;  //  Close popup
  if popupEdit.PopupComponent is TCustomEdit then begin
    Edit := popupEdit.PopupComponent as TCustomEdit;
    case Index of
      0: Edit.CutToClipboard; //  Cut

      1: Edit.CopyToClipboard; //  Copy

      2: Edit.PasteFromClipboard; //  Paste
    end;
  end;
end;

procedure TformLoginDialog.textShowMoreOptionsClick(Sender: TObject);
begin
  panelMoreOptions.Visible := not panelMoreOptions.Visible;
end;

end.
