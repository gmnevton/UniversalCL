unit DataModule.Main;

interface

uses
  UCL.TUThemeManager, UCL.Classes, UCL.Utils,
  UCL.TUCheckBox,
  SysUtils, Classes, Dialogs,
  Windows;

type
  TdmMain = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmMain: TdmMain;

implementation

uses
  Form.Demo, Form.LoginDialog, Form.ImageBackground;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
