unit Unit1;

interface

uses
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  UCL.Form, UCL.ThemeManager, Vcl.ExtCtrls, UCL.CaptionBar;

type
  TForm1 = class(TUForm)
    UCaptionBar1: TUCaptionBar;
    UThemeManager1: TUThemeManager;
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
