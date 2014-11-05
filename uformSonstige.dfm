inherited FormSonstige: TFormSonstige
  Caption = 'FormSonstige'
  PixelsPerInch = 96
  TextHeight = 12
  inherited pnotiz: TPanel
    Anchors = []
    inherited lkundennummer: TLabeledEdit
      Top = 53
      EditLabel.ExplicitLeft = 99
      EditLabel.ExplicitTop = 57
      EditLabel.ExplicitWidth = 127
      EditLabel.ExplicitHeight = 18
      ExplicitTop = 53
    end
  end
  inherited FlowPanel1: TFlowPanel
    inherited panel1: TPanel
      inherited Panel7: TPanel
        inherited LAuftragsnummer: TLabeledEdit
          Top = 73
          EditLabel.Width = 109
          EditLabel.Caption = 'Dokumenttyp'
          EditLabel.ExplicitLeft = 127
          EditLabel.ExplicitTop = 77
          EditLabel.ExplicitWidth = 109
          MaxLength = 0
          Visible = False
          ExplicitTop = 73
        end
        inherited LNutzernummer: TLabeledEdit
          Top = 125
          EditLabel.ExplicitTop = 129
          ExplicitTop = 125
        end
      end
    end
    inherited panel3: TPanel
      inherited Panel6: TPanel
        inherited dteingangsdatum: TNxDatePicker6
          Text = '21.08.2014'
        end
      end
    end
  end
  object ApplicationEvents1: TApplicationEvents
    Left = 352
    Top = 240
  end
end
