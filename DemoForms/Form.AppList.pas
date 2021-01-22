unit Form.AppList;

interface

uses
  SysUtils,
  Classes,
  Controls,
  Forms,
  StdCtrls,
  ExtCtrls,
  pngimage,
  UCL.Utils,
  UCL.Form,
  UCL.ScrollBox,
  UCL.ItemButton,
  UCL.CaptionBar,
  UCL.QuickButton,
  UCL.SymbolButton;

type
  TformAppList = class(TUForm)
    boxHorizontal: TUScrollBox;
    captionBar: TUCaptionBar;
    buttonWinClose: TUQuickButton;
    buttonWinMin: TUQuickButton;
    boxVertical: TUScrollBox;
    UItemButton1: TUItemButton;
    UItemButton2: TUItemButton;
    UItemButton3: TUItemButton;
    UItemButton4: TUItemButton;
    UItemButton5: TUItemButton;
    UItemButton6: TUItemButton;
    UItemButton7: TUItemButton;
    UItemButton8: TUItemButton;
    UItemButton9: TUItemButton;
    UItemButton10: TUItemButton;
    UItemButton11: TUItemButton;
    UItemButton12: TUItemButton;
    UItemButton13: TUItemButton;
    UItemButton14: TUItemButton;
    UItemButton15: TUItemButton;
    UItemButton16: TUItemButton;
    UItemButton17: TUItemButton;
    UItemButton18: TUItemButton;
    UItemButton19: TUItemButton;
    UItemButton20: TUItemButton;
    UItemButton21: TUItemButton;
    UItemButton22: TUItemButton;
    UItemButton23: TUItemButton;
    UItemButton24: TUItemButton;
    UItemButton25: TUItemButton;
    UItemButton26: TUItemButton;
    UItemButton27: TUItemButton;
    UItemButton28: TUItemButton;
    UItemButton29: TUItemButton;
    UItemButton30: TUItemButton;
    USymbolButton1: TUSymbolButton;
    USymbolButton14: TUSymbolButton;
    USymbolButton15: TUSymbolButton;
    USymbolButton18: TUSymbolButton;
    USymbolButton2: TUSymbolButton;
    USymbolButton4: TUSymbolButton;
    USymbolButton3: TUSymbolButton;
    //
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
  public
  end;

var
  formAppList: TformAppList;

implementation

{$R *.dfm}

uses
  UCL.DragReorder;

procedure TformAppList.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to boxVertical.ControlCount - 1 do
    if boxVertical.Controls[i] is TUItemButton then begin
      AssignVertDragHandler(boxVertical.Controls[i]);
//      RemoveDragHandler(boxVertical.Controls[i]);
    end;
end;

procedure TformAppList.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to boxVertical.ControlCount - 1 do
    if boxVertical.Controls[i] is TUItemButton then begin
//      AssignVertDragHandler(boxVertical.Controls[i]);
      RemoveDragHandler(boxVertical.Controls[i]);
    end;
end;

end.
