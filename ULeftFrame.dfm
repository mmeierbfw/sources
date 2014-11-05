object Frame3: TFrame3
  Left = 0
  Top = 0
  Width = 451
  Height = 625
  Align = alClient
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentBackground = False
  ParentColor = False
  ParentFont = False
  TabOrder = 0
  ExplicitHeight = 304
  object FlowPanel1: TFlowPanel
    Left = 0
    Top = 0
    Width = 451
    Height = 625
    Margins.Top = 50
    Align = alClient
    BevelOuter = bvNone
    Color = clSilver
    FlowStyle = fsTopBottomLeftRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    ExplicitHeight = 304
    DesignSize = (
      451
      625)
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 250
      Height = 48
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      BorderWidth = 1
      Color = 14600124
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      Padding.Left = 15
      Padding.Top = 15
      Padding.Right = 15
      Padding.Bottom = 15
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      object Label4: TLabel
        Left = 5
        Top = 15
        Width = 210
        Height = 20
        Caption = 'Dokumentart ausw'#228'hlen'
        Color = 14600124
        Font.Charset = ANSI_CHARSET
        Font.Color = clGray
        Font.Height = -17
        Font.Name = 'Verdana'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
    end
    object RGDocumentType: TmxFlatRadioGroup
      Left = 0
      Top = 49
      Width = 249
      Height = 144
      BorderColor = clBtnShadow
      Flat = True
      ShowBorder = False
      Version = '1.29'
      Anchors = [akLeft, akTop, akRight]
      Color = clSilver
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -17
      Font.Name = 'Verdana'
      Font.Style = []
      ParentColor = False
      ParentCtl3D = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      ItemIndex = 3
      Items.Strings = (
        'erledigte Auftr'#228'ge'
        'Reklamation'
        'Zwischenablesung'
        'Sonstiges')
    end
    object BScanAndSave: TSpeedButton
      Left = 0
      Top = 194
      Width = 249
      Height = 33
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Scannen und Speichern'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -17
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
  end
end
