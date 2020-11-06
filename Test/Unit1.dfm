object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object UCaptionBar1: TUCaptionBar
    Left = 0
    Top = 0
    Width = 635
    Caption = '   Caption bar'
    Color = clLime
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ThemeManager = UThemeManager1
    UseSystemCaptionColor = True
  end
  object UThemeManager1: TUThemeManager
    Theme = ttLight
    Left = 408
    Top = 112
  end
end
