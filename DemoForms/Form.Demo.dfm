object formDemo: TformDemo
  Left = 0
  Top = 0
  Caption = 'Delphi UWP app'
  ClientHeight = 590
  ClientWidth = 1000
  Color = clWhite
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object linkConnected: TUHyperLink
    Left = 540
    Top = 170
    Width = 125
    Height = 17
    Caption = 'TUHyperLink (default)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TextColors.Enabled = False
    TextColors.LightColor = 14120960
    TextColors.LightHover = clBlue
    TextColors.LightPress = clMedGray
    TextColors.LightDisabled = clGray
    TextColors.LightFocused = 14120960
    TextColors.DarkColor = 14120960
    TextColors.DarkHover = clBlue
    TextColors.DarkPress = clMedGray
    TextColors.DarkDisabled = clGray
    TextColors.DarkFocused = 14120960
    URL = 'https://embarcadero.com/'
  end
  object linkCustomColor: TUHyperLink
    Left = 540
    Top = 190
    Width = 161
    Height = 17
    Caption = 'TUHyperLink (custom color)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TextColors.Enabled = False
    TextColors.LightColor = 14120960
    TextColors.LightHover = clBlue
    TextColors.LightPress = clMedGray
    TextColors.LightDisabled = clGray
    TextColors.LightFocused = 14120960
    TextColors.DarkColor = 14120960
    TextColors.DarkHover = clBlue
    TextColors.DarkPress = clMedGray
    TextColors.DarkDisabled = clGray
    TextColors.DarkFocused = 14120960
    URL = 'https://embarcadero.com/'
  end
  object linkDisabled: TUHyperLink
    Left = 540
    Top = 210
    Width = 135
    Height = 17
    Cursor = crDefault
    Caption = 'TUHyperLink (disabled)'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ButtonState = csDisabled
    TextColors.Enabled = False
    TextColors.LightColor = 14120960
    TextColors.LightHover = clBlue
    TextColors.LightPress = clMedGray
    TextColors.LightDisabled = clGray
    TextColors.LightFocused = 14120960
    TextColors.DarkColor = 14120960
    TextColors.DarkHover = clBlue
    TextColors.DarkPress = clMedGray
    TextColors.DarkDisabled = clGray
    TextColors.DarkFocused = 14120960
    URL = 'https://embarcadero.com/'
  end
  object textDescription: TUText
    Left = 390
    Top = 210
    Width = 94
    Height = 15
    Caption = 'This is description'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TextKind = tkDescription
  end
  object textNormal: TUText
    Left = 390
    Top = 190
    Width = 106
    Height = 17
    Caption = 'This is normal text'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object textEntry: TUText
    Left = 390
    Top = 170
    Width = 74
    Height = 17
    Caption = 'This is entry'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = []
    ParentFont = False
    TextKind = tkEntry
  end
  object textHeading: TUText
    Left = 390
    Top = 140
    Width = 128
    Height = 28
    Caption = 'This is heading'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TextKind = tkHeading
  end
  object textTitle: TUText
    Left = 390
    Top = 100
    Width = 132
    Height = 38
    Caption = 'This is title'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -28
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    Transparent = True
    TextKind = tkTitle
  end
  object sliderHorz: TUSlider
    Left = 390
    Top = 446
    Width = 140
    ParentShowHint = False
    ShowHint = False
    BackColor.Enabled = False
    BackColor.LightColor = 10066329
    BackColor.LightHover = 6710886
    BackColor.LightPress = 10066329
    BackColor.LightDisabled = 10066329
    BackColor.LightFocused = 6710886
    BackColor.DarkColor = 6710886
    BackColor.DarkHover = 10066329
    BackColor.DarkPress = 6710886
    BackColor.DarkDisabled = 6710886
    BackColor.DarkFocused = 10066329
    CurColor.Enabled = False
    CurColor.LightColor = 14120960
    CurColor.LightHover = 1513239
    CurColor.LightPress = 13421772
    CurColor.LightDisabled = 14120960
    CurColor.LightFocused = 1513239
    CurColor.DarkColor = 14120960
    CurColor.DarkHover = 7763574
    CurColor.DarkPress = 15921906
    CurColor.DarkDisabled = 14120960
    CurColor.DarkFocused = 15921906
    OnChange = sliderHorzChange
  end
  object sliderDisabled: TUSlider
    Left = 390
    Top = 416
    Width = 140
    Enabled = False
    BackColor.Enabled = False
    BackColor.LightColor = 10066329
    BackColor.LightHover = 6710886
    BackColor.LightPress = 10066329
    BackColor.LightDisabled = 10066329
    BackColor.LightFocused = 6710886
    BackColor.DarkColor = 6710886
    BackColor.DarkHover = 10066329
    BackColor.DarkPress = 6710886
    BackColor.DarkDisabled = 6710886
    BackColor.DarkFocused = 10066329
    CurColor.Enabled = False
    CurColor.LightColor = 14120960
    CurColor.LightHover = 1513239
    CurColor.LightPress = 13421772
    CurColor.LightDisabled = 14120960
    CurColor.LightFocused = 1513239
    CurColor.DarkColor = 14120960
    CurColor.DarkHover = 7763574
    CurColor.DarkPress = 15921906
    CurColor.DarkDisabled = 14120960
    CurColor.DarkFocused = 15921906
    ControlState = csDisabled
    Value = 50
  end
  object sliderVert: TUSlider
    Left = 680
    Top = 480
    Width = 25
    Height = 70
    BackColor.Enabled = False
    BackColor.LightColor = 10066329
    BackColor.LightHover = 6710886
    BackColor.LightPress = 10066329
    BackColor.LightDisabled = 10066329
    BackColor.LightFocused = 6710886
    BackColor.DarkColor = 6710886
    BackColor.DarkHover = 10066329
    BackColor.DarkPress = 6710886
    BackColor.DarkDisabled = 6710886
    BackColor.DarkFocused = 10066329
    CurColor.Enabled = False
    CurColor.LightColor = 14120960
    CurColor.LightHover = 1513239
    CurColor.LightPress = 13421772
    CurColor.LightDisabled = 14120960
    CurColor.LightFocused = 1513239
    CurColor.DarkColor = 14120960
    CurColor.DarkHover = 15921906
    CurColor.DarkPress = 7763574
    CurColor.DarkDisabled = 14120960
    CurColor.DarkFocused = 15921906
    Orientation = oVertical
    Max = 4
  end
  object radioC1: TURadioButton
    Left = 540
    Top = 317
    Width = 193
    Height = 90
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    TabOrder = 31
    IconFont.Charset = DEFAULT_CHARSET
    IconFont.Color = clWindowText
    IconFont.Height = -20
    IconFont.Name = 'Segoe MDL2 Assets'
    IconFont.Style = []
    Group = 'GroupC'
    Multiline = True
    Caption = 
      'Radio C1'#13#10#13#10'More than one line of text'#13#10'This is another demo'#13#10'On' +
      'e more line...'
  end
  object check2State: TUCheckBox
    Left = 390
    Top = 340
    Width = 129
    AutoSize = True
    TabOrder = 25
    IconFont.Charset = DEFAULT_CHARSET
    IconFont.Color = clWindowText
    IconFont.Height = -20
    IconFont.Name = 'Segoe MDL2 Assets'
    IconFont.Style = []
    Checked = True
    State = cbsChecked
    Caption = '2-state checkbox'
  end
  object check3State: TUCheckBox
    Left = 390
    Top = 368
    Width = 129
    AutoSize = True
    TabOrder = 26
    IconFont.Charset = DEFAULT_CHARSET
    IconFont.Color = clWindowText
    IconFont.Height = -20
    IconFont.Name = 'Segoe MDL2 Assets'
    IconFont.Style = []
    AllowGrayed = True
    State = cbsGrayed
    Caption = '3-state checkbox'
  end
  object radioA1: TURadioButton
    Left = 390
    Top = 240
    Width = 84
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    AutoSize = True
    TabOrder = 20
    IconFont.Charset = DEFAULT_CHARSET
    IconFont.Color = clWindowText
    IconFont.Height = -20
    IconFont.Name = 'Segoe MDL2 Assets'
    IconFont.Style = []
    Group = 'GroupA'
    Caption = 'Radio A1'
  end
  object radioA2: TURadioButton
    Left = 390
    Top = 270
    Width = 84
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    AutoSize = True
    TabOrder = 21
    IconFont.Charset = DEFAULT_CHARSET
    IconFont.Color = clWindowText
    IconFont.Height = -20
    IconFont.Name = 'Segoe MDL2 Assets'
    IconFont.Style = []
    Group = 'GroupA'
    Caption = 'Radio A2'
  end
  object radioA3: TURadioButton
    Left = 390
    Top = 300
    Width = 84
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    AutoSize = True
    Enabled = False
    TabOrder = 22
    IconFont.Charset = DEFAULT_CHARSET
    IconFont.Color = clWindowText
    IconFont.Height = -20
    IconFont.Name = 'Segoe MDL2 Assets'
    IconFont.Style = []
    Group = 'GroupA'
    Caption = 'Radio A3'
  end
  object radioB1: TURadioButton
    Left = 540
    Top = 240
    Width = 83
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    AutoSize = True
    TabOrder = 23
    IconFont.Charset = DEFAULT_CHARSET
    IconFont.Color = clWindowText
    IconFont.Height = -20
    IconFont.Name = 'Segoe MDL2 Assets'
    IconFont.Style = []
    Group = 'GroupB'
    Caption = 'Radio B1'
  end
  object radioB2: TURadioButton
    Left = 540
    Top = 270
    Width = 83
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    AutoSize = True
    TabOrder = 24
    IconFont.Charset = DEFAULT_CHARSET
    IconFont.Color = clWindowText
    IconFont.Height = -20
    IconFont.Name = 'Segoe MDL2 Assets'
    IconFont.Style = []
    Group = 'GroupB'
    Caption = 'Radio B2'
  end
  object progressVert: TUProgressBar
    Left = 660
    Top = 480
    Width = 5
    Height = 70
    ParentColor = False
    TabOrder = 30
    AniSet.AniKind = akOut
    AniSet.AniFunctionKind = afkQuartic
    AniSet.DelayStartTime = 0
    AniSet.Duration = 250
    AniSet.Step = 25
    BackColor.Enabled = False
    BackColor.Color = 15132390
    BackColor.LightColor = 13421772
    BackColor.DarkColor = 3355443
    FillColor.Enabled = False
    FillColor.Color = 15132390
    FillColor.LightColor = 13421772
    FillColor.DarkColor = 3355443
    Value = 45
    Orientation = oVertical
  end
  object progressCustomColor: TUProgressBar
    Left = 390
    Top = 480
    Width = 250
    ParentColor = False
    TabOrder = 27
    AniSet.AniKind = akOut
    AniSet.AniFunctionKind = afkQuartic
    AniSet.DelayStartTime = 0
    AniSet.Duration = 250
    AniSet.Step = 25
    BackColor.Enabled = False
    BackColor.Color = 15132390
    BackColor.LightColor = 13421772
    BackColor.DarkColor = 3355443
    FillColor.Enabled = False
    FillColor.Color = 15132390
    FillColor.LightColor = 13421772
    FillColor.DarkColor = 3355443
    Value = 45
    Orientation = oHorizontal
  end
  object progressConnected: TUProgressBar
    Left = 390
    Top = 500
    Width = 250
    ParentColor = False
    TabOrder = 28
    AniSet.AniKind = akOut
    AniSet.AniFunctionKind = afkQuartic
    AniSet.DelayStartTime = 0
    AniSet.Duration = 250
    AniSet.Step = 25
    BackColor.Enabled = False
    BackColor.Color = 15132390
    BackColor.LightColor = 13421772
    BackColor.DarkColor = 3355443
    FillColor.Enabled = False
    FillColor.Color = 15132390
    FillColor.LightColor = 13421772
    FillColor.DarkColor = 3355443
    Value = 0
    Orientation = oHorizontal
  end
  object captionBarMain: TUCaptionBar
    Left = 0
    Top = 0
    Width = 1000
    Height = 32
    Caption = '                Delphi UWP app'
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 0
    BackColors.Enabled = False
    BackColors.Color = clBlack
    BackColors.LightColor = 15921906
    BackColors.DarkColor = 2829099
    BackColors.FocusedLightColor = 14120960
    BackColors.FocusedDarkColor = clBlue
    object buttonAppBack: TUQuickButton
      Left = 0
      Top = 0
      Hint = 'Cofnij'
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe MDL2 Assets'
      Font.Style = []
      ParentFont = False
      BackColors.Enabled = False
      BackColors.Color = clBlack
      BackColors.LightColor = 13619151
      BackColors.DarkColor = 3947580
      ButtonStyle = qbsHighlight
      HintHighlightButton = 'Cofnij'
      Caption = #57510
    end
    object buttonWinClose: TUQuickButton
      Left = 955
      Top = 0
      Hint = 'Zamknij'
      Align = alCustom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe MDL2 Assets'
      Font.Style = []
      ParentFont = False
      BackColors.Enabled = False
      BackColors.Color = clBlack
      BackColors.LightColor = 13619151
      BackColors.DarkColor = 3947580
      ButtonStyle = qbsQuit
      HintCloseButton = 'Zamknij'
      CustomAccentColor = clNone
      StickAlign = alRight
      Caption = #59153
      ExplicitLeft = 276
    end
    object buttonWinMax: TUQuickButton
      Left = 910
      Top = 0
      Hint = 'Maksymalizuj okno'
      Align = alCustom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe MDL2 Assets'
      Font.Style = []
      ParentFont = False
      BackColors.Enabled = False
      BackColors.Color = clBlack
      BackColors.LightColor = 13619151
      BackColors.DarkColor = 3947580
      ButtonStyle = qbsMax
      HintMaxButton = 'Maksymalizuj okno'
      HintRestoreButton = 'Zmniejsz okno'
      CustomAccentColor = clNone
      StickAlign = alRight
      StickToControl = buttonWinClose
      Caption = #57347
      ExplicitLeft = 769
    end
    object buttonWinMin: TUQuickButton
      Left = 865
      Top = 0
      Hint = 'Minimalizuj okno'
      Align = alCustom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe MDL2 Assets'
      Font.Style = []
      ParentFont = False
      BackColors.Enabled = False
      BackColors.Color = clBlack
      BackColors.LightColor = 13619151
      BackColors.DarkColor = 3947580
      ButtonStyle = qbsMin
      HintMinButton = 'Minimalizuj okno'
      CustomAccentColor = clNone
      StickAlign = alRight
      StickToControl = buttonWinMax
      Caption = #57608
      ExplicitLeft = 724
    end
    object buttonBlurForm: TUQuickButton
      Tag = 3
      Left = 544
      Top = 0
      Hint = 'Test prze'#378'roczysto'#347'ci'
      Align = alCustom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe MDL2 Assets'
      Font.Style = []
      ParentFont = False
      OnClick = buttonBlurFormClick
      BackColors.Enabled = False
      BackColors.Color = clBlack
      BackColors.LightColor = 13619151
      BackColors.DarkColor = 3947580
      HintSysButton = 'Test prze'#378'roczysto'#347'ci'
      CustomAccentColor = clNone
      Caption = #57615
      ExplicitLeft = 955
    end
    object buttonFullScreen: TUQuickButton
      Tag = 4
      Left = 499
      Top = 0
      Hint = 'Pe'#322'ny ekran'
      Align = alCustom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe MDL2 Assets'
      Font.Style = []
      ParentFont = False
      OnClick = buttonFullScreenClick
      BackColors.Enabled = False
      BackColors.Color = clBlack
      BackColors.LightColor = 13619151
      BackColors.DarkColor = 3947580
      ButtonStyle = qbsNone
      Caption = #59200
      ExplicitLeft = 955
    end
    object comboAppDPI: TComboBox
      Tag = 1
      AlignWithMargins = True
      Left = 741
      Top = 4
      Width = 120
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alCustom
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 1
      Text = '100%'
      OnChange = comboAppDPIChange
      Items.Strings = (
        '100%'
        '125%'
        '150%'
        '175%'
        '200%')
    end
    object comboAppBorderStyle: TComboBox
      Tag = 2
      AlignWithMargins = True
      Left = 613
      Top = 4
      Width = 120
      Height = 25
      Hint = 'Do not change form style runtime in Windows 7'
      Margins.Left = 24
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alCustom
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ItemIndex = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Text = 'bsSizeable'
      OnChange = comboAppBorderStyleChange
      Items.Strings = (
        'bsDialog'
        'bsSingle'
        'bsSizeable'
        'bsToolWindow'
        'bsSizeToolWin')
    end
  end
  object panelRibbon: TUScrollBox
    Left = 0
    Top = 32
    Width = 1000
    Height = 60
    HorzScrollBar.Tracking = True
    VertScrollBar.Tracking = True
    Align = alTop
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    Color = 3355443
    ParentColor = False
    TabOrder = 1
    StyleElements = []
    AniSet.AniKind = akOut
    AniSet.AniFunctionKind = afkQuartic
    AniSet.DelayStartTime = 0
    AniSet.Duration = 120
    AniSet.Step = 6
    AniSet.Queue = True
    BackColor.Enabled = True
    BackColor.Color = clBlack
    BackColor.LightColor = 14342874
    BackColor.DarkColor = 3355443
    ScrollOrientation = oHorizontal
    object separator1: TUSeparator
      Left = 120
      Top = 0
      Height = 60
      Align = alLeft
      CustomColor = clBlack
    end
    object separator2: TUSeparator
      Left = 320
      Top = 0
      Height = 60
      Align = alLeft
      CustomColor = clBlack
    end
    object buttonGoBack: TUSymbolButton
      Left = 0
      Top = 0
      Width = 60
      Height = 60
      Align = alLeft
      TabOrder = 0
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
      SymbolChar = #57366
      Text = 'Back'
      TextOffset = 35
      Detail = 'Alt+Left'
      ShowDetail = False
      Transparent = True
      KeepOrginalColor = False
    end
    object buttonGoHome: TUSymbolButton
      Left = 60
      Top = 0
      Width = 60
      Height = 60
      Align = alLeft
      TabOrder = 1
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
      TextOffset = 35
      Detail = 'Ctrl+H'
      ShowDetail = False
      Transparent = True
      KeepOrginalColor = False
    end
    object buttonNewDoc: TUSymbolButton
      Left = 140
      Top = 0
      Width = 60
      Height = 60
      Align = alLeft
      TabOrder = 2
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
      SymbolChar = #57696
      Text = 'New'
      TextOffset = 35
      Detail = 'Ctrl+N'
      ShowDetail = False
      Transparent = True
      KeepOrginalColor = False
    end
    object buttonOpenDoc: TUSymbolButton
      Left = 200
      Top = 0
      Width = 60
      Height = 60
      Align = alLeft
      TabOrder = 3
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
      SymbolChar = #60739
      Text = 'Open'
      TextOffset = 35
      Detail = 'Ctrl+O'
      ShowDetail = False
      Transparent = True
      KeepOrginalColor = False
    end
    object buttonLoginForm: TUSymbolButton
      Left = 340
      Top = 0
      Width = 80
      Height = 60
      Align = alLeft
      TabOrder = 5
      OnClick = buttonLoginFormClick
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
      SymbolChar = #58031
      Text = 'Login form'
      TextOffset = 35
      Detail = 'Detail'
      ShowDetail = False
      Transparent = True
      KeepOrginalColor = False
    end
    object buttonSaveDoc: TUSymbolButton
      Left = 260
      Top = 0
      Width = 60
      Height = 60
      Align = alLeft
      TabOrder = 4
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
      SymbolChar = #57605
      Text = 'Save'
      TextOffset = 35
      Detail = 'Ctrl+S'
      ShowDetail = False
      Transparent = True
      KeepOrginalColor = False
    end
    object buttonImageForm: TUSymbolButton
      Left = 420
      Top = 0
      Width = 80
      Height = 60
      Align = alLeft
      TabOrder = 6
      OnClick = buttonImageFormClick
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
      SymbolChar = #58033
      Text = 'Image form'
      TextOffset = 35
      Detail = 'Detail'
      ShowDetail = False
      Transparent = True
      KeepOrginalColor = False
    end
    object buttonAppListForm: TUSymbolButton
      Left = 500
      Top = 0
      Width = 80
      Height = 60
      Align = alLeft
      TabOrder = 7
      OnClick = buttonAppListFormClick
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
      SymbolChar = #57721
      Text = 'App list'
      TextOffset = 35
      Detail = 'Detail'
      ShowDetail = False
      Transparent = True
      KeepOrginalColor = False
    end
  end
  object buttonNoFocus: TUButton
    Tag = 14
    Left = 60
    Top = 190
    Width = 151
    TabOrder = 7
    BackColors.Enabled = False
    BackColors.LightColor = 13421772
    BackColors.LightHover = 13421772
    BackColors.LightPress = 10066329
    BackColors.LightDisabled = 13421772
    BackColors.LightFocused = 13421772
    BackColors.DarkColor = 3355443
    BackColors.DarkHover = 3355443
    BackColors.DarkPress = 6710886
    BackColors.DarkDisabled = 3355443
    BackColors.DarkFocused = 3355443
    BorderColors.Enabled = False
    BorderColors.LightColor = 13421772
    BorderColors.LightHover = 8026746
    BorderColors.LightPress = 10066329
    BorderColors.LightDisabled = 8026746
    BorderColors.LightFocused = 8026746
    BorderColors.DarkColor = 3355443
    BorderColors.DarkHover = 8750469
    BorderColors.DarkPress = 6710886
    BorderColors.DarkDisabled = 8750469
    BorderColors.DarkFocused = 8750469
    TextColors.Enabled = False
    TextColors.LightColor = clBlack
    TextColors.LightHover = clBlack
    TextColors.LightPress = clBlack
    TextColors.LightDisabled = clGray
    TextColors.LightFocused = clBlack
    TextColors.DarkColor = clWhite
    TextColors.DarkHover = clWhite
    TextColors.DarkPress = clWhite
    TextColors.DarkDisabled = clGray
    TextColors.DarkFocused = clWhite
    Alignment = taLeftJustify
    Caption = 'Button no focus'
  end
  object buttonCanFocus: TUButton
    Tag = 9
    Left = 60
    Top = 230
    Width = 151
    TabOrder = 9
    BackColors.Enabled = False
    BackColors.LightColor = 13421772
    BackColors.LightHover = 13421772
    BackColors.LightPress = 10066329
    BackColors.LightDisabled = 13421772
    BackColors.LightFocused = 13421772
    BackColors.DarkColor = 3355443
    BackColors.DarkHover = 3355443
    BackColors.DarkPress = 6710886
    BackColors.DarkDisabled = 3355443
    BackColors.DarkFocused = 3355443
    BorderColors.Enabled = False
    BorderColors.LightColor = 13421772
    BorderColors.LightHover = 8026746
    BorderColors.LightPress = 10066329
    BorderColors.LightDisabled = 8026746
    BorderColors.LightFocused = 8026746
    BorderColors.DarkColor = 3355443
    BorderColors.DarkHover = 8750469
    BorderColors.DarkPress = 6710886
    BorderColors.DarkDisabled = 8750469
    BorderColors.DarkFocused = 8750469
    TextColors.Enabled = False
    TextColors.LightColor = clBlack
    TextColors.LightHover = clBlack
    TextColors.LightPress = clBlack
    TextColors.LightDisabled = clGray
    TextColors.LightFocused = clBlack
    TextColors.DarkColor = clWhite
    TextColors.DarkHover = clWhite
    TextColors.DarkPress = clWhite
    TextColors.DarkDisabled = clGray
    TextColors.DarkFocused = clWhite
    Caption = 'Button can focus'
  end
  object buttonCustomColor: TUButton
    Tag = 17
    Left = 60
    Top = 270
    Width = 151
    TabOrder = 11
    BackColors.Enabled = False
    BackColors.LightColor = 13421772
    BackColors.LightHover = 13421772
    BackColors.LightPress = 10066329
    BackColors.LightDisabled = 13421772
    BackColors.LightFocused = 13421772
    BackColors.DarkColor = 3355443
    BackColors.DarkHover = 3355443
    BackColors.DarkPress = 6710886
    BackColors.DarkDisabled = 3355443
    BackColors.DarkFocused = 3355443
    BorderColors.Enabled = False
    BorderColors.LightColor = 13421772
    BorderColors.LightHover = 8026746
    BorderColors.LightPress = 10066329
    BorderColors.LightDisabled = 8026746
    BorderColors.LightFocused = 8026746
    BorderColors.DarkColor = 3355443
    BorderColors.DarkHover = 8750469
    BorderColors.DarkPress = 6710886
    BorderColors.DarkDisabled = 8750469
    BorderColors.DarkFocused = 8750469
    TextColors.Enabled = False
    TextColors.LightColor = clBlack
    TextColors.LightHover = clBlack
    TextColors.LightPress = clBlack
    TextColors.LightDisabled = clGray
    TextColors.LightFocused = clBlack
    TextColors.DarkColor = clWhite
    TextColors.DarkHover = clWhite
    TextColors.DarkPress = clWhite
    TextColors.DarkDisabled = clGray
    TextColors.DarkFocused = clWhite
    Alignment = taRightJustify
    Caption = 'Custom button'
  end
  object buttonReloadSettings: TUSymbolButton
    Left = 220
    Top = 270
    Width = 151
    Height = 30
    TabOrder = 12
    OnClick = buttonReloadSettingsClick
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
    SymbolChar = #57615
    Text = 'Reload settings'
    Detail = 'Detail'
    ShowDetail = False
    KeepOrginalColor = False
  end
  object buttonHighlight: TUButton
    Tag = 6
    Left = 220
    Top = 230
    Width = 151
    TabOrder = 10
    OnClick = buttonHighlightClick
    BackColors.Enabled = False
    BackColors.LightColor = 13421772
    BackColors.LightHover = 13421772
    BackColors.LightPress = 10066329
    BackColors.LightDisabled = 13421772
    BackColors.LightFocused = 13421772
    BackColors.DarkColor = 3355443
    BackColors.DarkHover = 3355443
    BackColors.DarkPress = 6710886
    BackColors.DarkDisabled = 3355443
    BackColors.DarkFocused = 3355443
    BorderColors.Enabled = False
    BorderColors.LightColor = 13421772
    BorderColors.LightHover = 8026746
    BorderColors.LightPress = 10066329
    BorderColors.LightDisabled = 8026746
    BorderColors.LightFocused = 8026746
    BorderColors.DarkColor = 3355443
    BorderColors.DarkHover = 8750469
    BorderColors.DarkPress = 6710886
    BorderColors.DarkDisabled = 8750469
    BorderColors.DarkFocused = 8750469
    TextColors.Enabled = False
    TextColors.LightColor = clBlack
    TextColors.LightHover = clBlack
    TextColors.LightPress = clBlack
    TextColors.LightDisabled = clGray
    TextColors.LightFocused = clBlack
    TextColors.DarkColor = clWhite
    TextColors.DarkHover = clWhite
    TextColors.DarkPress = clWhite
    TextColors.DarkDisabled = clGray
    TextColors.DarkFocused = clWhite
    Highlight = True
    Caption = 'Highlight button'
  end
  object buttonDisabled: TUButton
    Tag = 7
    Left = 220
    Top = 190
    Width = 151
    Enabled = False
    TabOrder = 8
    BackColors.Enabled = False
    BackColors.LightColor = 13421772
    BackColors.LightHover = 13421772
    BackColors.LightPress = 10066329
    BackColors.LightDisabled = 13421772
    BackColors.LightFocused = 13421772
    BackColors.DarkColor = 3355443
    BackColors.DarkHover = 3355443
    BackColors.DarkPress = 6710886
    BackColors.DarkDisabled = 3355443
    BackColors.DarkFocused = 3355443
    BorderColors.Enabled = False
    BorderColors.LightColor = 13421772
    BorderColors.LightHover = 8026746
    BorderColors.LightPress = 10066329
    BorderColors.LightDisabled = 8026746
    BorderColors.LightFocused = 8026746
    BorderColors.DarkColor = 3355443
    BorderColors.DarkHover = 8750469
    BorderColors.DarkPress = 6710886
    BorderColors.DarkDisabled = 8750469
    BorderColors.DarkFocused = 8750469
    TextColors.Enabled = False
    TextColors.LightColor = clBlack
    TextColors.LightHover = clBlack
    TextColors.LightPress = clBlack
    TextColors.LightDisabled = clGray
    TextColors.LightFocused = clBlack
    TextColors.DarkColor = clWhite
    TextColors.DarkHover = clWhite
    TextColors.DarkPress = clWhite
    TextColors.DarkDisabled = clGray
    TextColors.DarkFocused = clWhite
    ButtonState = csDisabled
    Caption = 'Button disabled'
  end
  object buttonToggled: TUButton
    Tag = 5
    Left = 220
    Top = 310
    Width = 151
    TabOrder = 14
    BackColors.Enabled = False
    BackColors.LightColor = 13421772
    BackColors.LightHover = 13421772
    BackColors.LightPress = 10066329
    BackColors.LightDisabled = 13421772
    BackColors.LightFocused = 13421772
    BackColors.DarkColor = 3355443
    BackColors.DarkHover = 3355443
    BackColors.DarkPress = 6710886
    BackColors.DarkDisabled = 3355443
    BackColors.DarkFocused = 3355443
    BorderColors.Enabled = False
    BorderColors.LightColor = 13421772
    BorderColors.LightHover = 8026746
    BorderColors.LightPress = 10066329
    BorderColors.LightDisabled = 8026746
    BorderColors.LightFocused = 8026746
    BorderColors.DarkColor = 3355443
    BorderColors.DarkHover = 8750469
    BorderColors.DarkPress = 6710886
    BorderColors.DarkDisabled = 8750469
    BorderColors.DarkFocused = 8750469
    TextColors.Enabled = False
    TextColors.LightColor = clBlack
    TextColors.LightHover = clBlack
    TextColors.LightPress = clBlack
    TextColors.LightDisabled = clGray
    TextColors.LightFocused = clBlack
    TextColors.DarkColor = clWhite
    TextColors.DarkHover = clWhite
    TextColors.DarkPress = clWhite
    TextColors.DarkDisabled = clGray
    TextColors.DarkFocused = clWhite
    IsToggleButton = True
    Caption = 'Toggle button'
  end
  object itembuttonImage: TUItemButton
    Left = 60
    Top = 460
    Width = 311
    Height = 41
    DragCursor = crDefault
    TabOrder = 18
    OnClick = itembuttonImageClick
    ImageRightIndex = 3
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
    Text = 'You clicked on'
    Detail = 'Nothing'
    RightIcon = #57345
    AlignSpace = 10
    CustomActiveColor = clNone
  end
  object itembuttonFontIcon: TUItemButton
    Left = 60
    Top = 510
    Width = 311
    Height = 41
    DragCursor = crDefault
    TabOrder = 19
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
    LeftIcon = #58031
    Text = 'Don'#39't combine'
    Detail = 'CheckBox and Toggled'
    RightIcon = #57345
    CustomActiveColor = clNone
    IsToggleButton = True
  end
  object symbolButtonOpenDisabled: TUSymbolButton
    Left = 130
    Top = 350
    Width = 241
    Height = 41
    Enabled = False
    TabOrder = 16
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
    ButtonState = csDisabled
    SymbolChar = #60739
    Text = 'Open file (disabled)'
    Detail = 'Ctrl+O'
    KeepOrginalColor = False
  end
  object symbolbuttonSaveHorz: TUSymbolButton
    Left = 130
    Top = 400
    Width = 241
    Height = 41
    TabOrder = 17
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
    SymbolChar = #57605
    Text = 'Save file (toggle button)'
    Detail = 'Ctrl+S'
    IsToggleButton = True
    KeepOrginalColor = False
  end
  object symbolbuttonSaveVert: TUSymbolButton
    Left = 60
    Top = 350
    Width = 61
    Height = 91
    TabOrder = 15
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
    SymbolChar = #57696
    Text = 'New'
    Detail = 'Ctrl+N'
    KeepOrginalColor = False
  end
  object buttonRandomProgress: TUButton
    Tag = 5
    Left = 390
    Top = 520
    Width = 250
    Height = 31
    Hint = 'This is tooltip'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 29
    OnClick = buttonRandomProgressClick
    BackColors.Enabled = False
    BackColors.LightColor = 13421772
    BackColors.LightHover = 13421772
    BackColors.LightPress = 10066329
    BackColors.LightDisabled = 13421772
    BackColors.LightFocused = 13421772
    BackColors.DarkColor = 3355443
    BackColors.DarkHover = 3355443
    BackColors.DarkPress = 6710886
    BackColors.DarkDisabled = 3355443
    BackColors.DarkFocused = 3355443
    BorderColors.Enabled = False
    BorderColors.LightColor = 13421772
    BorderColors.LightHover = 8026746
    BorderColors.LightPress = 10066329
    BorderColors.LightDisabled = 8026746
    BorderColors.LightFocused = 8026746
    BorderColors.DarkColor = 3355443
    BorderColors.DarkHover = 8750469
    BorderColors.DarkPress = 6710886
    BorderColors.DarkDisabled = 8750469
    BorderColors.DarkFocused = 8750469
    TextColors.Enabled = False
    TextColors.LightColor = clBlack
    TextColors.LightHover = clBlack
    TextColors.LightPress = clBlack
    TextColors.LightDisabled = clGray
    TextColors.LightFocused = clBlack
    TextColors.DarkColor = clWhite
    TextColors.DarkHover = clWhite
    TextColors.DarkPress = clWhite
    TextColors.DarkDisabled = clGray
    TextColors.DarkFocused = clWhite
    Caption = 'Random progress value'
  end
  object buttonRunning: TButton
    Left = 60
    Top = 110
    Width = 101
    Height = 25
    Hint = 'ABC'
    Caption = 'Here we go'
    TabOrder = 4
  end
  object buttonAniToRight: TButton
    Left = 60
    Top = 140
    Width = 151
    Height = 31
    Caption = 'Start animation'
    TabOrder = 5
    OnClick = buttonAniToRightClick
  end
  object buttonAniToLeft: TButton
    Left = 220
    Top = 140
    Width = 151
    Height = 31
    Caption = 'Reserve animation'
    ImageIndex = 0
    TabOrder = 6
    OnClick = buttonAniToLeftClick
  end
  object buttonWithImage: TUButton
    Tag = 6
    Left = 60
    Top = 310
    Width = 151
    TabOrder = 13
    BackColors.Enabled = False
    BackColors.LightColor = 13421772
    BackColors.LightHover = 13421772
    BackColors.LightPress = 10066329
    BackColors.LightDisabled = 13421772
    BackColors.LightFocused = 13421772
    BackColors.DarkColor = 3355443
    BackColors.DarkHover = 3355443
    BackColors.DarkPress = 6710886
    BackColors.DarkDisabled = 3355443
    BackColors.DarkFocused = 3355443
    BorderColors.Enabled = False
    BorderColors.LightColor = 13421772
    BorderColors.LightHover = 8026746
    BorderColors.LightPress = 10066329
    BorderColors.LightDisabled = 8026746
    BorderColors.LightFocused = 8026746
    BorderColors.DarkColor = 3355443
    BorderColors.DarkHover = 8750469
    BorderColors.DarkPress = 6710886
    BorderColors.DarkDisabled = 8750469
    BorderColors.DarkFocused = 8750469
    TextColors.Enabled = False
    TextColors.LightColor = clBlack
    TextColors.LightHover = clBlack
    TextColors.LightPress = clBlack
    TextColors.LightDisabled = clGray
    TextColors.LightFocused = clBlack
    TextColors.DarkColor = clWhite
    TextColors.DarkHover = clWhite
    TextColors.DarkPress = clWhite
    TextColors.DarkDisabled = clGray
    TextColors.DarkFocused = clWhite
    Caption = 'Button with image'
  end
  object drawerNavigation: TUPanel
    Left = 0
    Top = 92
    Width = 45
    Height = 498
    Align = alLeft
    FullRepaint = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    BackColor.Enabled = False
    BackColor.Color = clWhite
    BackColor.LightColor = 15132390
    BackColor.DarkColor = 2039583
    object buttonOpenMenu: TUSymbolButton
      Left = 0
      Top = 0
      Width = 45
      Height = 45
      Align = alTop
      Constraints.MaxWidth = 45
      TabOrder = 0
      OnClick = buttonOpenMenuClick
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
      SymbolChar = #59136
      Text = '-'
      TextOffset = 45
      Detail = 'Detail'
      ShowDetail = False
      KeepOrginalColor = False
    end
    object buttonMenuSettings: TUSymbolButton
      Left = 0
      Top = 90
      Width = 45
      Height = 45
      Align = alTop
      TabOrder = 2
      OnClick = buttonMenuSettingsClick
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
      SymbolChar = #57621
      Text = 'Settings'
      TextOffset = 45
      Detail = 'Detail'
      ShowDetail = False
      KeepOrginalColor = False
    end
    object buttonMenuProfile: TUSymbolButton
      Left = 0
      Top = 180
      Width = 45
      Height = 45
      Align = alTop
      TabOrder = 4
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
      SymbolChar = #57686
      Text = 'My profile'
      TextOffset = 45
      Detail = 'Detail'
      ShowDetail = False
      KeepOrginalColor = False
    end
    object buttonMenuSave: TUSymbolButton
      Left = 0
      Top = 135
      Width = 45
      Height = 45
      Align = alTop
      TabOrder = 3
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
      SymbolChar = #57605
      Text = 'Save document'
      TextOffset = 45
      Detail = 'Detail'
      ShowDetail = False
      KeepOrginalColor = False
    end
    object buttonMenuOpen: TUSymbolButton
      Left = 0
      Top = 45
      Width = 45
      Height = 45
      Align = alTop
      TabOrder = 1
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
      SymbolChar = #60739
      Text = 'Open document'
      TextOffset = 45
      Detail = 'Detail'
      ShowDetail = False
      KeepOrginalColor = False
    end
    object buttonMenuRate: TUSymbolButton
      Left = 0
      Top = 225
      Width = 45
      Height = 45
      Align = alTop
      TabOrder = 5
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
      SymbolChar = #57806
      Text = 'Rate this app'
      TextOffset = 45
      Detail = 'Detail'
      ShowDetail = False
      KeepOrginalColor = False
    end
  end
  object TrackBar1: TTrackBar
    Left = 555
    Top = 410
    Width = 150
    Height = 31
    ShowSelRange = False
    TabOrder = 32
    TickMarks = tmBoth
    TickStyle = tsNone
  end
  object boxSettings: TUScrollBox
    Left = 750
    Top = 92
    Width = 250
    Height = 498
    HorzScrollBar.Tracking = True
    VertScrollBar.Tracking = True
    Align = alRight
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    Color = clWhite
    Padding.Left = 15
    Padding.Top = 5
    Padding.Right = 15
    Padding.Bottom = 15
    ParentColor = False
    TabOrder = 3
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
    MaxScrollCount = 6
    object headingSettings: TUText
      AlignWithMargins = True
      Left = 15
      Top = 5
      Width = 203
      Height = 28
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Settings'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      TextKind = tkHeading
      ExplicitWidth = 71
    end
    object entryAppTheme: TUText
      AlignWithMargins = True
      Left = 15
      Top = 43
      Width = 203
      Height = 17
      Margins.Left = 0
      Margins.Top = 5
      Margins.Right = 0
      Margins.Bottom = 5
      Align = alTop
      Caption = 'App theme'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      TextKind = tkEntry
      ExplicitWidth = 68
    end
    object entryUserProfile: TUText
      AlignWithMargins = True
      Left = 15
      Top = 240
      Width = 203
      Height = 17
      Margins.Left = 0
      Margins.Top = 10
      Margins.Right = 0
      Margins.Bottom = 10
      Align = alTop
      Caption = 'User profile'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
      TextKind = tkEntry
      ExplicitWidth = 69
    end
    object imgAvatar: TImage
      Left = 15
      Top = 267
      Width = 203
      Height = 72
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 10
      Align = alTop
      Center = True
      ParentShowHint = False
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000480000
        0048080600000055EDB347000000017352474200AECE1CE90000000467414D41
        0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000008
        2E4944415478DAED9A0970146516C7FF3D3D992B9923072831864384284B0A36
        1CD140C0C8E19AB8B05B2052E8A26C59BA5A78E0011E55C1F2C2C28896552AEA
        EEBA029607EE0202CAA19022501A02AB22A0820221971C93CC91C95C3DEDFBBA
        C34064263D81E00C93FE57A552F3F537D3FDFDE6BDFF7B5F4F7350D5A9B8785F
        40A24B05A42015908254400A5201294805A42015908254400A5201294805A420
        15908254400A5201292822205104B777614EBA1782C6A4E7C4785FE48594C727
        7206F0A1210BEB9A390E67AD3522A0EFCA7332F421EF6E9D46B405042435A014
        1E5C40E09A3D41D31FF317D536C70468DF73D9993A8FB7364D071301420A42F1
        5EC70551001A06086E3F5ABDBC29F70F4FD5D9BB00C87750CF8B361F01724127
        214A16C36229A1A13F33FCD013201F459097370E8C19504D799F2CABE03F98C6
        0BD626C1803F0B37C0013D4D4E8E4812098F0D5EACE137E012DE0B77906FB10B
        FA81A317359CEC12203301AA2740638529F088063A22C47B6DDD241EA99C17DB
        F8D5C82640AEF301D44080AE136E828333D2EC24F16B91834D6CC316FE13F4E9
        16408152386C9702563310BAC8D34C43EED3E282CDD1882D29EBBB11507A1F20
        DD9A1C80EC0ED85A1A2E00209BE5E200449D2E8201EA4F749101353B7B302051
        F6C9FCACDEF8B6E1A80C89415101B5CBD38AF9D796E0D9C2623C53B3032FEEDA
        0137BB668E5301A1AD15A58387626DE9F4F0D07D559BF1EACE2AC060ECE1807C
        5EE4F5BA14D5D36F8759A79786AA1AEB50BAFA3D3805E1749A253420E60F4290
        FA34EDE990EF0E0502B0EA0DA89E3107836C19D2509DDB85111FFC13BFB4BA3A
        9A75C20262DF22BDF74A32CF03277E91219D699EE7AA90207DF6A75367E186DC
        01D2909F5E8FFDEF3254D71D3E9D5A090DC8EB85C96040C5D8499873553E2ABE
        A9C6E3E40D922295E258C522D2EBC1920937E181FC91F26B8ACCD99FAFC5BB5F
        5703A6D4B3DF935080D85C6F1B0A73FBE3CD92320CCDEC153EF459EDCFB863D3
        1A34395BCEFE96631555AC3B0BAEC19BE3FF1486B3F8FF5FE1D12FD6014653E4
        344E184001BFF46FFE88223C53381EDA08E954EB7662F6C6D5D87AE840F40545
        539B07C5FD0761CBD499D070F267AF3BF213CA56AD00B429D1D337EE80DAC3BE
        5F666FBC71DD8D98DCEE0B4CCC38DFDE5383B9C30B91D91E35219AFF30A5DB92
        9AEDF2C2B45A65387E1F72C98C6B6E9E835E0C2CE987163B4691293B7D3E4ADB
        94E8EF8D2B2056A1FC7ECC1C321CAF8E9B1C86C0B4F6F041DC4DA15F7FBC0979
        97F5C5F2C953514065F99456FCB8573AEEA69484DE10FD1CC1200C3C8F1DD3EF
        C0F05E9748436E3AE7A895EF60FFB1C6CEDF1B5740B430B331154B8A27E2EF57
        0F0B0F0768FE633BB6A062D7763985588F42738DF4FFF5921B313B2F3F3C77CF
        C9E3B875E32A798B1029E5D8B929753F289B819B07E6C9B70669CA94F52BB166
        FFB7914D392100313FE87B05969694222F3DB3C382EFA48AF2D5D143B460763F
        E90C5F60D146FDCBFDE4512F8D99403E225F8A9BC6FEB1753D96EFD92DC3A468
        098B4C7961F164948F2CA24C16891F87C7BFACC4F3DBA9229AD294E1C405107D
        A34F8E2AC6D385E33A0C2FFD6E37E66DDB040F75B851C39EF915C11D4F66BB6C
        D214E4A499C3875EFE66271EDAB691DA1C3A9F9E40B5BA31636801DEA779A72A
        D67B07F661D6DA0FE5E35C8C3DD5EF0E880C73DE8831A8282A915E9EA0F499BB
        F533BCBFEF6B8A009DDC102A894C3DDB9A81FFD0E227E4F40B0F5736D44A55EE
        48533D0A060C46D55F6F83A1DDC4779197157DF46FF818C0588C3D6E80D8B749
        51B29C3688032C36CCDAF03F1C3A798C7A9B2E966DD616D0FC8AB113316FD8E8
        F07093C78D0514894F8C1E872BDBB711C729EA467CF82FD452E542FBBE2B7101
        31D19896BC422058225BE8B976C76CDB405DF7AD944AAC45488D50AE595B5042
        1BD0CA9F7F948DBCAB8A5B153B357EDEFB2B8A488F07C3B22FA756E02F189291
        2545A954B028C2EEA9DC80D76BAA6237E58401D4DDA2B4B55084BC757D1995F4
        ABA4A1D7C8F8EF254F92B626E77A3720690031B1FBCAB4337F967C6954EF6C4C
        A2D4926EA89E59FA7B342026312475CF52A5620541731E709212900489C58D18
        7BAF93908084187F9666DED11D37CA2E2640EC436C7AF67043E7C6C98E3A6863
        19F42BECB8930A10454E3A559B9A69B3914ED54514A3FF7ECFCAF4519713B7D0
        8674BFFD786C5D762202B22F1D606DA9731C366B055BBD60C4187F19DC19D951
        01D952D3D0F0B77B618CB1F26E6AACC7A48FDF8D4F14B5033237D7A34AB70ED9
        7C1B03D46CC94AEF9775FF41674C80D6CFCDC8C935897BD3F890457A3E283811
        4EF6F082C52C5795DF006211B473DAED946606889D3CB1C752F0A8DB81991B56
        E17BFB89AEEDA1BA4BCCE81D2E581D8D58A3DD2C3F1F24F08EBD2D183263A9BD
        BE5340E55743E7CFE4176B386E9A46C3B1BB59D2032F2EA440641F1CB13913A5
        855B084E2C01E4220F6A250F32C4CB83A44BA66BA62FDA8C8074CD221B09898D
        B4555AD9DF233C72D72E3A1009D0FC22FE158B91BBAF95B653BEA01C0AECC14F
        AD0441ECE47C2202A1F0FDABE8F3E88FA7095A4DFC1FE6632B0A4AAB92AF45AF
        0597465B4887577CF9852AE1C1B3009517C0D466D41ED16A90150C25F793ADD1
        446BE784108EF983C17E4BBE445B07400B462253D4697FA246D52AF450403C03
        24A03920040712207B0740E585C8F0F2DA5AB2865421417F7EFF1D002110848B
        92AFEFA22A347700B4600CD243A2B68622C816EAA111441D00476BB7FBF8E0C8
        572AD1D20110DBE92C98000BE78546CFF74C403E818A9B01A1459BE1E470AA48
        A9EA542A2005A98014A40252900A48412A2005A98014A40252900A48412A2005
        A98014A40252900A48412A2005FD0ACC37D794B0EDAE810000000049454E44AE
        426082}
      ShowHint = False
      ExplicitLeft = 25
      ExplicitTop = 472
      ExplicitWidth = 220
    end
    object entryAccountType: TUText
      AlignWithMargins = True
      Left = 15
      Top = 474
      Width = 203
      Height = 17
      Margins.Left = 0
      Margins.Top = 10
      Margins.Right = 0
      Margins.Bottom = 10
      Align = alTop
      Caption = 'Account'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
      TextKind = tkEntry
      ExplicitWidth = 50
    end
    object desAccountHint: TUText
      AlignWithMargins = True
      Left = 15
      Top = 673
      Width = 203
      Height = 30
      Margins.Left = 0
      Margins.Top = 5
      Margins.Right = 0
      Margins.Bottom = 10
      Align = alTop
      Caption = 'Upgrade to Developer account to get more features'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      TextKind = tkDescription
      ExplicitWidth = 198
    end
    object entryStorage: TUText
      AlignWithMargins = True
      Left = 15
      Top = 646
      Width = 203
      Height = 17
      Margins.Left = 0
      Margins.Top = 10
      Margins.Right = 0
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Free storage'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
      TextKind = tkEntry
      ExplicitWidth = 76
    end
    object desStorageHint: TUText
      AlignWithMargins = True
      Left = 15
      Top = 768
      Width = 203
      Height = 30
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 10
      Align = alTop
      Caption = 'Your are using 3/5 GB of free cloud storage'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      TextKind = tkDescription
      ExplicitWidth = 186
    end
    object headingAbout: TUText
      AlignWithMargins = True
      Left = 15
      Top = 828
      Width = 203
      Height = 28
      Margins.Left = 0
      Margins.Top = 20
      Margins.Right = 0
      Margins.Bottom = 5
      Align = alTop
      Caption = 'About'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TextKind = tkHeading
      ExplicitWidth = 55
    end
    object desAppVersion: TUText
      AlignWithMargins = True
      Left = 15
      Top = 906
      Width = 203
      Height = 15
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 5
      Align = alTop
      Caption = 'App version: 1.1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      TextKind = tkDescription
      ExplicitWidth = 84
    end
    object desFlashVersion: TUText
      AlignWithMargins = True
      Left = 15
      Top = 926
      Width = 203
      Height = 15
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Flash version: 31.0.0.14'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      TextKind = tkDescription
      ExplicitWidth = 119
    end
    object desChromiumVersion: TUText
      AlignWithMargins = True
      Left = 15
      Top = 946
      Width = 203
      Height = 15
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Chromium version: 71.0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      TextKind = tkDescription
      ExplicitWidth = 126
    end
    object linkEmbarcadero: TUHyperLink
      AlignWithMargins = True
      Left = 15
      Top = 966
      Width = 203
      Height = 13
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 10
      Align = alTop
      Caption = 'https://example.com/'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 14120960
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TextColors.Enabled = False
      TextColors.LightColor = 14120960
      TextColors.LightHover = clBlue
      TextColors.LightPress = clMedGray
      TextColors.LightDisabled = clGray
      TextColors.LightFocused = 14120960
      TextColors.DarkColor = 14120960
      TextColors.DarkHover = clBlue
      TextColors.DarkPress = clMedGray
      TextColors.DarkDisabled = clGray
      TextColors.DarkFocused = 14120960
      URL = 'https://example.com/'
      ExplicitWidth = 104
    end
    object separatorLastBox: TUSeparator
      Left = 15
      Top = 989
      Width = 203
      Height = 10
      Align = alTop
      CustomColor = clBlack
      Orientation = oHorizontal
      AlignSpace = 5
      LineBetween = False
      ExplicitTop = 488
    end
    object checkColorBorder: TUCheckBox
      Left = 15
      Top = 200
      Width = 203
      Align = alTop
      Enabled = False
      TabOrder = 4
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      Caption = 'Color on window border'
    end
    object checkAutoSync: TUCheckBox
      AlignWithMargins = True
      Left = 15
      Top = 374
      Width = 203
      Margins.Left = 0
      Margins.Top = 5
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      TabOrder = 6
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      Caption = 'Auto synchronize'
    end
    object checkKeepEmailPrivate: TUCheckBox
      Left = 15
      Top = 434
      Width = 203
      Align = alTop
      TabOrder = 8
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      Caption = 'Keep my email in private'
    end
    object checkSendEmail: TUCheckBox
      Left = 15
      Top = 404
      Width = 203
      Align = alTop
      TabOrder = 7
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      Caption = 'Send me emails'
    end
    object radioSystemTheme: TURadioButton
      Left = 15
      Top = 65
      Width = 203
      Align = alTop
      TabOrder = 0
      OnClick = radioSystemThemeClick
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      Group = 'AppTheme'
      Caption = 'Use system setting'
    end
    object radioLightTheme: TURadioButton
      Left = 15
      Top = 95
      Width = 203
      Align = alTop
      TabOrder = 1
      OnClick = radioLightThemeClick
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      Group = 'AppTheme'
      Caption = 'Light'
    end
    object radioDarkTheme: TURadioButton
      Left = 15
      Top = 125
      Width = 203
      Align = alTop
      TabOrder = 2
      OnClick = radioDarkThemeClick
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      Group = 'AppTheme'
      Caption = 'Dark'
    end
    object radioFreeAccount: TURadioButton
      Left = 15
      Top = 501
      Width = 203
      Align = alTop
      TabOrder = 9
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      Group = 'AccountType'
      Caption = 'Free user'
    end
    object radioProAccount: TURadioButton
      Left = 15
      Top = 531
      Width = 203
      Align = alTop
      TabOrder = 10
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      Group = 'AccountType'
      Caption = 'Professional user'
    end
    object radioDevAccount: TURadioButton
      Left = 15
      Top = 561
      Width = 203
      Align = alTop
      TabOrder = 11
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      Group = 'AccountType'
      Caption = 'Developer'
    end
    object panelSelectAccentColor: TUPanel
      AlignWithMargins = True
      Left = 15
      Top = 160
      Width = 203
      Height = 35
      Margins.Left = 0
      Margins.Top = 5
      Margins.Right = 0
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Select custom accent color'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = panelSelectAccentColorClick
      BackColor.Enabled = False
      BackColor.Color = -1
      BackColor.LightColor = 15132390
      BackColor.DarkColor = 2039583
    end
    object buttonDeleteAccount: TUButton
      Tag = 2
      AlignWithMargins = True
      Left = 15
      Top = 596
      Width = 203
      Margins.Left = 0
      Margins.Top = 5
      Margins.Right = 0
      Margins.Bottom = 10
      Align = alTop
      TabOrder = 13
      BackColors.Enabled = False
      BackColors.LightColor = 13421772
      BackColors.LightHover = 13421772
      BackColors.LightPress = 10066329
      BackColors.LightDisabled = 13421772
      BackColors.LightFocused = 13421772
      BackColors.DarkColor = 3355443
      BackColors.DarkHover = 3355443
      BackColors.DarkPress = 6710886
      BackColors.DarkDisabled = 3355443
      BackColors.DarkFocused = 3355443
      BorderColors.Enabled = False
      BorderColors.LightColor = 13421772
      BorderColors.LightHover = 8026746
      BorderColors.LightPress = 10066329
      BorderColors.LightDisabled = 8026746
      BorderColors.LightFocused = 8026746
      BorderColors.DarkColor = 3355443
      BorderColors.DarkHover = 8750469
      BorderColors.DarkPress = 6710886
      BorderColors.DarkDisabled = 8750469
      BorderColors.DarkFocused = 8750469
      TextColors.Enabled = False
      TextColors.LightColor = clBlack
      TextColors.LightHover = clBlack
      TextColors.LightPress = clBlack
      TextColors.LightDisabled = clGray
      TextColors.LightFocused = clBlack
      TextColors.DarkColor = clWhite
      TextColors.DarkHover = clWhite
      TextColors.DarkPress = clWhite
      TextColors.DarkDisabled = clGray
      TextColors.DarkFocused = clWhite
      Caption = 'Delete my account'
    end
    object buttonUpgradeAccount: TUButton
      Tag = 2
      AlignWithMargins = True
      Left = 15
      Top = 713
      Width = 203
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 10
      Align = alTop
      TabOrder = 14
      BackColors.Enabled = False
      BackColors.LightColor = 13421772
      BackColors.LightHover = 13421772
      BackColors.LightPress = 10066329
      BackColors.LightDisabled = 13421772
      BackColors.LightFocused = 13421772
      BackColors.DarkColor = 3355443
      BackColors.DarkHover = 3355443
      BackColors.DarkPress = 6710886
      BackColors.DarkDisabled = 3355443
      BackColors.DarkFocused = 3355443
      BorderColors.Enabled = False
      BorderColors.LightColor = 13421772
      BorderColors.LightHover = 8026746
      BorderColors.LightPress = 10066329
      BorderColors.LightDisabled = 8026746
      BorderColors.LightFocused = 8026746
      BorderColors.DarkColor = 3355443
      BorderColors.DarkHover = 8750469
      BorderColors.DarkPress = 6710886
      BorderColors.DarkDisabled = 8750469
      BorderColors.DarkFocused = 8750469
      TextColors.Enabled = False
      TextColors.LightColor = clBlack
      TextColors.LightHover = clBlack
      TextColors.LightPress = clBlack
      TextColors.LightDisabled = clGray
      TextColors.LightFocused = clBlack
      TextColors.DarkColor = clWhite
      TextColors.DarkHover = clWhite
      TextColors.DarkPress = clWhite
      TextColors.DarkDisabled = clGray
      TextColors.DarkFocused = clWhite
      Caption = 'Upgrade account'
    end
    object progressStorageUsed: TUProgressBar
      AlignWithMargins = True
      Left = 15
      Top = 753
      Width = 203
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 10
      Align = alTop
      TabOrder = 15
      AniSet.AniKind = akOut
      AniSet.AniFunctionKind = afkQuartic
      AniSet.DelayStartTime = 0
      AniSet.Duration = 250
      AniSet.Step = 25
      BackColor.Enabled = False
      BackColor.Color = 15132390
      BackColor.LightColor = 13421772
      BackColor.DarkColor = 3355443
      FillColor.Enabled = False
      FillColor.Color = 15132390
      FillColor.LightColor = 13421772
      FillColor.DarkColor = 3355443
      Value = 64
      Orientation = oHorizontal
    end
    object buttonCheckUpdate: TUButton
      Tag = 2
      AlignWithMargins = True
      Left = 15
      Top = 866
      Width = 203
      Margins.Left = 0
      Margins.Top = 5
      Margins.Right = 0
      Margins.Bottom = 10
      Align = alTop
      TabOrder = 16
      BackColors.Enabled = False
      BackColors.LightColor = 13421772
      BackColors.LightHover = 13421772
      BackColors.LightPress = 10066329
      BackColors.LightDisabled = 13421772
      BackColors.LightFocused = 13421772
      BackColors.DarkColor = 3355443
      BackColors.DarkHover = 3355443
      BackColors.DarkPress = 6710886
      BackColors.DarkDisabled = 3355443
      BackColors.DarkFocused = 3355443
      BorderColors.Enabled = False
      BorderColors.LightColor = 13421772
      BorderColors.LightHover = 8026746
      BorderColors.LightPress = 10066329
      BorderColors.LightDisabled = 8026746
      BorderColors.LightFocused = 8026746
      BorderColors.DarkColor = 3355443
      BorderColors.DarkHover = 8750469
      BorderColors.DarkPress = 6710886
      BorderColors.DarkDisabled = 8750469
      BorderColors.DarkFocused = 8750469
      TextColors.Enabled = False
      TextColors.LightColor = clBlack
      TextColors.LightHover = clBlack
      TextColors.LightPress = clBlack
      TextColors.LightDisabled = clGray
      TextColors.LightFocused = clBlack
      TextColors.DarkColor = clWhite
      TextColors.DarkHover = clWhite
      TextColors.DarkPress = clWhite
      TextColors.DarkDisabled = clGray
      TextColors.DarkFocused = clWhite
      Caption = 'Check for update'
    end
    object editAccountName: TUEdit
      Left = 15
      Top = 339
      Width = 203
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 5
      BorderThickness = 1
      BackColor.Enabled = False
      BackColor.Color = clWhite
      BackColor.LightColor = clWhite
      BackColor.DarkColor = clBlack
      BackColor.FocusedLightColor = clBlack
      BackColor.FocusedDarkColor = clBlack
      BorderColor.Enabled = False
      BorderColor.Color = clBlack
      BorderColor.LightColor = 10066329
      BorderColor.DarkColor = 6710886
      BorderColor.FocusedLightColor = 14120960
      BorderColor.FocusedDarkColor = 14120960
      Transparent = True
    end
  end
  object dialogSelectColor: TColorDialog
    Color = 14120960
    Left = 560
    Top = 110
  end
  object popupEdit: TUPopupMenu
    AniSet.AniKind = akOut
    AniSet.AniFunctionKind = afkQuartic
    AniSet.DelayStartTime = 0
    AniSet.Duration = 120
    AniSet.Step = 20
    OnItemClick = popupEditItemClick
    Left = 666
    Top = 112
    object CutCtrlX1: TMenuItem
      Caption = #57707'Cut|Ctrl+X'
      Hint = 'Remove the selected content and put it on the clipboard'
    end
    object CopyCtrlC1: TMenuItem
      Caption = #57711'Copy|Ctrl+C'
      Hint = 'Copy the selected content to the clipboard'
    end
    object PasteCtrlV1: TMenuItem
      Caption = #57709'Paste|Ctrl+V'
      Hint = 'Insert the contents of the clipboard at the current location'
    end
  end
end
