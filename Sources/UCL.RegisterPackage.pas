unit UCL.RegisterPackage;

interface

uses
  Classes;

procedure Register;

implementation

uses
  UCL.IntAnimation,
  UCL.ThemeManager,
  UCL.Form,
  UCL.CaptionBar,
  UCL.SymbolButton,
  UCL.Button,
  UCL.Text,
  UCL.HyperLink,
  UCL.Panel,
  UCL.CheckBox,
  UCL.ProgressBar,
  UCL.ScrollBox,
  UCL.RadioButton,
  UCL.ItemButton,
  UCL.Separator,
  UCL.Edit,
  UCL.Slider,
  UCL.PopupMenu,
  UCL.QuickButton,
  UCL.TitleBar,
  UCL.Shadow;

procedure Register;
begin
  RegisterComponents('Universal CL', [
    TUThemeManager,
    TUForm,
    TUCaptionBar,
    TUSymbolButton,
    TUButton,
    TUText,
    TUHyperLink,
    TUPanel,
    TUCheckBox,
    TUProgressBar,
    TUScrollBox,
    TURadioButton,
    TUItemButton,
    TUSeparator,
    TUEdit,
    TUSlider,
    TUPopupMenu,
    TUTitleBar,
    TUQuickButton,
    TUShadow
  ]);
end;

end.
