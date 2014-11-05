unit udocs;


interface

        
uses SysUtils;
type

  TDocument = record
  documenttype: integer;
  liegenschaft, nutzer, auftrag: string;
  erledigt: boolean;
  eingang, montage, gueltigkeit: TdateTime;
  notizen: string;
  end;
  
implementation

end.
