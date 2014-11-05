unit UNewMiddleFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, StdCtrls, mxFlatControls, ComCtrls;

type
  TFrame4 = class(TFrame)
    GridPanel1: TGridPanel;
    Panel2: TPanel;
    Panel6: TPanel;
    Panel3: TPanel;
    Panel7: TPanel;
    Label1: TLabel;
    RGerledigt: TmxFlatRadioGroup;
    Panel4: TPanel;
    Panel8: TPanel;
    Label2: TLabel;
    LMontage: TLabel;
    LGueltigkeit: TLabel;
    DTEingangsdatum: TmxFlatDateTimePicker;
    DTMontageDatum: TmxFlatDateTimePicker;
    DTGueltigkeitsdatum: TmxFlatDateTimePicker;
    Panel5: TPanel;
    Panel9: TPanel;
    Label5: TLabel;
    MENotizen: TmxFlatMemo;
    EAuftrag: TEdit;
    ELiegenschaft: TEdit;
    ENutzer: TEdit;
    LAuftrag: TLabel;
    LLiegenschaft: TLabel;
    LNutzer: TLabel;
    mxFlatButton1: TmxFlatButton;
    Label3: TLabel;
    Edit1: TEdit;
    procedure changeEnabledMontage(Sender: TObject);
    procedure changeEnabledGueltigkeit(Sender: TObject);
    procedure changeEnabledDateTimePicker(tp: TmxFlatDateTimePicker);
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.dfm}

procedure TFrame4.changeEnabledMontage(Sender: TObject);
begin
  changeEnabledDateTimePicker(DTMontageDatum);
end;



procedure TFrame4.changeEnabledGueltigkeit(Sender: TObject);
begin
  changeEnabledDateTimePicker(DTGueltigkeitsdatum);
end;

procedure TFrame4.changeEnabledDateTimePicker(tp: TmxFlatDateTimePicker);
var test: boolean;
begin
  test := tp.enabled;


  tp.Enabled := not test;
end;


end.
