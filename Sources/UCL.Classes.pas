unit UCL.Classes;

interface

{$IF CompilerVersion > 29}
  {$LEGACYIFEND ON}
{$IFEND}

uses
  Classes,
  Windows,
  Controls,
  Graphics,
  Forms;

{$REGION 'Older Delphi version'}
{$IF CompilerVersion <= 30}
const
  {$EXTERNALSYM WM_DPICHANGED}
  WM_DPICHANGED       = $02E0;

type
  TDWordFiller = record
  {$IFDEF CPUX64}
    Filler: array[1..4] of Byte; // Pad DWORD to make it 8 bytes (4+4) [x64 only]
  {$ENDIF}
  end;

  PRect = ^TRect;

  TWMDpi = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    YDpi: Word;
    XDpi: Word;
    WParamFiller: TDWordFiller;
    ScaledRect: PRECT;
    Result: LRESULT;
  end;

  TMonitorHelper = class helper for TMonitor
  private
    function GetPixelsPerInch: Integer;
  public
    property PixelsPerInch: Integer read GetPixelsPerInch;
  end;
{$IFEND}
{$ENDREGION}

type
  TUOrientation = (oHorizontal, oVertical);

  TUDirection = (dLeft, dTop, dRight, dBottom);

  TUControlState = (csNone, csHover, csPress, csDisabled, csFocused);

  //  NEW
  TUButtonState = (ubsNone, ubsHover, ubsPress, ubsSelectedNone, ubsSelectedHover, ubsSelectedPress);

  TUImageKind = (ikFontIcon, ikImage);

//  TDefColor = array [TUTheme, TUControlState] of TColor;

  AccentPolicy = packed record
    AccentState: Integer;
    AccentFlags: Integer;
    GradientColor: Integer;
    AnimationId: Integer;
  end;

  WindowCompositionAttributeData = packed record
    Attribute: Cardinal;
    Data: Pointer;
    SizeOfData: Integer;
  end;

  TQuadColor = packed record
    case Boolean of
      True: (Blue, Green, Red, Alpha: Byte);
      False: (Quad: Cardinal);
  end;

  PQuadColor = ^TQuadColor;
  PPQuadColor = ^PQuadColor;

  TControlStateColors = class(TPersistent)
    private
      FNone: TColor;
      FHover: TColor;
      FPress: TColor;
      FDisabled: TColor;
      FFocused: TColor;

      FOnChange: TNotifyEvent;

      procedure SetStateColor(const Index: Integer; const Value: TColor);

    protected 
      procedure Changed;

    public
      constructor Create(aNone, aHover, aPress, aDisabled, aFocused: TColor); overload;
      function GetStateColor(const State: TUControlState): TColor;

    published
      property None: TColor index 0 read FNone write SetStateColor default $000000;
      property Hover: TColor index 1 read FHover write SetStateColor default $000000;
      property Press: TColor index 2 read FPress write SetStateColor default $000000;
      property Disabled: TColor index 3 read FDisabled write SetStateColor default $000000;
      property Focused: TColor index 4 read FFocused write SetStateColor default $000000;

      property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TUCustomControl = class(TCustomControl)
    published
      property Align;
      property Anchors;
      property AutoSize;
      property BiDiMode;
      property Caption;
      //property Color;
      property Constraints;
      property DragCursor;
      property DragKind;
      property DragMode;
      property Enabled;
      property Font;
      property ParentBiDiMode;
      property ParentColor;
      property ParentFont;
      property ParentShowHint;
      property PopupMenu;
      property ShowHint;
      property Touch;
      property Visible;
      {$IF CompilerVersion > 29}
        property StyleElements;
      {$IFEND}

      property OnCanResize;
      property OnClick;
      property OnConstrainedResize;
      property OnContextPopup;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDock;
      property OnEndDrag;
      property OnGesture;
      property OnMouseActivate;
      property OnMouseDown;
      property OnMouseEnter;
      property OnMouseLeave;
      property OnMouseMove;
      property OnMouseUp;
      property OnResize;
      property OnStartDock;
      property OnStartDrag;
  end;

  TUGraphicControl = class(TGraphicControl)
    published
      property Align;
      property Anchors;
      property AutoSize;
      property BiDiMode;
      //property Caption;
      property Color;
      property Constraints;
      property DragCursor;
      property DragKind;
      property DragMode;
      property Enabled;
      property Font;
      property ParentBiDiMode;
      property ParentColor;
      property ParentFont;
      property ParentShowHint;
      property PopupMenu;
      property ShowHint;
      property Touch;
      property Visible;
      {$IF CompilerVersion > 29}
        property StyleElements;
      {$IFEND}

      property OnCanResize;
      property OnClick;
      property OnConstrainedResize;
      property OnContextPopup;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDock;
      property OnEndDrag;
      property OnGesture;
      property OnMouseActivate;
      property OnMouseDown;
      property OnMouseEnter;
      property OnMouseLeave;
      property OnMouseMove;
      property OnMouseUp;
      property OnResize;
      property OnStartDock;
      property OnStartDrag;
  end;

