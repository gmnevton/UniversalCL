unit Unit1;

interface

uses
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  UCL.Form, UCL.ThemeManager, Vcl.ExtCtrls, UCL.CaptionBar, UCL.QuickButton, Vcl.StdCtrls, UCL.Button, UCL.SymbolButton, UCL.Separator, UCL.ScrollBox;

type
  TForm1 = class(TUForm)
    UCaptionBar1: TUCaptionBar;
    UThemeManager1: TUThemeManager;
    panelRibbon: TUScrollBox;
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
