program Demo;

uses
  madExcept,
  madLinkDisAsm,
  madListModules,
  Forms,
  Form.Demo in 'DemoForms\Form.Demo.pas' {formDemo},
  Form.LoginDialog in 'DemoForms\Form.LoginDialog.pas' {formLoginDialog},
  Form.ImageBackground in 'DemoForms\Form.ImageBackground.pas' {formImageBackground},
  Form.AppList in 'DemoForms\Form.AppList.pas' {formAppList};

{$R *.res}
{$R 'UCLPackage_D2010Resource.res'}

begin
  {$IFDEF DEBUG}
    ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformDemo, formDemo);
  Application.CreateForm(TformLoginDialog, formLoginDialog);
  Application.CreateForm(TformImageBackground, formImageBackground);
  Application.CreateForm(TformAppList, formAppList);
  Application.Run;
end.
