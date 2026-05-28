object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 339
  ClientWidth = 805
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object UCaptionBar1: TUCaptionBar
    Left = 0
    Top = 0
    Width = 805
    Height = 32
    ThemeManager = UThemeManager1
    Caption = ' Caption bar'
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 0
    BackColors.Enabled = False
    BackColors.Color = clBlack
    BackColors.LightColor = 15921906
    BackColors.DarkColor = 2829099
    BackColors.FocusedLightColor = 14120960
    BackColors.FocusedDarkColor = 1525760
    Menu = MainMenu2
    MenuController.ButtonWidth = 48
    MenuController.ButtonHeight = 32
    MenuController.PosX = 120
    MenuController.Transparent = False
    MenuController.Font.Charset = DEFAULT_CHARSET
    MenuController.Font.Color = clMenuText
    MenuController.Font.Height = -12
    MenuController.Font.Name = 'Segoe UI'
    MenuController.Font.Style = []
    MenuController.ButtonBackColors.Enabled = False
    MenuController.ButtonBackColors.LightColor = 15921906
    MenuController.ButtonBackColors.LightHover = 14120960
    MenuController.ButtonBackColors.LightDisabled = clGray
    MenuController.ButtonBackColors.DarkColor = 2829099
    MenuController.ButtonBackColors.DarkHover = 1525760
    MenuController.ButtonBackColors.DarkDisabled = clGray
    MenuController.ButtonTextColors.Enabled = False
    MenuController.ButtonTextColors.LightColor = clBlack
    MenuController.ButtonTextColors.LightHover = clWhite
    MenuController.ButtonTextColors.LightDisabled = clGray
    MenuController.ButtonTextColors.DarkColor = clWhite
    MenuController.ButtonTextColors.DarkHover = clWhite
    MenuController.ButtonTextColors.DarkDisabled = clGray
    MenuController.MenuBorderColors.Enabled = False
    MenuController.MenuBorderColors.Color = clDefault
    MenuController.MenuBorderColors.LightColor = clBlack
    MenuController.MenuBorderColors.DarkColor = clSilver
    MenuController.MenuBackColors.Enabled = False
    MenuController.MenuBackColors.LightColor = clWhite
    MenuController.MenuBackColors.LightHover = clHighlight
    MenuController.MenuBackColors.LightDisabled = clGray
    MenuController.MenuBackColors.DarkColor = clBlack
    MenuController.MenuBackColors.DarkHover = clHighlight
    MenuController.MenuBackColors.DarkDisabled = clGray
    MenuController.MenuTextColors.Enabled = False
    MenuController.MenuTextColors.LightColor = clBlack
    MenuController.MenuTextColors.LightHover = clBlack
    MenuController.MenuTextColors.LightDisabled = clGray
    MenuController.MenuTextColors.DarkColor = clWhite
    MenuController.MenuTextColors.DarkHover = clWhite
    MenuController.MenuTextColors.DarkDisabled = clGray
    MenuOffset = 120
    UseSystemCaptionColor = True
  end
  object panelRibbon: TUScrollBox
    Left = 0
    Top = 32
    Width = 805
    Height = 60
    HorzScrollBar.Tracking = True
    VertScrollBar.Tracking = True
    Align = alTop
    AutoScroll = False
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    Color = 3355443
    ParentColor = False
    TabOrder = 1
    TabStop = True
    StyleElements = []
    ThemeManager = UThemeManager1
    BackColor.Enabled = True
    BackColor.Color = clBlack
    BackColor.LightColor = 14342874
    BackColor.DarkColor = 3355443
    ScrollOrientation = oHorizontal
  end
  object UPanel1: TUPanel
    Left = 504
    Top = 92
    Width = 301
    Height = 247
    ThemeManager = UThemeManager1
    Align = alRight
    Caption = 'UPanel1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ShowCaption = False
    TabOrder = 2
    BackColor.Enabled = False
    BackColor.Color = clBlack
    BackColor.LightColor = 15132390
    BackColor.DarkColor = 2039583
    object UScrollBox2: TUScrollBox
      Left = 0
      Top = 0
      Width = 301
      Height = 247
      HorzScrollBar.Tracking = True
      VertScrollBar.Tracking = True
      Align = alClient
      AutoScroll = False
      BevelEdges = []
      BevelInner = bvNone
      BevelOuter = bvNone
      Color = 2039583
      ParentColor = False
      TabOrder = 0
      StyleElements = []
      ThemeManager = UThemeManager1
      BackColor.Enabled = False
      BackColor.Color = clBlack
      BackColor.LightColor = 15132390
      BackColor.DarkColor = 2039583
    end
  end
  object UScrollBox1: TUScrollBox
    Left = 0
    Top = 92
    Width = 301
    Height = 247
    HorzScrollBar.Tracking = True
    VertScrollBar.Range = 800
    VertScrollBar.Tracking = True
    Align = alLeft
    AutoScroll = False
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    Color = 2039583
    ParentColor = False
    TabOrder = 3
    Visible = False
    StyleElements = []
    ThemeManager = UThemeManager1
    BackColor.Enabled = False
    BackColor.Color = clBlack
    BackColor.LightColor = 15132390
    BackColor.DarkColor = 2039583
    object UItemButton1: TUItemButton
      Left = 0
      Top = 760
      Width = 301
      ThemeManager = UThemeManager1
      Align = alTop
      DragCursor = crDefault
      TabOrder = 1
      CustomColors.BackColors.Enabled = False
      CustomColors.BackColors.LightColor = 13421772
      CustomColors.BackColors.LightHover = 13421772
      CustomColors.BackColors.LightPress = 10066329
      CustomColors.BackColors.LightDisabled = 13421772
      CustomColors.BackColors.LightFocused = 13421772
      CustomColors.BackColors.DarkColor = 3355443
      CustomColors.BackColors.DarkHover = 3355443
      CustomColors.BackColors.DarkPress = 6710886
      CustomColors.BackColors.DarkDisabled = 3355443
      CustomColors.BackColors.DarkFocused = 3355443
      CustomColors.BorderColors.Enabled = False
      CustomColors.BorderColors.LightColor = 13421772
      CustomColors.BorderColors.LightHover = 11184810
      CustomColors.BorderColors.LightPress = 10066329
      CustomColors.BorderColors.LightDisabled = 8026746
      CustomColors.BorderColors.LightFocused = 11184810
      CustomColors.BorderColors.DarkColor = 3355443
      CustomColors.BorderColors.DarkHover = 11184810
      CustomColors.BorderColors.DarkPress = 6710886
      CustomColors.BorderColors.DarkDisabled = 8750469
      CustomColors.BorderColors.DarkFocused = 11184810
      CustomColors.TextColors.Enabled = False
      CustomColors.TextColors.LightColor = clBlack
      CustomColors.TextColors.LightHover = clBlack
      CustomColors.TextColors.LightPress = clBlack
      CustomColors.TextColors.LightDisabled = clGray
      CustomColors.TextColors.LightFocused = clBlack
      CustomColors.TextColors.DarkColor = clWhite
      CustomColors.TextColors.DarkHover = clWhite
      CustomColors.TextColors.DarkPress = clWhite
      CustomColors.TextColors.DarkDisabled = clGray
      CustomColors.TextColors.DarkFocused = clWhite
      CustomColors.DetailColors.Enabled = False
      CustomColors.DetailColors.LightColor = clGray
      CustomColors.DetailColors.LightHover = clSilver
      CustomColors.DetailColors.LightPress = clSilver
      CustomColors.DetailColors.LightDisabled = clSilver
      CustomColors.DetailColors.LightFocused = clSilver
      CustomColors.DetailColors.DarkColor = 3355443
      CustomColors.DetailColors.DarkHover = 3355443
      CustomColors.DetailColors.DarkPress = 6710886
      CustomColors.DetailColors.DarkDisabled = 3355443
      CustomColors.DetailColors.DarkFocused = 3355443
      CustomColors.ActiveColors.Enabled = False
      CustomColors.ActiveColors.LightColor = 13421772
      CustomColors.ActiveColors.LightHover = 13421772
      CustomColors.ActiveColors.LightPress = 10066329
      CustomColors.ActiveColors.LightDisabled = 13421772
      CustomColors.ActiveColors.LightFocused = 13421772
      CustomColors.ActiveColors.DarkColor = 3355443
      CustomColors.ActiveColors.DarkHover = 3355443
      CustomColors.ActiveColors.DarkPress = 6710886
      CustomColors.ActiveColors.DarkDisabled = 3355443
      CustomColors.ActiveColors.DarkFocused = 3355443
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -11
      DetailFont.Name = 'Tahoma'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #57347
      Text = 'Text'
      Detail = 'Detail'
      RightIcon = #59198
      Caption = 'UItemButton1'
    end
    object UItemButton2: TUItemButton
      Left = 0
      Top = 720
      Width = 301
      ThemeManager = UThemeManager1
      Align = alTop
      DragCursor = crDefault
      TabOrder = 2
      CustomColors.BackColors.Enabled = False
      CustomColors.BackColors.LightColor = 13421772
      CustomColors.BackColors.LightHover = 13421772
      CustomColors.BackColors.LightPress = 10066329
      CustomColors.BackColors.LightDisabled = 13421772
      CustomColors.BackColors.LightFocused = 13421772
      CustomColors.BackColors.DarkColor = 3355443
      CustomColors.BackColors.DarkHover = 3355443
      CustomColors.BackColors.DarkPress = 6710886
      CustomColors.BackColors.DarkDisabled = 3355443
      CustomColors.BackColors.DarkFocused = 3355443
      CustomColors.BorderColors.Enabled = False
      CustomColors.BorderColors.LightColor = 13421772
      CustomColors.BorderColors.LightHover = 11184810
      CustomColors.BorderColors.LightPress = 10066329
      CustomColors.BorderColors.LightDisabled = 8026746
      CustomColors.BorderColors.LightFocused = 11184810
      CustomColors.BorderColors.DarkColor = 3355443
      CustomColors.BorderColors.DarkHover = 11184810
      CustomColors.BorderColors.DarkPress = 6710886
      CustomColors.BorderColors.DarkDisabled = 8750469
      CustomColors.BorderColors.DarkFocused = 11184810
      CustomColors.TextColors.Enabled = False
      CustomColors.TextColors.LightColor = clBlack
      CustomColors.TextColors.LightHover = clBlack
      CustomColors.TextColors.LightPress = clBlack
      CustomColors.TextColors.LightDisabled = clGray
      CustomColors.TextColors.LightFocused = clBlack
      CustomColors.TextColors.DarkColor = clWhite
      CustomColors.TextColors.DarkHover = clWhite
      CustomColors.TextColors.DarkPress = clWhite
      CustomColors.TextColors.DarkDisabled = clGray
      CustomColors.TextColors.DarkFocused = clWhite
      CustomColors.DetailColors.Enabled = False
      CustomColors.DetailColors.LightColor = clGray
      CustomColors.DetailColors.LightHover = clSilver
      CustomColors.DetailColors.LightPress = clSilver
      CustomColors.DetailColors.LightDisabled = clSilver
      CustomColors.DetailColors.LightFocused = clSilver
      CustomColors.DetailColors.DarkColor = 3355443
      CustomColors.DetailColors.DarkHover = 3355443
      CustomColors.DetailColors.DarkPress = 6710886
      CustomColors.DetailColors.DarkDisabled = 3355443
      CustomColors.DetailColors.DarkFocused = 3355443
      CustomColors.ActiveColors.Enabled = False
      CustomColors.ActiveColors.LightColor = 13421772
      CustomColors.ActiveColors.LightHover = 13421772
      CustomColors.ActiveColors.LightPress = 10066329
      CustomColors.ActiveColors.LightDisabled = 13421772
      CustomColors.ActiveColors.LightFocused = 13421772
      CustomColors.ActiveColors.DarkColor = 3355443
      CustomColors.ActiveColors.DarkHover = 3355443
      CustomColors.ActiveColors.DarkPress = 6710886
      CustomColors.ActiveColors.DarkDisabled = 3355443
      CustomColors.ActiveColors.DarkFocused = 3355443
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -11
      DetailFont.Name = 'Tahoma'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #57347
      Text = 'Text'
      Detail = 'Detail'
      RightIcon = #59198
      Caption = 'UItemButton1'
    end
    object UItemButton3: TUItemButton
      Left = 0
      Top = 680
      Width = 301
      ThemeManager = UThemeManager1
      Align = alTop
      DragCursor = crDefault
      TabOrder = 3
      CustomColors.BackColors.Enabled = False
      CustomColors.BackColors.LightColor = 13421772
      CustomColors.BackColors.LightHover = 13421772
      CustomColors.BackColors.LightPress = 10066329
      CustomColors.BackColors.LightDisabled = 13421772
      CustomColors.BackColors.LightFocused = 13421772
      CustomColors.BackColors.DarkColor = 3355443
      CustomColors.BackColors.DarkHover = 3355443
      CustomColors.BackColors.DarkPress = 6710886
      CustomColors.BackColors.DarkDisabled = 3355443
      CustomColors.BackColors.DarkFocused = 3355443
      CustomColors.BorderColors.Enabled = False
      CustomColors.BorderColors.LightColor = 13421772
      CustomColors.BorderColors.LightHover = 11184810
      CustomColors.BorderColors.LightPress = 10066329
      CustomColors.BorderColors.LightDisabled = 8026746
      CustomColors.BorderColors.LightFocused = 11184810
      CustomColors.BorderColors.DarkColor = 3355443
      CustomColors.BorderColors.DarkHover = 11184810
      CustomColors.BorderColors.DarkPress = 6710886
      CustomColors.BorderColors.DarkDisabled = 8750469
      CustomColors.BorderColors.DarkFocused = 11184810
      CustomColors.TextColors.Enabled = False
      CustomColors.TextColors.LightColor = clBlack
      CustomColors.TextColors.LightHover = clBlack
      CustomColors.TextColors.LightPress = clBlack
      CustomColors.TextColors.LightDisabled = clGray
      CustomColors.TextColors.LightFocused = clBlack
      CustomColors.TextColors.DarkColor = clWhite
      CustomColors.TextColors.DarkHover = clWhite
      CustomColors.TextColors.DarkPress = clWhite
      CustomColors.TextColors.DarkDisabled = clGray
      CustomColors.TextColors.DarkFocused = clWhite
      CustomColors.DetailColors.Enabled = False
      CustomColors.DetailColors.LightColor = clGray
      CustomColors.DetailColors.LightHover = clSilver
      CustomColors.DetailColors.LightPress = clSilver
      CustomColors.DetailColors.LightDisabled = clSilver
      CustomColors.DetailColors.LightFocused = clSilver
      CustomColors.DetailColors.DarkColor = 3355443
      CustomColors.DetailColors.DarkHover = 3355443
      CustomColors.DetailColors.DarkPress = 6710886
      CustomColors.DetailColors.DarkDisabled = 3355443
      CustomColors.DetailColors.DarkFocused = 3355443
      CustomColors.ActiveColors.Enabled = False
      CustomColors.ActiveColors.LightColor = 13421772
      CustomColors.ActiveColors.LightHover = 13421772
      CustomColors.ActiveColors.LightPress = 10066329
      CustomColors.ActiveColors.LightDisabled = 13421772
      CustomColors.ActiveColors.LightFocused = 13421772
      CustomColors.ActiveColors.DarkColor = 3355443
      CustomColors.ActiveColors.DarkHover = 3355443
      CustomColors.ActiveColors.DarkPress = 6710886
      CustomColors.ActiveColors.DarkDisabled = 3355443
      CustomColors.ActiveColors.DarkFocused = 3355443
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -11
      DetailFont.Name = 'Tahoma'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #57347
      Text = 'Text'
      Detail = 'Detail'
      RightIcon = #59198
      Caption = 'UItemButton1'
    end
    object UItemButton4: TUItemButton
      Left = 0
      Top = 640
      Width = 301
      ThemeManager = UThemeManager1
      Align = alTop
      DragCursor = crDefault
      TabOrder = 4
      CustomColors.BackColors.Enabled = False
      CustomColors.BackColors.LightColor = 13421772
      CustomColors.BackColors.LightHover = 13421772
      CustomColors.BackColors.LightPress = 10066329
      CustomColors.BackColors.LightDisabled = 13421772
      CustomColors.BackColors.LightFocused = 13421772
      CustomColors.BackColors.DarkColor = 3355443
      CustomColors.BackColors.DarkHover = 3355443
      CustomColors.BackColors.DarkPress = 6710886
      CustomColors.BackColors.DarkDisabled = 3355443
      CustomColors.BackColors.DarkFocused = 3355443
      CustomColors.BorderColors.Enabled = False
      CustomColors.BorderColors.LightColor = 13421772
      CustomColors.BorderColors.LightHover = 11184810
      CustomColors.BorderColors.LightPress = 10066329
      CustomColors.BorderColors.LightDisabled = 8026746
      CustomColors.BorderColors.LightFocused = 11184810
      CustomColors.BorderColors.DarkColor = 3355443
      CustomColors.BorderColors.DarkHover = 11184810
      CustomColors.BorderColors.DarkPress = 6710886
      CustomColors.BorderColors.DarkDisabled = 8750469
      CustomColors.BorderColors.DarkFocused = 11184810
      CustomColors.TextColors.Enabled = False
      CustomColors.TextColors.LightColor = clBlack
      CustomColors.TextColors.LightHover = clBlack
      CustomColors.TextColors.LightPress = clBlack
      CustomColors.TextColors.LightDisabled = clGray
      CustomColors.TextColors.LightFocused = clBlack
      CustomColors.TextColors.DarkColor = clWhite
      CustomColors.TextColors.DarkHover = clWhite
      CustomColors.TextColors.DarkPress = clWhite
      CustomColors.TextColors.DarkDisabled = clGray
      CustomColors.TextColors.DarkFocused = clWhite
      CustomColors.DetailColors.Enabled = False
      CustomColors.DetailColors.LightColor = clGray
      CustomColors.DetailColors.LightHover = clSilver
      CustomColors.DetailColors.LightPress = clSilver
      CustomColors.DetailColors.LightDisabled = clSilver
      CustomColors.DetailColors.LightFocused = clSilver
      CustomColors.DetailColors.DarkColor = 3355443
      CustomColors.DetailColors.DarkHover = 3355443
      CustomColors.DetailColors.DarkPress = 6710886
      CustomColors.DetailColors.DarkDisabled = 3355443
      CustomColors.DetailColors.DarkFocused = 3355443
      CustomColors.ActiveColors.Enabled = False
      CustomColors.ActiveColors.LightColor = 13421772
      CustomColors.ActiveColors.LightHover = 13421772
      CustomColors.ActiveColors.LightPress = 10066329
      CustomColors.ActiveColors.LightDisabled = 13421772
      CustomColors.ActiveColors.LightFocused = 13421772
      CustomColors.ActiveColors.DarkColor = 3355443
      CustomColors.ActiveColors.DarkHover = 3355443
      CustomColors.ActiveColors.DarkPress = 6710886
      CustomColors.ActiveColors.DarkDisabled = 3355443
      CustomColors.ActiveColors.DarkFocused = 3355443
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -11
      DetailFont.Name = 'Tahoma'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #57347
      Text = 'Text'
      Detail = 'Detail'
      RightIcon = #59198
      Caption = 'UItemButton1'
    end
    object UItemButton5: TUItemButton
      Left = 0
      Top = 600
      Width = 301
      ThemeManager = UThemeManager1
      Align = alTop
      DragCursor = crDefault
      TabOrder = 5
      CustomColors.BackColors.Enabled = False
      CustomColors.BackColors.LightColor = 13421772
      CustomColors.BackColors.LightHover = 13421772
      CustomColors.BackColors.LightPress = 10066329
      CustomColors.BackColors.LightDisabled = 13421772
      CustomColors.BackColors.LightFocused = 13421772
      CustomColors.BackColors.DarkColor = 3355443
      CustomColors.BackColors.DarkHover = 3355443
      CustomColors.BackColors.DarkPress = 6710886
      CustomColors.BackColors.DarkDisabled = 3355443
      CustomColors.BackColors.DarkFocused = 3355443
      CustomColors.BorderColors.Enabled = False
      CustomColors.BorderColors.LightColor = 13421772
      CustomColors.BorderColors.LightHover = 11184810
      CustomColors.BorderColors.LightPress = 10066329
      CustomColors.BorderColors.LightDisabled = 8026746
      CustomColors.BorderColors.LightFocused = 11184810
      CustomColors.BorderColors.DarkColor = 3355443
      CustomColors.BorderColors.DarkHover = 11184810
      CustomColors.BorderColors.DarkPress = 6710886
      CustomColors.BorderColors.DarkDisabled = 8750469
      CustomColors.BorderColors.DarkFocused = 11184810
      CustomColors.TextColors.Enabled = False
      CustomColors.TextColors.LightColor = clBlack
      CustomColors.TextColors.LightHover = clBlack
      CustomColors.TextColors.LightPress = clBlack
      CustomColors.TextColors.LightDisabled = clGray
      CustomColors.TextColors.LightFocused = clBlack
      CustomColors.TextColors.DarkColor = clWhite
      CustomColors.TextColors.DarkHover = clWhite
      CustomColors.TextColors.DarkPress = clWhite
      CustomColors.TextColors.DarkDisabled = clGray
      CustomColors.TextColors.DarkFocused = clWhite
      CustomColors.DetailColors.Enabled = False
      CustomColors.DetailColors.LightColor = clGray
      CustomColors.DetailColors.LightHover = clSilver
      CustomColors.DetailColors.LightPress = clSilver
      CustomColors.DetailColors.LightDisabled = clSilver
      CustomColors.DetailColors.LightFocused = clSilver
      CustomColors.DetailColors.DarkColor = 3355443
      CustomColors.DetailColors.DarkHover = 3355443
      CustomColors.DetailColors.DarkPress = 6710886
      CustomColors.DetailColors.DarkDisabled = 3355443
      CustomColors.DetailColors.DarkFocused = 3355443
      CustomColors.ActiveColors.Enabled = False
      CustomColors.ActiveColors.LightColor = 13421772
      CustomColors.ActiveColors.LightHover = 13421772
      CustomColors.ActiveColors.LightPress = 10066329
      CustomColors.ActiveColors.LightDisabled = 13421772
      CustomColors.ActiveColors.LightFocused = 13421772
      CustomColors.ActiveColors.DarkColor = 3355443
      CustomColors.ActiveColors.DarkHover = 3355443
      CustomColors.ActiveColors.DarkPress = 6710886
      CustomColors.ActiveColors.DarkDisabled = 3355443
      CustomColors.ActiveColors.DarkFocused = 3355443
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -11
      DetailFont.Name = 'Tahoma'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #57347
      Text = 'Text'
      Detail = 'Detail'
      RightIcon = #59198
      Caption = 'UItemButton1'
    end
    object UItemButton6: TUItemButton
      Left = 0
      Top = 560
      Width = 301
      ThemeManager = UThemeManager1
      Align = alTop
      DragCursor = crDefault
      TabOrder = 6
      CustomColors.BackColors.Enabled = False
      CustomColors.BackColors.LightColor = 13421772
      CustomColors.BackColors.LightHover = 13421772
      CustomColors.BackColors.LightPress = 10066329
      CustomColors.BackColors.LightDisabled = 13421772
      CustomColors.BackColors.LightFocused = 13421772
      CustomColors.BackColors.DarkColor = 3355443
      CustomColors.BackColors.DarkHover = 3355443
      CustomColors.BackColors.DarkPress = 6710886
      CustomColors.BackColors.DarkDisabled = 3355443
      CustomColors.BackColors.DarkFocused = 3355443
      CustomColors.BorderColors.Enabled = False
      CustomColors.BorderColors.LightColor = 13421772
      CustomColors.BorderColors.LightHover = 11184810
      CustomColors.BorderColors.LightPress = 10066329
      CustomColors.BorderColors.LightDisabled = 8026746
      CustomColors.BorderColors.LightFocused = 11184810
      CustomColors.BorderColors.DarkColor = 3355443
      CustomColors.BorderColors.DarkHover = 11184810
      CustomColors.BorderColors.DarkPress = 6710886
      CustomColors.BorderColors.DarkDisabled = 8750469
      CustomColors.BorderColors.DarkFocused = 11184810
      CustomColors.TextColors.Enabled = False
      CustomColors.TextColors.LightColor = clBlack
      CustomColors.TextColors.LightHover = clBlack
      CustomColors.TextColors.LightPress = clBlack
      CustomColors.TextColors.LightDisabled = clGray
      CustomColors.TextColors.LightFocused = clBlack
      CustomColors.TextColors.DarkColor = clWhite
      CustomColors.TextColors.DarkHover = clWhite
      CustomColors.TextColors.DarkPress = clWhite
      CustomColors.TextColors.DarkDisabled = clGray
      CustomColors.TextColors.DarkFocused = clWhite
      CustomColors.DetailColors.Enabled = False
      CustomColors.DetailColors.LightColor = clGray
      CustomColors.DetailColors.LightHover = clSilver
      CustomColors.DetailColors.LightPress = clSilver
      CustomColors.DetailColors.LightDisabled = clSilver
      CustomColors.DetailColors.LightFocused = clSilver
      CustomColors.DetailColors.DarkColor = 3355443
      CustomColors.DetailColors.DarkHover = 3355443
      CustomColors.DetailColors.DarkPress = 6710886
      CustomColors.DetailColors.DarkDisabled = 3355443
      CustomColors.DetailColors.DarkFocused = 3355443
      CustomColors.ActiveColors.Enabled = False
      CustomColors.ActiveColors.LightColor = 13421772
      CustomColors.ActiveColors.LightHover = 13421772
      CustomColors.ActiveColors.LightPress = 10066329
      CustomColors.ActiveColors.LightDisabled = 13421772
      CustomColors.ActiveColors.LightFocused = 13421772
      CustomColors.ActiveColors.DarkColor = 3355443
      CustomColors.ActiveColors.DarkHover = 3355443
      CustomColors.ActiveColors.DarkPress = 6710886
      CustomColors.ActiveColors.DarkDisabled = 3355443
      CustomColors.ActiveColors.DarkFocused = 3355443
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -11
      DetailFont.Name = 'Tahoma'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #57347
      Text = 'Text'
      Detail = 'Detail'
      RightIcon = #59198
      Caption = 'UItemButton1'
    end
    object UItemButton7: TUItemButton
      Left = 0
      Top = 520
      Width = 301
      ThemeManager = UThemeManager1
      Align = alTop
      DragCursor = crDefault
      TabOrder = 7
      CustomColors.BackColors.Enabled = False
      CustomColors.BackColors.LightColor = 13421772
      CustomColors.BackColors.LightHover = 13421772
      CustomColors.BackColors.LightPress = 10066329
      CustomColors.BackColors.LightDisabled = 13421772
      CustomColors.BackColors.LightFocused = 13421772
      CustomColors.BackColors.DarkColor = 3355443
      CustomColors.BackColors.DarkHover = 3355443
      CustomColors.BackColors.DarkPress = 6710886
      CustomColors.BackColors.DarkDisabled = 3355443
      CustomColors.BackColors.DarkFocused = 3355443
      CustomColors.BorderColors.Enabled = False
      CustomColors.BorderColors.LightColor = 13421772
      CustomColors.BorderColors.LightHover = 11184810
      CustomColors.BorderColors.LightPress = 10066329
      CustomColors.BorderColors.LightDisabled = 8026746
      CustomColors.BorderColors.LightFocused = 11184810
      CustomColors.BorderColors.DarkColor = 3355443
      CustomColors.BorderColors.DarkHover = 11184810
      CustomColors.BorderColors.DarkPress = 6710886
      CustomColors.BorderColors.DarkDisabled = 8750469
      CustomColors.BorderColors.DarkFocused = 11184810
      CustomColors.TextColors.Enabled = False
      CustomColors.TextColors.LightColor = clBlack
      CustomColors.TextColors.LightHover = clBlack
      CustomColors.TextColors.LightPress = clBlack
      CustomColors.TextColors.LightDisabled = clGray
      CustomColors.TextColors.LightFocused = clBlack
      CustomColors.TextColors.DarkColor = clWhite
      CustomColors.TextColors.DarkHover = clWhite
      CustomColors.TextColors.DarkPress = clWhite
      CustomColors.TextColors.DarkDisabled = clGray
      CustomColors.TextColors.DarkFocused = clWhite
      CustomColors.DetailColors.Enabled = False
      CustomColors.DetailColors.LightColor = clGray
      CustomColors.DetailColors.LightHover = clSilver
      CustomColors.DetailColors.LightPress = clSilver
      CustomColors.DetailColors.LightDisabled = clSilver
      CustomColors.DetailColors.LightFocused = clSilver
      CustomColors.DetailColors.DarkColor = 3355443
      CustomColors.DetailColors.DarkHover = 3355443
      CustomColors.DetailColors.DarkPress = 6710886
      CustomColors.DetailColors.DarkDisabled = 3355443
      CustomColors.DetailColors.DarkFocused = 3355443
      CustomColors.ActiveColors.Enabled = False
      CustomColors.ActiveColors.LightColor = 13421772
      CustomColors.ActiveColors.LightHover = 13421772
      CustomColors.ActiveColors.LightPress = 10066329
      CustomColors.ActiveColors.LightDisabled = 13421772
      CustomColors.ActiveColors.LightFocused = 13421772
      CustomColors.ActiveColors.DarkColor = 3355443
      CustomColors.ActiveColors.DarkHover = 3355443
      CustomColors.ActiveColors.DarkPress = 6710886
      CustomColors.ActiveColors.DarkDisabled = 3355443
      CustomColors.ActiveColors.DarkFocused = 3355443
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -11
      DetailFont.Name = 'Tahoma'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #57347
      Text = 'Text'
      Detail = 'Detail'
      RightIcon = #59198
      Caption = 'UItemButton1'
    end
    object UItemButton8: TUItemButton
      Left = 0
      Top = 480
      Width = 301
      ThemeManager = UThemeManager1
      Align = alTop
      DragCursor = crDefault
      TabOrder = 8
      CustomColors.BackColors.Enabled = False
      CustomColors.BackColors.LightColor = 13421772
      CustomColors.BackColors.LightHover = 13421772
      CustomColors.BackColors.LightPress = 10066329
      CustomColors.BackColors.LightDisabled = 13421772
      CustomColors.BackColors.LightFocused = 13421772
      CustomColors.BackColors.DarkColor = 3355443
      CustomColors.BackColors.DarkHover = 3355443
      CustomColors.BackColors.DarkPress = 6710886
      CustomColors.BackColors.DarkDisabled = 3355443
      CustomColors.BackColors.DarkFocused = 3355443
      CustomColors.BorderColors.Enabled = False
      CustomColors.BorderColors.LightColor = 13421772
      CustomColors.BorderColors.LightHover = 11184810
      CustomColors.BorderColors.LightPress = 10066329
      CustomColors.BorderColors.LightDisabled = 8026746
      CustomColors.BorderColors.LightFocused = 11184810
      CustomColors.BorderColors.DarkColor = 3355443
      CustomColors.BorderColors.DarkHover = 11184810
      CustomColors.BorderColors.DarkPress = 6710886
      CustomColors.BorderColors.DarkDisabled = 8750469
      CustomColors.BorderColors.DarkFocused = 11184810
      CustomColors.TextColors.Enabled = False
      CustomColors.TextColors.LightColor = clBlack
      CustomColors.TextColors.LightHover = clBlack
      CustomColors.TextColors.LightPress = clBlack
      CustomColors.TextColors.LightDisabled = clGray
      CustomColors.TextColors.LightFocused = clBlack
      CustomColors.TextColors.DarkColor = clWhite
      CustomColors.TextColors.DarkHover = clWhite
      CustomColors.TextColors.DarkPress = clWhite
      CustomColors.TextColors.DarkDisabled = clGray
      CustomColors.TextColors.DarkFocused = clWhite
      CustomColors.DetailColors.Enabled = False
      CustomColors.DetailColors.LightColor = clGray
      CustomColors.DetailColors.LightHover = clSilver
      CustomColors.DetailColors.LightPress = clSilver
      CustomColors.DetailColors.LightDisabled = clSilver
      CustomColors.DetailColors.LightFocused = clSilver
      CustomColors.DetailColors.DarkColor = 3355443
      CustomColors.DetailColors.DarkHover = 3355443
      CustomColors.DetailColors.DarkPress = 6710886
      CustomColors.DetailColors.DarkDisabled = 3355443
      CustomColors.DetailColors.DarkFocused = 3355443
      CustomColors.ActiveColors.Enabled = False
      CustomColors.ActiveColors.LightColor = 13421772
      CustomColors.ActiveColors.LightHover = 13421772
      CustomColors.ActiveColors.LightPress = 10066329
      CustomColors.ActiveColors.LightDisabled = 13421772
      CustomColors.ActiveColors.LightFocused = 13421772
      CustomColors.ActiveColors.DarkColor = 3355443
      CustomColors.ActiveColors.DarkHover = 3355443
      CustomColors.ActiveColors.DarkPress = 6710886
      CustomColors.ActiveColors.DarkDisabled = 3355443
      CustomColors.ActiveColors.DarkFocused = 3355443
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -11
      DetailFont.Name = 'Tahoma'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #57347
      Text = 'Text'
      Detail = 'Detail'
      RightIcon = #59198
      Caption = 'UItemButton1'
    end
    object UItemButton9: TUItemButton
      Left = 0
      Top = 440
      Width = 301
      ThemeManager = UThemeManager1
      Align = alTop
      DragCursor = crDefault
      TabOrder = 9
      CustomColors.BackColors.Enabled = False
      CustomColors.BackColors.LightColor = 13421772
      CustomColors.BackColors.LightHover = 13421772
      CustomColors.BackColors.LightPress = 10066329
      CustomColors.BackColors.LightDisabled = 13421772
      CustomColors.BackColors.LightFocused = 13421772
      CustomColors.BackColors.DarkColor = 3355443
      CustomColors.BackColors.DarkHover = 3355443
      CustomColors.BackColors.DarkPress = 6710886
      CustomColors.BackColors.DarkDisabled = 3355443
      CustomColors.BackColors.DarkFocused = 3355443
      CustomColors.BorderColors.Enabled = False
      CustomColors.BorderColors.LightColor = 13421772
      CustomColors.BorderColors.LightHover = 11184810
      CustomColors.BorderColors.LightPress = 10066329
      CustomColors.BorderColors.LightDisabled = 8026746
      CustomColors.BorderColors.LightFocused = 11184810
      CustomColors.BorderColors.DarkColor = 3355443
      CustomColors.BorderColors.DarkHover = 11184810
      CustomColors.BorderColors.DarkPress = 6710886
      CustomColors.BorderColors.DarkDisabled = 8750469
      CustomColors.BorderColors.DarkFocused = 11184810
      CustomColors.TextColors.Enabled = False
      CustomColors.TextColors.LightColor = clBlack
      CustomColors.TextColors.LightHover = clBlack
      CustomColors.TextColors.LightPress = clBlack
      CustomColors.TextColors.LightDisabled = clGray
      CustomColors.TextColors.LightFocused = clBlack
      CustomColors.TextColors.DarkColor = clWhite
      CustomColors.TextColors.DarkHover = clWhite
      CustomColors.TextColors.DarkPress = clWhite
      CustomColors.TextColors.DarkDisabled = clGray
      CustomColors.TextColors.DarkFocused = clWhite
      CustomColors.DetailColors.Enabled = False
      CustomColors.DetailColors.LightColor = clGray
      CustomColors.DetailColors.LightHover = clSilver
      CustomColors.DetailColors.LightPress = clSilver
      CustomColors.DetailColors.LightDisabled = clSilver
      CustomColors.DetailColors.LightFocused = clSilver
      CustomColors.DetailColors.DarkColor = 3355443
      CustomColors.DetailColors.DarkHover = 3355443
      CustomColors.DetailColors.DarkPress = 6710886
      CustomColors.DetailColors.DarkDisabled = 3355443
      CustomColors.DetailColors.DarkFocused = 3355443
      CustomColors.ActiveColors.Enabled = False
      CustomColors.ActiveColors.LightColor = 13421772
      CustomColors.ActiveColors.LightHover = 13421772
      CustomColors.ActiveColors.LightPress = 10066329
      CustomColors.ActiveColors.LightDisabled = 13421772
      CustomColors.ActiveColors.LightFocused = 13421772
      CustomColors.ActiveColors.DarkColor = 3355443
      CustomColors.ActiveColors.DarkHover = 3355443
      CustomColors.ActiveColors.DarkPress = 6710886
      CustomColors.ActiveColors.DarkDisabled = 3355443
      CustomColors.ActiveColors.DarkFocused = 3355443
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -11
      DetailFont.Name = 'Tahoma'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #57347
      Text = 'Text'
      Detail = 'Detail'
      RightIcon = #59198
      Caption = 'UItemButton1'
    end
    object UItemButton10: TUItemButton
      Left = 0
      Top = 400
      Width = 301
      ThemeManager = UThemeManager1
      Align = alTop
      DragCursor = crDefault
      TabOrder = 10
      CustomColors.BackColors.Enabled = False
      CustomColors.BackColors.LightColor = 13421772
      CustomColors.BackColors.LightHover = 13421772
      CustomColors.BackColors.LightPress = 10066329
      CustomColors.BackColors.LightDisabled = 13421772
      CustomColors.BackColors.LightFocused = 13421772
      CustomColors.BackColors.DarkColor = 3355443
      CustomColors.BackColors.DarkHover = 3355443
      CustomColors.BackColors.DarkPress = 6710886
      CustomColors.BackColors.DarkDisabled = 3355443
      CustomColors.BackColors.DarkFocused = 3355443
      CustomColors.BorderColors.Enabled = False
      CustomColors.BorderColors.LightColor = 13421772
      CustomColors.BorderColors.LightHover = 11184810
      CustomColors.BorderColors.LightPress = 10066329
      CustomColors.BorderColors.LightDisabled = 8026746
      CustomColors.BorderColors.LightFocused = 11184810
      CustomColors.BorderColors.DarkColor = 3355443
      CustomColors.BorderColors.DarkHover = 11184810
      CustomColors.BorderColors.DarkPress = 6710886
      CustomColors.BorderColors.DarkDisabled = 8750469
      CustomColors.BorderColors.DarkFocused = 11184810
      CustomColors.TextColors.Enabled = False
      CustomColors.TextColors.LightColor = clBlack
      CustomColors.TextColors.LightHover = clBlack
      CustomColors.TextColors.LightPress = clBlack
      CustomColors.TextColors.LightDisabled = clGray
      CustomColors.TextColors.LightFocused = clBlack
      CustomColors.TextColors.DarkColor = clWhite
      CustomColors.TextColors.DarkHover = clWhite
      CustomColors.TextColors.DarkPress = clWhite
      CustomColors.TextColors.DarkDisabled = clGray
      CustomColors.TextColors.DarkFocused = clWhite
      CustomColors.DetailColors.Enabled = False
      CustomColors.DetailColors.LightColor = clGray
      CustomColors.DetailColors.LightHover = clSilver
      CustomColors.DetailColors.LightPress = clSilver
      CustomColors.DetailColors.LightDisabled = clSilver
      CustomColors.DetailColors.LightFocused = clSilver
      CustomColors.DetailColors.DarkColor = 3355443
      CustomColors.DetailColors.DarkHover = 3355443
      CustomColors.DetailColors.DarkPress = 6710886
      CustomColors.DetailColors.DarkDisabled = 3355443
      CustomColors.DetailColors.DarkFocused = 3355443
      CustomColors.ActiveColors.Enabled = False
      CustomColors.ActiveColors.LightColor = 13421772
      CustomColors.ActiveColors.LightHover = 13421772
      CustomColors.ActiveColors.LightPress = 10066329
      CustomColors.ActiveColors.LightDisabled = 13421772
      CustomColors.ActiveColors.LightFocused = 13421772
      CustomColors.ActiveColors.DarkColor = 3355443
      CustomColors.ActiveColors.DarkHover = 3355443
      CustomColors.ActiveColors.DarkPress = 6710886
      CustomColors.ActiveColors.DarkDisabled = 3355443
      CustomColors.ActiveColors.DarkFocused = 3355443
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -11
      DetailFont.Name = 'Tahoma'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #57347
      Text = 'Text'
      Detail = 'Detail'
      RightIcon = #59198
      Caption = 'UItemButton1'
    end
    object UItemButton11: TUItemButton
      Left = 0
      Top = 360
      Width = 301
      ThemeManager = UThemeManager1
      Align = alTop
      DragCursor = crDefault
      TabOrder = 11
      CustomColors.BackColors.Enabled = False
      CustomColors.BackColors.LightColor = 13421772
      CustomColors.BackColors.LightHover = 13421772
      CustomColors.BackColors.LightPress = 10066329
      CustomColors.BackColors.LightDisabled = 13421772
      CustomColors.BackColors.LightFocused = 13421772
      CustomColors.BackColors.DarkColor = 3355443
      CustomColors.BackColors.DarkHover = 3355443
      CustomColors.BackColors.DarkPress = 6710886
      CustomColors.BackColors.DarkDisabled = 3355443
      CustomColors.BackColors.DarkFocused = 3355443
      CustomColors.BorderColors.Enabled = False
      CustomColors.BorderColors.LightColor = 13421772
      CustomColors.BorderColors.LightHover = 11184810
      CustomColors.BorderColors.LightPress = 10066329
      CustomColors.BorderColors.LightDisabled = 8026746
      CustomColors.BorderColors.LightFocused = 11184810
      CustomColors.BorderColors.DarkColor = 3355443
      CustomColors.BorderColors.DarkHover = 11184810
      CustomColors.BorderColors.DarkPress = 6710886
      CustomColors.BorderColors.DarkDisabled = 8750469
      CustomColors.BorderColors.DarkFocused = 11184810
      CustomColors.TextColors.Enabled = False
      CustomColors.TextColors.LightColor = clBlack
      CustomColors.TextColors.LightHover = clBlack
      CustomColors.TextColors.LightPress = clBlack
      CustomColors.TextColors.LightDisabled = clGray
      CustomColors.TextColors.LightFocused = clBlack
      CustomColors.TextColors.DarkColor = clWhite
      CustomColors.TextColors.DarkHover = clWhite
      CustomColors.TextColors.DarkPress = clWhite
      CustomColors.TextColors.DarkDisabled = clGray
      CustomColors.TextColors.DarkFocused = clWhite
      CustomColors.DetailColors.Enabled = False
      CustomColors.DetailColors.LightColor = clGray
      CustomColors.DetailColors.LightHover = clSilver
      CustomColors.DetailColors.LightPress = clSilver
      CustomColors.DetailColors.LightDisabled = clSilver
      CustomColors.DetailColors.LightFocused = clSilver
      CustomColors.DetailColors.DarkColor = 3355443
      CustomColors.DetailColors.DarkHover = 3355443
      CustomColors.DetailColors.DarkPress = 6710886
      CustomColors.DetailColors.DarkDisabled = 3355443
      CustomColors.DetailColors.DarkFocused = 3355443
      CustomColors.ActiveColors.Enabled = False
      CustomColors.ActiveColors.LightColor = 13421772
      CustomColors.ActiveColors.LightHover = 13421772
      CustomColors.ActiveColors.LightPress = 10066329
      CustomColors.ActiveColors.LightDisabled = 13421772
      CustomColors.ActiveColors.LightFocused = 13421772
      CustomColors.ActiveColors.DarkColor = 3355443
      CustomColors.ActiveColors.DarkHover = 3355443
      CustomColors.ActiveColors.DarkPress = 6710886
      CustomColors.ActiveColors.DarkDisabled = 3355443
      CustomColors.ActiveColors.DarkFocused = 3355443
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -11
      DetailFont.Name = 'Tahoma'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #57347
      Text = 'Text'
      Detail = 'Detail'
      RightIcon = #59198
      Caption = 'UItemButton1'
    end
    object UItemButton12: TUItemButton
      Left = 0
      Top = 320
      Width = 301
      ThemeManager = UThemeManager1
      Align = alTop
      DragCursor = crDefault
      TabOrder = 12
      CustomColors.BackColors.Enabled = False
      CustomColors.BackColors.LightColor = 13421772
      CustomColors.BackColors.LightHover = 13421772
      CustomColors.BackColors.LightPress = 10066329
      CustomColors.BackColors.LightDisabled = 13421772
      CustomColors.BackColors.LightFocused = 13421772
      CustomColors.BackColors.DarkColor = 3355443
      CustomColors.BackColors.DarkHover = 3355443
      CustomColors.BackColors.DarkPress = 6710886
      CustomColors.BackColors.DarkDisabled = 3355443
      CustomColors.BackColors.DarkFocused = 3355443
      CustomColors.BorderColors.Enabled = False
      CustomColors.BorderColors.LightColor = 13421772
      CustomColors.BorderColors.LightHover = 11184810
      CustomColors.BorderColors.LightPress = 10066329
      CustomColors.BorderColors.LightDisabled = 8026746
      CustomColors.BorderColors.LightFocused = 11184810
      CustomColors.BorderColors.DarkColor = 3355443
      CustomColors.BorderColors.DarkHover = 11184810
      CustomColors.BorderColors.DarkPress = 6710886
      CustomColors.BorderColors.DarkDisabled = 8750469
      CustomColors.BorderColors.DarkFocused = 11184810
      CustomColors.TextColors.Enabled = False
      CustomColors.TextColors.LightColor = clBlack
      CustomColors.TextColors.LightHover = clBlack
      CustomColors.TextColors.LightPress = clBlack
      CustomColors.TextColors.LightDisabled = clGray
      CustomColors.TextColors.LightFocused = clBlack
      CustomColors.TextColors.DarkColor = clWhite
      CustomColors.TextColors.DarkHover = clWhite
      CustomColors.TextColors.DarkPress = clWhite
      CustomColors.TextColors.DarkDisabled = clGray
      CustomColors.TextColors.DarkFocused = clWhite
      CustomColors.DetailColors.Enabled = False
      CustomColors.DetailColors.LightColor = clGray
      CustomColors.DetailColors.LightHover = clSilver
      CustomColors.DetailColors.LightPress = clSilver
      CustomColors.DetailColors.LightDisabled = clSilver
      CustomColors.DetailColors.LightFocused = clSilver
      CustomColors.DetailColors.DarkColor = 3355443
      CustomColors.DetailColors.DarkHover = 3355443
      CustomColors.DetailColors.DarkPress = 6710886
      CustomColors.DetailColors.DarkDisabled = 3355443
      CustomColors.DetailColors.DarkFocused = 3355443
      CustomColors.ActiveColors.Enabled = False
      CustomColors.ActiveColors.LightColor = 13421772
      CustomColors.ActiveColors.LightHover = 13421772
      CustomColors.ActiveColors.LightPress = 10066329
      CustomColors.ActiveColors.LightDisabled = 13421772
      CustomColors.ActiveColors.LightFocused = 13421772
      CustomColors.ActiveColors.DarkColor = 3355443
      CustomColors.ActiveColors.DarkHover = 3355443
      CustomColors.ActiveColors.DarkPress = 6710886
      CustomColors.ActiveColors.DarkDisabled = 3355443
      CustomColors.ActiveColors.DarkFocused = 3355443
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -11
      DetailFont.Name = 'Tahoma'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #57347
      Text = 'Text'
      Detail = 'Detail'
      RightIcon = #59198
      Caption = 'UItemButton1'
    end
    object UItemButton13: TUItemButton
      Left = 0
      Top = 280
      Width = 301
      ThemeManager = UThemeManager1
      Align = alTop
      DragCursor = crDefault
      TabOrder = 13
      CustomColors.BackColors.Enabled = False
      CustomColors.BackColors.LightColor = 13421772
      CustomColors.BackColors.LightHover = 13421772
      CustomColors.BackColors.LightPress = 10066329
      CustomColors.BackColors.LightDisabled = 13421772
      CustomColors.BackColors.LightFocused = 13421772
      CustomColors.BackColors.DarkColor = 3355443
      CustomColors.BackColors.DarkHover = 3355443
      CustomColors.BackColors.DarkPress = 6710886
      CustomColors.BackColors.DarkDisabled = 3355443
      CustomColors.BackColors.DarkFocused = 3355443
      CustomColors.BorderColors.Enabled = False
      CustomColors.BorderColors.LightColor = 13421772
      CustomColors.BorderColors.LightHover = 11184810
      CustomColors.BorderColors.LightPress = 10066329
      CustomColors.BorderColors.LightDisabled = 8026746
      CustomColors.BorderColors.LightFocused = 11184810
      CustomColors.BorderColors.DarkColor = 3355443
      CustomColors.BorderColors.DarkHover = 11184810
      CustomColors.BorderColors.DarkPress = 6710886
      CustomColors.BorderColors.DarkDisabled = 8750469
      CustomColors.BorderColors.DarkFocused = 11184810
      CustomColors.TextColors.Enabled = False
      CustomColors.TextColors.LightColor = clBlack
      CustomColors.TextColors.LightHover = clBlack
      CustomColors.TextColors.LightPress = clBlack
      CustomColors.TextColors.LightDisabled = clGray
      CustomColors.TextColors.LightFocused = clBlack
      CustomColors.TextColors.DarkColor = clWhite
      CustomColors.TextColors.DarkHover = clWhite
      CustomColors.TextColors.DarkPress = clWhite
      CustomColors.TextColors.DarkDisabled = clGray
      CustomColors.TextColors.DarkFocused = clWhite
      CustomColors.DetailColors.Enabled = False
      CustomColors.DetailColors.LightColor = clGray
      CustomColors.DetailColors.LightHover = clSilver
      CustomColors.DetailColors.LightPress = clSilver
      CustomColors.DetailColors.LightDisabled = clSilver
      CustomColors.DetailColors.LightFocused = clSilver
      CustomColors.DetailColors.DarkColor = 3355443
      CustomColors.DetailColors.DarkHover = 3355443
      CustomColors.DetailColors.DarkPress = 6710886
      CustomColors.DetailColors.DarkDisabled = 3355443
      CustomColors.DetailColors.DarkFocused = 3355443
      CustomColors.ActiveColors.Enabled = False
      CustomColors.ActiveColors.LightColor = 13421772
      CustomColors.ActiveColors.LightHover = 13421772
      CustomColors.ActiveColors.LightPress = 10066329
      CustomColors.ActiveColors.LightDisabled = 13421772
      CustomColors.ActiveColors.LightFocused = 13421772
      CustomColors.ActiveColors.DarkColor = 3355443
      CustomColors.ActiveColors.DarkHover = 3355443
      CustomColors.ActiveColors.DarkPress = 6710886
      CustomColors.ActiveColors.DarkDisabled = 3355443
      CustomColors.ActiveColors.DarkFocused = 3355443
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -11
      DetailFont.Name = 'Tahoma'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #57347
      Text = 'Text'
      Detail = 'Detail'
      RightIcon = #59198
      Caption = 'UItemButton1'
    end
    object UItemButton14: TUItemButton
      Left = 0
      Top = 240
      Width = 301
      ThemeManager = UThemeManager1
      Align = alTop
      DragCursor = crDefault
      TabOrder = 14
      CustomColors.BackColors.Enabled = False
      CustomColors.BackColors.LightColor = 13421772
      CustomColors.BackColors.LightHover = 13421772
      CustomColors.BackColors.LightPress = 10066329
      CustomColors.BackColors.LightDisabled = 13421772
      CustomColors.BackColors.LightFocused = 13421772
      CustomColors.BackColors.DarkColor = 3355443
      CustomColors.BackColors.DarkHover = 3355443
      CustomColors.BackColors.DarkPress = 6710886
      CustomColors.BackColors.DarkDisabled = 3355443
      CustomColors.BackColors.DarkFocused = 3355443
      CustomColors.BorderColors.Enabled = False
      CustomColors.BorderColors.LightColor = 13421772
      CustomColors.BorderColors.LightHover = 11184810
      CustomColors.BorderColors.LightPress = 10066329
      CustomColors.BorderColors.LightDisabled = 8026746
      CustomColors.BorderColors.LightFocused = 11184810
      CustomColors.BorderColors.DarkColor = 3355443
      CustomColors.BorderColors.DarkHover = 11184810
      CustomColors.BorderColors.DarkPress = 6710886
      CustomColors.BorderColors.DarkDisabled = 8750469
      CustomColors.BorderColors.DarkFocused = 11184810
      CustomColors.TextColors.Enabled = False
      CustomColors.TextColors.LightColor = clBlack
      CustomColors.TextColors.LightHover = clBlack
      CustomColors.TextColors.LightPress = clBlack
      CustomColors.TextColors.LightDisabled = clGray
      CustomColors.TextColors.LightFocused = clBlack
      CustomColors.TextColors.DarkColor = clWhite
      CustomColors.TextColors.DarkHover = clWhite
      CustomColors.TextColors.DarkPress = clWhite
      CustomColors.TextColors.DarkDisabled = clGray
      CustomColors.TextColors.DarkFocused = clWhite
      CustomColors.DetailColors.Enabled = False
      CustomColors.DetailColors.LightColor = clGray
      CustomColors.DetailColors.LightHover = clSilver
      CustomColors.DetailColors.LightPress = clSilver
      CustomColors.DetailColors.LightDisabled = clSilver
      CustomColors.DetailColors.LightFocused = clSilver
      CustomColors.DetailColors.DarkColor = 3355443
      CustomColors.DetailColors.DarkHover = 3355443
      CustomColors.DetailColors.DarkPress = 6710886
      CustomColors.DetailColors.DarkDisabled = 3355443
      CustomColors.DetailColors.DarkFocused = 3355443
      CustomColors.ActiveColors.Enabled = False
      CustomColors.ActiveColors.LightColor = 13421772
      CustomColors.ActiveColors.LightHover = 13421772
      CustomColors.ActiveColors.LightPress = 10066329
      CustomColors.ActiveColors.LightDisabled = 13421772
      CustomColors.ActiveColors.LightFocused = 13421772
      CustomColors.ActiveColors.DarkColor = 3355443
      CustomColors.ActiveColors.DarkHover = 3355443
      CustomColors.ActiveColors.DarkPress = 6710886
      CustomColors.ActiveColors.DarkDisabled = 3355443
      CustomColors.ActiveColors.DarkFocused = 3355443
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -11
      DetailFont.Name = 'Tahoma'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #57347
      Text = 'Text'
      Detail = 'Detail'
      RightIcon = #59198
      Caption = 'UItemButton1'
    end
    object UItemButton15: TUItemButton
      Left = 0
      Top = 200
      Width = 301
      ThemeManager = UThemeManager1
      Align = alTop
      DragCursor = crDefault
      TabOrder = 15
      CustomColors.BackColors.Enabled = False
      CustomColors.BackColors.LightColor = 13421772
      CustomColors.BackColors.LightHover = 13421772
      CustomColors.BackColors.LightPress = 10066329
      CustomColors.BackColors.LightDisabled = 13421772
      CustomColors.BackColors.LightFocused = 13421772
      CustomColors.BackColors.DarkColor = 3355443
      CustomColors.BackColors.DarkHover = 3355443
      CustomColors.BackColors.DarkPress = 6710886
      CustomColors.BackColors.DarkDisabled = 3355443
      CustomColors.BackColors.DarkFocused = 3355443
      CustomColors.BorderColors.Enabled = False
      CustomColors.BorderColors.LightColor = 13421772
      CustomColors.BorderColors.LightHover = 11184810
      CustomColors.BorderColors.LightPress = 10066329
      CustomColors.BorderColors.LightDisabled = 8026746
      CustomColors.BorderColors.LightFocused = 11184810
      CustomColors.BorderColors.DarkColor = 3355443
      CustomColors.BorderColors.DarkHover = 11184810
      CustomColors.BorderColors.DarkPress = 6710886
      CustomColors.BorderColors.DarkDisabled = 8750469
      CustomColors.BorderColors.DarkFocused = 11184810
      CustomColors.TextColors.Enabled = False
      CustomColors.TextColors.LightColor = clBlack
      CustomColors.TextColors.LightHover = clBlack
      CustomColors.TextColors.LightPress = clBlack
      CustomColors.TextColors.LightDisabled = clGray
      CustomColors.TextColors.LightFocused = clBlack
      CustomColors.TextColors.DarkColor = clWhite
      CustomColors.TextColors.DarkHover = clWhite
      CustomColors.TextColors.DarkPress = clWhite
      CustomColors.TextColors.DarkDisabled = clGray
      CustomColors.TextColors.DarkFocused = clWhite
      CustomColors.DetailColors.Enabled = False
      CustomColors.DetailColors.LightColor = clGray
      CustomColors.DetailColors.LightHover = clSilver
      CustomColors.DetailColors.LightPress = clSilver
      CustomColors.DetailColors.LightDisabled = clSilver
      CustomColors.DetailColors.LightFocused = clSilver
      CustomColors.DetailColors.DarkColor = 3355443
      CustomColors.DetailColors.DarkHover = 3355443
      CustomColors.DetailColors.DarkPress = 6710886
      CustomColors.DetailColors.DarkDisabled = 3355443
      CustomColors.DetailColors.DarkFocused = 3355443
      CustomColors.ActiveColors.Enabled = False
      CustomColors.ActiveColors.LightColor = 13421772
      CustomColors.ActiveColors.LightHover = 13421772
      CustomColors.ActiveColors.LightPress = 10066329
      CustomColors.ActiveColors.LightDisabled = 13421772
      CustomColors.ActiveColors.LightFocused = 13421772
      CustomColors.ActiveColors.DarkColor = 3355443
      CustomColors.ActiveColors.DarkHover = 3355443
      CustomColors.ActiveColors.DarkPress = 6710886
      CustomColors.ActiveColors.DarkDisabled = 3355443
      CustomColors.ActiveColors.DarkFocused = 3355443
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -11
      DetailFont.Name = 'Tahoma'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #57347
      Text = 'Text'
      Detail = 'Detail'
      RightIcon = #59198
      Caption = 'UItemButton1'
    end
    object UItemButton16: TUItemButton
      Left = 0
      Top = 160
      Width = 301
      ThemeManager = UThemeManager1
      Align = alTop
      DragCursor = crDefault
      TabOrder = 16
      CustomColors.BackColors.Enabled = False
      CustomColors.BackColors.LightColor = 13421772
      CustomColors.BackColors.LightHover = 13421772
      CustomColors.BackColors.LightPress = 10066329
      CustomColors.BackColors.LightDisabled = 13421772
      CustomColors.BackColors.LightFocused = 13421772
      CustomColors.BackColors.DarkColor = 3355443
      CustomColors.BackColors.DarkHover = 3355443
      CustomColors.BackColors.DarkPress = 6710886
      CustomColors.BackColors.DarkDisabled = 3355443
      CustomColors.BackColors.DarkFocused = 3355443
      CustomColors.BorderColors.Enabled = False
      CustomColors.BorderColors.LightColor = 13421772
      CustomColors.BorderColors.LightHover = 11184810
      CustomColors.BorderColors.LightPress = 10066329
      CustomColors.BorderColors.LightDisabled = 8026746
      CustomColors.BorderColors.LightFocused = 11184810
      CustomColors.BorderColors.DarkColor = 3355443
      CustomColors.BorderColors.DarkHover = 11184810
      CustomColors.BorderColors.DarkPress = 6710886
      CustomColors.BorderColors.DarkDisabled = 8750469
      CustomColors.BorderColors.DarkFocused = 11184810
      CustomColors.TextColors.Enabled = False
      CustomColors.TextColors.LightColor = clBlack
      CustomColors.TextColors.LightHover = clBlack
      CustomColors.TextColors.LightPress = clBlack
      CustomColors.TextColors.LightDisabled = clGray
      CustomColors.TextColors.LightFocused = clBlack
      CustomColors.TextColors.DarkColor = clWhite
      CustomColors.TextColors.DarkHover = clWhite
      CustomColors.TextColors.DarkPress = clWhite
      CustomColors.TextColors.DarkDisabled = clGray
      CustomColors.TextColors.DarkFocused = clWhite
      CustomColors.DetailColors.Enabled = False
      CustomColors.DetailColors.LightColor = clGray
      CustomColors.DetailColors.LightHover = clSilver
      CustomColors.DetailColors.LightPress = clSilver
      CustomColors.DetailColors.LightDisabled = clSilver
      CustomColors.DetailColors.LightFocused = clSilver
      CustomColors.DetailColors.DarkColor = 3355443
      CustomColors.DetailColors.DarkHover = 3355443
      CustomColors.DetailColors.DarkPress = 6710886
      CustomColors.DetailColors.DarkDisabled = 3355443
      CustomColors.DetailColors.DarkFocused = 3355443
      CustomColors.ActiveColors.Enabled = False
      CustomColors.ActiveColors.LightColor = 13421772
      CustomColors.ActiveColors.LightHover = 13421772
      CustomColors.ActiveColors.LightPress = 10066329
      CustomColors.ActiveColors.LightDisabled = 13421772
      CustomColors.ActiveColors.LightFocused = 13421772
      CustomColors.ActiveColors.DarkColor = 3355443
      CustomColors.ActiveColors.DarkHover = 3355443
      CustomColors.ActiveColors.DarkPress = 6710886
      CustomColors.ActiveColors.DarkDisabled = 3355443
      CustomColors.ActiveColors.DarkFocused = 3355443
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -11
      DetailFont.Name = 'Tahoma'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #57347
      Text = 'Text'
      Detail = 'Detail'
      RightIcon = #59198
      Caption = 'UItemButton1'
    end
    object UItemButton17: TUItemButton
      Left = 0
      Top = 120
      Width = 301
      ThemeManager = UThemeManager1
      Align = alTop
      DragCursor = crDefault
      TabOrder = 17
      CustomColors.BackColors.Enabled = False
      CustomColors.BackColors.LightColor = 13421772
      CustomColors.BackColors.LightHover = 13421772
      CustomColors.BackColors.LightPress = 10066329
      CustomColors.BackColors.LightDisabled = 13421772
      CustomColors.BackColors.LightFocused = 13421772
      CustomColors.BackColors.DarkColor = 3355443
      CustomColors.BackColors.DarkHover = 3355443
      CustomColors.BackColors.DarkPress = 6710886
      CustomColors.BackColors.DarkDisabled = 3355443
      CustomColors.BackColors.DarkFocused = 3355443
      CustomColors.BorderColors.Enabled = False
      CustomColors.BorderColors.LightColor = 13421772
      CustomColors.BorderColors.LightHover = 11184810
      CustomColors.BorderColors.LightPress = 10066329
      CustomColors.BorderColors.LightDisabled = 8026746
      CustomColors.BorderColors.LightFocused = 11184810
      CustomColors.BorderColors.DarkColor = 3355443
      CustomColors.BorderColors.DarkHover = 11184810
      CustomColors.BorderColors.DarkPress = 6710886
      CustomColors.BorderColors.DarkDisabled = 8750469
      CustomColors.BorderColors.DarkFocused = 11184810
      CustomColors.TextColors.Enabled = False
      CustomColors.TextColors.LightColor = clBlack
      CustomColors.TextColors.LightHover = clBlack
      CustomColors.TextColors.LightPress = clBlack
      CustomColors.TextColors.LightDisabled = clGray
      CustomColors.TextColors.LightFocused = clBlack
      CustomColors.TextColors.DarkColor = clWhite
      CustomColors.TextColors.DarkHover = clWhite
      CustomColors.TextColors.DarkPress = clWhite
      CustomColors.TextColors.DarkDisabled = clGray
      CustomColors.TextColors.DarkFocused = clWhite
      CustomColors.DetailColors.Enabled = False
      CustomColors.DetailColors.LightColor = clGray
      CustomColors.DetailColors.LightHover = clSilver
      CustomColors.DetailColors.LightPress = clSilver
      CustomColors.DetailColors.LightDisabled = clSilver
      CustomColors.DetailColors.LightFocused = clSilver
      CustomColors.DetailColors.DarkColor = 3355443
      CustomColors.DetailColors.DarkHover = 3355443
      CustomColors.DetailColors.DarkPress = 6710886
      CustomColors.DetailColors.DarkDisabled = 3355443
      CustomColors.DetailColors.DarkFocused = 3355443
      CustomColors.ActiveColors.Enabled = False
      CustomColors.ActiveColors.LightColor = 13421772
      CustomColors.ActiveColors.LightHover = 13421772
      CustomColors.ActiveColors.LightPress = 10066329
      CustomColors.ActiveColors.LightDisabled = 13421772
      CustomColors.ActiveColors.LightFocused = 13421772
      CustomColors.ActiveColors.DarkColor = 3355443
      CustomColors.ActiveColors.DarkHover = 3355443
      CustomColors.ActiveColors.DarkPress = 6710886
      CustomColors.ActiveColors.DarkDisabled = 3355443
      CustomColors.ActiveColors.DarkFocused = 3355443
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -11
      DetailFont.Name = 'Tahoma'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #57347
      Text = 'Text'
      Detail = 'Detail'
      RightIcon = #59198
      Caption = 'UItemButton1'
    end
    object UItemButton18: TUItemButton
      Left = 0
      Top = 80
      Width = 301
      ThemeManager = UThemeManager1
      Align = alTop
      DragCursor = crDefault
      TabOrder = 18
      CustomColors.BackColors.Enabled = False
      CustomColors.BackColors.LightColor = 13421772
      CustomColors.BackColors.LightHover = 13421772
      CustomColors.BackColors.LightPress = 10066329
      CustomColors.BackColors.LightDisabled = 13421772
      CustomColors.BackColors.LightFocused = 13421772
      CustomColors.BackColors.DarkColor = 3355443
      CustomColors.BackColors.DarkHover = 3355443
      CustomColors.BackColors.DarkPress = 6710886
      CustomColors.BackColors.DarkDisabled = 3355443
      CustomColors.BackColors.DarkFocused = 3355443
      CustomColors.BorderColors.Enabled = False
      CustomColors.BorderColors.LightColor = 13421772
      CustomColors.BorderColors.LightHover = 11184810
      CustomColors.BorderColors.LightPress = 10066329
      CustomColors.BorderColors.LightDisabled = 8026746
      CustomColors.BorderColors.LightFocused = 11184810
      CustomColors.BorderColors.DarkColor = 3355443
      CustomColors.BorderColors.DarkHover = 11184810
      CustomColors.BorderColors.DarkPress = 6710886
      CustomColors.BorderColors.DarkDisabled = 8750469
      CustomColors.BorderColors.DarkFocused = 11184810
      CustomColors.TextColors.Enabled = False
      CustomColors.TextColors.LightColor = clBlack
      CustomColors.TextColors.LightHover = clBlack
      CustomColors.TextColors.LightPress = clBlack
      CustomColors.TextColors.LightDisabled = clGray
      CustomColors.TextColors.LightFocused = clBlack
      CustomColors.TextColors.DarkColor = clWhite
      CustomColors.TextColors.DarkHover = clWhite
      CustomColors.TextColors.DarkPress = clWhite
      CustomColors.TextColors.DarkDisabled = clGray
      CustomColors.TextColors.DarkFocused = clWhite
      CustomColors.DetailColors.Enabled = False
      CustomColors.DetailColors.LightColor = clGray
      CustomColors.DetailColors.LightHover = clSilver
      CustomColors.DetailColors.LightPress = clSilver
      CustomColors.DetailColors.LightDisabled = clSilver
      CustomColors.DetailColors.LightFocused = clSilver
      CustomColors.DetailColors.DarkColor = 3355443
      CustomColors.DetailColors.DarkHover = 3355443
      CustomColors.DetailColors.DarkPress = 6710886
      CustomColors.DetailColors.DarkDisabled = 3355443
      CustomColors.DetailColors.DarkFocused = 3355443
      CustomColors.ActiveColors.Enabled = False
      CustomColors.ActiveColors.LightColor = 13421772
      CustomColors.ActiveColors.LightHover = 13421772
      CustomColors.ActiveColors.LightPress = 10066329
      CustomColors.ActiveColors.LightDisabled = 13421772
      CustomColors.ActiveColors.LightFocused = 13421772
      CustomColors.ActiveColors.DarkColor = 3355443
      CustomColors.ActiveColors.DarkHover = 3355443
      CustomColors.ActiveColors.DarkPress = 6710886
      CustomColors.ActiveColors.DarkDisabled = 3355443
      CustomColors.ActiveColors.DarkFocused = 3355443
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -11
      DetailFont.Name = 'Tahoma'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #57347
      Text = 'Text'
      Detail = 'Detail'
      RightIcon = #59198
      Caption = 'UItemButton1'
    end
    object UItemButton19: TUItemButton
      Left = 0
      Top = 40
      Width = 301
      ThemeManager = UThemeManager1
      Align = alTop
      DragCursor = crDefault
      TabOrder = 19
      CustomColors.BackColors.Enabled = False
      CustomColors.BackColors.LightColor = 13421772
      CustomColors.BackColors.LightHover = 13421772
      CustomColors.BackColors.LightPress = 10066329
      CustomColors.BackColors.LightDisabled = 13421772
      CustomColors.BackColors.LightFocused = 13421772
      CustomColors.BackColors.DarkColor = 3355443
      CustomColors.BackColors.DarkHover = 3355443
      CustomColors.BackColors.DarkPress = 6710886
      CustomColors.BackColors.DarkDisabled = 3355443
      CustomColors.BackColors.DarkFocused = 3355443
      CustomColors.BorderColors.Enabled = False
      CustomColors.BorderColors.LightColor = 13421772
      CustomColors.BorderColors.LightHover = 11184810
      CustomColors.BorderColors.LightPress = 10066329
      CustomColors.BorderColors.LightDisabled = 8026746
      CustomColors.BorderColors.LightFocused = 11184810
      CustomColors.BorderColors.DarkColor = 3355443
      CustomColors.BorderColors.DarkHover = 11184810
      CustomColors.BorderColors.DarkPress = 6710886
      CustomColors.BorderColors.DarkDisabled = 8750469
      CustomColors.BorderColors.DarkFocused = 11184810
      CustomColors.TextColors.Enabled = False
      CustomColors.TextColors.LightColor = clBlack
      CustomColors.TextColors.LightHover = clBlack
      CustomColors.TextColors.LightPress = clBlack
      CustomColors.TextColors.LightDisabled = clGray
      CustomColors.TextColors.LightFocused = clBlack
      CustomColors.TextColors.DarkColor = clWhite
      CustomColors.TextColors.DarkHover = clWhite
      CustomColors.TextColors.DarkPress = clWhite
      CustomColors.TextColors.DarkDisabled = clGray
      CustomColors.TextColors.DarkFocused = clWhite
      CustomColors.DetailColors.Enabled = False
      CustomColors.DetailColors.LightColor = clGray
      CustomColors.DetailColors.LightHover = clSilver
      CustomColors.DetailColors.LightPress = clSilver
      CustomColors.DetailColors.LightDisabled = clSilver
      CustomColors.DetailColors.LightFocused = clSilver
      CustomColors.DetailColors.DarkColor = 3355443
      CustomColors.DetailColors.DarkHover = 3355443
      CustomColors.DetailColors.DarkPress = 6710886
      CustomColors.DetailColors.DarkDisabled = 3355443
      CustomColors.DetailColors.DarkFocused = 3355443
      CustomColors.ActiveColors.Enabled = False
      CustomColors.ActiveColors.LightColor = 13421772
      CustomColors.ActiveColors.LightHover = 13421772
      CustomColors.ActiveColors.LightPress = 10066329
      CustomColors.ActiveColors.LightDisabled = 13421772
      CustomColors.ActiveColors.LightFocused = 13421772
      CustomColors.ActiveColors.DarkColor = 3355443
      CustomColors.ActiveColors.DarkHover = 3355443
      CustomColors.ActiveColors.DarkPress = 6710886
      CustomColors.ActiveColors.DarkDisabled = 3355443
      CustomColors.ActiveColors.DarkFocused = 3355443
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -11
      DetailFont.Name = 'Tahoma'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #57347
      Text = 'Text'
      Detail = 'Detail'
      RightIcon = #59198
      Caption = 'UItemButton1'
    end
    object UItemButton20: TUItemButton
      Left = 0
      Top = 0
      Width = 301
      ThemeManager = UThemeManager1
      Align = alTop
      DragCursor = crDefault
      TabOrder = 20
      CustomColors.BackColors.Enabled = False
      CustomColors.BackColors.LightColor = 13421772
      CustomColors.BackColors.LightHover = 13421772
      CustomColors.BackColors.LightPress = 10066329
      CustomColors.BackColors.LightDisabled = 13421772
      CustomColors.BackColors.LightFocused = 13421772
      CustomColors.BackColors.DarkColor = 3355443
      CustomColors.BackColors.DarkHover = 3355443
      CustomColors.BackColors.DarkPress = 6710886
      CustomColors.BackColors.DarkDisabled = 3355443
      CustomColors.BackColors.DarkFocused = 3355443
      CustomColors.BorderColors.Enabled = False
      CustomColors.BorderColors.LightColor = 13421772
      CustomColors.BorderColors.LightHover = 11184810
      CustomColors.BorderColors.LightPress = 10066329
      CustomColors.BorderColors.LightDisabled = 8026746
      CustomColors.BorderColors.LightFocused = 11184810
      CustomColors.BorderColors.DarkColor = 3355443
      CustomColors.BorderColors.DarkHover = 11184810
      CustomColors.BorderColors.DarkPress = 6710886
      CustomColors.BorderColors.DarkDisabled = 8750469
      CustomColors.BorderColors.DarkFocused = 11184810
      CustomColors.TextColors.Enabled = False
      CustomColors.TextColors.LightColor = clBlack
      CustomColors.TextColors.LightHover = clBlack
      CustomColors.TextColors.LightPress = clBlack
      CustomColors.TextColors.LightDisabled = clGray
      CustomColors.TextColors.LightFocused = clBlack
      CustomColors.TextColors.DarkColor = clWhite
      CustomColors.TextColors.DarkHover = clWhite
      CustomColors.TextColors.DarkPress = clWhite
      CustomColors.TextColors.DarkDisabled = clGray
      CustomColors.TextColors.DarkFocused = clWhite
      CustomColors.DetailColors.Enabled = False
      CustomColors.DetailColors.LightColor = clGray
      CustomColors.DetailColors.LightHover = clSilver
      CustomColors.DetailColors.LightPress = clSilver
      CustomColors.DetailColors.LightDisabled = clSilver
      CustomColors.DetailColors.LightFocused = clSilver
      CustomColors.DetailColors.DarkColor = 3355443
      CustomColors.DetailColors.DarkHover = 3355443
      CustomColors.DetailColors.DarkPress = 6710886
      CustomColors.DetailColors.DarkDisabled = 3355443
      CustomColors.DetailColors.DarkFocused = 3355443
      CustomColors.ActiveColors.Enabled = False
      CustomColors.ActiveColors.LightColor = 13421772
      CustomColors.ActiveColors.LightHover = 13421772
      CustomColors.ActiveColors.LightPress = 10066329
      CustomColors.ActiveColors.LightDisabled = 13421772
      CustomColors.ActiveColors.LightFocused = 13421772
      CustomColors.ActiveColors.DarkColor = 3355443
      CustomColors.ActiveColors.DarkHover = 3355443
      CustomColors.ActiveColors.DarkPress = 6710886
      CustomColors.ActiveColors.DarkDisabled = 3355443
      CustomColors.ActiveColors.DarkFocused = 3355443
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -11
      DetailFont.Name = 'Tahoma'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #57347
      Text = 'Text'
      Detail = 'Detail'
      RightIcon = #59198
      Caption = 'UItemButton1'
    end
  end
  object UThemeManager1: TUThemeManager
    AccentColor = 6318152
    Colors.ButtonColors.BackColors.Enabled = False
    Colors.ButtonColors.BackColors.LightColor = clBlack
    Colors.ButtonColors.BackColors.LightHover = clBlack
    Colors.ButtonColors.BackColors.LightPress = clBlack
    Colors.ButtonColors.BackColors.LightDisabled = clBlack
    Colors.ButtonColors.BackColors.LightFocused = clBlack
    Colors.ButtonColors.BackColors.DarkColor = clBlack
    Colors.ButtonColors.BackColors.DarkHover = clBlack
    Colors.ButtonColors.BackColors.DarkPress = clBlack
    Colors.ButtonColors.BackColors.DarkDisabled = clBlack
    Colors.ButtonColors.BackColors.DarkFocused = clBlack
    Colors.ButtonColors.BorderColors.Enabled = False
    Colors.ButtonColors.BorderColors.LightColor = clBlack
    Colors.ButtonColors.BorderColors.LightHover = clBlack
    Colors.ButtonColors.BorderColors.LightPress = clBlack
    Colors.ButtonColors.BorderColors.LightDisabled = clBlack
    Colors.ButtonColors.BorderColors.LightFocused = clBlack
    Colors.ButtonColors.BorderColors.DarkColor = clBlack
    Colors.ButtonColors.BorderColors.DarkHover = clBlack
    Colors.ButtonColors.BorderColors.DarkPress = clBlack
    Colors.ButtonColors.BorderColors.DarkDisabled = clBlack
    Colors.ButtonColors.BorderColors.DarkFocused = clBlack
    Colors.ButtonColors.TextColors.Enabled = False
    Colors.ButtonColors.TextColors.LightColor = clBlack
    Colors.ButtonColors.TextColors.LightHover = clBlack
    Colors.ButtonColors.TextColors.LightPress = clBlack
    Colors.ButtonColors.TextColors.LightDisabled = clGray
    Colors.ButtonColors.TextColors.LightFocused = clBlack
    Colors.ButtonColors.TextColors.DarkColor = clWhite
    Colors.ButtonColors.TextColors.DarkHover = clWhite
    Colors.ButtonColors.TextColors.DarkPress = clWhite
    Colors.ButtonColors.TextColors.DarkDisabled = clGray
    Colors.ButtonColors.TextColors.DarkFocused = clWhite
    Colors.ItemButtonColors.BackColors.Enabled = False
    Colors.ItemButtonColors.BackColors.LightColor = clBlack
    Colors.ItemButtonColors.BackColors.LightHover = clBlack
    Colors.ItemButtonColors.BackColors.LightPress = clBlack
    Colors.ItemButtonColors.BackColors.LightDisabled = clBlack
    Colors.ItemButtonColors.BackColors.LightFocused = clBlack
    Colors.ItemButtonColors.BackColors.DarkColor = clBlack
    Colors.ItemButtonColors.BackColors.DarkHover = clBlack
    Colors.ItemButtonColors.BackColors.DarkPress = clBlack
    Colors.ItemButtonColors.BackColors.DarkDisabled = clBlack
    Colors.ItemButtonColors.BackColors.DarkFocused = clBlack
    Colors.ItemButtonColors.BorderColors.Enabled = False
    Colors.ItemButtonColors.BorderColors.LightColor = clBlack
    Colors.ItemButtonColors.BorderColors.LightHover = clBlack
    Colors.ItemButtonColors.BorderColors.LightPress = clBlack
    Colors.ItemButtonColors.BorderColors.LightDisabled = clBlack
    Colors.ItemButtonColors.BorderColors.LightFocused = clBlack
    Colors.ItemButtonColors.BorderColors.DarkColor = clBlack
    Colors.ItemButtonColors.BorderColors.DarkHover = clBlack
    Colors.ItemButtonColors.BorderColors.DarkPress = clBlack
    Colors.ItemButtonColors.BorderColors.DarkDisabled = clBlack
    Colors.ItemButtonColors.BorderColors.DarkFocused = clBlack
    Colors.ItemButtonColors.TextColors.Enabled = False
    Colors.ItemButtonColors.TextColors.LightColor = clBlack
    Colors.ItemButtonColors.TextColors.LightHover = clBlack
    Colors.ItemButtonColors.TextColors.LightPress = clBlack
    Colors.ItemButtonColors.TextColors.LightDisabled = clGray
    Colors.ItemButtonColors.TextColors.LightFocused = clBlack
    Colors.ItemButtonColors.TextColors.DarkColor = clWhite
    Colors.ItemButtonColors.TextColors.DarkHover = clWhite
    Colors.ItemButtonColors.TextColors.DarkPress = clWhite
    Colors.ItemButtonColors.TextColors.DarkDisabled = clGray
    Colors.ItemButtonColors.TextColors.DarkFocused = clWhite
    Colors.ItemButtonColors.DetailColors.Enabled = False
    Colors.ItemButtonColors.DetailColors.LightColor = clBlack
    Colors.ItemButtonColors.DetailColors.LightHover = clBlack
    Colors.ItemButtonColors.DetailColors.LightPress = clBlack
    Colors.ItemButtonColors.DetailColors.LightDisabled = clBlack
    Colors.ItemButtonColors.DetailColors.LightFocused = clBlack
    Colors.ItemButtonColors.DetailColors.DarkColor = clBlack
    Colors.ItemButtonColors.DetailColors.DarkHover = clBlack
    Colors.ItemButtonColors.DetailColors.DarkPress = clBlack
    Colors.ItemButtonColors.DetailColors.DarkDisabled = clBlack
    Colors.ItemButtonColors.DetailColors.DarkFocused = clBlack
    Colors.ItemButtonColors.ActiveColors.Enabled = False
    Colors.ItemButtonColors.ActiveColors.LightColor = clBlack
    Colors.ItemButtonColors.ActiveColors.LightHover = clBlack
    Colors.ItemButtonColors.ActiveColors.LightPress = clBlack
    Colors.ItemButtonColors.ActiveColors.LightDisabled = clBlack
    Colors.ItemButtonColors.ActiveColors.LightFocused = clBlack
    Colors.ItemButtonColors.ActiveColors.DarkColor = clBlack
    Colors.ItemButtonColors.ActiveColors.DarkHover = clBlack
    Colors.ItemButtonColors.ActiveColors.DarkPress = clBlack
    Colors.ItemButtonColors.ActiveColors.DarkDisabled = clBlack
    Colors.ItemButtonColors.ActiveColors.DarkFocused = clBlack
    Left = 240
    Top = 104
  end
  object MainMenu1: TMainMenu
    Left = 96
    Top = 128
    object File1: TMenuItem
      AutoHotkeys = maManual
      Caption = 'File'
      object Open1: TMenuItem
        Caption = 'Open file'
      end
      object Close1: TMenuItem
        Caption = 'Close file'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
      end
    end
    object Edit1: TMenuItem
      AutoHotkeys = maManual
      Caption = 'Edit'
      object Cut1: TMenuItem
        Caption = 'Cut'
      end
      object Copy1: TMenuItem
        Caption = 'Copy'
      end
      object Paste1: TMenuItem
        Caption = 'Paste'
      end
      object Delete1: TMenuItem
        Caption = 'Delete'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Selectall1: TMenuItem
        Caption = 'Select all'
      end
    end
    object Search1: TMenuItem
      AutoHotkeys = maManual
      Caption = 'Search'
      object Find1: TMenuItem
        Caption = 'Find'
      end
      object Replace1: TMenuItem
        Caption = 'Replace'
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Repeataction1: TMenuItem
        Caption = 'Repeat action'
      end
    end
    object View1: TMenuItem
      AutoHotkeys = maManual
      Caption = 'View'
      object Source1: TMenuItem
        Caption = 'Source'
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Fullscreen1: TMenuItem
        Caption = 'Full screen'
      end
    end
    object Help1: TMenuItem
      AutoHotkeys = maManual
      Caption = 'Help'
      object About1: TMenuItem
        Caption = 'About'
      end
    end
  end
  object ActImgLst: TImageList
    DrawingStyle = dsTransparent
    Height = 20
    Width = 20
    Left = 456
    Top = 112
    Bitmap = {
      494C01012C003100040014001400FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000050000000F00000000100200000000000002C
      0100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009CBD
      A5007B9C840000000000000000000000000000000000000000007B9C84009CBD
      A500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B5C6C600BDCECE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009CBDAD0029D6
      6300314A39000000000000000000000000000000000000000000314A390029D6
      63009CBDAD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ADB5BD00424242005A636300BDCED6000000000000000000CEDE
      DE009CA5AD00ADBDBD0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CBCC
      CA00BCAE980074767400767B7A007A7E7B008285830081898600818986008189
      860081898600818986008999970000000000000000009CBDAD0018B5390031D6
      6300214A2100ADB5B500A5B5B500ADB5B5009CADAD00ADB5B500214A210031D6
      630018B539009CBDAD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B5C6C600A5A5A5005A6363005A636B00A5ADB5008C9C9C007373
      73003131310094A5A50000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C8AD
      A200F5AE6E008E82760094898300B5998500B5908B00CE9A9200CE9A9200CE9A
      9200CE9A9200CE9A9200CB8B7B0098A8A600ADCEBD0010A5210018B5390029CE
      630039DE6B0042EF730031EF6B0042EF730039EF730042EF730039DE6B0029CE
      630018B5390010A52100ADCEBD00000000000000000000000000000000000000
      00000000000000000000CE630000CE630000CE630000CE630000CE630000CE63
      0000CE630000CE630000CE630000CE630000CE630000CE630000CE630000CE63
      0000CE630000CE63000000000000000000000000000000000000000000000000
      00000000000000000000ADBDBD00B5B5B5005A6363003939390094949400A5A5
      A500848C8C000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000597DA6000047A70039D1
      FF00298FC00039415E00004CA7009A928B0082858300E3CAB400FFE9CD00FFE4
      CC00FFE1BC00FEDBBC00DB9B8C00909896007BAD840008A5180018BD420029CE
      630042DE730052F78C004AEF840052F78C0052F78C0052F78C0042DE730029CE
      630018BD420008A518007BAD8400000000000000000000000000000000000000
      00000000000000000000CE630000FFFFFF00FFFFFF00FFFFF700FFF7E700FFF7
      E700FFEFDE00FFEFD600FFE7CE00FFE7C600FFDEBD00FFDEB500FFD6AD00FFD6
      A500FFD6A500CE63000000000000000000000000000000000000000000000000
      00007B8C8C008C9C9C00B5C6C6008C949400E7E7E7009C9C9C006B6B7300A5AD
      B500000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006F93A8004ED2FF0038BE
      F80021A5E1000885C7000EAEE60067868D007E848800AF745000B7592000AF51
      1B00CF7E4600FEDBBC00DB9B8C009098960000000000529C5A0018BD390029CE
      630021733900319C4A00299C4200319C4A0029943900319C4A002173390029CE
      630018BD3900529C5A00000000007BAD8400ADCEBD0000000000000000000000
      00000000000000000000CE630000FFFFFF00FFFFFF00B5B5AD00B5B5AD00FFF7
      E700FFF7E700B5ADAD00B5ADAD00FFE7CE00FFE7C600B5ADA500B5ADA500FFD6
      AD00FFD6AD00CE63000000000000000000000000000000000000000000007373
      73009C8C8C00635A5A005A525200394242006B7373007B7B7B00313939009CAD
      AD00B5BDC600C6D6D60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004C779F000863A70055CAFF0047B6
      E60028A9DE001CA7DF000B96D10000449800ADA6A000E2BFA6008F1A0000A543
      0F00FFEED300FFE0C300DB9B8C0090989600000000000000000052A5520029D6
      5A003942390000000000000000000000000000000000000000003942390029D6
      5A0052A5520000000000529C5A0008A5180010A521009CBDAD00000000000000
      00000000000000000000CE630000FFFFFF00FFFFFF004A7BFF004A7BFF00FFFF
      F700FFFFF7009C3100009C310000FFEFD600FFE7CE00009CCE00009CCE00FFDE
      B500FFDEB500CE63000000000000000000000000000000000000000000009C94
      9400FFFFFF00FFEFEF00FFDEDE00EFCECE00E7C6C600CEB5B500736B6B00524A
      4A0039424200525A5A005A6B6B00A5B5B5000000000000000000000000000000
      0000000000000000000000000000BBB4B40086CEF7005BD8FF004EC0FA00ECC5
      B20047444300005B9F000093C90000A3E300E3CAB400E4BB9D0099290000AF4D
      1A00FFF1D600FFE0C300DB9B8C009098960000000000000000000000000052A5
      5A00737B73000000000000000000000000000000000000000000737B730052A5
      5A000000000052A5520018BD390018BD420018B5390018B539009CBDAD000000
      00000000000000000000CE630000FFFFFF00FFFFFF004A7BFF004A7BFF00FFFF
      F700FFFFF7009C3100009C310000FFEFDE00FFEFD600009CCE00009CCE00FFDE
      B500FFDEB500CE6300000000000000000000000000000000000000000000A59C
      9C00FFF7F700FFE7E700FFE7E700FFE7E700FFDEDE00FFE7E700FFE7E700FFE7
      E700FFD6D600D6ADAD00846B63006B737B000000000000000000000000000000
      00000000000000000000F6CFB500F0B3A4004C9555001490610046B6FF00D7C2
      B70048626A000B96D10010A0D300458BA4008F898400B5998500A7370000AF51
      1B00FFF1DA00FFE4CC00DB9B8C00909896000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000052A55A0029D65A0029CE630029CE630029CE630031D6630029D663009CBD
      A5000000000000000000CE630000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFF700FFFFF700FFF7E700FFF7E700FFEFDE00FFEFDE00FFE7C600FFE7
      C600FFE7C600CE6300000000000000000000000000000000000000000000ADA5
      A500FFF7F700FFE7E700FFE7E700FFE7E700FFDEDE00FFDEDE00FFDEDE00FFD6
      D600FFD6D600FFDEDE00C69C9C00637373000000000000000000000000000000
      000000000000000000003FF6760000A814002ACA43002ACA4300009701009569
      5E0079675200FFCFB500F1DFCE00FEEBDC00C3723200F7D3B700A7370000B555
      1800FEFBF900FFDCC200DB9B8C00909896000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000737B7300394239002173390042DE730039DE6B00214A2100314A39007B9C
      84000000000000000000CE630000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFF7E700FFF7EF00FFF7E700FFEFDE00FFE7C600FFE7
      CE00FFE7CE00CE6300000000000000000000000000000000000000000000ADA5
      A500FFF7F700FFEFEF00FFE7E700FFE7E700FFE7E700FFDEDE00FFDEDE00FFD6
      D600FFD6D600FFDEDE00BD9C9C00637373000000000000000000000000000000
      0000000000002C55240047F5790045E76C0038D557002ACA430024C336001278
      090096A44C00AA9A9500D7C2B700FEFBF900BD540000C56F3400B04A0000B555
      1800B85D2300FFE4CC00DB9B8C00909896000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000319C4A0052F78C0042EF7300ADB5B500000000000000
      00000000000000000000CE630000FFFFFF00FFFFFF00B5ADAD00B5ADAD00FFFF
      FF00FFFFFF00B5ADAD00B5ADAD00FFFFF700FFF7EF00B5ADAD00B5ADAD00FFEF
      D600FFEFD600CE6300000000000000000000000000000000000000000000ADA5
      A500FFFFFF00FFEFEF00FFEFEF00FFE7E700FFE7E700FFE7E700FFDEDE00FFDE
      DE00FFDEDE00FFDEDE00BD9C9C00637373000000000000000000000000000000
      00000000000054A8690049EB730073E78900BEC3C6004A644C00008300000097
      01007FB84A00DAC4C600C9A38900FEFBF900A9988600FEEBDC00AA9A9500FDD5
      B200F8DECC00FFEED300DB9B8C00909896000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000299C42004AEF840031EF6B00A5B5B500000000000000
      00000000000000000000CE630000FFFFFF00FFFFFF00CE9C9C00CE9C9C00FFFF
      FF00FFFFFF00E77B0800E77B0800FFFFFF00FFFFF700009C0000009C0000FFEF
      D600FFEFD600CE6300000000000000000000000000000000000000000000ADA5
      A500FFFFFF00FFEFEF00FFEFEF00FFEFEF00FFE7E700FFE7E700FFE7E700FFDE
      DE00FFDEDE00FFE7E700BD9C9C00637373000000000000000000000000000000
      0000000000008A87870034E5610091EDA600DCC6D700516755000BC123005EAE
      3400B5C3AF00DCDCDC00A9988600FAC49600A9988600F6CDA9009A928B00FFE0
      C300FFEBE300FEEBDC00DB9B8C00909896000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000319C4A0052F78C0042EF7300ADB5B500000000000000
      00000000000000000000CE630000FFFFFF00FFFFFF00CE9C9C00CE9C9C00FFFF
      FF00FFFFFF00E77B0800E77B0800FFFFFF00FFFFFF00009C0000009C0000FFF7
      E700FFF7E700CE6300000000000000000000000000000000000000000000ADA5
      A500FFFFFF00FFF7F700FFEFEF00FFEFEF00FFEFEF00FFE7E700FFE7E700FFE7
      E700FFDEDE00FFE7E700BDA5A500637373000000000000000000000000000000
      000000000000726E710027FC600082ECA200CFBFD0004A644C000BC12300AD83
      9100FFEBE300F1EEF100C3C4CA00BEC3C600C2BEC500B3B1B400C6BDB800FFF7
      E900FFEBE300FFF7E900DB9B8C00909A9C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002994390052F78C0039EF73009CADAD00000000000000
      00000000000000000000CE630000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFEF00FFF7
      E700FFF7E700CE6300000000000000000000000000000000000000000000ADAD
      AD00FFFFFF00FFF7F700FFF7F700FFEFEF00FFEFEF00FFEFEF00FFE7E700FFE7
      E700FFE7E700FFE7E700BDA5A500637373000000000000000000000000000000
      0000000000000000000080788A0065684300FFFF6F00FFDA0000FFB50000FFB5
      0000FEFBF900FEFBF900FEFBF900FEFBF900FFF7E900FFF7E900FFF7E900FFF7
      E900F3D7CB00EE93160095867900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000319C4A0052F78C0042EF7300ADB5B500000000000000
      00000000000000000000CE630000DE7B0000DE7B0000DE7B0000DE7B0000DE7B
      0000DE7B0000DE7B0000DE7B0000DE7B0000DE7B0000DE7B0000DE7B0000DE7B
      0000DE7B0000CE630000000000000000000000000000000000006B7B7B009C94
      9400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFEFEF00FFEF
      EF00FFE7E700FFEFEF00C6A5A5006B737B000000000000000000000000000000
      0000000000000000000000000000A3A5B7005E524F00350600002F0000001B00
      0000FEFBF900FEFBF900FEFBF900FEFBF900FEFBF900FEFBF900FEFBF900FEFB
      F900F9E4D3009586790000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000737B7300394239002173390042DE730039DE6B00214A2100314A39007B9C
      84000000000000000000CE6B0000CE6B0000CE6B0000CE6B0000CE6B0000CE6B
      0000CE6B0000CE6B0000CE6B0000CE6B0000CE6B0000CE6B0000CE6B0000CE6B
      0000CE6B0000CE731000000000000000000000000000949C9C005A525200635A
      5A008C6B6B00946B6B00A5737300B58C8C00C6A5A500D6ADAD00EFC6C600F7D6
      D600FFD6D600FFE7E700C6ADAD0042525200B5C6C60000000000000000000000
      0000000000000000000000000000A0A09F00929698009FA4AE00838B91003447
      4B00FFF7E900FFF7E900FFE9CD00F3D7C200EACFBB00E4C9B900E2C6B900D9C0
      B000DEB9A4000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000052A55A0029D65A0029CE630029CE630029CE630031D6630029D663009CBD
      A500000000000000000000000000D6731000D6731000D6731000D6731000D673
      1000D6731000D6731000D6731000D6731000D6731000D6731000D6731000D673
      1000D673100000000000000000000000000000000000A5ADAD00D6D6D600B5BD
      BD00C6C6C600B5B5B500A5A5A5009C9C9C0094949400949494008C8484009484
      84009C848400B59494009C848400293131005A636300C6DEDE00000000000000
      000000000000000000008F8E8F009A9C9A00CBCCCA00B3B1B400A0A09F007E81
      7E00434F4C000103010000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000052A5520018BD390018BD420018B5390018B539009CBDAD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009CADAD00ADADAD00D6D6
      D600DED6D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00FFFFFF00EFEF
      EF00E7EFEF00D6DEDE00D6D6D600C6C6C60052525200C6CED600000000000000
      000000000000000000009A9C9A00DCDCDC00CBCCCA0000000000ADB0AD009193
      9100232323000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000529C5A0008A5180010A521009CBDAD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6D6DE00ADBD
      BD00ADBDBD00849494008C9494008C949400B5B5B500B5B5B5008C8C8C00B5B5
      B500B5B5B500CECED600DEDEDE00BDBDBD00949C9C0000000000000000000000
      000000000000010301007E817E007E817E007E817E00747674007A7E7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007BAD8400ADCEBD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5ADAD007B7B8400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C7B4A00AD6B
      6300AD6B6300AD6B6300AD6B6300AD6B6300AD6B6300AD6B6300AD6B6300AD6B
      6300AD6B6300AD6B6300AD6B6300AD6B6B008C63420000000000000000000000
      000000000000000000009C7B4A00AD6B6300AD6B6300AD6B6300AD6B6300AD6B
      6300AD6B6300AD6B6300AD6B6300AD6B6300AD6B6300AD6B6300AD6B63004263
      63004263630000000000000000000000000000000000000000009C7B4A00AD6B
      6300AD6B6300AD6B6300AD6B6300AD6B6300AD6B6300AD6B6300AD6B6300AD6B
      6300AD6B6300AD6B6300AD6B6300AD6B6B008C63420000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052BD73007B5A6B00C69C
      9400F7E7C600FFF7CE00FFEFC600FFDEC600FFEFC600FFDEBD00FFE7AD00FFE7
      B500FFD6AD00FFCEAD00FFD6A500FFDEAD00AD945A0000000000000000000000
      00000000000052BD73007B5A6B00C69C9400F7E7C600FFF7CE00FFEFC600FFDE
      C600FFEFC600FFDEBD00FFE7AD00FFE7B500FFD6AD00FFCEAD00FFD6A5004221
      2100000000000000000000000000000000000000000052BD73007B5A6B00C69C
      9400F7E7C600FFF7CE00FFEFC600FFDEC600FFEFC600FFDEBD00FFE7AD00FFE7
      B500FFD6AD00FFCEAD00FFD6A500FFDEAD00AD945A0000000000000000000000
      000039F7FF0039F7FF0039F7FF0000000000DE943100DE943100DE9431000000
      0000DE943100DE943100DE94310000000000D6942900CE8C2900BD7B2100C6CE
      D60031942900319C290039AD3100000000000000000000A5B50029429C00946B
      8400DEB5AD00FFEFCE00FFDEBD00FFDEB500FFDEBD00FFDEB500FFD6A500FFCE
      A500FFD6AD00FFCE9400FFC68400FFCE9400A584520000000000000000000000
      00000000000000A5B50029429C00946B8400DEB5AD00FFEFCE00FFDEBD00FFDE
      B500FFDEBD00FFDEB500FFD6A500FFCEA500FFD6AD00FFCE9400FFC684004221
      2100422121000000000000000000000000000000000000A5B50029429C00946B
      8400DEB5AD00FFEFCE00FFDEBD00FFDEB500FFDEBD00FFDEB500FFD6A500FFCE
      A500FFD6AD00FFCE9400FFC68400FFCE9400A584520000000000000000000000
      000039F7FF0039F7FF0039F7FF0000000000DE943100DE943100DE9431000000
      0000DE943100DE943100DE94310000000000C6842900B57321009C6318009CA5
      A50021732100298C2100319C290000000000000000007352FF000073DE002942
      9400946B7B00DEB5A500FFEFD600FFDEBD00FFDEB500FFDEBD00FFD6B500FFD6
      A500FFD6AD00FFCE9400FFC68400FFCE9400A584520000000000000000000000
      0000000000007352FF000073DE0029429400946B7B00DEB5A500FFEFD600FFDE
      BD00FFDEB500FFDEBD00FFD6B500FFD6A500846B630000214200422121000000
      000000000000422121000021420042636300000000007352FF000073DE002942
      9400946B7B00DEB5A500FFEFD600FFDEBD00FFDEB500FFDEBD00FFD6B500FFD6
      A500846B63000021420042212100422121004221210042212100002142004263
      630039F7FF0039F7FF0039F7FF0000000000DE943100DE943100DE9431000000
      0000DE943100DE943100D6942900DEEFEF00B573210094631800D6ADAD004A39
      4A00A5C6AD002173210031942900000000000000000000000000299CB5000063
      EF0029429400946B7B00EFBDAD00FFEFD600FFE7C600FFE7BD00FFE7C600FFDE
      BD00FFD6AD00FFCE9400FFC68400FFCE9400A584520000000000000000000000
      00000000000000000000299CB5000063EF0029429400946B7B00EFBDAD00FFEF
      D600FFE7C600FFE7BD00FFE7C600FFDEBD00846B630042212100422121000000
      0000000000004221210042212100426363000000000000000000299CB5000063
      EF0029429400946B7B00EFBDAD00FFEFD600FFE7C600FFE7BD00FFE7C600FFDE
      BD00846B63004221210042212100422121004221210042212100422121004263
      6300000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEE7EF00C6CED600A5ADAD00C68C840021187B000031
      E7004A94C6009CA5A500C6CED6000000000000000000000000009C8C4A00529C
      DE00005AE70010318C00AD8C8400FFEFD600CE9C9400AD737300B5848C00CE9C
      9C00FFD6AD00FFD6A500FFCE9C00FFCE9C00A584630000000000000000000000
      000000000000000000009C8C4A00529CDE00005AE70010318C00AD8C8400FFEF
      D600CE9C9400AD737300B5848C00CE9C9C00FFD6AD00FFD6A500FFCE9C004221
      21004221210000000000000000000000000000000000000000009C8C4A00529C
      DE00005AE70010318C00AD8C8400FFEFD600CE9C9400AD737300B5848C00CE9C
      9C00FFD6AD00FFD6A500FFCE9C00FFCE9C00A584630000000000000000000000
      0000DE943100DE943100DE9431000000000031DEFF0031D6F70031D6EF00D6E7
      E700BD842100B57B2100A57321009CADAD00CEAD9C0018086300004AEF0000AD
      FF00ADF7FF00C6C6C600F7F7F700000000000000000000000000B5A56B00FFFF
      EF005AB5FF003994D6005A636300AD6B6B00D6A58400FFEFAD00FFFFBD00D6C6
      9C00AD636B00DEC6AD00FFD6A500FFD6AD00A584520000000000000000000000
      00000000000000000000B5A56B00FFFFEF005AB5FF003994D6005A636300AD6B
      6B00D6A58400FFEFAD00FFFFBD00D6C69C00AD636B00DEC6AD00FFD6A5004221
      2100422121000000000000000000000000000000000000000000B5A56B00FFFF
      EF005AB5FF003994D6005A636300AD6B6B00D6A58400FFEFAD00FFFFBD00D6C6
      9C00AD636B00DEC6AD00FFD6A500FFD6AD00A584520000000000000000000000
      0000DE943100DE943100D68C2900D6E7EF0029BDDE0029B5CE0021ADC600ADB5
      B500946318008C5A18007B521000D6B5AD00421842000029FF0000ADFF008CEF
      FF00BDBDBD00E7E7E700FFFFFF00000000000000000000000000ADA56B00FFFF
      EF00FFFFE700EFDECE00AD736B00FFE79C00FFFFBD00FFFFD600FFFFDE00FFFF
      FF00FFFFFF009C636B00EFCEA500FFD6B500B594630000000000000000000000
      00000000000000000000ADA56B00FFFFEF00FFFFE700EFDECE00AD736B00FFE7
      9C00FFFFBD00FFFFD600FFFFDE00FFFFFF00FFFFFF009C636B00EFCEA500846B
      6300846B63000000000000000000000000000000000000000000ADA56B00FFFF
      EF00FFFFE700EFDECE00AD736B00FFE79C00FFFFBD00FFFFD600FFFFDE00FFFF
      FF00FFFFFF009C636B00EFCEA500FFD6B500B594630000000000000000000000
      0000DE943100D68C2900C6842900BDC6CE00219CAD001884940018738400737B
      7B00634210005A390800BD948C00180863000029F70000DEFF00B5FFFF009CAD
      AD00E7E7E700FFFFFF00FFFFFF00000000000000000000000000B5AD7B00FFFF
      F700FFFFEF00C69C9C00EFC68400FFF7B500F7E7AD00FFFFCE00FFF7E700FFFF
      FF00FFFFFF00DED6BD00B57B7300FFE7B500AD946B0000000000000000000000
      00000000000000000000B5AD7B00FFFFF700FFFFEF00C69C9C00EFC68400FFF7
      B500F7E7AD00FFFFCE00FFF7E700FFFFFF00FFFFFF00DED6BD00B57B7300FFE7
      B500AD946B000000000000000000000000000000000000000000B5AD7B00FFFF
      F700FFFFEF00C69C9C00EFC68400FFF7B500F7E7AD00FFFFCE00FFF7E700FFFF
      FF00FFFFFF00DED6BD00B57B7300FFE7B500AD946B0000000000000000000000
      0000EFFFFF00DEEFF700C6CED600DEE7EF00E7C6BD00E7B59C00DEB5A500C694
      7B00D69C8C00CEBDBD00848C9400004AC6000094FF00B5FFFF009CA5AD00BDCE
      CE00DEEFEF00EFFFFF00F7FFFF00000000000000000000000000BDB57B00FFFF
      F700FFFFFF00B58C9400FFEFAD00FFD69400F7EFB500FFFFC600FFFFDE00FFFF
      EF00FFF7E700FFFFB500A56B6B00FFE7C600AD946B0000000000000000000000
      00000000000000000000BDB57B00FFFFF700FFFFFF00B58C9400FFEFAD00FFD6
      9400F7EFB500FFFFC600FFFFDE00FFFFEF00FFF7E700FFFFB500A56B6B00FFE7
      C600AD946B000000000000000000000000000000000000000000BDB57B00FFFF
      F700FFFFFF00B58C9400FFEFAD00FFD69400F7EFB500FFFFC600FFFFDE00FFFF
      EF00FFF7E700FFFFB500A56B6B00FFE7C600AD946B0000000000000000000000
      000031E7FF0031CEE70021A5BD00CE9C9400FFCEC600FFFFBD00FFFFCE00FFF7
      BD00FFE79400C6735A0094634A004AC6F7008CD6FF007B521000A56B2100DEE7
      EF003939F7003939FF004242FF00000000000000000000000000C6BD7B00FFFF
      FF00FFFFFF00BD848400FFFFB500FFCE8C00F7E7AD00FFFFCE00FFFFC600FFFF
      D600FFFFCE00FFFFBD00A5737300FFEFCE00B5946B0000000000000000000000
      00000000000000000000C6BD7B00FFFFFF00FFFFFF00BD848400FFFFB500FFCE
      8C00F7E7AD00FFFFCE00FFFFC600FFFFD600FFFFCE00FFFFBD00A5737300FFEF
      CE00B5946B000000000000000000000000000000000000000000C6BD7B00FFFF
      FF00FFFFFF00BD848400FFFFB500FFCE8C00F7E7AD00FFFFCE00FFFFC600FFFF
      D600FFFFCE00FFFFBD00A5737300FFEFCE00B5946B0000000000000000000000
      000031DEF70029BDD600B5A5AD00F7D6D600FFFFFF00FFFFFF00FFFFEF00FFFF
      DE00FFFFD600FFFFAD00EF7B6B00D6DEE7005A3908008C5A1800B57B2100E7F7
      F7003939FF004242FF004242FF00000000000000000000000000C6BD7B00FFFF
      FF00FFFFFF00C6949400EFD6A500FFE7C600FFD68C00F7DEA500F7F7BD00F7F7
      BD00FFFFBD00EFDEA500A5737300FFEFCE00BD9C730000000000000000000000
      00000000000000000000C6BD7B00FFFFFF00FFFFFF00C6949400EFD6A500FFE7
      C600FFD68C00F7DEA500F7F7BD00F7F7BD00FFFFBD00EFDEA500A5737300FFEF
      CE00BD9C73000000000000000000000000000000000000000000C6BD7B00FFFF
      FF00FFFFFF00C6949400EFD6A500FFE7C600FFD68C00F7DEA500F7F7BD00F7F7
      BD00FFFFBD00EFDEA500A5737300FFEFCE00BD9C730000000000000000000000
      000031D6F700BDBDC600D68C6B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      E700FFFFAD00FFFFAD00FFE7A500DEB5AD006342100094631800BD842100EFFF
      FF003939FF004242FF004242FF00000000000000000000000000D6CE8400FFFF
      FF00FFFFFF00CEC6C600D69C8C00FFFFFF00F7F7E700FFDE9400FFCE9400FFDE
      9C00FFF7AD00C6846B00C6B5A500FFE7BD00BD9C630000000000000000000000
      00000000000000000000D6CE8400FFFFFF00FFFFFF00CEC6C600D69C8C00FFFF
      FF00F7F7E700FFDE9400FFCE9400FFDE9C00FFF7AD00C6846B00C6B5A500FFE7
      BD00BD9C63000000000000000000000000000000000000000000D6CE8400FFFF
      FF00FFFFFF00CEC6C600D69C8C00FFFFFF00F7F7E700FFDE9400FFCE9400FFDE
      9C00FFF7AD00C6846B00C6B5A500FFE7BD00BD9C630000000000000000000000
      0000DEE7EF00E7B5B500DEAD7B00FFFFF700FFFFFF00FFFFFF00FFFFF700FFFF
      DE00FFFFB500FFD68C00FFFFAD00DEB5A500737B8400ADB5BD00D6E7E700EFFF
      FF00F7FFFF000000000000000000000000000000000000000000D6CE8400FFFF
      FF00FFFFFF00FFFFFF00BD8C8C00C6AD9400EFDED600F7E7C600FFDE9C00EFD6
      A500C68C7300B5848400FFD6C600FFBDB500AD84630000000000000000000000
      00000000000000000000D6CE8400FFFFFF00FFFFFF00FFFFFF00BD8C8C00C6AD
      9400EFDED600F7E7C600FFDE9C00EFD6A500C68C7300B5848400FFD6C600FFBD
      B500AD8463000000000000000000000000000000000000000000D6CE8400FFFF
      FF00FFFFFF00FFFFFF00BD8C8C00C6AD9400EFDED600F7E7C600FFDE9C00EFD6
      A500C68C7300B5848400FFD6C600FFBDB500AD84630000000000000000000000
      0000FFFFFF00EFB5B500E7BD8C00FFFFE700FFFFEF00FFFFEF00FFFFE700FFFF
      CE00FFFFAD00FFEF9400FFFFAD00E7B5A500181884002929BD003131E700EFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000DECE8400FFFF
      FF00946B840000000000FFFFFF00C69CA500BD8C7B00BD948400BD948C00C694
      8C00C69C8C00F7C6B50000000000946B8400BD7B520000000000000000000000
      00000000000000000000DECE8400FFFFFF00FFFFF700FFFFFF00FFFFFF00C69C
      A500BD8C7B00BD948400BD948C00C6948C00C69C8C00F7C6B500DE848C00EF73
      8400BD7B52000000000000000000000000000000000000000000DECE8400FFFF
      FF00FFFFF700FFFFFF00FFFFFF00C69CA500BD8C7B00BD948400BD948C00C694
      8C00C69C8C00F7C6B500DE848C00EF738400BD7B520000000000000000000000
      0000FFFFFF00FFC6B500D68C4A00FFFFE700FFFFCE00FFFFCE00FFFFC600FFEF
      9C00FFEF7300FFFFC600FFFFB500F7BDA500212194003131C6003939EF00EFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000946B84000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00EFE7DE00F7E7E700FFFF
      FF009C5A5200A55A4A00000000000000000000000000946B8400000000000000
      00000000000000000000DED68C00FFFFFF00F7FFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00EFE7DE00F7E7E700FFFFFF009C5A5200A55A4A00AD6321009C52
      1800947B31000000000000000000000000000000000000000000DED68C00FFFF
      FF00F7FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFE7DE00F7E7E700FFFF
      FF009C5A5200A55A4A00AD6321009C521800947B310000000000000000000000
      0000FFFFFF00FFFFFF00CE7B6B00FFF7A500FFFFBD00FFE79400FFEF9400FFF7
      A500FFFFFF00FFFFFF00F7B5B500CEC6CE002929B5003131DE003939F700F7FF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E7DE8C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFF7F700FFFFFF00945A5200E7B57B00FFAD1800DE94
      0800CE737B000000000000000000000000000000000000000000E7DE8C00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFFF
      FF00945A5200E7B57B00FFAD1800DE940800CE737B0000000000000000000000
      0000F7FFFF00E7F7F700D6CECE00DE845200FFEF9C00FFFFC600FFFFB500FFFF
      D600FFFFFF00EFC6BD00CEB5AD00ADB5BD00CED6DE00E7EFF700EFFFFF00F7FF
      FF00000000000000000000000000000000000000000000000000946B84000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFF
      FF0094525200E7C68C00000000000000000000000000946B8400000000000000
      00000000000000000000EFE79400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFF700FFFFFF0094525200E7C68C00DEAD5A00C67B
      8400000000000000000000000000000000000000000000000000EFE79400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFF
      FF0094525200E7C68C00DEAD5A00C67B84000000000000000000000000000000
      000039EFFF0039EFFF0031DEFF00DED6DE00DE948400E7AD7300E7AD7300DE94
      5A00CE8C6B00C69CB5002929C600CEDEE700FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000EFE78C00FFFF
      FF00946B840000000000EFEFE700EFE7DE00E7DEDE00EFDEDE00DEDED600E7E7
      DE00945A5200D6A5630000000000946B84000000000000000000000000000000
      00000000000000000000EFE78C00FFFFFF00F7F7EF00F7F7EF00EFEFE700EFE7
      DE00E7DEDE00EFDEDE00DEDED600E7E7DE00945A5200D6A56300D69C6B000000
      0000000000000000000000000000000000000000000000000000EFE78C00FFFF
      FF00F7F7EF00F7F7EF00EFEFE700EFE7DE00E7DEDE00EFDEDE00DEDED600E7E7
      DE00945A5200D6A56300D69C6B00000000000000000000000000000000000000
      000039F7FF0039EFFF0039EFFF00EFF7FF00FFFFFF00FFFFFF00F7F7F700D6E7
      E7003131DE003131E7003939EF00E7F7FF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFE77B00FFAD
      7B00FFAD7B00FFAD7B00FFAD7B00FFAD7B00FFAD7B00FFAD7B00FFAD7B00FFB5
      8400BD736300FFB57B0000000000000000000000000000000000000000000000
      00000000000000000000FFE77B00FFAD7B00FFAD7B00FFAD7B00FFAD7B00FFAD
      7B00FFAD7B00FFAD7B00FFAD7B00FFB58400BD736300FFB57B00000000000000
      0000000000000000000000000000000000000000000000000000FFE77B00FFAD
      7B00FFAD7B00FFAD7B00FFAD7B00FFAD7B00FFAD7B00FFAD7B00FFAD7B00FFB5
      8400BD736300FFB57B0000000000000000000000000000000000000000000000
      000039F7FF0039F7FF0039EFFF00F7FFFF00FFFFFF00FFFFFF00FFFFFF00EFFF
      FF003939F7003939F7003939FF0000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C7B4A00AD6B
      6300AD6B6300AD6B6300AD6B6300AD6B6300AD6B6300AD6B6300AD6B6300AD6B
      6300AD6B6300AD6B6300AD6B6300AD6B6B008C63420000000000000000000000
      000000000000000000009C7B4A00AD6B6300AD6B6300AD6B6300AD6B6300AD6B
      6300AD6B6300AD6B6300AD6B6300AD6B6300AD6B6300AD6B6300AD6B6300AD6B
      6B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6D6D6006BCE84007BBD8C0073B5840073BD840073BD840073BD8C007BBD
      8C007BC6940094B59C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052BD73007B5A6B00C69C
      9400F7E7C6000000000000000000FFDEC600FFEFC6000000000000000000FFE7
      B500FFD6AD00FFCEAD000000000000000000AD945A0000000000000000000000
      00000000000052BD73007B5A6B00C69C9400F7E7C600FFF7CE00FFEFC600FFDE
      C600FFEFC600FFDEBD00FFE7AD00FFE7B500FFD6AD00FFCEAD00FFD6A500946B
      840000000000946B840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BDBDBD00087B210021E7630018DE520008C6390008BD290000B5100000AD
      000000A5000052845A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000A5B50029429C00946B
      8400DEB5AD000000000000000000FFDEB500FFDEBD000000000000000000FFCE
      A500FFD6AD00FFCE94000000000000000000A584520000000000000000000000
      00000000000000A5B50029429C00946B8400DEB5AD00FFEFCE00FFDEBD00FFDE
      B500FFDEBD00FFDEB500FFD6A500FFCEA500FFD6AD00FFCE9400FFC684000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A5736B009C635A00A5635A00A5635A00A563
      5A00A5635A00A5635A00A5635A00A5635A00A5635A00A5635A00844239000000
      0000A5ADB5005A4A5A00085A180031DE730029CE5A0021BD4A0021B5420010AD
      310008B5180052945A0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007352FF000073DE002942
      9400946B7B000000000000000000FFDEBD00FFDEB500FFDEBD00FFD6B500FFD6
      A500FFD6AD00FFCE94000000000000000000A584520000000000000000000000
      0000000000007352FF000073DE0029429400946B7B00DEB5A500FFEFD600FFDE
      BD00FFDEB500FFDEBD00FFD6B500FFD6A500FFD6AD00FFCE9400946B84000000
      00000000000000000000946B8400000000000000000000000000000000000000
      0000000000000000000000000000AD846B00DEBDB500FFCEC600FFCEC600FFCE
      C600FFCEC600FFCEC600FFCEC600FFCEC600FFCEC600FFCEBD00A56B5A000000
      000000000000B5BDC6004A2139001094290031DE7B0029C65A0018C64A0021BD
      420010BD290052945A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000299CB5000063
      EF00294294000000000000000000FFEFD600FFE7C600FFE7BD00FFE7C600FFDE
      BD00FFD6AD00FFD6A5000000000000000000A584630000000000000000000000
      00000000000000000000299CB5000063EF0029429400946B7B00EFBDAD00FFEF
      D600FFE7C600FFE7BD00FFE7C600FFDEBD00FFD6AD00FFCE9400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A56B5A00E7C6B500FFE7D600FFE7CE00FFE7
      CE00FFDEC600FFDEC600FFDEC600FFD6B500FFD6BD00FFE7CE00A56B5A000000
      000000000000DED6EF00399C520042EF730031CE630029D66B0029CE630018C6
      4A0021BD420052945A0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C8C4A00529C
      DE000052CE000000000000000000FFEFD600CE9C94000000000000000000CE9C
      9C00FFD6AD00E7C69C000000000000000000A584630000000000000000000000
      000000000000000000009C8C4A00529CDE00005AE70010318C00AD8C8400FFEF
      D600CE9C9400AD737300B5848C00CE9C9C00FFD6AD00FFD6A500FFCE9C00FFCE
      9C0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000B5736B00E7C6B500FFDEBD00FFC68C00FFC6
      8C00FFC68400FFC68400FFC68400FFBD8400FFC69400FFE7CE00A56B5A000000
      0000000000008CA59C0021BD4A004AF78C0042DE730039D66B0031DE6B0031CE
      6B0018CE4200529C5A000000000000000000000000000000000000000000A5A5
      B500B5C6C6000000000000000000000000000000000000000000B5A56B000000
      0000101829000000000000000000AD6B6B00D6A584000000000000000000D6C6
      9C0000000000212118000000000000000000A584520000000000000000000000
      00000000000000000000B5A56B00FFFFEF005AB5FF003994D6005A636300AD6B
      6B00D6A58400FFEFAD00FFFFBD00D6C69C00AD636B00DEC6AD00FFD6A500FFD6
      AD0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000BD847B00DECEC600F7E7DE00FFE7CE00FFE7
      CE00FFE7CE00FFE7CE00FFE7CE00FFEFCE00F7E7D600FFE7CE00AD7B63000000
      0000D6D6E70042734A0039EF730052F7840042EF7B0039D66B00006B080031DE
      630031DE6300529C5A000000000000000000000000000000000084B58C0063B5
      8400392939009CA5AD0000000000000000000000000000000000ADA56B00CECE
      BD00393939000000000000000000FFE79C00FFFFBD00FFFFD600FFFFDE00FFFF
      FF00CECECE00211818000000000000000000B594630000000000000000000000
      00000000000000000000ADA56B00FFFFEF00FFFFE700EFDECE00AD736B00FFE7
      9C00FFFFBD00FFFFD600FFFFDE00FFFFFF00FFFFFF009C636B00EFCEA500FFD6
      B50000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000CE8C6B00EFDEC600FFDEBD00FFC68C00FFC6
      8C00FFC68C00FFC68C00FFC68C00FFC68400FFCE9400FFE7CE00AD7B63000000
      0000CED6DE00316339004AFF7B0052F7940052F7840029842900423142000042
      000029FF6B0063A56B0000000000000000000000000000000000B5C6BD0039F7
      6B00217B390042313100ADB5B500000000000000000000000000B5AD7B00FFFF
      F700FFFFEF003129290000000000FFF7B500F7E7AD00FFFFCE00FFF7E700FFFF
      FF00FFFFFF00D6CEB5003121210000000000AD946B0000000000000000000000
      00000000000000000000B5AD7B00FFFFF700FFFFEF00C69C9C00EFC68400FFF7
      B500F7E7AD00FFFFCE00FFF7E700FFFFFF00FFFFFF00DED6BD00B57B7300FFE7
      B5000000000000000000000000000000000000000000000000000000000052A5
      5A00217339000000000000000000CE8C7300EFDED600FFE7CE00FFD6B500FFD6
      B500FFD6B500FFD6B500FFD6B500FFD6B500FFDEBD00FFE7CE00B5846B000000
      0000D6D6DE00293918004ACE73006BFFA50031D66B009CA5A500BDC6C6005242
      5A00184A180063A56B0000000000948CA500BDCEC6000000000000000000189C
      29007BFFBD00106B21006B637300000000000000000000000000BDB57B00FFFF
      F700FFFFFF00B58C9400FFEFAD00FFD69400F7EFB500FFFFC600FFFFDE00FFFF
      EF00FFF7E700FFFFB500A56B6B00FFE7C600AD946B0000000000000000000000
      00000000000000000000BDB57B00FFFFF700FFFFFF00B58C9400FFEFAD00FFD6
      9400F7EFB500FFFFC600FFFFDE00FFFFEF00FFF7E700FFFFB500A56B6B00FFE7
      C60000000000000000000000000000000000000000000000000052A5520029D6
      5A00217339000000000000000000DE9C7300EFE7DE00FFEFDE00FFDEB500FFDE
      B500FFDEB500FFDEB500FFDEB500FFDEB500FFDEBD00FFE7CE00BD8473000000
      0000000000006B637300106B21007BFFBD00189C29000000000000000000BDCE
      C600948CA5000000000063A56B00184A180052425A00BDC6C6009CA5A50031D6
      6B006BFFA5004ACE730029391800D6D6DE000000000000000000C6BD7B00FFFF
      FF00FFFFFF00BD848400FFFFB500FFCE8C00F7E7AD00FFFFCE00FFFFC600FFFF
      D600FFFFCE00FFFFBD00A5737300FFEFCE00B5946B0000000000000000000000
      00000000000000000000C6BD7B00FFFFFF00FFFFFF00BD848400FFFFB500FFCE
      8C00F7E7AD00FFFFCE00FFFFC600FFFFD600FFFFCE00FFFFBD00000000000000
      00000000000000000000000000000000000000000000529C5A0018BD390029CE
      630021733900319C4A00299C4200319C4A0029943900319C4A00FFCE9400FFCE
      9400FFCE9400FFCE9400FFCE9400FFCE8C00FFCE9C00FFE7CE00BD8473000000
      000000000000ADB5B50042313100217B390039F76B00B5C6BD00000000000000
      0000000000000000000063A56B0029FF6B0000420000423142002984290052F7
      840052F794004AFF7B0031633900CED6DE000000000000000000C6BD7B00FFFF
      FF00FFFFFF00C6949400EFD6A500FFE7C600FFD68C00F7DEA500F7F7BD00F7F7
      BD00FFFFBD00EFDEA500A5737300FFEFCE00BD9C730000000000000000000000
      00000000000000000000C6BD7B00FFFFFF00FFFFFF00C6949400EFD6A500FFE7
      C600FFD68C00F7DEA500F7F7BD00F7F7BD00FFFFBD00EFDEA500946B84000000
      00000000000000000000946B8400000000007BAD840008A5180018BD420029CE
      630042DE730052F78C004AEF840052F78C0052F78C0029943900FFFFFF00FFFF
      FF00FFFFF700FFFFEF00FFFFE700FFF7E700FFE7CE00FFC6B500BD7B6B000000
      000000000000000000009CA5AD003929390063B5840084B58C00000000000000
      00000000000000000000529C5A0031DE630031DE6300006B080039D66B0042EF
      7B0052F7840039EF730042734A00D6D6E7000000000000000000D6CE8400FFFF
      FF00FFFFFF00CEC6C600D69C8C00FFFFFF00F7F7E700FFDE9400FFCE9400FFDE
      9C00FFF7AD00C6846B00C6B5A500FFE7BD00BD9C630000000000000000000000
      00000000000000000000D6CE8400FFFFFF00FFFFFF00CEC6C600D69C8C00FFFF
      FF00F7F7E700FFDE9400FFCE9400FFDE9C00FFF7AD00C6846B00C6B5A5000000
      0000000000000000000000000000000000007BAD840008A5180018BD420029CE
      630042DE730052F78C004AEF840052F78C0052F78C0029943900FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFFFEF00FFFFE700C6947300C67B6B00AD6B52000000
      0000000000000000000000000000B5C6C600A5A5B50000000000000000000000
      00000000000000000000529C5A0018CE420031CE6B0031DE6B0039D66B0042DE
      73004AF78C0021BD4A008CA59C00000000000000000000000000D6CE8400FFFF
      FF00FFFFFF00FFFFFF00BD8C8C00C6AD9400EFDED600F7E7C600FFDE9C00EFD6
      A500C68C7300B5848400FFD6C600FFBDB500AD84630000000000000000000000
      00000000000000000000D6CE8400FFFFFF00FFFFFF00FFFFFF00BD8C8C00C6AD
      9400EFDED600F7E7C600FFDE9C00EFD6A500C68C7300B5848400FFD6C600946B
      840000000000946B8400000000000000000000000000529C5A0018BD390029CE
      630021733900319C4A00299C4200319C4A0029943900319C4A00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFF700FFFFF700AD734A00D6945200C68C7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000052945A0021BD420018C64A0029CE630029D66B0031CE
      630042EF7300399C5200DED6EF00000000000000000000000000DECE8400FFFF
      FF00FFFFF700FFFFFF00FFFFFF00C69CA500BD8C7B00BD948400BD948C00C694
      8C00C69C8C00F7C6B500DE848C00EF738400BD7B520000000000000000000000
      00000000000000000000DECE8400FFFFFF00FFFFF700FFFFFF00FFFFFF00C69C
      A500BD8C7B00BD948400BD948C00C6948C00C69C8C00F7C6B500DE848C00EF73
      840000000000000000000000000000000000000000000000000052A5520029D6
      5A00217339000000000000000000EFBD8C00F7E7CE00F7EFDE00F7EFDE00F7E7
      DE00F7E7DE00F7E7DE00EFDED600E7D6CE00AD6B5200DEAD8C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000052945A0010BD290021BD420018C64A0029C65A0031DE
      7B00109429004A213900B5BDC600000000000000000000000000DED68C00FFFF
      FF00F7FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFE7DE00F7E7E700FFFF
      FF009C5A5200A55A4A00AD6321009C521800947B310000000000000000000000
      00000000000000000000DED68C00FFFFFF00946B840000000000FFFFFF00FFFF
      FF00FFFFFF00EFE7DE00F7E7E700FFFFFF009C5A5200A55A4A0000000000946B
      8400947B3100000000000000000000000000FFFFFF00FFFFFF00FFFFFF0052A5
      5A0021733900FFFFFF0000000000F7D6BD00E7BDA500E7BDA500E7BD9C00E7BD
      9C00C6845A00DE9C5A00D69C7300E7BD9C00CEAD9C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000052945A0008B5180010AD310021B5420021BD4A0029CE
      5A0031DE7300085A18005A4A5A00A5ADB5000000000000000000E7DE8C00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFFF
      FF00945A5200E7B57B00FFAD1800DE940800CE737B0000000000000000000000
      00000000000000000000946B8400000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFF7F700FFFFFF00945A5200E7B57B00000000000000
      000000000000946B84000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000052845A0000A5000000AD000000B5100008BD290008C6
      390018DE520021E76300087B2100BDBDBD000000000000000000EFE79400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFF
      FF0094525200E7C68C00DEAD5A00C67B84000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000094B59C007BC694007BBD8C0073BD8C0073BD840073BD
      840073B584007BBD8C006BCE8400C6D6D6000000000000000000EFE78C00FFFF
      FF00F7F7EF00F7F7EF00EFEFE700EFE7DE00E7DEDE00EFDEDE00DEDED600E7E7
      DE00945A5200D6A56300D69C6B00000000000000000000000000000000000000
      00000000000000000000946B8400000000000000000000000000EFEFE700EFE7
      DE00E7DEDE00EFDEDE00DEDED600E7E7DE00945A5200D6A56300000000000000
      000000000000946B840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFE77B00FFAD
      7B00FFAD7B00FFAD7B00FFAD7B00FFAD7B00FFAD7B00FFAD7B00FFAD7B00FFB5
      8400BD736300FFB57B0000000000000000000000000000000000000000000000
      00000000000000000000FFE77B00FFAD7B00946B840000000000FFAD7B00FFAD
      7B00FFAD7B00FFAD7B00FFAD7B00FFB58400BD736300FFB57B0000000000946B
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000219CC600007B
      A50000426B001031390039394200635A5A009C948C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5C6CE009CAD
      AD00B5C6C600949494007B737B00737B8400CEDEE70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000094CE00E7FF
      FF0031D6FF0018BDFF0000A5E7000084B50000527B0000315200103142005242
      420094847B00B5ADA50000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C949400C6A5A5009C84
      8400A58C8400EFBDB500FFCECE008C737B0084949400949C9C00848C9400CEDE
      E700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000052A55A002173390000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000010A5D60094D6
      EF0063DEFF0052D6FF005ADEFF005ADEFF0052DEFF0042D6FF0018B5EF000094
      CE00005A8C0000395A0000394A00635A5A000000000000000000000000000000
      0000000000000000000000000000C6DEDE00A59C9C00DEAD9C00FFCECE00FFC6
      CE00E7B5AD00FFC6BD00FFCED600C69C9C00AD8C7B00EFB5B5009C737300737B
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EFDEDE0094635200B57B7300BD7B7300BD7B7300BD7B
      7300BD7B7300BD7B7300BD7B7300BD7B7300BD7B73007B393900000000000000
      0000000000000000000052A5520029D65A002173390000000000A5736B009C63
      5A00A5635A00A5635A00A5635A00A5635A00A5635A00A5635A00A5635A00A563
      5A00A5635A008442390000000000000000000000000000000000009CDE0039B5
      DE00BDF7FF0052DEFF005ADEFF005ADEFF005ADEFF005ADEFF0063E7FF0063EF
      FF006BEFFF0042DEFF0010D6FF00001031000000000000000000000000000000
      00000000000000000000CED6D600AD949400A57B8400D6AD9400FFBDBD00FFBD
      C600FFC6C600FFBDC600FFC6C600FFC6C600FFBDBD00FFC6C600FFBDBD008494
      94000000000000000000000000000000000000000000000000000000000084CE
      EF006BC6E7006BC6E70073ADC600AD7B7300EFCEBD00FFD6CE00FFD6CE00FFD6
      CE00FFD6CE00FFD6CE00FFD6CE00FFD6CE00FFD6BD008C4A4200000000000000
      000000000000529C5A0018BD390029CE630021733900319C4A00299C4200319C
      4A0029943900319C4A00FFCEC600FFCEC600FFCEC600FFCEC600FFCEC600FFCE
      C600FFCEBD00A56B5A000000000000000000000000000000000029ADDE00089C
      D600B5EFF7005AE7FF0063E7FF0063E7FF0063E7FF0063E7FF006BEFFF005AE7
      FF0052DEFF006BEFFF005ADEFF000094BD003139390000000000000000000000
      00000000000000000000BDA59400FFADA500FFBDBD00FFB5B500FFB5BD00FFBD
      BD00FFB5B500FFB5B500FFB5B500FFB5BD00FFBDBD00FFBDBD00CE949400526B
      6B008C9494008CA5A5000000000000000000000000000000000063BDDE0018A5
      DE0031CEF70039DEF7004ABDD600B5847300EFDED600FFDEBD00FFDEB500FFD6
      AD00FFCEA500FFCEA500FFCEA500FFD6BD00FFDEC6008C4A4200000000000000
      00007BAD840008A5180018BD420029CE630042DE730052F78C004AEF840052F7
      8C0052F78C0029943900FFE7CE00FFDEC600FFDEC600FFDEC600FFD6B500FFD6
      BD00FFE7CE00A56B5A000000000000000000000000000000000031B5DE00009C
      EF00ADDEEF0063F7FF006BEFFF006BEFFF006BEFFF0073F7FF0063EFFF006BC6
      E7008CC6CE0063F7FF004AD6FF005AE7FF0000314A0000000000000000000000
      00000000000000000000C6A59C00EFADA500FFADB500FFB5B500FFB5B500EFA5
      A500CEC6C600D6DEDE00C6BDB500CEA59400FFADA500FFB5B500FFADAD00EFA5
      9C00FFADAD004A4A4200BDCED60000000000000000000000000018ADDE005AE7
      FF004AC6FF004AC6FF005AB5DE00BD948400EFDED600FFCE9C00FFC68C00FFC6
      8C00FFC68C00FFC68C00FFC68C00FFD6AD00FFDEC600945A4A00000000000000
      00007BAD840008A5180018BD420029CE630042DE730052F78C004AEF840052F7
      8C0052F78C0029943900FFC68C00FFC68400FFC68400FFC68400FFBD8400FFC6
      9400FFE7CE00A56B5A000000000000000000000000000000000000A5DE0018B5
      EF0063B5DE00B5FFFF006BFFFF0073FFFF0073FFFF0073FFFF006BDEEF00FFBD
      7B00FFBD730073DEEF0042DEFF00CEFFFF000073A5005A424200000000000000
      00000000000000000000A5ADAD00BDA58C00F7A5A500FFADAD00FFA5A500A5A5
      A500000000000000000000000000D6DED600C6A58C00F7A5A500FFADAD00FFAD
      AD00FFB5B500BD949400C6DEE70000000000000000000000000018ADDE005AE7
      FF004ACEFF004ACEFF0063BDDE00CE9C8C00F7E7D600FFE7D600FFE7D600FFE7
      D600FFE7CE00FFE7CE00FFE7CE00FFE7D600FFDEC600945A4A00000000000000
      000000000000529C5A0018BD390029CE630021733900319C4A00299C4200319C
      4A0029943900319C4A00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFEFCE00F7E7
      D600FFE7CE00AD7B63000000000000000000000000000000000031B5E70042CE
      FF000094DE00EFF7F700BDFFFF00B5FFFF00ADFFFF0073F7FF00FFBD7B00FFD6
      9400FFD69400EFC68C0039C6F700E7FFFF006BE7FF0000183900000000000000
      000000000000C6C6C600B5847B00EF9C9C00FFA5A500FFADAD00B57B7B00ADCE
      D60000000000000000000000000000000000C6C6C600D6A58C00FFA5A500FFAD
      AD00BD8484009CB5B5000000000000000000000000000000000018ADDE0063EF
      FF0052D6FF0052D6FF0063C6DE00CE9C8C00F7E7D600FFD6A500FFCE9400FFCE
      9400FFCE9400FFC68C00FFC68C00FFD6AD00FFDEC600945A4A00000000000000
      0000000000000000000052A5520029D65A002173390000000000CE8C6B00EFDE
      C600FFDEBD00FFC68C00FFC68C00FFC68C00FFC68C00FFC68C00FFC68400FFCE
      9400FFE7CE00AD7B6300000000000000000000000000EFEFEF0042BDE70052D6
      FF004ACEFF0029ADE7004AB5E70063BDDE0073CEEF00CEE7F700FFDE9400FFC6
      7B00FFEF9400FFE78C00BDBD9400DEFFFF00DEFFFF00004A8400736B63000000
      000000000000C6A59C00F79C9400FF9CA500FF9C9C00FFA5A5007B5A5A00C6DE
      DE000000000000000000000000000000000000000000C6AD9400EF9C9400FFA5
      A500BD7B7B007B6363007B848C0000000000000000000000000021ADDE007BFF
      FF0063F7FF0063F7FF007BDEDE00DEB58C00FFF7EF00FFF7EF00FFF7E700FFF7
      E700FFF7E700FFF7E700FFF7E700FFEFD600FFD6AD00A5635200000000000000
      000000000000000000000000000052A55A002173390000000000CE8C7300EFDE
      D600FFE7CE00FFD6B500FFD6B500FFD6B500FFD6B500FFD6B500FFD6B500FFDE
      BD00FFE7CE00B5846B00000000000000000000000000A5D6EF005AC6E70063E7
      FF005ADEFF0063EFFF005AE7FF0042CEFF008C949C0084B5C600A5DEEF00F7E7
      C600FFF7BD00FFFFD600FFFFAD00FFD6AD00FFFFFF0073D6FF00002939000000
      000000000000CEBDB500DEA59400F79C9400FF9C9400FFA5A500845A5A00ADBD
      C6000000000000000000000000000000000000000000BDA59C00EF9C9400FF9C
      9C00FF9C9C00FF9C9C00525A5A0000000000000000000000000029ADDE009CFF
      FF007BFFFF007BFFFF008CEFE700EFC69C00FFFFF700FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFEF00EFDEC600A56B4A00AD6B4A00AD735A00000000000000
      0000000000000000000000000000000000000000000000000000DE9C7300EFE7
      DE00FFEFDE00FFDEB500FFDEB500FFDEB500FFDEB500FFDEB500FFDEB500FFDE
      BD00FFE7CE00BD847300000000000000000000000000B5D6EF0073DEEF006BF7
      FF0073F7FF0073F7FF005AEFFF00849CAD00F7E7CE00FFAD42000029CE000052
      D600106BBD007BCEE70052BDDE00ADCEDE00DEEFF700F7FFFF00006B9C000000
      00000000000000000000BDD6DE00B59C8C00EF9C9400FF949C00C67373005A73
      7B000000000000000000000000000000000000000000BDA59C00EF9C9400FF94
      9400FF949400FF949400949C9C0000000000000000000000000029ADDE00ADFF
      FF0084FFFF007BFFFF009CEFE700F7CE9C00FFFFF700FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00EFDEC600BD7B5200E7A56B00E7C6B500000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000DE9C6B00EFE7
      DE00FFE7D600FFCE9400FFCE9400FFCE9400FFCE9400FFCE9400FFCE8C00FFCE
      9C00FFE7CE00BD84730000000000000000000000000094D6E7009CE7EF007BFF
      FF007BFFFF0073F7F700739CA500F7E7E700F7941800BD9C7B006B63FF00EFF7
      EF002939CE00E7AD8C00FFFFFF00A5CEDE006BADBD00185A7300B5CEDE000000
      00000000000000000000B5A5A500E78C8400FF8C8C00FF8C8C00FF8C8C00634A
      4A0094A5AD00000000000000000000000000CED6DE00C6A59400F78C8C00FF8C
      94009C6B6B00949C9C000000000000000000000000000000000029ADDE00ADFF
      FF0094FFFF008CFFFF00A5EFE700E7B58400E7BD9C00E7BDA500E7BDA500E7BD
      A500E7BDA500E7BD9C00D6AD8C00B5846300EFCEBD0000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000E7AD7B00FFEF
      DE00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFEF00FFFFE700FFF7E700FFE7
      CE00FFC6B500BD7B6B00000000000000000000000000DEEFF7006BBDDE0094FF
      FF0073FFFF006BCED600D6CED600FFAD3100E7730000C6C6CE008CADF700949C
      F7007394FF009C735200FFE7A500FFFFFF00BDB5B500C6BDB500000000000000
      000000000000D6DEE700C69C8400EF847B00F7847B00F7848400F78C8C00EF84
      7B005A4A4A006B7B7B00B5CED600BDD6DE00AD9C9400E78C8400F7848400F78C
      8C00D67373004A424200B5C6CE0000000000000000000000000031ADDE00CEFF
      FF00ADFFFF00ADFFFF00B5FFFF00BDEFE700BDEFDE00BDEFDE00BDEFDE00BDEF
      DE00BDEFDE00BDEFDE00ADDEDE005AA5CE00ADCEE70000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000E7A57300FFEF
      DE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFEF00FFFFE700C694
      7300C67B6B00AD6B52000000000000000000000000000000000063BDDE0084D6
      E700B5EFFF00DEFFFF00D6CECE00C6C6C600E76B0000ADADC600EFFFFF00EFF7
      F700A5DEFF00AD733100E7BD8C00C6CED6009C9C9C0000000000000000000000
      00000000000000000000CEC6C600D6A59C00DEA5AD00CE9C8C00E77B7B00F77B
      8400F7848400B56363007B525200AD6B6B00EF847B00EF7B7B00EF7B8400EF7B
      7B00F77B7B00AD6B6B00BDCED60000000000000000000000000031ADDE00E7FF
      FF009CCEDE00948484009C7B73009C7B73009C7B73009C7B73009C7B73009C7B
      73008C736B0063ADD600BDF7FF0042ADDE009CCEE70000000000000000000000
      0000000000000000000000000000000000000000000000000000EFBD8C00FFF7
      E700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700AD73
      4A00D6945200C68C7B000000000000000000000000000000000000000000BDDE
      EF0084CEDE005ABDDE0052BDDE00BDC6D600D6BD9C00A5520000ADCEFF0084AD
      FF0052529400D69C7300C6D6D600949494000000000000000000000000000000
      000000000000000000000000000000000000C6D6DE00C69C8400E77B7300E77B
      7B00E7737300EF7B7B00EF7B7B00EF7B7B00E7737300E7737B00D67B7300C694
      8400DE848400BDB5B5000000000000000000000000000000000073C6EF00A5E7
      F7009CC6C600B5A5A500CEC6BD00E7DEDE00E7DEDE00E7DEDE00E7DEDE00CEBD
      B5008C847B00189CC60094DEEF0052ADDE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFBD8C00F7E7
      CE00F7EFDE00F7EFDE00F7E7DE00F7E7DE00F7E7DE00EFDED600E7D6CE00AD6B
      5200DEAD8C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F7F7F700C6C6D600D69C6B00CE630000D66B
      1000BD8C3100C6C6D60094949400000000000000000000000000000000000000
      000000000000000000000000000000000000BDBDB500D68C7B00DE6B6B00DE63
      6B00D68C8400DE737300DE737300DE7B7300DE7B7300E7737300D66363005A6B
      6B00CEDEDE0000000000000000000000000000000000000000000000000073CE
      EF0031B5DE003994B500AD948400D6CEC600D6CEC600D6CEC600D6C6BD00949C
      9C003984A500089CCE0042BDDE00C6DEEF000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000F7D6BD00E7BD
      A500E7BDA500E7BD9C00E7BD9C00C6845A00DE9C5A00D69C7300E7BD9C00CEAD
      9C00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E7EFEF00CEDEF700CE840000E784
      0000BDC6D6009C9C9C0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6B5AD00CE948C00C69C
      9C00C6AD9C00D6737300DE636300C66B6B00C6A58C00D6636300D66B6B00ADB5
      BD00000000000000000000000000000000000000000000000000000000000000
      000000000000000000008C6B6300947B6B00947B6B00947B6B0094736B00ADA5
      9C00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DEDEDE00BDC6C600BDC6
      C6009CA5A5000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEF7
      FF00C6B5AD00C68C7B00D6736B00B59C9C00CED6CE00D6C6C600D6DEDE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000947B7B008C848400848484007B7B84007373
      73007B737B0063636300525A5A005A5A5A007B8C8C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6D6DE00A5B5B5007B8C94006B7B7B006B737B006B737B007384
      8400949CA500BDCECE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000ADADAD00D6D6D600E7E7EF00C6D6C60063A56300398C
      3900A5ADA500B5ADB5009C9C9C006B6B6B005A5A5A005A636B00000000000000
      00000000000000000000CED6E7008C9CD60094A5D60094A5D60094A5D60094A5
      D60094A5D60094A5D60094A5D60094A5D600949CD600949CD600949CD600949C
      DE008C9CD600CECEE7000000000000000000000000000000000000000000D6E7
      E700ADBDBD008C8C8C00BDADA500D6C6B500CEBDB500CEBDB500CEBDB500C6B5
      AD00736B6B004A5252007B848C00C6D6D6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600F7F7F700FFFFFF00FFFFFF00A5CEA500108C10000894
      0800A5C6A500E7DEE700BDBDBD00B5ADAD008C8C94005A636300525A63000000
      000000000000CED6EF001839BD000018AD000021B5000021B5000029B5000021
      B5000021B5000021B5000021BD000021BD000021BD000018B5000018BD000010
      BD000008AD001031A500CECEE700000000000000000000000000CEDEE70094A5
      A500BDAD9C00FFF7EF00FFFFFF00F7FFFF00F7FFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E7D6C6006B5A5A004A5A5A00B5C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B5AD9400D6DEF700B5BDDE00CED6E700FFFFFF00FFFFFF00C6E7C600BDE7
      BD00F7F7FF00CEBDB500736B7300EFA55A00C6946B00949494005A5A6300737B
      7B00000000008CA5EF000021D6001842DE00294ADE002952DE002952DE00294A
      DE00214ADE00184ADE001042DE001042E7001042E7001042E7000842E7000039
      E7000031DE000008B5008C94D6000000000000000000CEE7E700A5ADAD00E7D6
      CE00FFFFFF00F7FFFF00DED6CE00BD8C7300BD6B4200BD6B4200CE846300D6B5
      A500EFEFEF00FFFFFF00FFFFF7008C7B73004A525200B5C6CE00000000000000
      0000000000000000000000000000A5736B009C635A00A5635A00A5635A00A563
      5A00A5635A00A5635A00A5635A00A5635A00A5635A00A5635A00844239000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ADB5C6005A6BFF001018E7003942D600D6DEF700FFFFFF00A5948C00CE9C
      6B00EFAD6B00004A8C00004A9400BD845200F7B57B00A5847300DEA56B005252
      52000000000094A5F7000029DE00294AE7003152E700395AE7003152E700395A
      E700637BEF007394EF007394EF00527BEF001852E7000842EF000842EF000042
      E7000039E7000010BD00949CD6000000000000000000ADBDBD00EFD6CE00FFFF
      FF00F7FFFF00CE8C6B00BD521800BD4A1000C6947B00EFD6CE00BD521800B54A
      1000BD633100DED6C600F7FFFF00FFFFF700736B63005A6B6B00CEDEDE000000
      0000000000000000000000000000AD846B00DEBDB500FFCEC600FFCEC600FFCE
      C600FFCEC600FFCEC600FFCEC600FFCEC600FFCEC600FFCEBD00A56B5A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BDC6CE00DEE7FF005A7BFF00637BFF00E7EFFF008C9CB50000428C000042
      8C0073636B0039ADE70031B5E7004A637B00635A630000428C00315284007B7B
      84000000000094ADF7000831DE003152E7003963E700395AE7005A7BE700DEE7
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D6DEFF003163EF000042E7000842
      EF000039E7000018BD00949CD60000000000C6DEDE00DECEBD00FFFFFF00EFF7
      F700C66B3900BD4A1800CE632900C6633100CEDEE700FFFFFF00DEA58400C65A
      2100C65A2900B54A1000D6AD9C00FFFFFF00FFF7EF00524A4A0094A5A5000000
      0000000000000000000000000000A56B5A00E7C6B500FFE7D600FFE7CE00FFE7
      CE00FFDEC600FFDEC600FFDEC600FFD6B500FFD6BD00FFE7CE00A56B5A000000
      000000000000000000000000000000000000A5736B009C635A00A5635A00A563
      5A00C6BDAD00FFFFFF00FFFFFF00FFFFFF00FFFFFF0094ADBD0052C6FF00319C
      D6000052940039B5EF0031B5E700086BAD00005A9C0010A5D600318CB5000000
      0000000000009CADF7001039DE00395AE700395AE700637BEF00FFFFFF00F7F7
      FF008CA5EF003963E7003163E70084A5F700FFFFFF00FFFFFF00295AEF000042
      EF000842E7000018BD00949CD60000000000D6DEDE00F7E7DE00FFFFFF00CE8C
      6300BD521800CE633100CE633100CE5A2100CE947B00EFCEBD00C65A2900CE63
      2900CE633100C65A2900BD4A1000EFE7E700FFFFFF00B59C9400636B6B00CEDE
      DE00000000000000000000000000B5736B00E7C6B500FFDEBD00FFC68C00FFC6
      8C00FFC68400FFC68400FFC68400FFBD8400FFC69400FFE7CE00A56B5A000000
      000000000000000000000000000000000000AD846B00DEBDB500FFCEC600FFCE
      C600CEB5B500DEDEE700FFFFFF00D6DEE7009494A50063738C0052C6F7004AC6
      F70042BDEF0039B5EF0031B5E70029ADE70021ADDE0018A5DE001884B500736B
      7300000000009CADF7001842DE004263E700526BE700E7E7FF00F7F7FF004263
      E7002952E7006384EF005A84EF00104AE700215AEF00FFFFFF00CEDEFF00104A
      E7001042E7000021BD0094A5D60000000000E7DED600FFFFFF00EFDED600BD52
      1800CE633100CE633100CE633100CE632900CE734200D67B5200CE632900CE63
      3100CE633100CE633100C65A2100C6845A00F7FFFF00FFFFF700424A4A00B5C6
      C600000000000000000000000000BD847B00DECEC600F7E7DE00FFE7CE00FFE7
      CE00FFE7CE00FFE7CE00FFE7CE00FFEFCE00F7E7D600FFE7CE00AD7B63000000
      000000000000000000000000000000000000A56B5A00E7C6B500FFE7D600FFE7
      CE00E7CEB500C6BDAD00DEE7EF004294DE00296B9C000863A50052C6F7004ABD
      F70042BDEF0052BDE70039ADD600219CD600189CD600109CD600006BAD00004A
      9400000000009CADF700214AE7004263E7007B94EF00FFFFFF008C9CEF00395A
      E7002952E700FFFFFF00FFFFFF00104AE7001042E7007B9CF700FFFFFF004A73
      EF001042E7000021BD0094A5D60000000000F7DED600FFFFFF00D6947B00C65A
      2100CE6B3100CE633100CE633100C6521800D6CEC600FFFFFF00CE6B3900CE5A
      2100CE633100CE633100CE633100BD5A2100EFE7DE00FFFFFF008C847B009CA5
      AD00000000000000000000000000CE8C6B00EFDEC600FFDEBD00FFC68C00FFC6
      8C00FFC68C00FFC68C00FFC68C00FFC68400FFCE9400FFE7CE00AD7B63000000
      000000000000000000000000000000000000B5736B00E7C6B500FFDEBD00FFC6
      8C00FFC68C00DEB58400BDBDB500C6DEF7006BCEF7005ACEFF0052C6F7004ABD
      F70042BDEF00CECECE007373730021425A00006BB5000084BD00009CCE00009C
      CE0000000000A5B5F7002952E7004A63E70094A5F700FFFFFF005273E7004263
      E7002952E700EFEFFF00EFEFFF001042E700214AE7002952E700FFFFFF006B8C
      EF001042DE000029BD009CA5D60000000000F7E7DE00FFFFFF00CE7B5200CE63
      2900CE633100CE633100CE633100CE5A1800BDADA500FFFFFF00E7B59400C64A
      1000CE633100CE633100CE633100BD521800E7CEBD00FFFFFF00ADA59C008C9C
      A500000000000000000000000000CE8C7300EFDED600FFE7CE00FFD6B500FFD6
      B500FFD6B500FFD6B500FFD6B500FFD6B500FFDEBD00FFE7CE00B5846B000000
      000000000000000000000000000000000000BD847B00DECEC600F7E7DE00FFE7
      CE00FFE7CE00FFE7CE00E7D6BD00CEBDAD007BC6D6004ABDD60052C6F7004ABD
      F70063C6F700CECECE007373730029638400088CCE00109CD60008A5D600189C
      CE0000000000A5B5F700315AE700526BE7009CA5F700FFFFFF005273E7004A63
      E7002952E700EFEFFF00EFEFFF001042E700184AE7002152E700FFFFFF006B8C
      EF001842DE000829BD009CA5D60000000000F7E7DE00FFFFFF00D6734200D66B
      3100CE6B3100CE633100CE633100CE632900C65A2900CEC6BD00FFFFFF00EFC6
      AD00C6521800CE633100CE6B3100C6522100E7C6B500FFFFFF00B5A59C008C9C
      A500000000000000000000000000DE9C7300EFE7DE00FFEFDE00FFDEB500FFDE
      B500FFDEB500FFDEB500FFDEB500FFDEB500FFDEBD00FFE7CE00BD8473000000
      000000000000000000000000000000000000CE8C6B00EFDEC600FFDEBD00FFC6
      8C00FFC68C00E7D6A500F7BD7B00F7D6AD00007B000000840000399CD6004ABD
      F70063C6EF00CECECE007373730031738C0018A5DE0010A5D6006B8C94000000
      000000000000ADB5F700395AE7005A73E700849CEF00FFFFFF008C9CEF00395A
      E700294AE700FFFFFF00FFFFFF001039DE001039DE007394EF00FFFFFF005273
      EF00214ADE000829BD009CA5D60000000000F7E7DE00FFFFFF00DE845A00D66B
      3900D66B3900CE632900CE5A2900CE632900CE632900BD522100E7EFEF00FFFF
      FF00DE9C7300CE5A2100D66B3900C65A2100EFD6C600FFFFFF00B5A59C0094A5
      AD00000000000000000000000000DE9C6B00EFE7DE00FFE7D600FFCE9400FFCE
      9400FFCE9400FFCE9400FFCE9400FFCE8C00FFCE9C00FFE7CE00BD8473000000
      000000000000000000000000000000000000CE8C7300EFDED600FFE7CE00FFD6
      B500B5CEA500007B0000297B10007384290039D65A0031CE4A0042ADDE004ABD
      F7005AC6EF00CECECE007373730031738C0018A5DE0010A5D600CECEC6000000
      000000000000ADB5F7004263E7006B84EF006B84EF00E7EFFF00EFEFFF00425A
      E7003152E700637BEF005A7BE7001039DE00214ADE00F7F7FF00D6DEFF002952
      E700294ADE000829BD009CA5D60000000000F7DED600FFFFFF00F7B59400E773
      3900D6733900CE6B3900D67B5200D6734200CE5A2900CE5A2100CE7B5A00FFFF
      FF00F7E7DE00CE5A2900D66B3900CE633100FFF7EF00FFFFFF009C8C8C00B5C6
      C600000000000000000000000000E7AD7B00FFEFDE00FFFFFF00FFFFFF00FFFF
      FF00FFFFF700FFFFEF00FFFFE700FFF7E700FFE7CE00FFC6B500BD7B6B000000
      000000000000000000000000000000000000DE9C7300EFE7DE00FFEFDE00FFDE
      B5009CDE9C0052EF7B0018AD2900008C000039D6520031CE4A000894180010A5
      310039BD4200A58C7300525252009C8C73000000000000000000000000000000
      000000000000ADBDF7004A6BE700738CEF00637BEF007B94EF00FFFFFF00EFF7
      FF008494EF00395AE700395AE7007B94EF00F7F7FF00FFFFFF004263E700214A
      E7002952DE001031B5009CA5D60000000000E7DED600FFFFFF00FFF7EF00F784
      4A00EF7B4200C6846300EFFFFF00FFFFF700CE632900C64A1000D69C8400FFFF
      FF00EFD6CE00D66B3100DE6B3900E79C7300FFFFFF00FFF7EF007B848400CEDE
      E700000000000000000000000000E7A57300FFEFDE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFFFEF00FFFFE700C6947300C67B6B00AD6B52000000
      000000000000000000000000000000000000DE9C6B00EFE7DE00FFE7D600B5CE
      A50052A542004AE773004AE7730042DE630039D6520031CE4A0021C6390018BD
      290010AD2100638C42004A6B3100000000000000000000000000000000000000
      000000000000ADBDF7005A73E700849CEF00738CEF005A7BEF007B94EF00EFEF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E7FF00526BE700214ADE003152
      E7003152DE000831B5009CA5D60000000000DEE7DE00FFEFE700FFFFFF00FFC6
      9C00FF945200E77B4200D6CECE00FFFFFF00FFEFE700EFCEB500FFFFFF00FFFF
      FF00DEAD9400E7733900E76B3100FFFFF700FFFFFF00C6B5A5009CADAD000000
      0000000000000000000000000000EFBD8C00FFF7E700FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFF700FFFFF700AD734A00D6945200C68C7B000000
      000000000000000000000000000000000000E7AD7B00FFEFDE00FFFFFF000084
      0000089410004AEF73004AE76B0042DE63004ACE630031BD4A0021B5310018AD
      210010AD1800008C000000840000000000000000000000000000000000000000
      000000000000B5BDF7006B84EF0094ADF700849CEF00738CEF00637BEF006384
      EF00849CEF009CADEF0094ADF7007B94EF004A6BE700425AE7004263E700395A
      E7003152DE000829B50094A5D60000000000D6E7EF00E7D6CE00FFFFFF00FFFF
      FF00FFDEB500FFB57300F79C6B00DECEC600EFEFF700E7F7FF00EFEFF700EFC6
      B500FF844A00FF945A00FFE7CE00FFFFFF00FFEFDE00949C9400CEDEDE000000
      0000000000000000000000000000EFBD8C00F7E7CE00F7EFDE00F7EFDE00F7E7
      DE00F7E7DE00F7E7DE00EFDED600E7D6CE00AD6B5200DEAD8C00000000000000
      000000000000000000000000000000000000E7A57300FFEFDE00FFFFFF005AF7
      84005AF78C0052EF7B004AE76B00ADE7B500B5B5B5006B6B6B00007B0000008C
      00000094000008A51000009C0000000000000000000000000000000000000000
      000000000000ADBDF700738CEF00A5B5F70094A5F7008494EF00738CEF006B84
      EF00637BEF005A73E7005A73E7005A73E7005A73E7005273E7004A6BE7004263
      E7003152DE000021B500949CD6000000000000000000D6E7E700F7DED600FFFF
      FF00FFFFFF00FFF7D600FFE7AD00FFCE9400F7BD9400F7B58C00FFB58400FFB5
      7300FFBD8C00FFF7EF00FFFFFF00FFFFF700B5ADA500B5C6C600000000000000
      0000000000000000000000000000F7D6BD00E7BDA500E7BDA500E7BD9C00E7BD
      9C00C6845A00DE9C5A00D69C7300E7BD9C00CEAD9C0000000000000000000000
      000000000000000000000000000000000000EFBD8C00FFF7E700FFFFFF00CEFF
      D60063F78C0052EF7B0042E76B00D6EFD600B5B5B5006B6B6B0018B5290010AD
      210010AD180018A510007BC67300000000000000000000000000000000000000
      000000000000D6DEF700738CEF006B84EF00637BEF005273E7004A6BE7004263
      E7004263E700395AE700395AE700395AE7003152E7002952E700214AE7001842
      DE000831D6002142C600CED6EF00000000000000000000000000D6DEDE00F7DE
      D600FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFE700FFFFDE00FFF7DE00FFFF
      EF00FFFFFF00FFFFFF00FFF7F700B5ADA500B5C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFBD8C00F7E7CE00F7EFDE00F7EF
      DE00F7E7DE0042DE630042E76B00D6EFD600B5B5B5006B6B6B0021BD310018B5
      210008AD1000CEAD630000000000000000000000000000000000000000000000
      00000000000000000000D6DEFF00ADBDF700ADBDF700ADBDF700ADB5F700A5B5
      F700A5B5F700ADB5F700A5B5F700A5B5F700A5B5F700A5B5F700A5B5F7009CAD
      F70094A5EF00CED6F7000000000000000000000000000000000000000000D6E7
      E700E7D6CE00F7E7DE00FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFF7EF00E7D6CE00BDBDB500BDD6D6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7D6BD00E7BDA500E7BDA500E7BD
      9C00E7BD9C0052EF7B0042DE6B00D6E7D600A5A5A5006363630039BD390029BD
      390010AD18000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D6E7EF00DEE7DE00E7DED600EFDED600F7E7DE00F7E7DE00F7E7DE00EFDE
      D600DEDEDE00CEDEDE00CEE7EF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B5C6
      C600A5A5B5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052943900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000219CC600007B
      A50000426B005294390039394200635A5A009C948C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052943900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A5736B009C635A00A5635A00A5635A00A5635A009CA5AD003929
      390063B5840084B58C00A5635A00A5635A008442390000000000000000000000
      00000000000000000000000000000000000000000000087300006BA552000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000094CE00E7FF
      FF0031D6FF00087300006BA552000084B50000527B0000315200103142005242
      420094847B00B5ADA50000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000087300006BA552000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000AD846B00DEBDB500FFCEC600FFCEC600ADB5B50042313100217B
      390039F76B00B5C6BD00FFCEC600FFCEBD00A56B5A0000000000000000000000
      000000000000000000000000000000000000000000000873000008730000ADBD
      8400733918007339180073391800733918007339180073391800733918007339
      18007339180073391800736B630000000000000000000000000010A5D60094D6
      EF0063DEFF000873000008730000ADBD840052DEFF0042D6FF0018B5EF000094
      CE00005A8C0000395A0000394A00635A5A000000000000000000000000000000
      0000000000000000000000000000000000000000000008730000087300001010
      1000101010001010100010101000101010001010100010101000101010001010
      1000101010001010100000000000000000000000000000000000BD949400BD94
      9400BD949400A56B5A00E7C6B500FFE7D600FFE7CE006B637300106B21007BFF
      BD00189C2900FFD6B500FFD6BD00BDCEC600948CA50000000000000000000000
      000000000000087300000873000008730000087300000873000000B518000073
      0000C6C6CE00D6E7EF00DEF7F700C6C6CE00CED6DE00DEEFF700D6E7E700C6C6
      CE00D6E7EF00D6DEDE00634A3900000000000000000008730000087300000873
      0000087300000873000000B51800007300005ADEFF005ADEFF0063E7FF0063EF
      FF006BEFFF0042DEFF0010D6FF00001031000000000000000000000000000000
      000000000000087300000873000008730000087300000873000000B518000073
      0000DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE0010101000000000000000000000000000000000009C635A00EFAD
      A500EFADA500B5736B00E7C6B500FFDEBD00D6D6DE00293918004ACE73006BFF
      A50031D66B009CA5A500BDC6C60052425A00184A180063A56B00000000000000
      0000000000001084100039F77B0029E76B0010D6520008CE4A0000B5210000A5
      0000006B0000B5EFFF00DEF7F700E7CE9400BDB55A00DEF7F7009CBDF7007B84
      C600D6E7F700D6DEDE00634A390000000000000000001084100039F77B0029E7
      6B0010D6520008CE4A0000B5210000A50000006B000063E7FF006BEFFF005AE7
      FF0052DEFF006BEFFF005ADEFF000094BD003139390000000000000000000000
      0000000000001084100039F77B0029E76B0010D6520008CE4A0000B5210000A5
      0000006B0000DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00E7E7DE001010100000000000000000000000000000000000A5736300F7E7
      DE00FFE7D600BD847B00DECEC600F7E7DE00CED6DE00316339004AFF7B0052F7
      940052F7840029842900423142000042000029FF6B0063A56B00000000000000
      0000000000001084100039F77B0029E76B0010D6520008CE4A0000B5210000A5
      0000006B00009CE7FF00DEF7F7007BBD6300C6B50800DEF7F7007394F700A552
      2100CED6EF00D6DEDE00634A390000000000000000001084100039F77B0029E7
      6B0010D6520008CE4A0000B5210000A50000006B000073F7FF0063EFFF006BC6
      E7008CC6CE0063F7FF004AD6FF005AE7FF0000314A0000000000000000000000
      0000000000001084100039F77B0029E76B0010D6520008CE4A0000B5210000A5
      0000006B0000DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00D6D6
      DE00BDBDE7001010100000000000000000000000000000000000AD7B6300FFDE
      C600FFCE9C00CE8C6B00EFDEC600FFDEBD00D6D6E70042734A0039EF730052F7
      840042EF7B0039D66B00006B080031DE630031DE6300529C5A00000000000000
      000000000000087300000873000008730000087300000873000000B518000073
      00005AD6F700CEEFEF00DEF7F700E7D6A500E7CE9C00DEF7F700ADC6F7006B8C
      F700D6E7F700D6DEDE00634A3900000000000000000008730000087300000873
      0000087300000873000000B518000073000073FFFF0073FFFF006BDEEF00FFBD
      7B00FFBD730073DEEF0042DEFF00CEFFFF000073A5005A424200000000000000
      000000000000087300000873000008730000087300000873000000B518000073
      00008484E7004242E7008C8CE7007B7BE700B5B5E700ADADE7008C8CE7006363
      E7004A42EF001010100000000000000000000000000000000000AD7B6300FFE7
      CE00FFD6B500CE8C7300EFDED600FFE7CE00FFD6B5008CA59C0021BD4A004AF7
      8C0042DE730039D66B0031DE6B0031CE6B0018CE4200529C5A00000000000000
      00000000000000000000000000007BC6DE0052CEF7000873000008730000ADBD
      84004AA55200B5DECE00DEF7F7008C9CDE00739CEF00DEF7F700D6DEE700BD94
      9C00D6CED600D6DEDE00634A390000000000000000000000000031B5E70042CE
      FF000094DE000873000008730000ADBD8400ADFFFF0073F7FF00FFBD7B00FFD6
      9400FFD69400EFC68C0039C6F700E7FFFF006BE7FF0000183900000000000000
      000000000000000000000000000000000000000000000873000008730000DEDE
      DE00D6D6DE005A5AEF00ADADE700B5B5E7003131E7003939EF004242E7005A52
      E700BDB5E7001010100000000000000000000000000000000000BD847B00FFEF
      D600FFDEB500DE9C7300EFE7DE00FFEFDE00FFDEB500DED6EF00399C520042EF
      730031CE630029D66B0029CE630018C64A0021BD420052945A00000000000000
      00000000000000000000000000007BC6E7004ACEEF00087300006BA552006BC6
      840000AD9C009CD6AD00DEF7F7008C7BB500425AD600DEF7F700DEE7EF00299C
      DE00D6BDBD00D6DEDE00634A39000000000000000000EFEFEF0042BDE70052D6
      FF004ACEFF00087300006BA5520063BDDE0073CEEF00CEE7F700FFDE9400FFC6
      7B00FFEF9400FFE78C00BDBD9400DEFFFF00DEFFFF00004A8400736B63000000
      00000000000000000000000000000000000000000000087300006BA55200DEDE
      DE00DEDEDE009C9CE700CECEDE008C8CE7006B6BE700DEDEDE00DEDEDE00DEDE
      DE00DEDEDE001010100000000000000000000000000000000000BD8C7B00FFE7
      C600FFCE9400DE9C6B00EFE7DE00FFE7D600FFCE9400B5BDC6004A2139001094
      290031DE7B0029C65A0018C64A0021BD420010BD290052945A00000000000000
      000000000000000000000000000084CEE70063CEF70052943900847B5A00A5DE
      BD0063C68C00D6EFEF00DEF7F7009CB5F700ADB5D600DEF7F700DEEFF700BDB5
      C600DEDED600D6DEDE00634A39000000000000000000A5D6EF005AC6E70063E7
      FF005ADEFF00529439005AE7FF0042CEFF008C949C0084B5C600A5DEEF00F7E7
      C600FFF7BD00FFFFD600FFFFAD00FFD6AD00FFFFFF0073D6FF00002939000000
      0000000000000000000000000000000000000000000052943900DEDEDE00DEDE
      DE00DEDEDE00DEDEDE002929E7007373E700DEDEDE00DEDEDE00DEDEDE00E7E7
      DE00DEDEDE001010100000000000000000000000000000000000CE948400FFF7
      EF00FFEFDE00E7AD7B00FFEFDE00FFFFFF00A5ADB5005A4A5A00085A180031DE
      730029CE5A0021BD4A0021B5420010AD310008B5180052945A00000000000000
      000000000000000000000000000073CEEF005ACEEF008CFFFF00947B4A00EF73
      0000EF730000EF730000EF730000EF730000EF730000EF730000F79C2100F794
      1000D6842100AD845A00736352000000000000000000B5D6EF0073DEEF006BF7
      FF0073F7FF0073F7FF005AEFFF00849CAD00F7E7CE00FFAD42000029CE000052
      D600106BBD007BCEE70052BDDE00ADCEDE00DEEFF700F7FFFF00006B9C000000
      0000000000000000000000000000000000000000000000000000DEDEDE00DEDE
      DE00DEDEDE00DEDEDE004239E7009C9CE700DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE001010100000000000000000000000000000000000D6A58400FFEF
      D600FFC68C00E7A57300FFEFDE00FFFFFF00BDBDBD00087B210021E7630018DE
      520008C6390008BD290000B5100000AD000000A5000052845A00000000000000
      000000000000000000000000000094D6F70073D6F7009CFFFF009CC6AD00AD7B
      4200B58C4A00B58C4A00B58C4A00B58C4A00B58C4A00AD844A009C733900A55A
      1000B57329009C522100B5B5B500000000000000000094D6E7009CE7EF007BFF
      FF007BFFFF0073F7F700739CA500F7E7E700F7941800BD9C7B006B63FF00EFF7
      EF002939CE00E7AD8C00FFFFFF00A5CEDE006BADBD00185A7300B5CEDE000000
      0000000000000000000000000000000000000000000000000000DEDEDE00DEDE
      DE00DEDEDE00DEDEDE004A4AE700ADADE700DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE001010100000000000000000000000000000000000DEAD8400FFFF
      F700FFF7E700EFBD8C00FFF7E700FFFFFF00C6D6D6006BCE84007BBD8C0073B5
      840073BD840073BD840073BD8C007BBD8C007BC6940094B59C00000000000000
      00000000000000000000000000007BCEEF0052CEF70073D6F7009CEFFF00C6FF
      FF00C6FFFF00BDFFFF00BDFFFF00BDFFFF00BDFFFF00A5FFFF006BD6F700525A
      5A00C6D6D600D6E7EF00000000000000000000000000DEEFF7006BBDDE0094FF
      FF0073FFFF006BCED600D6CED600FFAD3100E7730000C6C6CE008CADF700949C
      F7007394FF009C735200FFE7A500FFFFFF00BDB5B500C6BDB500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DEDEDE00DEDEDE00DEDE
      DE00DEDEDE001010100000000000000000000000000000000000E7AD8C00FFFF
      FF00FFFFFF00EFBD8C00F7E7CE00F7EFDE00F7EFDE00F7E7DE00F7E7DE00F7E7
      DE00EFDED600E7D6CE00AD6B5200DEAD8C000000000000000000000000000000
      00000000000000000000000000009CDEF70094FFFF0084FFFF0063EFFF0042DE
      F7006BD6EF00E7FFFF00E7FFFF00DEFFFF00DEFFFF00BDFFFF009CE7FF00395A
      6300BDD6D600000000000000000000000000000000000000000063BDDE0084D6
      E700B5EFFF00DEFFFF00D6CECE00C6C6C600E76B0000ADADC600EFFFFF00EFF7
      F700A5DEFF00AD733100E7BD8C00C6CED6009C9C9C0000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF0000000000DEDEDE00DEDEDE00DEDE
      DE00DEDEDE001010100000000000000000000000000000000000E7B58C00FFFF
      FF00FFFFFF00F7D6BD00E7BDA500E7BDA500E7BD9C00E7BD9C00C6845A00DE9C
      5A00D69C7300E7BD9C00CEAD9C00000000000000000000000000000000000000
      000000000000000000000000000094DEEF00A5FFFF008CFFFF008CFFFF008CFF
      FF0094F7FF0063D6F70063DEF7006BD6F7007BD6F7008CDEF700A5E7FF004284
      9400C6DEDE00000000000000000000000000000000000000000000000000BDDE
      EF0084CEDE005ABDDE0052BDDE00BDC6D600D6BD9C00A5520000ADCEFF0084AD
      FF0052529400D69C7300C6D6D600949494000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF0000000000DEDEDE00000000000000
      0000000000001010100000000000000000000000000000000000EFBD8C00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFEF00AD734A00E7A5
      6B00E7C6B5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A5D6E700ADF7FF00B5FFFF00A5FFFF00BDFF
      FF0063A5BD0084C6D60094D6E7008CD6E70084DEEF0052CEEF005A9CB500B5D6
      D600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F7F7F700C6C6D600D69C6B00CE630000D66B
      1000BD8C3100C6C6D60094949400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DEDEDE00101010000000
      FF000000FF001010100000000000000000000000000000000000E7AD7300DEAD
      8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD8400DEA57B00AD735A00EFCE
      BD00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000094D6E7008CD6EF0094DEEF0094D6
      E700BDD6D600D6EFEF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E7EFEF00CEDEF700CE840000E784
      0000BDC6D6009C9C9C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00101010000000
      FF00101010000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DEDEDE00BDC6C600BDC6
      C6009CA5A5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000101010001010
      1000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009CBDA5007B9C8400000000000000000000000000000000000000
      0000000000007B9C84009CBDA500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009CBDAD0029D66300314A3900000000000000000000000000000000000000
      000000000000314A390029D663009CBDAD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6842100C6842100C6842100C6842100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007BAD
      8400ADCEBD000000000000000000000000000000000000000000000000009CBD
      AD0018B5390031D66300214A2100ADB5B500A5B5B500ADB5B500ADB5B5009CAD
      AD00ADB5B500214A210031D6630018B539009CBDAD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6842100C6842100C684210000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000529C5A0008A5
      180010A521009CBDAD0000000000000000000000000000000000ADCEBD0010A5
      210018B5390029CE630039DE6B0042EF730031EF6B0042EF730042EF730039EF
      730042EF730039DE6B0029CE630018B5390010A52100ADCEBD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6842100C6842100C684210000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6842100000000000000000052A5520018BD390018BD
      420018B5390018B539009CBDAD000000000000000000000000007BAD840008A5
      180018BD420029CE630042DE730052F78C004AEF840052F78C0052F78C0052F7
      8C0052F78C0042DE730029CE630018BD420008A518007BAD8400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C68421000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6842100C68421000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6842100C6842100C68421000000000052A55A0029D65A0029CE630029CE
      630029CE630031D6630029D663009CBDA500000000000000000000000000529C
      5A0018BD390029CE630021733900319C4A00299C4200319C4A00319C4A002994
      3900319C4A002173390029CE630018BD3900529C5A0000000000000000000000
      00000000000000000000000000000000000008941000216B2100000000000000
      0000C6842100C6842100C6842100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000630000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6842100C68421000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6842100C684
      2100C6842100C6842100C684210000000000737B7300394239002173390042DE
      730039DE6B00214A2100314A39007B9C84000000000000000000000000000000
      000052A5520029D65A0039423900000000000000000000000000000000000000
      0000000000003942390029D65A0052A552000000000000000000000000000000
      000000000000000000000000000031A5290052E7840021C663006B9C4A000000
      0000C6842100C6842100C6842100C6842100C684210000000000000000000000
      0000000000000000000000000000000000007B9C730000520000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6842100000000000000000000000000000000000000
      000000000000000000000000000000000000C6842100C6842100C6842100C684
      2100C6842100C6842100C6842100000000000000000000000000319C4A0052F7
      8C0042EF7300ADB5B50000000000000000000000000000000000000000000000
      00000000000052A55A00737B7300000000000000000000000000000000000000
      000000000000737B730052A55A00000000000000000000000000000000000000
      0000000000000000000052DE5A0018B542005AE78C005AE7840021A539000000
      0000C6842100C6842100C6842100C6842100C6842100C6842100C68421000000
      0000000000000000000000000000000000003184310000630000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6842100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000299C42004AEF
      840031EF6B00A5B5B50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000894210042CE6B005AE78C005AE78C004AD67B0021A5
      3900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003994420008941800ADC6A5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000299C42004AEF
      840031EF6B00A5B5B50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6842100C6842100C6842100C68421000000000000000000000000000000
      0000000000000094100018BD4A0031CE6B0042CE73004AD67B0063EF9C004AD6
      7B00298C31000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A8C420008BD3900317B29000000
      0000000000000000000000000000106B1000298C310000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000319C4A0052F7
      8C0042EF7300ADB5B50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6842100C6842100C6842100000000000000000000000000000000000000
      0000188C1000187B1800187B180018AD390042CE73004AD6730018A539001873
      180018731800106B100000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084AD7B000894180008941800639C
      5A00000000000000000000000000187318004AD67B0021A53900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002994390052F7
      8C0039EF73009CADAD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6842100C6842100C6842100000000000000000000000000000000000000
      00000000000000000000000000000094100018BD4A0021BD5A00429C52000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000087B100008B5210008A5
      2100219C3100429C5200429C520018A5390063EF9C004AD67B0021A539006B9C
      4A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000319C4A0052F7
      8C0042EF7300ADB5B50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6842100C684210000000000000000000000000000000000000000000000
      00000000000000000000000000000094100018BD420018B54200429C52000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000007B000008B5
      210018B5420018B5420021BD5A004AD673004AD67B005AE78C005AE7840021C6
      6300216B21000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000737B7300394239002173390042DE
      730039DE6B00214A2100314A39007B9C84000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6842100C684210000000000000000000000000000000000000000000000
      00000000000000000000000000001084100008A5210018B54200219C31000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000007B
      000008A5210018BD420018BD4A0042CE730042CE73005AE78C005AE78C0052E7
      8400089410000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000052A55A0029D65A0029CE630029CE
      630029CE630031D6630029D663009CBDA5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C68421000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000007B000008B5210008A52100639C
      5A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000010841000009410000094100018AD390031CE6B0042CE6B0018B5420031A5
      2900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052A5520018BD390018BD
      420018B5390018B539009CBDAD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C68421000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000007B000008B521000894
      1800317B2900ADC6A50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084D68400187B180018BD4A000894210052DE5A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000529C5A0008A5
      180010A521009CBDAD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000087B10000894
      180008BD39000894180000630000005200000063000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000188C10000094100000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007BAD
      8400ADCEBD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000084AD
      7B004A8C420039944200318431007B9C73000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000005AE752000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000219CC600007B
      A50000426B001031390039394200635A5A009C948C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6DEE700B5C6C600BDD6D6000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDCECE008C9494008C8C8C008C94
      8C008C948C008C948C008C948C008C948C008C948C008C948C008C949400A5B5
      B5000000000000000000000000000000000000000000000000000094CE00E7FF
      FF0031D6FF0018BDFF0000A5E7000084B50000527B0000315200103142005242
      420094847B00B5ADA50000000000000000000000000000000000000000000000
      00000000000000000000C6842100C6842100C6842100C6842100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BDD6DE009CA5A500737B7B00525A5A0042525200848C
      9C00BDD6D6000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E7A59400FFC6BD00F7BDB500F7BD
      B500F7BDAD00F7BDAD00F7BDAD00F7BDAD00F7BDB500F7BDB500FFBDA500AD73
      6B00C6D6DE00000000000000000000000000000000000000000010A5D60094D6
      EF0063DEFF0052D6FF005ADEFF005ADEFF0052DEFF0042D6FF0018B5EF000094
      CE00005A8C0000395A0000394A00635A5A000000000000000000000000000000
      0000000000000000000000000000C6842100C6842100C6842100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BDD6D6007B848400848C8C00B5BDB500ADADAD00635A5A003939
      3900525A5A008CA5A500BDD6DE00000000000000000000000000000000000000
      000000000000000000000000000000000000E7CEBD00FFF7DE00FFF7DE00FFF7
      DE00FFF7D600FFEFC600FFEFC600FFE7B500FFE7AD00FFDEAD00FFE7BD009C6B
      6B00BDD6D6000000000000000000000000000000000000000000009CDE0039B5
      DE00BDF7FF0052DEFF005ADEFF005ADEFF005ADEFF005ADEFF0063E7FF0063EF
      FF006BEFFF0042DEFF0010D6FF00001031000000000000000000000000000000
      0000000000000000000000000000C6842100C6842100C6842100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDD6D6008CA5A500737B
      7B00636B7300525A5A00BDBDBD00B5E7BD00ADDEB500B5B5B5009C8C8C00A584
      8400736363004239390042425200849C9C00BDD6D60000000000000000000000
      000000000000000000000000000000000000EFCEC600F7F7E700E7AD9C00E7AD
      9400E7AD9400DEAD9C00D6B5A500BDCEC600B5C6BD00EFC69C00FFE7C6009C6B
      6B00C6D6CE00000000000000000000000000000000000000000029ADDE00089C
      D600B5EFF7005AE7FF0063E7FF0063E7FF0063E7FF0063E7FF006BEFFF005AE7
      FF0052DEFF006BEFFF005ADEFF000094BD003139390000000000000000000000
      000000000000000000000000000000000000C6842100C6842100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ADBDBD00737B7B007B7B7B005A5A
      5A00636363009C9C9C00DEDEDE00DEDEDE00D6D6D600C6C6C600B5ADAD00AD8C
      8C00B58C8C00AD7B7B007B5A5A0039393900525A5A009CA5A500BDD6DE000000
      000000000000000000000000000000000000EFD6C600EFC6C600A56B8400B57B
      8C00A57B94009C7B94007BBDDE0073CEF70073ADE700B56B5A00FFF7CE009C6B
      6B00C6D6CE00000000000000000000000000000000000000000031B5DE00009C
      EF00ADDEEF0063F7FF006BEFFF006BEFFF006BEFFF0073F7FF0063EFFF006BC6
      E7008CC6CE0063F7FF004AD6FF005AE7FF0000314A0000000000000000000000
      000000000000000000000000000000000000C6842100C6842100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000630000000000008C9C9C00D6D6D600DEDEDE00DEDE
      DE00E7E7E700E7E7E700E7DEDE00E7DEC600EFDEBD00F7EFEF00E7D6BD00BDB5
      A500AD9C9C00B58C8C00D68C8C00C67B7B00845A5A00423939005A636300A5B5
      B50000000000000000000000000000000000F7DECE00DECED6008C84AD00C65A
      5200A5738C008C8CBD0084CEE70084FFFF008CB5DE00A5737300FFF7CE009C6B
      6B00C6D6CE00000000000000000000000000000000000000000000A5DE0018B5
      EF0063B5DE00B5FFFF006BFFFF0073FFFF0073FFFF0073FFFF006BDEEF00FFBD
      7B00FFBD730073DEEF0042DEFF00CEFFFF000073A5005A424200000000000000
      00000000000000000000000000000000000000000000C6842100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000005200007B9C7300ADB5B500DEDEDE00E7E7E700EFE7
      E700EFDED600EFE7D600F7F7EF00F7DEB500FFDEB500FFFFF700FFE7BD00F7BD
      8400DEAD7300B58C7300A5847B00BD848400DE848400DE7B7B00735252006B7B
      7B0000000000000000000000000000000000F7E7D600CECEE700738CC6003152
      7B00426394006B94D60084DEF7008CF7FF0073B5E7008C7B9400FFF7CE009C6B
      6B00C6D6CE00000000000000000000000000000000000000000031B5E70042CE
      FF000094DE00EFF7F700BDFFFF00B5FFFF00ADFFFF0073F7FF00FFBD7B00FFD6
      9400FFD69400EFC68C0039C6F700E7FFFF006BE7FF0000183900000000000000
      00000000000000000000000000000000000000000000C6842100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000063000031843100B5BDBD00BDC6C600D6D6D600DEBD
      AD00E7BD8C00F7E7C600FFF7EF00F7DEB500FFDEB500FFFFF700FFE7BD00FFC6
      8400F7AD6300EF9C4200D6843100AD7339008C6B6300B5737300A56363006373
      730000000000000000000000000000000000FFE7D600C6DEEF005A9CF7001018
      29004A8CCE00529CEF0063BDF70084EFFF0052A5EF007384A500FFF7CE009C6B
      6B00C6D6CE0000000000000000000000000000000000EFEFEF0042BDE70052D6
      FF004ACEFF0029ADE7004AB5E70063BDDE0073CEEF00CEE7F700FFDE9400FFC6
      7B00FFEF9400FFE78C00BDBD9400DEFFFF00DEFFFF00004A8400736B63000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ADC6A50008941800399442000000000000000000BDD6D600ADBD
      BD00ADB5B500ADADAD00B5B5B500DEBDAD00EFD6AD00FFF7F700FFE7BD00FFC6
      8400F7AD6300E79C4200C67B2900A56321008452290084635A008C636300636B
      6B0000000000000000000000000000000000FFEFDE00ADBDEF001042BD002142
      5200215AEF001863E700317BF7003984EF00216BF7004A63AD00FFFFCE009C6B
      6300C6D6CE0000000000000000000000000000000000A5D6EF005AC6E70063E7
      FF005ADEFF0063EFFF005AE7FF0042CEFF008C949C0084B5C600A5DEEF00F7E7
      C600FFF7BD00FFFFD600FFFFAD00FFD6AD00FFFFFF0073D6FF00002939000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000298C3100106B100000000000000000000000
      000000000000317B290008BD39004A8C42000000000000000000000000000000
      000000000000C6DEDE00BDD6D6009CA5A500A59C9C00A5A5A500C6AD9C00DEAD
      7B00AD845A007B63520063524200845A5A00BD737300C67B7B00AD7B7B00ADBD
      BD0000000000000000000000000000000000FFF7DE00A5ADF70000108400214A
      9C00214AE7001839D600316BEF00428CFF00184AF70029299C00FFFFD6009C6B
      6300C6D6CE0000000000000000000000000000000000B5D6EF0073DEEF006BF7
      FF0073F7FF0073F7FF005AEFFF00849CAD00F7E7CE00FFAD42000029CE000052
      D600106BBD007BCEE70052BDDE00ADCEDE00DEEFF700F7FFFF00006B9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000021A539004AD67B001873180000000000000000000000
      0000639C5A00089418000894180084AD7B000000000000000000000000000000
      00000000000000000000C6DEE700B5C6C600848C9C00525A5A00393939003939
      39005A42420084636300BD7B7B00AD7B7B00A5848C00A5ADAD00D6E7E7000000
      000000000000000000000000000000000000FFF7DE00ADCEFF00185AE7002173
      F7003994FF0052B5FF0063D6FF00BDFFFF0052C6FF006394D600FFF7D6009C6B
      6300C6D6CE000000000000000000000000000000000094D6E7009CE7EF007BFF
      FF007BFFFF0073F7F700739CA500F7E7E700F7941800BD9C7B006B63FF00EFF7
      EF002939CE00E7AD8C00FFFFFF00A5CEDE006BADBD00185A7300B5CEDE000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006B9C4A0021A539004AD67B0063EF9C0018A53900429C5200429C5200219C
      310008A5210008B52100087B100000000000000000000000000000000000BDD6
      DE00ADB5BD007B848C00525A5A00393939003939390052525200736B6B008C7B
      7B00A57B7B009C7B7B00847B7B00B5BDBD00C6DEE70000000000000000000000
      000000000000000000000000000000000000FFEFDE00E7EFFF000852FF002163
      FF00317BFF00429CFF004AADFF004ABDFF0039ADFF008CA5CE00FFFFDE009C6B
      6300BDD6D60000000000000000000000000000000000DEEFF7006BBDDE0094FF
      FF0073FFFF006BCED600D6CED600FFAD3100E7730000C6C6CE008CADF700949C
      F7007394FF009C735200FFE7A500FFFFFF00BDB5B500C6BDB500000000000000
      000000000000000000000000000000000000000000000000000000000000216B
      210021C663005AE784005AE78C004AD67B004AD6730021BD5A0018B5420018B5
      420008B52100007B000000000000000000000000000000000000A5ADB500525A
      5A00394242006363630084848400ADADAD00C6C6C600DEDEDE00DEDEDE008C84
      840084848400ADB5B500C6DEE700000000000000000000000000000000000000
      000000000000000000000000000000000000FFEFDE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFFFF700FFFFEF00FFFFE700FFBDCE00FFB5C600A573
      6B00C6D6DE00000000000000000000000000000000000000000063BDDE0084D6
      E700B5EFFF00DEFFFF00D6CECE00C6C6C600E76B0000ADADC600EFFFFF00EFF7
      F700A5DEFF00AD733100E7BD8C00C6CED6009C9C9C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000894
      100052E784005AE78C005AE78C0042CE730042CE730018BD4A0018BD420008A5
      2100007B000000000000000000000000000000000000C6DEDE0084848400DEDE
      DE00F7F7F700EFD6D600E7C6C600EFE7E700D6D6D600BDBDBD009CA5A500B5C6
      C600000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFEFDE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFF700FFFFF700F7D6CE00FF9C1000E77B00009C94
      8C0000000000000000000000000000000000000000000000000000000000BDDE
      EF0084CEDE005ABDDE0052BDDE00BDC6D600D6BD9C00A5520000ADCEFF0084AD
      FF0052529400D69C7300C6D6D600949494000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000031A5290018B5420042CE6B0031CE6B0018AD390000941000009410001084
      10000000000000000000000000000000000000000000D6E7E700B5B5BD00B5B5
      B500B5B5B500B5737300AD737B00ADA5A500B5BDBD00BDD6D600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFF7E700FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFE7DE00FFC663008C8C8C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F7F7F700C6C6D600D69C6B00CE630000D66B
      1000BD8C3100C6C6D60094949400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000052DE5A000894210018BD4A00187B180084D68400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFE7C600FFEFD600FFE7D600FFE7
      D600F7E7CE00F7DECE00EFDECE00EFD6CE00EFCEB500B5BDBD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E7EFEF00CEDEF700CE840000E784
      0000BDC6D6009C9C9C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000941000188C100000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DEDEDE00BDC6C600BDC6
      C6009CA5A5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005AE7520000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008CA5940094BD
      A500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BDCECE00BDCED60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007BA58400187B210018B5
      21008CBD9C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5BDB5008C9C9400398C39000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5BDB5008C9C9400398C
      39000000000000000000A5BDB5008C9C9400398C390000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B73
      CE0039299C0052527B00B5C6C600000000000000000000000000000000000000
      0000000000000000000000000000C6D6DE00848CBD0063639400000000000000
      0000000000000000000000000000000000007BA584002994390000BD000000A5
      000021B5290084BD9C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007373730018211800007B0000319C
      3900000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007373730018211800007B
      0000319C3900000000007373730018211800007B0000319C3900000000000000
      0000000000000000000000000000000000000000000000000000000000004221
      E7002900DE0031189C00848C9400000000000000000000000000000000000000
      00000000000000000000B5C6D6005242C6003110D600736BC600000000000000
      00000000000000000000000000007BAD84003194420008C6210018B5310018AD
      420000B5080021BD390084BD8C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000635263000831100039FF8400008C
      0000319431000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000635263000831100039FF
      8400008C000031943100635263000831100039FF8400008C0000319431000000
      0000000000000000000000000000000000000000000000000000000000007B73
      E7002900DE002900CE004A427300ADB5B5000000000000000000000000000000
      000000000000ADB5CE004A31CE003108DE007B73D600CEDEE700000000000000
      000000000000000000007BA5840031A5420008D6310018C64A0018C64A0018C6
      4A0021B54A0000C6290029C64A007BAD84000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000063526B001039100031F76B0039E7
      7B00008400003194310000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000063526B001039100031F7
      6B0039E77B0000840000319431001039100031F76B0039E77B00008400003194
      3100000000000000000000000000000000000000000000000000000000000000
      0000847BE7002900DE002908BD0052526B00B5BDC60000000000000000000000
      0000A5A5D6003910D6003910D6009CA5D6000000000000000000000000000000
      0000000000008CB5940042CE630029FF6B0031E76B0031DE730029D6630021CE
      5A0029D66B0031DE6B0010F75A0039DE6B007BC68C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A5BDB500316339004A735200527B5200524A52000010000029C65A0029D6
      630021DE5200007B0000398C3900000000000000000000000000000000000000
      000000000000A5BDB500316339004A735200527B5200524A52000010000029C6
      5A0029D6630021DE5200007B0000398C390029C65A0029D6630021DE5200007B
      0000398C39000000000000000000000000000000000000000000000000000000
      0000000000006352E7002900DE003118A5006B6B7B00BDCECE0000000000A5AD
      D6003918D6003918D6009494CE00000000000000000000000000000000000000
      0000000000006B947300007B1800005A0000108C2900109C310039DE730029D6
      630029CE630008AD3100006B180000A531001894310000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000052214A0010C6390018BD390018BD420021BD4A0021AD4A0029CE630029CE
      630018C6420021CE420000730000398439000000000000000000000000000000
      00000000000052214A0010C6390018BD390018BD420021BD4A0021AD4A0029CE
      630029CE630018C6420021CE4200007300003984390029CE630018C6420021CE
      4200007300003984390000000000000000000000000000000000000000000000
      000000000000CEDEEF006B5AE7002900DE00312194006B737B009494C6003918
      D6003918D6009CA5CE0000000000000000000000000000000000000000000000
      000000000000947BA50063526300635263002908210029C6520039E7730042DE
      73004AFF8400294229006342520052214A00A5ADAD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000004208006BFFAD0052FF9C004AF77B004AEF840039DE730029D6730029C6
      5A0021BD4A0018B5390010C63100007300003984390000000000000000000000
      000000000000004208006BFFAD0052FF9C004AF77B004AEF840039DE730029D6
      730029C65A0021BD4A0018B5390010C63100007300003984390021BD4A0018B5
      390010C631000073000039843900000000000000000000000000000000000000
      00000000000000000000CED6EF007363E7003108DE0031189C003110CE003918
      CE009C9CCE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007BB5940010C6420052FF94004AFF
      840031CE52007B8C7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001042100031E763005AFF940042E7730042DE7B0039D6630029CE6B0029CE
      5A0018C6420018B5390008AD290000BD0800005A000000000000000000000000
      0000000000001042100031E763005AFF940042E7730042DE7B0039D6630029CE
      6B0029CE5A0018C6420018B5390008AD290000BD0800005A000018C6420018B5
      390008AD290000BD0800005A00008CAD94000000000000000000000000000000
      0000000000000000000000000000000000005A4ADE002900DE002900D6004A42
      8C00B5C6C6000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ADADB50031B55A0039FF7B0052FF
      9C0039EF7B0052BD730052BD73000084210018943900189439000084210052BD
      7300000000000000000000000000000000000000000000000000000000000000
      0000004A100039E76B005AF794004AF7840042E7840039D6630031CE6B0029C6
      5A0018BD420018B5310008AD180000AD0000529C630000000000000000000000
      000000000000004A100039E76B005AF794004AF7840042E7840039D6630031CE
      6B0029C65A0018BD420018B5310008AD180000AD0000529C630018BD420018B5
      310008AD180000AD0000529C6300ADC6BD000000000000000000000000000000
      0000000000000000000000000000A5A5D6003110DE003108D6002908DE003118
      AD00525A7300ADB5B50000000000000000000000000000000000000000000000
      00000000000000000000000000000000000052BD730000842100189439001894
      39000084210052BD7300ADADB50031B55A0039FF7B0052FF9C0039EF7B0052BD
      7300000000000000000000000000000000000000000000000000000000000000
      00004A184A0029FF630029E7630029E7630029DE5A0031DE630031D67B0029CE
      520021BD4A0018B5310000AD080052946300A5BDB50000000000000000000000
      0000000000004A184A0029FF630029E7630029E7630029DE5A0031DE630031D6
      7B0029CE520021BD4A0018B5310000AD08005294630029CE520021BD4A0018B5
      310000AD080052946300ADC6BD00000000000000000000000000000000000000
      00000000000000000000A5ADD6003918D6003110D6008484CE009494E7004221
      DE003118B50052527B0094A5A500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007BB5940010C6420052FF94004AFF840031CE52007B8C
      7B00000000000000000000000000000000000000000000000000000000000000
      0000A5BDB5005A6363006B7373007B848C00083100002173290039E77B0029CE
      520018BD420000BD180052946300A5BDB5000000000000000000000000000000
      000000000000A5BDB5005A6363006B7373007B848C00083100002173290039E7
      7B0029CE520018BD420000BD18005294630039E77B0029CE520018BD420000BD
      180052946300ADC6BD0000000000000000000000000000000000000000000000
      000000000000A5A5D6003918D6002900DE008484CE000000000000000000B5BD
      EF004A31E7002908C60042397B00848C9400C6D6D60000000000000000000000
      000000000000000000000000000000000000000000000000000000000000947B
      A50063526300635263002908210029C6520039E7730042DE73004AFF84002942
      29006342520052214A00A5ADAD00000000000000000000000000000000000000
      0000000000000000000000000000000000006B526B000029000031D66B0029CE
      520000C6310052946300A5BDB500000000000000000000000000000000000000
      000000000000000000000000000000000000000000006B526B000029000031D6
      6B0029CE520000C63100529463000029000031D66B0029CE520000C631005294
      6300ADC6B5000000000000000000000000000000000000000000000000000000
      0000A5ADCE003910D6002908DE007373CE000000000000000000000000000000
      0000C6D6EF006B5AE7003108D60039299400737B8400CEDEDE00000000000000
      0000000000000000000000000000000000000000000000000000000000006B94
      7300007B1800005A0000108C2900109C310039DE730029D6630029CE630008AD
      3100006B180000A5310018943100000000000000000000000000000000000000
      000000000000000000000000000000000000524263001042080031EF730010D6
      4A0052945A00A5BDB50000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000524263001042080031EF
      730010D64A0052945A00524263001042080031EF730010D64A0052945A00ADBD
      B500000000000000000000000000000000000000000000000000000000009494
      CE003918CE002900DE005A4AC600C6D6DE000000000000000000000000000000
      000000000000CEDEEF008C84E7002908DE006B63B500CEDEDE00000000000000
      0000000000000000000000000000000000000000000000000000000000008CB5
      940042CE630029FF6B0031E76B0031DE730029D6630021CE5A0029D66B0031DE
      6B0010F75A0039DE6B007BC68C00000000000000000000000000000000000000
      0000000000000000000000000000000000005A425A001852210021FF7300528C
      5A00A5BDB5000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005A425A001852210021FF
      7300528C5A00A5BDB5005A425A001852210021FF7300528C5A00A5BDB5000000
      0000000000000000000000000000000000000000000000000000ADB5E7003110
      DE002900DE005239C600BDCED600000000000000000000000000000000000000
      0000000000000000000000000000C6CEEF00CEDEE70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007BA5840031A5420008D6310018C64A0018C64A0018C64A0021B54A0000C6
      290029C64A007BAD840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B737B00217B2900398C4A00A5BD
      B500000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B737B00217B2900398C
      4A00A5BDB500000000007B737B00217B2900398C4A00A5BDB500000000000000
      00000000000000000000000000000000000000000000000000008C7BE7002900
      DE003918D600B5BDCE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007BAD84003194420008C6210018B5310018AD420000B5080021BD
      390084BD8C000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5BDB5009CC6B5009CC6B5000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5BDB5009CC6B5009CC6
      B5000000000000000000A5BDB5009CC6B5009CC6B50000000000000000000000
      0000000000000000000000000000000000000000000000000000BDC6EF008C84
      E700B5B5E7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007BA584002994390000BD000000A5000021B5290084BD
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007BA58400187B210018B521008CBD9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008CA5940094BDA500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000AD5252008C00000094080000A54A4A000000000000000000000000000000
      0000A54A4A009408000094080000AD524A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000398C39008C9C9400A5BDB500000000000000
      0000398C39008C9C9400A5BDB500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000398C39008C9C9400A5BDB5000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CEB5
      9C00A5310800A5311800AD524A009C180800B56B5A000000000000000000AD6B
      63009C180800AD524A00A5290800AD310800C6A59C0000000000000000000000
      0000000000000000000000000000000000000000000000000000EFDEDE009463
      5200B57B7300BD7B7300BD7B7300BD7B7300BD7B7300BD7B7300BD7B7300BD7B
      7300BD7B73007B39390000000000000000000000000000000000000000000000
      00000000000000000000319C3900007B0000182118007373730000000000319C
      3900007B00001821180073737300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000319C3900007B000018211800737373000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6A5
      94009C210000C67B6B00CEBDBD00B56B5A009C18080000000000000000009429
      1000B56B5A00CEBDBD00C6735A009C180000C69C8C0000000000000000000000
      000000000000000000000000000084CEEF006BC6E7006BC6E70073ADC600AD7B
      7300EFCEBD00FFD6CE00FFD6CE00FFD6CE00FFD6CE00FFD6CE00FFD6CE00FFD6
      CE00FFD6BD008C4A420000000000000000000000000000000000000000000000
      00000000000031943100008C000039FF8400083110006352630031943100008C
      000039FF84000831100063526300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003194
      3100008C000039FF840008311000635263000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CEAD
      9C00AD310800B5523100CEBDBD00C6948C0094100000CEBDBD00CEBDBD009410
      0000C6948C00CEBDBD00B55A3100AD310800CEAD9C0000000000000000000000
      0000000000000000000063BDDE0018A5DE0031CEF70039DEF7004ABDD600B584
      7300EFDED600FFDEBD00FFDEB500FFD6AD00FFCEA500FFCEA500FFCEA500FFD6
      BD00FFDEC6008C4A420000000000000000000000000000000000000000000000
      0000319431000084000039E77B0031F76B0010391000319431000084000039E7
      7B0031F76B001039100063526B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000319431000084
      000039E77B0031F76B001039100063526B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B56B630094100000B54A2100B53910009C180000CEBDBD00CEBDBD009C10
      0000AD391000AD4A2100AD210000B56B63000000000000000000000000000000
      0000000000000000000018ADDE005AE7FF004AC6FF004AC6FF005AB5DE00BD94
      8400EFDED600FFCE9C00FFC68C00FFC68C00FFC68C00FFC68C00FFC68C00FFD6
      AD00FFDEC600945A4A000000000000000000000000000000000000000000398C
      3900007B000021DE520029D6630029C65A00398C3900007B000021DE520029D6
      630029C65A0000100000524A5200527B52004A73520031633900A5BDB5000000
      00000000000000000000000000000000000000000000398C3900007B000021DE
      520029D6630029C65A0000100000524A5200527B52004A73520031633900A5BD
      B500000000000000000000000000000000000000000000000000000000000000
      0000CEB5A500AD4A3100AD180000AD1800009C100000BD8C7B00BD948C009C10
      0000A5180000A5180000B5523100CEB5A5000000000000000000000000000000
      0000000000000000000018ADDE005AE7FF004ACEFF004ACEFF0063BDDE00CE9C
      8C00F7E7D600FFE7D600FFE7D600FFE7D600FFE7CE00FFE7CE00FFE7CE00FFE7
      D600FFDEC600945A4A0000000000000000000000000000000000398439000073
      000021CE420018C6420029CE6300398439000073000021CE420018C6420029CE
      630029CE630021AD4A0021BD4A0018BD420018BD390010C6390052214A000000
      000000000000000000000000000000000000398439000073000021CE420018C6
      420029CE630029CE630021AD4A0021BD4A0018BD420018BD390010C639005221
      4A00000000000000000000000000000000000000000000000000000000000000
      000000000000D6C6C600BD8C8C00AD6B630094211000843921007B4229009C21
      0800B56B5A00BD8C8C00CEC6C600000000000000000000000000000000000000
      0000000000000000000018ADDE0063EFFF0052D6FF0052D6FF0063C6DE00CE9C
      8C00F7E7D600FFD6A500FFCE9400FFCE9400FFCE9400FFC68C00FFC68C00FFD6
      AD00FFDEC600945A4A00000000000000000000000000398439000073000010C6
      310018B5390021BD4A00398439000073000010C6310018B5390021BD4A0029C6
      5A0029D6730039DE73004AEF84004AF77B0052FF9C006BFFAD00004208000000
      0000000000000000000000000000398439000073000010C6310018B5390021BD
      4A0029C65A0029D6730039DE73004AEF84004AF77B0052FF9C006BFFAD000042
      0800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CECECE0084635200C6A59C009C8C84007B52
      3900BDBDB5000000000000000000000000000000000000000000000000000000
      0000000000000000000021ADDE007BFFFF0063F7FF0063F7FF007BDEDE00DEB5
      8C00FFF7EF00FFF7EF00FFF7E700FFF7E700FFF7E700FFF7E700FFF7E700FFEF
      D600FFD6AD00A563520000000000000000008CAD9400005A000000BD080008AD
      290018B5390018C64200005A000000BD080008AD290018B5390018C6420029CE
      5A0029CE6B0039D6630042DE7B0042E773005AFF940031E76300104210000000
      0000000000000000000000000000005A000000BD080008AD290018B5390018C6
      420029CE5A0029CE6B0039D6630042DE7B0042E773005AFF940031E763001042
      1000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEE7EF00AD9C94009C8C73009C84730073524200947B
      6B00A59C9400DEE7EF0000000000000000000000000000000000000000000000
      0000000000000000000029ADDE009CFFFF007BFFFF007BFFFF008CEFE700EFC6
      9C00FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFEF00EFDEC600A56B
      4A00AD6B4A00AD735A000000000000000000ADC6BD00529C630000AD000008AD
      180018B5310018BD4200529C630000AD000008AD180018B5310018BD420029C6
      5A0031CE6B0039D6630042E784004AF784005AF7940039E76B00004A10000000
      0000000000000000000000000000529C630000AD000008AD180018B5310018BD
      420029C65A0031CE6B0039D6630042E784004AF784005AF7940039E76B00004A
      1000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CECECE00947B7300A59C94008C7363009C7B7B00A58C
      84008C736B00CECECE0000000000000000000000000000000000000000000000
      0000000000000000000029ADDE00ADFFFF0084FFFF007BFFFF009CEFE700F7CE
      9C00FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFDEC600BD7B
      5200E7A56B00E7C6B500000000000000000000000000ADC6BD005294630000AD
      080018B5310021BD4A0029CE52005294630000AD080018B5310021BD4A0029CE
      520031D67B0031DE630029DE5A0029E7630029E7630029FF63004A184A000000
      0000000000000000000000000000A5BDB5005294630000AD080018B5310021BD
      4A0029CE520031D67B0031DE630029DE5A0029E7630029E7630029FF63004A18
      4A00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B5ADA5009C8C840094847B00BDBDB500CEC6C600947B
      6B009C847B00ADA59C0000000000000000000000000000000000000000000000
      0000000000000000000029ADDE00ADFFFF0094FFFF008CFFFF00A5EFE700E7B5
      8400E7BD9C00E7BDA500E7BDA500E7BDA500E7BDA500E7BD9C00D6AD8C00B584
      6300EFCEBD000000000000000000000000000000000000000000ADC6BD005294
      630000BD180018BD420029CE520039E77B005294630000BD180018BD420029CE
      520039E77B0021732900083100007B848C006B7373005A636300A5BDB5000000
      000000000000000000000000000000000000A5BDB5005294630000BD180018BD
      420029CE520039E77B0021732900083100007B848C006B7373005A636300A5BD
      B500000000000000000000000000000000000000000000000000000000000000
      00000000000000000000947B7300BDB5AD00ADA5A5000000000000000000ADA5
      9C00B5A59C00846B520000000000000000000000000000000000000000000000
      0000000000000000000031ADDE00CEFFFF00ADFFFF00ADFFFF00B5FFFF00BDEF
      E700BDEFDE00BDEFDE00BDEFDE00BDEFDE00BDEFDE00BDEFDE00ADDEDE005AA5
      CE00ADCEE700000000000000000000000000000000000000000000000000ADC6
      B5005294630000C6310029CE520031D66B00002900005294630000C6310029CE
      520031D66B00002900006B526B00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5BDB5005294630000C6
      310029CE520031D66B00002900006B526B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D6DEDE00947B6B00A59C8400CECEC6000000000000000000D6D6
      D600A5948400A58C8400D6D6DE00000000000000000000000000000000000000
      0000000000000000000031ADDE00E7FFFF009CCEDE00948484009C7B73009C7B
      73009C7B73009C7B73009C7B73009C7B73008C736B0063ADD600BDF7FF0042AD
      DE009CCEE7000000000000000000000000000000000000000000000000000000
      0000ADBDB50052945A0010D64A0031EF7300104208005242630052945A0010D6
      4A0031EF73001042080052426300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5BDB5005294
      5A0010D64A0031EF730010420800524263000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C8C7B008C735A00B5ADA5000000000000000000000000000000
      0000B5B5B5008C7363008C736B00000000000000000000000000000000000000
      0000000000000000000073C6EF00A5E7F7009CC6C600B5A5A500CEC6BD00E7DE
      DE00E7DEDE00E7DEDE00E7DEDE00CEBDB5008C847B00189CC60094DEEF0052AD
      DE00000000000000000000000000000000000000000000000000000000000000
      000000000000A5BDB500528C5A0021FF7300185221005A425A00A5BDB500528C
      5A0021FF7300185221005A425A00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A5BD
      B500528C5A0021FF7300185221005A425A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000846B5A00846B6300000000000000000000000000000000000000
      000000000000948473006B524200000000000000000000000000000000000000
      000000000000000000000000000073CEEF0031B5DE003994B500AD948400D6CE
      C600D6CEC600D6CEC600D6C6BD00949C9C003984A500089CCE0042BDDE00C6DE
      EF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A5BDB500398C4A00217B29007B737B0000000000A5BD
      B500398C4A00217B29007B737B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A5BDB500398C4A00217B29007B737B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000063524200CED6D600000000000000000000000000000000000000
      000000000000D6DEDE00735A4A00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008C6B6300947B
      6B00947B6B00947B6B0094736B00ADA59C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009CC6B5009CC6B500A5BDB500000000000000
      00009CC6B5009CC6B500A5BDB500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009CC6B5009CC6B500A5BDB5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DECE9C009C5A000094521000AD7B4A00D6BDAD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BD730000D6BDAD0000000000DECEBD00945A18009C84
      6300AD8473009C84730094847300000000000000000000000000000000000000
      0000000000000000000000000000E7CECE005A42390039211800393121008C8C
      8400BDB5B5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00D6FFD600FFF7FF00ADADAD009C949400424242006B31
      21005A5A5200BDBDBD00A5949C00D6FFD6007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F7BD63007B4A0000000000009484730094520000DE7B0000FF9C
      1000FFAD1800FFBD3900FFCE52009C733900947B730000000000000000000000
      0000000000000000000000000000ADBDBD00EF848400CE5A6300AD6B6B002118
      08006B5A5A00423129008C948C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B00E7D6E700FFFFFF00E7E7E7008C8C8C00ADADAD005A5A5A000000
      00001018180031292900635A5A00B5A5B500ADBDAD007B7B7B00000000000000
      00000000000000000000000000000000000000000000A5736B009C635A00A563
      5A00A5635A00A5635A00A5635A00A5635A00A5635A00A5635A00A5635A00A563
      5A00844239000000000000000000000000000000000000000000000000000000
      000000000000F7BD6300945A000094633900F7841000FF9C0000FF9C0000FF94
      0000FF940000FFAD1000FFCE3100FFF77300FFDE7B00947B5200000000000000
      0000000000000000000000000000B5BDBD00D67B8400CE524A00AD636300C6DE
      DE007B8C8C00424239004A3131004A393100848C7B00C6C6C600000000000000
      00000000000000000000000000000000000000000000000000007B7B7B00CEEF
      CE00FFFFFF00EFF7F700EFE7E700F7F7F700A5A5A500949494008C9494007373
      73006363630031313100181818005A5A5A00A5A5A500ADA5AD007B7B7B000000
      00000000000000000000000000000000000000000000AD846B00DEBDB500FFCE
      C600FFCEC600FFCEC600FFCEC600FFCEC600FFCEC600FFCEC600FFCEC600FFCE
      BD00A56B5A000000000000000000000000000000000000000000000000000000
      000000000000E7BD7300E7940000E7840000FFAD0000FF940000FF840000FF84
      0000E7730000F77B0000FF940000FFB51000FFE76300FFF7940084634A000000
      0000000000000000000000000000B5BDBD00D67B8400CE52520094525200F7E7
      E700FFD6DE00FFFFFF00BDCED6009C9C9C004A3131003939310042423100737B
      630000000000000000000000000000000000000000007B7B7B00FFFFFF00FFFF
      FF00FFFFF700FFFFFF00D6CECE0063636300393939005A5A5A00B5B5B500BDBD
      BD00B5ADAD00BDBDBD00A5A5A50073737300000000004A394A007B7B7B000000
      00000000000000000000BD949400BD949400BD949400A56B5A00E7C6B500FFE7
      D600FFE7CE00FFE7CE00FFDEC600FFDEC600FFDEC600FFD6B500FFD6BD00FFE7
      CE00A56B5A000000000000000000000000000000000000000000000000000000
      00000000000000000000FFBD0000FFB50000FF9C0000FF940000F78400009463
      310000000000CEB59C00D6730000FF940000FFB51000FFF77300D6AD5A00B5B5
      AD00000000000000000000000000B5BDBD00D6848400CE525200AD6B6B009C84
      8400BD292900FFE7E700FFFFFF00F7FFFF00E7ADA500844A42009C5A5A003110
      1000ADBDB500000000000000000000000000000000007B7B7B00FFFFFF00F7EF
      EF00D6D6D600393939006B6B6B00CECECE009C9C9C0063636300313131004242
      42006363630094949400A5ADA500CECECE00F7F7F700BDB5B5007B7B7B000000
      000000000000000000009C635A00EFADA500EFADA500B5736B00E7C6B500FFDE
      BD00FFC68C00FFC68C00FFC68400FFC68400FFC68400FFBD8400FFC69400FFE7
      CE00A56B5A000000000000000000000000000000000000000000000000000000
      00000000000000000000F7BD5200FFBD0000FF9C0000F7940000AD5A00000000
      00000000000000000000CEB59C00CE945A00CE945A00D6AD7300D6BD9400B5B5
      AD00000000000000000000000000B5BDBD00D6848400CE525200A5636300B5A5
      A500A5312900E7C6CE00FFFFFF00FFFFFF00E7A5A5007B393100F76B7B005A31
      2900A5B5B500000000000000000000000000000000007B7B7B00BDADB5006363
      6300635A6300FFFFFF00DEDEDE00C6C6C600E7DEDE00DEDEDE00B5B5B500ADAD
      AD007B7B7B004A52520052524A00736B73007B847300317331007B7B7B000000
      00000000000000000000A5736300F7E7DE00FFE7D600BD847B00DECEC600F7E7
      DE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFEFCE00F7E7D600FFE7
      CE00AD7B63000000000000000000000000000000000000000000000000000000
      00000000000000000000DED6BD00FFBD1000FFA50000FF9C0000C67300009C52
      00009C5200009C5200009C5200009C5200009C520000AD5A0000AD731000B594
      7300000000000000000000000000B5BDBD00D68C8C00C6524A00AD7B7B00E7CE
      C600840000009C847B00E7EFF700FFFFFF00F7B5AD007B393100DE6B6B005A31
      2900ADBDB500000000000000000000000000000000007B7B7B008C848400D6D6
      D600FFFFFF00BDBDBD00B5ADAD00E7E7E700BDBDBD00B5ADAD00CECECE00C6C6
      C600DED6D600E7DEDE00CECECE008484840063636300634A63007B7B7B000000
      00000000000000000000AD7B6300FFDEC600FFCE9C00CE8C6B00EFDEC600FFDE
      BD00FFC68C00FFC68C00FFC68C00FFC68C00FFC68C00FFC68400FFCE9400FFE7
      CE00AD7B63000000000000000000000000000000000000000000000000000000
      000000000000ADBDBD00A59C8C00AD9C6300C6940000CE7B0000CE7B0000E78C
      0000F7940000F7940000FF940000FF840000FF940000FF9C0000FFB53100CE9C
      7300000000000000000000000000B5BDBD00D68C8C00CE524A009C635A00FFFF
      FF00DE8C9400AD9CA500ADADAD00F7FFFF00F7BDC6007B313100DE6B6B005A31
      2900ADBDB500000000000000000000000000000000007B7B7B00FFFFFF00D6D6
      D600C6BDBD00ADADAD00E7E7E700BDBDBD00ADADAD00D6D6D600C6C6C6009494
      94009C9C9C00A5A5A500A5A5A500DEDEDE00FFFFFF00C6BDCE007B7B7B000000
      00000000000000000000AD7B6300FFE7CE00FFD6B500CE8C7300EFDED600FFE7
      CE00FFD6B500FFD6B500FFD6B500FFD6B500FFD6B500FFD6B500FFDEBD00FFE7
      CE00B5846B0000000000000000000000000000000000000000009CADAD003173
      3900317339003173390031733900317339003173390031733900317339008C73
      4A00B58C6300B5946300BD843100FF940000FF840000FF9C0000F79C1000D6BD
      AD00000000000000000000000000B5BDBD00D68C8C00CE5A5A009C524A00847B
      7B00BDCED600D6E7E7009CADA50094B5B500F7ADAD0084424200DE6B6B005A31
      2900ADBDB50000000000000000000000000000000000000000007B7B7B00CECE
      CE00BDBDBD00EFEFEF00A5A5A500D6D6D600FFFFFF00F7F7F700F7F7F700EFEF
      EF00EFE7E700CECECE00A59C9C0084848400948C94007B7B7B00000000000000
      00000000000000000000BD847B00FFEFD600FFDEB500DE9C7300EFE7DE00FFEF
      DE00FFDEB500FFDEB500FFDEB500FFDEB500FFDEB500FFDEB500FFDEBD00FFE7
      CE00BD84730000000000000000000000000000000000BDCECE004A9C52004A9C
      5200319439003194390031843900318439003184390031733900317339005A31
      180000000000D6BDAD00DE7B0000F7940000FF940000FF9C0000DE7B10000000
      0000000000000000000000000000B5BDBD00D6949400C65A5A00D6636B00B539
      3900B5393900AD424200A5525A008C5A5A0084525200734A4A00EF6B73005A31
      2900ADBDB5000000000000000000000000000000000000000000000000007B7B
      7B00949C94009C9C9C00BDBDC60094949400CEC6C600FFFFFF00EFEFEF00F7F7
      F700F7F7F700FFF7FF00FFF7F700FFF7F7007B7B7B0000000000000000000000
      00000000000000000000BD8C7B00FFE7C600FFCE9400DE9C6B00EFE7DE00FFE7
      D600FFCE9400FFCE9400FFCE9400FFCE9400FFCE9400FFCE8C00FFCE9C00FFE7
      CE00BD84730000000000000000000000000000000000847B9C000029000000FF
      520000E74A0000D6180000BD180000BD000000B50000009C000031733900B584
      0000BD730000DE840000FF9C0000F79C0000FF9C0000FFAD1000CE9C73000000
      0000000000000000000000000000B5B5BD00DE949400CE524A008C525200A58C
      8400A5737300A55A5A00A54A4200BD4A4A00AD394200CE5A5A00EF7373005A29
      2900ADBDB5000000000000000000000000000000000000000000000000000000
      00007B7B7B00FFFFFF00D6D6D600848C8C008C8C94007B848C008C8C8C00A59C
      A500BDBDBD00C6B5BD007B7B7B007B7B7B000000000000000000000000000000
      00000000000000000000CE948400FFF7EF00FFEFDE00E7AD7B00FFEFDE00FFFF
      FF00FFFFFF00FFFFFF00FFFFF700FFFFEF00FFFFE700FFF7E700FFE7CE00FFC6
      B500BD7B6B0000000000000000000000000000000000BDD6CE00311839000018
      000000E74A0000D6520000CE290000BD180000AD000000AD000031733900CEBD
      3900FFDE2100FFBD0000FFB50000FFB50000FFAD0000D694390000000000DECE
      B500000000000000000000000000B5BDBD00DE9C9400CE524A008C525200E7FF
      FF00DEEFF700DEEFEF00DEE7E700C6BDBD00ADA59C008C525200E76B6B005A31
      2900ADBDB5000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00FFE7B500FFD6A500DEC6B500DEC6AD00CEC6C600C6CE
      C600A5949C007B7B7B0000000000000000000000000000000000000000000000
      00000000000000000000D6A58400FFEFD600FFC68C00E7A57300FFEFDE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFEF00FFFFE700C6947300C67B
      6B00AD6B5200000000000000000000000000DEEFEF00B5C6CE00BDCECE001800
      18000052000000E7520000D64A0000CE290000B5180000B5000031733900CEC6
      5200FFFF5200FFDE2900FFD61800E7B52900CE944A000000000000000000DEAD
      5200000000000000000000000000B5BDBD00DE9C9400CE524A008C5A6300D6D6
      D600CECECE00CECECE00DED6DE00D6E7E700FFFFFF0094847B00DE5A52005A31
      2900ADBDB5000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00FFDEA500FFC68C00FFCE8C00FFD6A500FFD69C00FFEF
      B5007B7B7B000000000000000000000000000000000000000000000000000000
      00000000000000000000DEAD8400FFFFF700FFF7E700EFBD8C00FFF7E700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700AD734A00D694
      5200C68C7B00000000000000000000000000318439005A636300949C9C000073
      000010DE520010DE520000DE520000CE390000BD290000BD000031733900AD9C
      7B00E7D6A500E7D6AD00F7CE7300D69C4A00CE9C730000000000D6BDAD00CE9C
      4A00000000000000000000000000B5BDBD00DE9CA500CE524A008C525200D6D6
      D600C6C6C600C6C6C600CECECE00CEC6CE00E7EFEF00947B7B00DE5A52005A31
      2900ADBDB5000000000000000000000000000000000000000000000000000000
      00007B7B7B00FFBD7B00FFD6A500FFCE9C00FFCE9C00FFCE9C00FFCE9400FFC6
      A5007B7B7B000000000000000000000000000000000000000000000000000000
      00000000000000000000E7AD8C00FFFFFF00FFFFFF00EFBD8C00F7E7CE00F7EF
      DE00F7EFDE00F7E7DE00F7E7DE00F7E7DE00EFDED600E7D6CE00AD6B5200DEAD
      8C0000000000000000000000000000000000006310000094000000DE520031FF
      730018FF630018E75A0000D64A0000E7630000D6390000CE1000317339000000
      0000000000000000000000000000DED6BD00DECE8400D6843100DE9C3900D6CE
      B500000000000000000000000000B5BDC600EFA5AD00CE4A42008C4A4A00E7E7
      EF00D6D6D600CECECE00CEC6CE00BDBDBD00E7EFEF00947B7B00DE5A52005A31
      2900ADBDB5000000000000000000000000000000000000000000000000000000
      00007B7B7B00FFFFCE00FFD6BD00FFDEBD00FFDEBD00FFDEBD00FFEFC600DEB5
      9C007B7B7B000000000000000000000000000000000000000000000000000000
      00000000000000000000E7B58C00FFFFFF00FFFFFF00F7D6BD00E7BDA500E7BD
      A500E7BD9C00E7BD9C00C6845A00DE9C5A00D69C7300E7BD9C00CEAD9C000000
      0000000000000000000000000000000000000063100063FFBD0052FF9C0031FF
      840031FF730029FF7B0018FF5A000084000000E75A0000E73100317339000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B58C8C00BD63630094736B00DEDE
      E700F7F7F700F7EFF700EFEFEF00FFF7FF00FFFFFF008C6B6B00DE4A4A005221
      0800ADB5BD000000000000000000000000000000000000000000000000000000
      00007B7B7B00FFFFE700FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFF7DE007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EFBD8C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFEF00AD734A00E7A56B00E7C6B50000000000000000000000
      000000000000000000000000000000000000180000000052000029D65A0029FF
      630010FF5A0000BD290010943100290010000039000000F74A00317339000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      B500BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00C6ADA500D69C94008484
      8400000000000000000000000000000000000000000000000000000000000000
      00007B7B7B00FFF7E700FFEFDE00FFEFDE00FFEFDE00FFF7DE00FFEFE7007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E7AD7300DEAD8400DEAD8400DEAD8400DEAD8400DEAD
      8400DEAD8400DEA57B00AD735A00EFCEBD000000000000000000000000000000
      000000000000000000000000000000000000ADB5B500524A5A0000100000004A
      1000185A29007B9C940000000000000000003929390000630000317339000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7FFF7007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000050000000F00000000100010000000000400B00000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      E7CFFFFFFFFCFFFFFFFF0000C7C7FFFFFFF863FFE00100008003FFFFFFF803FF
      E00000000001FC0003FC07FF800000000001FC0003F00FFF8000000080027C00
      03E003FF00000000C7C43C0003E000FE00000000E7C81C0003E000FC00000000
      FFF00C0003E000FC00000000FFF00C0003E000F800000000FFFC3C0003E000F8
      00000000FFFC3C0003E000F800000000FFFC3C0003E000F800000000FFFC3C00
      03E000FC00010000FFFC3C0003C000FE00030000FFF00C000380007E00070000
      FFF00E000780003C03FF0000FFF81FFFFF80003C47FF0000FFFC3FFFFFC00078
      1FFF0000FFFE7FFFFFFF3FFFFFFF0000C0007C0007C0007FFFFF000080007800
      0780007111010000800078000780007111010000800078000080000110010000
      C0007C0000C0000FFC010000C0007C0007C0007100010000C0007C0007C00070
      00010000C0007C0007C0007000010000C0007C0007C0007000010000C0007C00
      07C0007000010000C0007C0007C0007000010000C0007C0007C0007000010000
      C0007C0007C0007000070000C0007C0007C0007000010000C0007C0007C00070
      00010000C0003C0007C000700001000080001C0007C00070000F0000C0003C00
      0FC000F000110000C000FC001FC001F000110000C003FC003FC003F001110000
      FFFFFFFFFFC0007C00070000FFFFF003FF80007800030000FFFFF003FF800078
      00030000FE001003FF80007800010000FE001803FFC0007C0001000000001803
      FFC0007C0007000000001803E7C0007C0007000000001003C3C0007C00070000
      00001003C1C0007C000700000000100261C0007C00070000C600186400C0007C
      000100008000183C00C0007C0001000000001C3C00C0007C0003000000001E7C
      01C0007C0003000080001FFC01C0007C0007000000003FFC01C0007C00070000
      00007FFC00C0007C0003000001FFFFFC00C000F80001000001FFFFFC00C001FC
      0003000001FFFFFFFFC003FC000F0000FFFFFFFFFFFFFFFFFFFF0000C07FFFC0
      7FFFFFFFFFFF0000C003FF800FFFFFFE7FFF0000C000FE000FFC003C40030000
      C000FC000FE0003800030000C0007C0003C0003000030000C0007C0001C00030
      00030000C0003C0E01C0003800030000C000380F03C0003C400300008000180F
      81C0003E400300008000180F81C000304003000080001C0F81C0003040030000
      80001C0703C00070400300008000380001C0007040030000C0007C0001C00070
      40030000E000FF0003C000F040070000FE01FF0007E000F0400F0000FF03FF80
      0FFC0FF07FFF0000FF87FFE01FFFFFF07FFF0000FFFFFFFFFFFFFFF07FFF0000
      FE007FFFFFF803FFFFFF0000FC003C0003E000FFFFFF0000F800180001C0007F
      FFFF0000F00008000180003E001F0000F00008000180001E001F0000F0000800
      0100001E001F0000000018000100000E001F0000000008000100000E001F0000
      000008000100000E001F0000000008000100000E001F0000000008000100000E
      001F0000000018000100000E001F0000000018000100000E001F00000000F800
      0100000E001F00000001F8000100001E001F00000001F8000100001E003F0000
      0001F8000180003E007F00000001F80001C0007FFFFF00000003FC0003E000FF
      FFFF00000007FFFFFFF001FFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFE7FFBF
      FFC07FFFBFFF0000F8007F9FFFC003FF9FFF0000F8007F8001C000FF80030000
      C0007800018000F800030000C00038000180007800030000C000380001800078
      00030000C00038000180003800030000C0003E0001C0003F80030000C0003E00
      0180001F80030000C0003E000180001F80030000C0003E000180001F80030000
      C0003E000180001F80030000C0003E000380003C00030000C000FE0007C0007C
      00030000C001FE0007E000FC00030000C007FE000FFE01FC00030000C00FFF03
      FFFF03FF80070000FFFFFFFFFFFF87FF800F0000FFFFFFFFFFFFFFFFFFFF0000
      FFFFFFFFFFF9F9FFFFFF0000E0081FFFFFF1F8FFFFFF0000F3E81FFFE7E0007F
      FFFF0000FCE83FFCC3C0003FE7FF0000FF283FF081C0003FE1FF0000FFC87FC0
      00E0007F207F0000BFF87F0000F1F8FE001F00003FF8FC00C3F9F9FC00070000
      3FF8F800C3E0607C000300001FF9FFFFC3EF607807FF00001E79FFFFC3F760F0
      03FF00000E3BF800C3F760FE00030000800FFCFEC3FB61FE13FB0000C007FF3E
      00FB61FE1CFB0000E007FFCE00FD63FF0F3B0000F00FFFF281FD63FF83CB0000
      FC1FFFFCC3FE67FFC0730000FE7FFFFFE7FE67FFE0FF0000FEFFFFFFFFFF6FFF
      FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFF
      FFC07FF810070000FF1FFF000FC003F817CF0000FC07FF0007C000FC173F0000
      F801FF0007C000FC14FF000080007F0007C0007E13FF000000001F0007C0007E
      1FFD000000000F0007C0003F1FFC000000000F0007C0003F1FFC000000000F00
      0780001F9FF80000C0000F000780001F9E780000F8000F000780001FDC700000
      FC001F000780001FF0010000E0007F000780003FE0030000C001FF0007C0007F
      E0070000800FFF000FE000FFF00F0000803FFF001FFE01FFF83F0000FFFFFF00
      3FFF03FFFE7F0000FFFFFFFFFFFF87FFFF7F0000FFFFFFFFFFFFFFFFFFFF0000
      FFFFFFFFFFFFFFFFCFFF0000FFFFFFFFFFF3FFFF87FF0000FF1FFF8C7FE1FE3F
      03FF0000FF0FFF843FE1FC3E01FF0000FF07FF801FE0F83C00FF0000FF03FF80
      0FF070F8007F0000F001F80007F821F8007F0000F000F80003F803F8007F0000
      F000780001FC07FF03FF0000F000780000FF07FF000F0000F000780000FE03FF
      000F0000F000780001FC01FFFC0F0000F000F80003F8607FE0010000FF01FF80
      07F0F03FE0010000FF03FF800FE0F83FE0010000FF07FF801FC1FE7FF0030000
      FF0FFF843FC3FFFFF8070000FF1FFF8C7FC7FFFFFC0F0000FFFFFFFFFFFFFFFF
      FE1F0000FFFFFFFFFFFFFFFFFF3F0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFF
      FFFFFFFFFFFF0000F0F0FFFFFFFE31FFF8FF0000E0607FC003FC21FFF0FF0000
      E0607E0003F801FFE0FF0000E0007C0003F001FFC0FF0000F000FC0003E0001F
      800F0000F000FC0003C0001F000F0000F801FC000380001E000F0000FE07FC00
      0300001E000F0000FC03FC000300001E000F0000FC03FC000380001E000F0000
      FC03FC0007C0001F000F0000FC63FC0007E001FF80FF0000F861FC0007F001FF
      C0FF0000F8F1FC000FF801FFE0FF0000F9F9FE000FFC21FFF0FF0000F9F9FFC0
      FFFE31FFF8FF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000
      FC1FFFFFFFFC00FFFFFF0000FC81FE07FFF8007FFFFF0000F9007E01FFE0003F
      80070000F8003E003FC0001F80070000F8001E000F80001C00070000FC080E00
      0780001C00070000FC1C0E000780001C00070000FC000E000780001C00070000
      F8000E000780001C00070000C0000E0007C0003C0007000080081E0007E0007C
      0007000080001E0007F000FC0007000080002E0007F803FC0007000000006E00
      07F807FC0007000000004E0007F007FC000F0000001E0E0007F007FC001F0000
      001FFF0007F00FFC007F0000001FFFE00FF00FFC00FF0000031FFFFFFFE00FFF
      FFFF0000FFFFFFFFFFE01FFFFFFF000000000000000000000000000000000000
      000000000000}
  end
  object ActList: TActionList
    Images = ActImgLst
    Left = 456
    Top = 208
    object NewAct: TAction
      Tag = -3
      Caption = '&Nowy'
      Hint = 'Tworzy nowy plik'
      ImageIndex = 27
      ShortCut = 16462
    end
    object OpenAct: TAction
      Tag = -3
      Caption = 'Otw'#243'rz'
      Hint = 'Otwiera istniej'#261'cy plik lokalny'
      ImageIndex = 14
      ShortCut = 16463
    end
    object SaveAct: TAction
      Tag = -3
      Caption = 'Zapisz i wy'#347'lij do systemu el-Dok'
      Hint = 'Wysy'#322'a plik do systemu el-Dok'
      ImageIndex = 0
      ShortCut = 16467
    end
    object SaveAsAct: TAction
      Tag = -2
      Caption = 'Zapisz kopi'#281' lokalnie'
      Hint = 'Zapisuje kopi'#281' pliku w podanej lokalizacji na tym komputerze'
      ImageIndex = 1
      ShortCut = 49235
    end
    object PrintPagesAct: TAction
      Tag = -2
      Caption = 'Drukuj...'
      Hint = 'Drukuje wybrane strony'
      ImageIndex = 2
      ShortCut = 16464
    end
    object CopyAct: TAction
      Tag = -2
      Caption = 'Kopiuj'
      Hint = 'Kopiuje obraz strony do schowka'
      ImageIndex = 3
      ShortCut = 16451
    end
    object CutAct: TAction
      Tag = -3
      Caption = 'Wytnij'
      Hint = 'Wycina obraz strony do schowka'
      ImageIndex = 4
      ShortCut = 16472
    end
    object PasteNewAct: TAction
      Tag = -3
      Caption = 'Jako now'#261' stron'#281
      Hint = 'Wkleja obraz ze schowka jako now'#261' stron'#281
      ImageIndex = 5
      ShortCut = 16470
    end
    object PasteReplaceAct: TAction
      Tag = -3
      Caption = 'Zamie'#324' bie'#380#261'c'#261' stron'#281
      Hint = 'Wkleja ze schowka zast'#281'puj'#261'c bie'#380#261'c'#261' stron'#281
      ImageIndex = 5
      ShortCut = 24662
    end
    object CloseAct: TAction
      Tag = -2
      Caption = 'Zamknij'
      Hint = 'Wychodzi do systemu el-Dok'
      ImageIndex = 25
      ShortCut = 32883
    end
    object FirstPageAct: TAction
      Tag = -2
      Caption = 'Pierwsza'
      Hint = 'Wy'#347'wietla pierwsz'#261' stron'#281
      ImageIndex = 6
      ShortCut = 16420
    end
    object NextPageAct: TAction
      Tag = -2
      Caption = 'Nast'#281'pna'
      Hint = 'Wy'#347'wietla nast'#281'pn'#261' stron'#281
      ImageIndex = 8
      ShortCut = 16418
    end
    object PrevPageAct: TAction
      Tag = -2
      Caption = 'Poprzednia'
      Hint = 'Wy'#347'wietla poprzedni'#261' stron'#281
      ImageIndex = 7
      ShortCut = 16417
    end
    object LastPageAct: TAction
      Tag = -2
      Caption = 'Ostatnia'
      Hint = 'Wy'#347'wietla ostatni'#261' stron'#281
      ImageIndex = 9
      ShortCut = 16419
    end
    object AddPgScanAct: TAction
      Tag = -3
      Caption = 'Skanuj'
      Hint = 'Dodaje now'#261' stron'#281' na ko'#324'cu ze skanera'
      ImageIndex = 12
      ShortCut = 120
    end
    object AddPgFileAct: TAction
      Tag = -3
      Caption = 'Dodaj z plik'#243'w graficznych'
      Hint = 'Dodaje nowe strony na ko'#324'cu z plik'#243'w graficznych'
      ImageIndex = 13
      ShortCut = 16455
    end
    object AddPgsElsAct: TAction
      Tag = -3
      Caption = 'Dodaj z pliku skanu'
      Hint = 'Dodaje nowe strony na ko'#324'cu z innego pliku skanu'
      ImageIndex = 14
      ShortCut = 16454
    end
    object InsertPgScanAct: TAction
      Tag = -3
      Caption = 'Skanuj'
      Hint = 'Wstawia now'#261' stron'#281' w tym miejscu ze skanera'
      ImageIndex = 12
      ShortCut = 16504
    end
    object InsertPgFileAct: TAction
      Tag = -3
      Caption = 'Wstaw z pliku graficznego'
      Hint = 'Wstawia now'#261' stron'#281' w tym miejscu z pliku graficznego'
      ImageIndex = 13
      ShortCut = 24647
    end
    object InsertPgsElsAct: TAction
      Tag = -3
      Caption = 'Wstaw z pliku skanu'
      Hint = 'Wstawia nowe strony w tym miejscu z innego pliku skanu'
      ImageIndex = 14
      ShortCut = 24646
    end
    object DeletePageAct: TAction
      Tag = -3
      Caption = 'Usu'#324' bie'#380#261'c'#261' stron'#281
      Hint = 'Usuwa bie'#380#261'c'#261' stron'#281
      ImageIndex = 10
      ShortCut = 16430
    end
    object RotateLeftAct: TAction
      Tag = -2
      Caption = 'Obr'#243#263' w lewo'
      Hint = 'Obraca obraz o 90 stopni w lewo'
      ImageIndex = 15
      ShortCut = 16460
    end
    object RotateRightAct: TAction
      Tag = -2
      Caption = 'Obr'#243#263' w prawo'
      Hint = 'Obraca obraz o 90 stopni w prawo'
      ImageIndex = 16
      ShortCut = 16466
    end
    object Rotate180Act: TAction
      Tag = -2
      Caption = 'Obr'#243#263' o 180 stopni'
      Hint = 'Obraca obraz o 180 stopni'
      ImageIndex = 19
      ShortCut = 16469
    end
    object MirrorHAct: TAction
      Tag = -2
      Caption = 'Lustro poziomo'
      Hint = 'Odwraca obraz strony w poziomie (lustrzane odbicie)'
      ImageIndex = 18
      ShortCut = 24658
    end
    object MirrorVAct: TAction
      Tag = -2
      Caption = 'Lustro pionowo'
      Hint = 'Odwraca obraz strony w pionie (lustrzane odbicie)'
      ImageIndex = 17
      ShortCut = 24661
    end
    object EffectsAct: TAction
      Tag = -3
      Caption = 'Efekty obrazu'
      Hint = 'Wywo'#322'uje okno zaawansowanej edycji obraz'#243'w stron'
      ImageIndex = 24
      ShortCut = 16453
    end
    object SortPagesAct: TAction
      Tag = -3
      Caption = 'Sortuj strony...'
      Hint = 'Wywo'#322'uje okno sortowania stron'
      ImageIndex = 11
    end
    object ExportPgsElsAct: TAction
      Tag = -2
      Caption = 'Do oddzielnego pliku skanu'
      Hint = 'Zapisuje wybrane strony do oddzielnego dokumentu skanu'
      ImageIndex = 22
      ShortCut = 24659
    end
    object ExportPgsJpgAct: TAction
      Tag = -2
      Caption = 'Do plik'#243'w graficznych'
      Hint = 'Zapisuje wybrane strony do oddzielnych plik'#243'w graficznych'
      ImageIndex = 21
      ShortCut = 24656
    end
    object ExportPgsPdfAct: TAction
      Tag = -2
      Caption = 'Do dokumentu PDF'
      Hint = 'Zapisuje wybrane strony do dokumentu PDF'
      ImageIndex = 23
      ShortCut = 24644
    end
    object ZoomWidthAct: TAction
      Tag = -1
      Caption = 'Szeroko'#347#263' strony'
      GroupIndex = 111
      Hint = 'Dopasowuje powi'#281'kszenie do szeroko'#347'ci strony'
      ImageIndex = 36
      ShortCut = 16471
    end
    object ZoomAutoAct: TAction
      Tag = 1
      Caption = 'Ca'#322'a strona'
      GroupIndex = 111
      Hint = 'Dopasowuje powi'#281'kszenie do widoku ca'#322'ej strony'
      ImageIndex = 35
      ShortCut = 16449
    end
    object ZoomActualAct: TAction
      Caption = 'Rozmiar naturalny'
      Hint = 'Ustawia powi'#281'kszenie 1:1'
      ImageIndex = 34
      ShortCut = 16433
    end
    object ZoomInAct: TAction
      Caption = 'Powi'#281'ksz'
      Hint = 'Powi'#281'kszenie o jeden krok w g'#243'r'#281
      ImageIndex = 37
      ShortCut = 107
    end
    object ZoomOutAct: TAction
      Caption = 'Zmniejsz'
      Hint = 'Powi'#281'kszenie o jeden krok w d'#243#322
      ImageIndex = 38
      ShortCut = 109
    end
    object OptionsAct: TAction
      Tag = -2
      Caption = 'Ustawienia...'
      Hint = 'Ustawienia modu'#322'u skanuj'#261'cego'
      ImageIndex = 29
      ShortCut = 113
    end
    object InfoAct: TAction
      Tag = -2
      Caption = 'Informacje ...'
      Hint = 'Informacje'
      ImageIndex = 26
      ShortCut = 112
    end
    object FullScreenAct: TAction
      Caption = 'Pe'#322'ny ekran'
      Hint = 'Pokazuje obraz na pe'#322'nym ekranie'
      ImageIndex = 42
      ShortCut = 122
    end
    object ShowThumbsAct: TAction
      Caption = 'Miniatury'
      Hint = 'Pokazuje/ukrywa miniatury stron'
      ImageIndex = 41
      ShortCut = 16461
    end
    object ImgFilterAct: TAction
      AutoCheck = True
      Caption = 'Interpolacja powi'#281'kszenia'
      Hint = 'W'#322#261'cza/wy'#322#261'cza interpolacj'#281' powi'#281'kszenia (wyg'#322'adzanie obrazu)'
      ImageIndex = 39
      ShortCut = 16457
    end
    object ShowScrollAct: TAction
      AutoCheck = True
      Caption = 'Paski przewijania obrazu'
      Checked = True
      Hint = 'Pokazuje/ukrywa paski przewijania obrazu'
      ImageIndex = 40
    end
    object ImportPDFAct: TAction
      Tag = -3
      Caption = 'Importuj dokument PDF'
      Visible = False
    end
    object RunOCRAct: TAction
      Tag = -3
      Caption = 'Rozpoznaj tekst'
    end
  end
  object MainMenu2: TMainMenu
    Images = ActImgLst
    Left = 456
    Top = 160
    object PlikMenu: TMenuItem
      AutoHotkeys = maManual
      Caption = 'Plik'
      Hint = 'Zawiera polecenia operacji na plikach'
      object NowyMenu: TMenuItem
        Action = NewAct
      end
      object OtworzMenu: TMenuItem
        Action = OpenAct
      end
      object ZapiszMenu: TMenuItem
        Action = SaveAct
      end
      object ZapiszjakoMenu: TMenuItem
        Action = SaveAsAct
      end
      object DrukujStroneMenu: TMenuItem
        Action = PrintPagesAct
      end
      object Rozpoznajtekst1: TMenuItem
        Action = RunOCRAct
      end
      object ImportujdokumentPDF1: TMenuItem
        Action = ImportPDFAct
      end
      object MenuItem1: TMenuItem
        Caption = '-'
      end
      object ExitMenu: TMenuItem
        Action = CloseAct
      end
    end
    object EdycjaMenu: TMenuItem
      AutoHotkeys = maManual
      Caption = 'Edycja'
      Hint = 'Zawiera polecenia edycji pliku i obraz'#243'w'
      object KopiujMenu: TMenuItem
        Action = CopyAct
      end
      object WytnijMenu: TMenuItem
        Action = CutAct
      end
      object WklejMenu: TMenuItem
        Caption = 'Wklej'
        Hint = 'Wkleja stron'#281' ze schowka'
        ImageIndex = 5
        object WklejNowaMenu: TMenuItem
          Action = PasteNewAct
        end
        object WklejZastapMenu: TMenuItem
          Action = PasteReplaceAct
        end
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object UstawDomyslnMenu: TMenuItem
        Action = OptionsAct
      end
    end
    object StronaMenu: TMenuItem
      AutoHotkeys = maManual
      Caption = 'Strona'
      Hint = 'Zawiera polecenia dotycz'#261'ce stron'
      object PierwszaMenu: TMenuItem
        Action = FirstPageAct
      end
      object PoprzedniaMenu: TMenuItem
        Action = PrevPageAct
      end
      object NastepnaMenu: TMenuItem
        Action = NextPageAct
      end
      object OstatniaMenu: TMenuItem
        Action = LastPageAct
      end
      object MenuItem2: TMenuItem
        Caption = '-'
      end
      object DodajStroneMenu: TMenuItem
        Caption = 'Dodaj now'#261' stron'#281
        Hint = 'Dodaje now'#261' stron'#281' na ko'#324'cu'
        ImageIndex = 31
        object AddPageScanMnu: TMenuItem
          Action = AddPgScanAct
        end
        object DodajZPlikuMenu: TMenuItem
          Action = AddPgFileAct
        end
        object Dodajzplikuskanu1: TMenuItem
          Action = AddPgsElsAct
        end
      end
      object WstawStroneMenu: TMenuItem
        Caption = 'Wstaw now'#261' stron'#281
        Hint = 'Wstawia now'#261' stron'#281' w tym miejscu'
        ImageIndex = 32
        object WstawSkanujMenu: TMenuItem
          Action = InsertPgScanAct
        end
        object WstawZPlikuMenu: TMenuItem
          Action = InsertPgFileAct
        end
        object Wstawzplikuskanu1: TMenuItem
          Action = InsertPgsElsAct
        end
      end
      object UsunStroneMenu: TMenuItem
        Action = DeletePageAct
      end
      object ZamienMiejscMenu: TMenuItem
        Action = SortPagesAct
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object ObrotMenu: TMenuItem
        Caption = 'Obr'#243't obrazu'
        Hint = 'Obraca obraz strony'
        ImageIndex = 33
        object ObrocWPrawoMenu: TMenuItem
          Action = RotateRightAct
        end
        object ObrocWLewoMenu: TMenuItem
          Action = RotateLeftAct
        end
        object Obroc180Menu: TMenuItem
          Action = Rotate180Act
        end
        object MirrorHorMenu: TMenuItem
          Action = MirrorHAct
        end
        object MirrorVertMenu: TMenuItem
          Action = MirrorVAct
        end
      end
      object EfektyStrMenu: TMenuItem
        Action = EffectsAct
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object ZapiszStroneMenu: TMenuItem
        Caption = 'Eksportuj strony'
        Hint = 'Eksportuje wybrane strony'
        ImageIndex = 20
        object Eksportujstrony1: TMenuItem
          Action = ExportPgsElsAct
        end
        object EksportujJPG: TMenuItem
          Action = ExportPgsJpgAct
        end
        object EkportujPDF: TMenuItem
          Action = ExportPgsPdfAct
        end
      end
    end
    object WidokMenu: TMenuItem
      AutoHotkeys = maManual
      Caption = 'Widok'
      Hint = 'Zawiera polecenia dotycz'#261'ce widoku'
      object ZoomNaturalMnu: TMenuItem
        Action = ZoomActualAct
      end
      object AutoZoomMenu: TMenuItem
        Action = ZoomAutoAct
      end
      object ZoomSzerMenu: TMenuItem
        Action = ZoomWidthAct
      end
      object ZoomPlusMenu: TMenuItem
        Action = ZoomInAct
        GroupIndex = 111
      end
      object ZoomMinusMenu: TMenuItem
        Action = ZoomOutAct
        GroupIndex = 111
      end
      object MenuItem3: TMenuItem
        Caption = '-'
        GroupIndex = 111
      end
      object ImgFilterMnu: TMenuItem
        Action = ImgFilterAct
        AutoCheck = True
        GroupIndex = 111
      end
      object ScrollMnu: TMenuItem
        Action = ShowScrollAct
        AutoCheck = True
        GroupIndex = 111
      end
      object MenuItem4: TMenuItem
        Caption = '-'
        GroupIndex = 111
      end
      object Miniatury1: TMenuItem
        Action = ShowThumbsAct
        GroupIndex = 111
      end
      object FullScreenMnu: TMenuItem
        Action = FullScreenAct
        GroupIndex = 111
      end
      object N7: TMenuItem
        Caption = '-'
        GroupIndex = 111
      end
      object mnuLanguage: TMenuItem
        Caption = 'J'#281'zyk'
        GroupIndex = 111
      end
    end
    object PomocMenu: TMenuItem
      AutoHotkeys = maManual
      Caption = 'Pomoc'
      Hint = 'Zawiera polecenia dotycz'#261'ce pomocy'
      object Oprogramie1: TMenuItem
        Action = InfoAct
      end
    end
  end
end
