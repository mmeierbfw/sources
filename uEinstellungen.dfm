object Einstellungen: TEinstellungen
  Left = 0
  Top = 0
  Caption = 'Einstellungen'
  ClientHeight = 581
  ClientWidth = 666
  Color = 15856113
  DockSite = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BSaveSettings: TButton
    Left = 72
    Top = 496
    Width = 249
    Height = 25
    Caption = 'Einstellungen Speichern'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -15
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = Bsave
  end
  object Panel1: TPanel
    Left = 72
    Top = 80
    Width = 505
    Height = 377
    Color = 15449742
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -15
    Font.Name = 'Verdana'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 48
      Top = 77
      Width = 118
      Height = 18
      Caption = 'Kundennummer'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 48
      Top = 145
      Width = 111
      Height = 18
      Caption = 'Sachbearbeiter'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 48
      Top = 213
      Width = 69
      Height = 18
      Caption = 'Passwort'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 48
      Top = 282
      Width = 83
      Height = 18
      Caption = 'Verzeichnis'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object CheckBox1: TCheckBox
      Left = 287
      Top = 240
      Width = 241
      Height = 17
      Caption = 'Passwort anzeigen'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object Button1: TButton
      Left = 414
      Top = 275
      Width = 51
      Height = 25
      Caption = '...'
      TabOrder = 1
      OnClick = Button1Click
    end
    object epassword: TNxEdit
      Left = 287
      Top = 208
      Width = 176
      Height = 26
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = 'epassword'
      PasswordChar = '*'
    end
    object everzeichnis: TNxEdit
      Left = 287
      Top = 277
      Width = 121
      Height = 26
      BevelInner = bvNone
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnChange = everzeichnisChange
    end
    object ekundennummer: TNxEdit
      Left = 432
      Top = 75
      Width = 32
      Height = 26
      BevelInner = bvNone
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = '01'
      OnKeyPress = ekundennummerKeyPress
    end
    object esachbearbeiter: TNxEdit
      Left = 432
      Top = 140
      Width = 32
      Height = 26
      BevelInner = bvNone
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Text = '01'
      OnKeyPress = ekundennummerKeyPress
    end
  end
  object Button2: TButton
    Left = 327
    Top = 496
    Width = 250
    Height = 25
    Caption = 'abbrechen'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -15
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = Babbrechen
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileName = 'C:\Users\jovani\Documents\RAD Studio\Projekte\Scan\ok.png'
    FileTypes = <>
    Options = [fdoPickFolders]
    Left = 416
    Top = 432
  end
end
