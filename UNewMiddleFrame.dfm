object Frame4: TFrame4
  Left = 0
  Top = 0
  Width = 1084
  Height = 758
  TabOrder = 0
  object GridPanel1: TGridPanel
    Left = 0
    Top = 0
    Width = 1084
    Height = 758
    Align = alClient
    BevelOuter = bvNone
    ColumnCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = Panel2
        Row = 0
      end
      item
        Column = 1
        Control = Panel3
        Row = 0
      end
      item
        Column = 0
        Control = Panel4
        Row = 1
      end
      item
        Column = 1
        Control = Panel5
        Row = 1
      end>
    RowCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end
      item
        SizeStyle = ssAuto
      end>
    TabOrder = 0
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 542
      Height = 379
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 5
      Color = clSilver
      ParentBackground = False
      TabOrder = 0
      object Panel6: TPanel
        AlignWithMargins = True
        Left = 35
        Top = 35
        Width = 442
        Height = 330
        Margins.Left = 30
        Margins.Top = 30
        Margins.Right = 30
        Margins.Bottom = 30
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        ExplicitWidth = 472
        ExplicitHeight = 309
        object LAuftrag: TLabel
          Left = 175
          Top = 154
          Width = 472
          Height = 18
          Caption = 'Auftragsnummer'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object LLiegenschaft: TLabel
          Left = 191
          Top = 50
          Width = 104
          Height = 18
          Caption = 'Liegenschaft'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object LNutzer: TLabel
          Left = 175
          Top = 103
          Width = 120
          Height = 18
          Caption = 'Nutzernummer'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 98
          Top = 201
          Width = 99
          Height = 18
          Caption = 'neuer Name'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object EAuftrag: TEdit
          Left = 322
          Top = 141
          Width = 79
          Height = 26
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object ELiegenschaft: TEdit
          Left = 322
          Top = 42
          Width = 79
          Height = 26
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = '1234567'
        end
        object ENutzer: TEdit
          Left = 322
          Top = 95
          Width = 79
          Height = 26
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Text = '1234'
        end
        object mxFlatButton1: TmxFlatButton
          Left = 157
          Top = 256
          Width = 244
          Height = 25
          Caption = 'Daten eingeben'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -17
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Visible = False
          Activate = True
          BorderColor = clBtnShadow
          Flat = True
          ShowBorder = True
          Version = '1.29'
        end
        object Edit1: TEdit
          Left = 239
          Top = 198
          Width = 162
          Height = 26
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          Visible = False
        end
      end
    end
    object Panel3: TPanel
      Left = 542
      Top = 0
      Width = 542
      Height = 379
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 5
      Color = clSilver
      ParentBackground = False
      TabOrder = 1
      object Panel7: TPanel
        AlignWithMargins = True
        Left = 35
        Top = 35
        Width = 443
        Height = 330
        Margins.Left = 30
        Margins.Top = 30
        Margins.Right = 30
        Margins.Bottom = 30
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        ExplicitWidth = 472
        ExplicitHeight = 309
        object Label1: TLabel
          Left = 136
          Top = 32
          Width = 60
          Height = 18
          Caption = 'Auftrag'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object RGerledigt: TmxFlatRadioGroup
          AlignWithMargins = True
          Left = 90
          Top = 90
          Width = 263
          Height = 150
          Margins.Left = 90
          Margins.Top = 90
          Margins.Right = 90
          Margins.Bottom = 90
          BorderColor = clBtnShadow
          Flat = True
          ShowBorder = True
          Version = '1.29'
          Align = alClient
          TabOrder = 0
          ItemIndex = 1
          Items.Strings = (
            'erledigt'
            'nicht erledigt')
          ExplicitWidth = 292
          ExplicitHeight = 129
        end
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 379
      Width = 542
      Height = 379
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 5
      Color = clSilver
      ParentBackground = False
      TabOrder = 2
      object Panel8: TPanel
        AlignWithMargins = True
        Left = 35
        Top = 35
        Width = 442
        Height = 330
        Margins.Left = 30
        Margins.Top = 30
        Margins.Right = 30
        Margins.Bottom = 30
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        OnClick = changeEnabledMontage
        OnDblClick = changeEnabledMontage
        ExplicitLeft = 37
        ExplicitTop = 33
        ExplicitWidth = 472
        ExplicitHeight = 309
        object Label2: TLabel
          Left = 113
          Top = 98
          Width = 126
          Height = 18
          Caption = 'Eingangsdatum'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object LMontage: TLabel
          Left = 117
          Top = 142
          Width = 122
          Height = 18
          Caption = 'Montagedatum'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          OnDblClick = changeEnabledMontage
        end
        object LGueltigkeit: TLabel
          Left = 98
          Top = 186
          Width = 141
          Height = 18
          Caption = 'G'#252'ltigkeitsdatum'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          OnClick = changeEnabledGueltigkeit
          OnDblClick = changeEnabledGueltigkeit
        end
        object DTEingangsdatum: TmxFlatDateTimePicker
          Left = 271
          Top = 103
          Width = 130
          Height = 21
          CalColors.TitleBackColor = 11960426
          CalColors.TrailingTextColor = clSilver
          Date = 41844.601099166670000000
          Time = 41844.601099166670000000
          TabOrder = 0
          Activate = True
          BorderColor = clBtnShadow
          Flat = True
          ShowBorder = True
          Version = '1.29'
        end
        object DTMontageDatum: TmxFlatDateTimePicker
          Left = 271
          Top = 144
          Width = 130
          Height = 21
          Date = 41844.601099166670000000
          Time = 41844.601099166670000000
          TabOrder = 1
          Activate = True
          BorderColor = clBtnShadow
          Flat = True
          ShowBorder = True
          Version = '1.29'
        end
        object DTGueltigkeitsdatum: TmxFlatDateTimePicker
          Left = 271
          Top = 185
          Width = 130
          Height = 21
          Date = 41844.601099166670000000
          Time = 41844.601099166670000000
          TabOrder = 2
          Activate = True
          BorderColor = clBtnShadow
          Flat = True
          ShowBorder = True
          Version = '1.29'
        end
      end
    end
    object Panel5: TPanel
      Left = 542
      Top = 379
      Width = 542
      Height = 379
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 5
      Color = clSilver
      ParentBackground = False
      TabOrder = 3
      object Panel9: TPanel
        AlignWithMargins = True
        Left = 35
        Top = 35
        Width = 443
        Height = 330
        Margins.Left = 30
        Margins.Top = 30
        Margins.Right = 30
        Margins.Bottom = 30
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        ExplicitWidth = 472
        ExplicitHeight = 309
        object Label5: TLabel
          Left = 136
          Top = 24
          Width = 63
          Height = 18
          Caption = 'Notizen'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object MENotizen: TmxFlatMemo
          AlignWithMargins = True
          Left = 20
          Top = 161
          Width = 403
          Height = 139
          Hint = 'bitte hier Ihre Notizen eingeben'
          Margins.Left = 20
          Margins.Top = 20
          Margins.Right = 20
          Margins.Bottom = 30
          Align = alBottom
          Alignment = taCenter
          BevelInner = bvNone
          BevelOuter = bvNone
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = []
          Lines.Strings = (
            '')
          ParentFont = False
          TabOrder = 0
          Activate = True
          BorderColor = 16101007
          Flat = True
          ShowBorder = True
          Version = '1.29'
          ExplicitTop = 140
          ExplicitWidth = 432
        end
      end
    end
  end
end
