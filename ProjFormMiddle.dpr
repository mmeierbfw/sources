program ProjFormMiddle;

uses
  Forms,
  uFormMiddle in 'uFormMiddle.pas' {FormMiddle};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMiddle, FormMiddle);
  Application.Run;
end.
