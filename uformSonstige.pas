unit uformSonstige;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormMiddle, StdCtrls, ComCtrls,  ExtCtrls, Buttons,
  AppEvnts, FileCtrl, NxEdit6;

type
  TFormSonstige = class(TFormMiddle)
    ApplicationEvents1: TApplicationEvents;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormSonstige: TFormSonstige;

implementation

{$R *.dfm}

procedure TFormSonstige.FormKeyPress(Sender: TObject; var Key: Char);
begin
  exit;
end;

procedure TFormSonstige.FormShow(Sender: TObject);
begin
  inherited;
//  LLIegenschaft.SetFocus;
end;

end.
