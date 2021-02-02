program Demo;

{$IF CompilerVersion > 29}
  {$LEGACYIFEND ON}
{$IFEND}

uses
  madListHardware,
  madListProcesses,
  madExcept,
  madLinkDisAsm,
  madListModules,
  Forms,
  UCL.HighDpiApp,
  Form.Demo in 'DemoForms\Form.Demo.pas' {formDemo},
  Form.LoginDialog in 'DemoForms\Form.LoginDialog.pas' {formLoginDialog},
  Form.ImageBackground in 'DemoForms\Form.ImageBackground.pas' {formImageBackground},
  Form.AppList in 'DemoForms\Form.AppList.pas' {formAppList};

{$R *.res}
{$IF CompilerVersion < 30}
  {$R 'UCLPackage_D2010Resource.res'}
{$ELSE}
  {$R 'UCLPackage.dres'}
{$IFEND}

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
