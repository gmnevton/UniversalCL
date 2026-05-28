program Test;

{$IF CompilerVersion > 29}
  {$LEGACYIFEND ON}
{$IFEND}

uses
  madExcept,
  madLinkDisAsm,
  madListModules,
  Forms,
  Unit2 in 'Unit2.pas' {Form2},
  Unit1 in 'Unit1.pas' {Form1},
  Unit3 in 'Unit3.pas' {Form3};

{$R *.res}
{$IF CompilerVersion < 30}
  {$R 'UCLPackage_D2010Resource.res'}
{$ELSE}
  {$R 'UCLPackage.dres'}
{$IFEND}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