function LoadResourceFontByName(const ResourceName: String; ResType: PChar): Boolean;
function LoadResourceFontByID(ResourceID: Integer; ResType: PChar): Boolean;

implementation

{$REGION 'Older Delphi version'}
{$IF CompilerVersion <= 30}
uses
  SysUtils,
  UCL.ShellUIScaling;

function TMonitorHelper.GetPixelsPerInch: Integer;
var
  Ydpi: Cardinal;
  Xdpi: Cardinal;
  DC: HDC;
begin
  if CheckWin32Version(6, 3) then begin
    if GetDpiForMonitor(Handle, TMonitorDpiType.MDT_EFFECTIVE_DPI, Ydpi, Xdpi) = S_OK then
      Result := Ydpi
    else
      Result := 0;
  end
  else begin
    DC := GetDC(0);
    Result := GetDeviceCaps(DC, LOGPIXELSY);
    ReleaseDC(0, DC);
  end;
end;
{$IFEND}
{$ENDREGION}

{ TControlStateColors }

procedure TControlStateColors.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TControlStateColors.Create(aNone, aHover, aPress, aDisabled, aFocused: TColor);
begin
  inherited Create;

  FNone := aNone;
  FHover := aHover;
  FPress := aPress;
  FDisabled := aDisabled;
  FFocused := aFocused;
end;

function TControlStateColors.GetStateColor(const State: TUControlState): TColor;
begin
  case State of
    csNone    : Result := None;
    csHover   : Result := Hover;
    csPress   : Result := Press;
    csDisabled: Result := Disabled;
    csFocused : Result := Focused;
    else
      Result := None;
  end;
end;

procedure TControlStateColors.SetStateColor(const Index: Integer; const Value: TColor);
begin
  case Index of
    0: if Value <> FNone then begin
      FNone := Value;
      Changed;
    end;
    1: if Value <> FHover then begin
      FHover := Value;
      Changed;
    end;
    2: if Value <> FPress then begin
      FPress := Value;
      Changed;
    end;
    3: if Value <> FDisabled then begin
      FDisabled := Value;
      Changed;
    end;
    4: if Value <> FFocused then begin
      FFocused := Value;
      Changed;
    end;
  end;
end;

function LoadResourceFontByName(const ResourceName: String; ResType: PChar): Boolean;
var
  ResStream: TResourceStream;
  FontsCount: DWORD;
begin
  try
    ResStream := TResourceStream.Create(hInstance, ResourceName, ResType);
    try
      Result := (AddFontMemResourceEx(ResStream.Memory, ResStream.Size, Nil, @FontsCount) <> 0);
    finally
      ResStream.Free;
    end;
  except
    Result := False;
  end;
end;

function LoadResourceFontByID(ResourceID: Integer; ResType: PChar): Boolean;
var
  ResStream: TResourceStream;
  FontsCount: DWORD;
begin
  try
    ResStream := TResourceStream.CreateFromID(hInstance, ResourceID, ResType);
    try
      Result := (AddFontMemResourceEx(ResStream.Memory, ResStream.Size, Nil, @FontsCount) <> 0);
    finally
      ResStream.Free;
    end;
  except
    Result := False;
  end;
end;

initialization
  LoadResourceFontByName('SEGOEUI', RT_RCDATA);
  LoadResourceFontByName('SEGOEMDL2ASSETS', RT_RCDATA);
  LoadResourceFontByName('SEGOEUISEMIBOLD', RT_RCDATA);
//  LoadResourceFontByID(2, RT_FONT);

end.
