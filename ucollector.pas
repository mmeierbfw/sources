unit ucollector;

interface


type
  TCollector = class(TObject)
  private
  liegenschaft, nutzernummer, auftragsnummer: string;
  erledigt: boolean;
  eingang, montage, gueltigkeit: tdatetime;

  end;


var
  collector: TCollector;
implementation

end.
