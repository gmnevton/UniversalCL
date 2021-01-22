object formAppList: TformAppList
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'App list'
  ClientHeight = 600
  ClientWidth = 440
  Color = clWhite
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  object boxHorizontal: TUScrollBox
    Left = 0
    Top = 32
    Width = 440
    Height = 90
    HorzScrollBar.Tracking = True
    VertScrollBar.Tracking = True
    Align = alTop
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    Color = 2039583
    ParentColor = False
    TabOrder = 0
    StyleElements = []
    AniSet.AniKind = akOut
    AniSet.AniFunctionKind = afkCubic
    AniSet.DelayStartTime = 0
    AniSet.Duration = 120
    AniSet.Step = 10
    AniSet.Queue = True
    BackColor.Enabled = False
    BackColor.Color = clBlack
    BackColor.LightColor = 15132390
    BackColor.DarkColor = 2039583
    ScrollOrientation = oHorizontal
    object USymbolButton1: TUSymbolButton
      Left = 555
      Top = 0
      Width = 111
      Height = 73
      Align = alLeft
      SymbolFont.Charset = DEFAULT_CHARSET
      SymbolFont.Color = clWindowText
      SymbolFont.Height = -16
      SymbolFont.Name = 'Segoe MDL2 Assets'
      SymbolFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      Orientation = oVertical
      SymbolChar = #57471
      Text = 'Help'
      Detail = 'Run wizard'
      KeepOrginalColor = False
      TabOrder = 1
    end
    object USymbolButton14: TUSymbolButton
      Left = 666
      Top = 0
      Width = 111
      Height = 73
      Align = alLeft
      SymbolFont.Charset = DEFAULT_CHARSET
      SymbolFont.Color = clWindowText
      SymbolFont.Height = -16
      SymbolFont.Name = 'Segoe MDL2 Assets'
      SymbolFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      Orientation = oVertical
      SymbolChar = #57621
      Text = 'Settings'
      Detail = 'Configuration'
      KeepOrginalColor = False
      TabOrder = 2
    end
    object USymbolButton15: TUSymbolButton
      Left = 333
      Top = 0
      Width = 111
      Height = 73
      Align = alLeft
      SymbolFont.Charset = DEFAULT_CHARSET
      SymbolFont.Color = clWindowText
      SymbolFont.Height = -16
      SymbolFont.Name = 'Segoe MDL2 Assets'
      SymbolFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      Orientation = oVertical
      SymbolChar = #57606
      Text = 'Delete'
      Detail = 'Delete item'
      KeepOrginalColor = False
      TabOrder = 3
    end
    object USymbolButton18: TUSymbolButton
      Left = 444
      Top = 0
      Width = 111
      Height = 73
      Align = alLeft
      SymbolFont.Charset = DEFAULT_CHARSET
      SymbolFont.Color = clWindowText
      SymbolFont.Height = -16
      SymbolFont.Name = 'Segoe MDL2 Assets'
      SymbolFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      Orientation = oVertical
      SymbolChar = #57492
      Text = 'Search'
      Detail = 'Search app'
      KeepOrginalColor = False
      TabOrder = 4
    end
    object USymbolButton2: TUSymbolButton
      Left = 111
      Top = 0
      Width = 111
      Height = 73
      Align = alLeft
      SymbolFont.Charset = DEFAULT_CHARSET
      SymbolFont.Color = clWindowText
      SymbolFont.Height = -16
      SymbolFont.Name = 'Segoe MDL2 Assets'
      SymbolFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      Orientation = oVertical
      SymbolChar = #57607
      Text = 'Uninstall'
      Detail = 'Detail'
      KeepOrginalColor = False
      TabOrder = 5
    end
    object USymbolButton4: TUSymbolButton
      Left = 0
      Top = 0
      Width = 111
      Height = 73
      Align = alLeft
      SymbolFont.Charset = DEFAULT_CHARSET
      SymbolFont.Color = clWindowText
      SymbolFont.Height = -16
      SymbolFont.Name = 'Segoe MDL2 Assets'
      SymbolFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      Orientation = oVertical
      SymbolChar = #57615
      Text = 'Home'
      Detail = 'Home page'
      IsToggleButton = True
      IsToggled = True
      KeepOrginalColor = False
      TabOrder = 6
    end
    object USymbolButton3: TUSymbolButton
      Left = 222
      Top = 0
      Width = 111
      Height = 73
      Align = alLeft
      SymbolFont.Charset = DEFAULT_CHARSET
      SymbolFont.Color = clWindowText
      SymbolFont.Height = -16
      SymbolFont.Name = 'Segoe MDL2 Assets'
      SymbolFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      Orientation = oVertical
      SymbolChar = #57350
      Text = 'Like'
      Detail = 'I like it'
      KeepOrginalColor = False
      TabOrder = 7
    end
  end
  object captionBar: TUCaptionBar
    Left = 0
    Top = 0
    Width = 440
    Caption = '   App list'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object buttonWinClose: TUQuickButton
      Left = 395
      Top = 0
      Hint = 'Close'
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe MDL2 Assets'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      ButtonStyle = sbsQuit
      LightColor = 2298344
      DarkColor = 2298344
      PressBrightnessDelta = 32
      Caption = #57606
      ExplicitLeft = 815
    end
    object buttonWinMin: TUQuickButton
      Left = 350
      Top = 0
      Hint = 'Minimize'
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe MDL2 Assets'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      ButtonStyle = sbsMin
      LightColor = 13619151
      DarkColor = 3947580
      PressBrightnessDelta = -32
      Caption = #59192
      ExplicitLeft = 710
    end
  end
  object boxVertical: TUScrollBox
    Left = 0
    Top = 122
    Width = 440
    Height = 478
    HorzScrollBar.Tracking = True
    VertScrollBar.Position = 722
    VertScrollBar.Tracking = True
    Align = alClient
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    Color = 2039583
    ParentColor = False
    TabOrder = 2
    StyleElements = []
    AniSet.AniKind = akOut
    AniSet.AniFunctionKind = afkCubic
    AniSet.DelayStartTime = 0
    AniSet.Duration = 120
    AniSet.Step = 10
    AniSet.Queue = True
    BackColor.Enabled = False
    BackColor.Color = clBlack
    BackColor.LightColor = 15132390
    BackColor.DarkColor = 2039583
    object UItemButton1: TUItemButton
      Left = 0
      Top = 438
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 30'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton2: TUItemButton
      Left = 0
      Top = 358
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 28'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton3: TUItemButton
      Left = 0
      Top = 318
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 27'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton4: TUItemButton
      Left = 0
      Top = 278
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 26'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton5: TUItemButton
      Left = 0
      Top = 238
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 25'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton6: TUItemButton
      Left = 0
      Top = 198
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 24'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton7: TUItemButton
      Left = 0
      Top = 398
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 29'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton8: TUItemButton
      Left = 0
      Top = -42
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 18'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton9: TUItemButton
      Left = 0
      Top = -2
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 19'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton10: TUItemButton
      Left = 0
      Top = 38
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 20'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton11: TUItemButton
      Left = 0
      Top = 78
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 21'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton12: TUItemButton
      Left = 0
      Top = 118
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 22'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton13: TUItemButton
      Left = 0
      Top = 158
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 23'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton14: TUItemButton
      Left = 0
      Top = -282
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 12'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton15: TUItemButton
      Left = 0
      Top = -242
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 13'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton16: TUItemButton
      Left = 0
      Top = -202
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 14'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton17: TUItemButton
      Left = 0
      Top = -162
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 15'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton18: TUItemButton
      Left = 0
      Top = -122
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 16'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton19: TUItemButton
      Left = 0
      Top = -82
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 17'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton20: TUItemButton
      Left = 0
      Top = -522
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 6'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton21: TUItemButton
      Left = 0
      Top = -482
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 7'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton22: TUItemButton
      Left = 0
      Top = -442
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 8'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton23: TUItemButton
      Left = 0
      Top = -402
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 9'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton24: TUItemButton
      Left = 0
      Top = -362
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 10'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton25: TUItemButton
      Left = 0
      Top = -322
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 11'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton26: TUItemButton
      Left = 0
      Top = -722
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 1'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton27: TUItemButton
      Left = 0
      Top = -682
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 2'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton28: TUItemButton
      Left = 0
      Top = -642
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 3'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton29: TUItemButton
      Left = 0
      Top = -602
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 4'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
    object UItemButton30: TUItemButton
      Left = 0
      Top = -562
      Width = 423
      Align = alTop
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      DetailFont.Charset = DEFAULT_CHARSET
      DetailFont.Color = clWindowText
      DetailFont.Height = -13
      DetailFont.Name = 'Segoe UI'
      DetailFont.Style = []
      ObjectsVisible = [iokNone, iokCheckBox, iokLeftIcon, iokText, iokDetail, iokRightIcon]
      LeftIcon = #58031
      Text = 'Item 5'
      Detail = 'Detail'
      RightIcon = #57345
      CustomActiveColor = 14120960
    end
  end
end
