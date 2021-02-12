object formLoginDialog: TformLoginDialog
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Login'
  ClientHeight = 560
  ClientWidth = 410
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 17
  object boxMain: TUScrollBox
    Left = 0
    Top = 32
    Width = 410
    Height = 476
    HorzScrollBar.Tracking = True
    VertScrollBar.Tracking = True
    Align = alClient
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    Color = 2039583
    Padding.Left = 40
    Padding.Right = 40
    Padding.Bottom = 50
    ParentColor = False
    TabOrder = 0
    StyleElements = []
    AniSet.AniKind = akOut
    AniSet.AniFunctionKind = afkQuartic
    AniSet.DelayStartTime = 0
    AniSet.Duration = 250
    AniSet.Step = 25
    AniSet.Queue = True
    BackColor.Enabled = False
    BackColor.Color = clBlack
    BackColor.LightColor = 15132390
    BackColor.DarkColor = 2039583
    MaxScrollCount = 6
    object titleSignin: TUText
      AlignWithMargins = True
      Left = 40
      Top = 50
      Width = 137
      Height = 38
      Margins.Left = 0
      Margins.Top = 50
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      Alignment = taCenter
      Caption = 'Hello, John'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -28
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TextKind = tkTitle
      UseAccentColor = True
    end
    object headingSignin: TUText
      AlignWithMargins = True
      Left = 40
      Top = 88
      Width = 197
      Height = 28
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 20
      Align = alTop
      Alignment = taCenter
      Caption = 'Log in to your account'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TextKind = tkHeading
    end
    object entryPassword: TUText
      Left = 40
      Top = 208
      Width = 58
      Height = 17
      Align = alTop
      Caption = 'Password'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
      TextKind = tkEntry
    end
    object entryEmail: TUText
      Left = 40
      Top = 136
      Width = 32
      Height = 17
      Align = alTop
      Caption = 'Email'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
      TextKind = tkEntry
    end
    object textShowMoreOptions: TUText
      AlignWithMargins = True
      Left = 40
      Top = 352
      Width = 103
      Height = 15
      Cursor = crHandPoint
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Show more options'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = textShowMoreOptionsClick
      TextKind = tkDescription
    end
    object entryDescription: TUText
      Left = 40
      Top = 280
      Width = 130
      Height = 17
      Align = alTop
      Caption = 'Description (optional)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
      TextKind = tkEntry
    end
    object panelMoreOptions: TUPanel
      Left = 40
      Top = 372
      Width = 330
      Height = 80
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ShowCaption = False
      TabOrder = 3
      Visible = False
      BackColor.Enabled = False
      BackColor.Color = clBlack
      BackColor.LightColor = 15132390
      BackColor.DarkColor = 2039583
      object checkSendMeNews: TUCheckBox
        Left = 0
        Top = 30
        Width = 330
        Align = alTop
        IconFont.Charset = DEFAULT_CHARSET
        IconFont.Color = clWindowText
        IconFont.Height = -20
        IconFont.Name = 'Segoe MDL2 Assets'
        IconFont.Style = []
        Caption = 'Send me news about offers'
        TabOrder = 1
        ExplicitTop = 36
      end
      object checkKeepLogin: TUCheckBox
        Left = 0
        Top = 0
        Width = 330
        Align = alTop
        IconFont.Charset = DEFAULT_CHARSET
        IconFont.Color = clWindowText
        IconFont.Height = -20
        IconFont.Name = 'Segoe MDL2 Assets'
        IconFont.Style = []
        Checked = True
        State = cbsChecked
        Caption = 'Keep me logged in'
        TabOrder = 0
      end
    end
    object editEmail: TUEdit
      AlignWithMargins = True
      Left = 40
      Top = 158
      Width = 330
      Margins.Left = 0
      Margins.Top = 5
      Margins.Right = 0
      Margins.Bottom = 20
      Align = alTop
      ParentColor = False
      ParentFont = False
      BevelOuter = bvNone
      Color = clBlack
      TabOrder = 0
      BorderThickness = 2
    end
    object editPassword: TUEdit
      AlignWithMargins = True
      Left = 40
      Top = 230
      Width = 330
      Margins.Left = 0
      Margins.Top = 5
      Margins.Right = 0
      Margins.Bottom = 20
      Align = alTop
      ParentColor = False
      ParentFont = False
      BevelOuter = bvNone
      Color = clBlack
      TabOrder = 1
      BorderThickness = 2
    end
    object editDescription: TUEdit
      AlignWithMargins = True
      Left = 40
      Top = 302
      Width = 330
      Margins.Left = 0
      Margins.Top = 5
      Margins.Right = 0
      Margins.Bottom = 20
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      BorderThickness = 2
      Transparent = True
    end
  end
  object captionbarMain: TUCaptionBar
    Left = 0
    Top = 0
    Width = 410
    Caption = '   Login'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object buttonAppQuit: TUQuickButton
      Left = 365
      Top = 0
      Hint = 'Close'
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe MDL2 Assets'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      ButtonStyle = qbsQuit
      LightColor = 2298344
      DarkColor = 2298344
      PressBrightnessDelta = 32
      Caption = #57606
    end
    object buttonAppMinimized: TUQuickButton
      Left = 320
      Top = 0
      Hint = 'Minimize'
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe MDL2 Assets'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      ButtonStyle = qbsMin
      LightColor = 13619151
      DarkColor = 3947580
      PressBrightnessDelta = -32
      Caption = #59192
    end
    object buttonAppTheme: TUQuickButton
      Left = 275
      Top = 0
      Hint = 'Switch theme'
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe MDL2 Assets'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = buttonAppThemeClick
      ButtonStyle = qbsSysButton
      LightColor = 13619151
      DarkColor = 3947580
      PressBrightnessDelta = -32
      Caption = #59144
    end
  end
  object panelAction: TUPanel
    Left = 0
    Top = 508
    Width = 410
    Height = 52
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    ParentFont = False
    ShowCaption = False
    TabOrder = 2
    BackColor.Enabled = False
    BackColor.Color = clBlack
    BackColor.LightColor = 15132390
    BackColor.DarkColor = 2039583
    object buttonOk: TUButton
      Left = 270
      Top = 10
      Width = 130
      Height = 32
      Align = alRight
      OnClick = buttonOkClick
      Highlight = True
      Caption = 'Ok'
    end
    object buttonCancel: TUButton
      AlignWithMargins = True
      Left = 130
      Top = 10
      Width = 130
      Height = 32
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alRight
      OnClick = buttonCancelClick
      Caption = 'Cancel'
    end
  end
  object popupEdit: TUPopupMenu
    AniSet.AniKind = akOut
    AniSet.AniFunctionKind = afkQuartic
    AniSet.DelayStartTime = 0
    AniSet.Duration = 120
    AniSet.Step = 20
    OnItemClick = popupEditItemClick
    Left = 40
    Top = 102
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
