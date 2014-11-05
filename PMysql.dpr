program PMysql;

uses
  Forms,
  uDBConnector in 'uDBConnector.pas' {FormDB};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormDB, FormDB);
  Application.Run;
end.
