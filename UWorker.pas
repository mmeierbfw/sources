unit UWorker;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, uFormLeft, uFormMiddle, UUpperFrame, ucollector,
  umysqlcontroller,
  Menus, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, ZConnection, StdCtrls, tool, uzwischenablesung, uusables,
  uscanningViaWia, shellapi,
  uutils, umontage, udbconnector, uconstants, uformtelefon;

type

  TStringArray = array of string;

  TWorker = class(TObject)

    FormZwischenablesung: TFormZwischenablesung;
    FormLeft: TFormLeft;
    FormMontage: TFormMontage;
    FormMiddle: TFormMiddle;
  public

    function doZwischenablesung(FormZwischenablesung: TFormZwischenablesung;
      FormLeft: TFormLeft; mode: boolean): boolean; overload;
    function doZwischenablesung(FormZwischenablesung: TFormZwischenablesung;
      FormLeft: TFormLeft; filename: string; mode: boolean;
      verarbeitungstyp: integer): boolean; overload;
    function doMontage(FormMontage: TFormMontage; FormLeft: TFormLeft;
      mode: boolean): boolean;
    function doTelefonnotizWithScan(FormNotiz: TFormTelefon;
      FormLeft: TFormLeft): boolean;
    function doTelefonnotiz(FormNotiz: TFormTelefon;
      FormLeft: TFormLeft): boolean;

    function doAll(FormMiddle: TFormMiddle; FormLeft: TFormLeft): boolean;

    Constructor Create();

  private
    scannedDocument: string;
    hasToScan: boolean;
    id, jahr, teilliegenschaft, lieg, nnummer, anummer, knummer, erl, Dok,
      Dokname, PE, ntzn, nname, abldat, vertbg, datname, einbaudat,
      gueltigkeitsdat: string;
    fmypath, pathname: string;

    col: TCollector;
    no: integer;

    zwablg: TDocumentZwischenablesung;
    montg: TDocumentMontage;

    zielverzeichnis, zieldatei: string;
    zielverzeichnisname: string;
    zieldateiname: string;
    { prüfen, ob eine Dokumentart ausgewählt ist }
    function validDocType(): boolean;

    { aktuellen Index erfahren }
    function getCount(query: string): integer;

    { füge eine neue Zwischenablesung in die Datenbank ein }
    function InsertZwischenablesung(doc: TDocumentZwischenablesung): boolean;

    function insertmontage(doc: TDocumentMontage): boolean;
    { irreführender Methodenname. Ruft die Scanmethode auf. True, wenns geklappt hat }
    function scanned(): boolean;

    { hole alle "MiddleForm" Properties und speichere in sprechende Variable }
    procedure getdefProperties(Document: TDocument);
    { hole alle Properties von der Zwischenablesung und speichere in sprechende
      Variablen. }
    procedure getzwiProperties(Zwischenablesg: TDocumentZwischenablesung);

    procedure getMontProperties(montg: TDocumentMontage);
    { ??? Eigentlich hat das hier nichts verloren
      diese Methode erhöht die IDs von 'runningid' um eins }
    function upOne(): boolean;

    { erzeuge eien Pfad aus Kundennummer, Liegenschaft, Dateityp und Datum }
    function createPath(): string;

    { erzeuge einen Dateinamen für das neue Dokument aus Kundennummer, Dateityp, Datum
      und ID }
    function createFileName(): string;

    { prüfe ob eine Liegenschaft siebenstellig ist }
    function validLiegenschaft(): boolean;

    procedure convertTolieg(kr, teilliegenschaft: string);
    function moveonewlocation(): boolean;

  end;


  // valueTypes: TStringArray;

var
  formdb: TFormDB;
  FormZwischenablesung: TFormZwischenablesung;

implementation

{ TWorker }

uses umain;

procedure TWorker.convertTolieg(kr, teilliegenschaft: string);
begin
  while not(length(teilliegenschaft) = 5) do
  begin
    teilliegenschaft := '0' + teilliegenschaft;
  end;
  lieg := kr + teilliegenschaft;
end;

constructor TWorker.Create;
begin

  // pad zum erstellen temporärer Dateien in appdata...
  fmypath := getLocalFolder;
  no := getCount('runningid');
  col := TCollector.Create();

  jahr := '2014';
end;

{ erzeuge einen Dateinamen aus Kundennummer, Liegenscahft, Nutzerunmmer, Typ,
  Datum und ID }
function TWorker.createFileName(): string;
var ending: string;
begin
  if not (scannedDocument = '') then
    ending := ExtractFileExt(scannedDocument)
  else ending := 'pdf';
  // ddate := StrToDateTime(datum);
  Result := knummer + teilliegenschaft + nnummer + '_' + Dok + '_' + abldat +
    '_' + inttostr(no)  + ending;
end;

{ erzeuge einen Pfad aus Kundennummer, LIegenschaft, Typ und Jahr im Tiffverzeichnis }
function TWorker.createPath(): string;
var
  path: WideString;
  filename1: string;
  filename2: string;
  f3: string;

begin
  Result := '';
  path := tiffpath + '\' + knummer + '\' + lieg + '\' + Dok + '\' + jahr + '\';
  if not Directoryexists(path) then
  begin
    forcedirectories(path);
  end;
  Result := path;
end;

function TWorker.insertmontage(doc: TDocumentMontage): boolean;
begin
  formdb := TFormDB.Create(nil);
  try
    Result := formdb.insertintoMontage(doc);
  finally
    formdb.free;

  end;
end;

{ erzeuge einen neuen Eintrag in der Datenbank über udbconnect }
function TWorker.InsertZwischenablesung(doc: TDocumentZwischenablesung)
  : boolean;
const
  table = 'zwischenablesung';
begin
  formdb := TFormDB.Create(nil);
  try
    Result := formdb.insertIntoZwischenablesung(doc);
  finally
    formdb.free;
  end;
end;

function TWorker.moveonewlocation: boolean;
var
  oldname, newname: string;
  ending: string;
begin
  try
    ending := ExtractFileExt(scannedDocument);
    newname := zielverzeichnis + zieldatei;
    MoveFile(PCHar(scannedDocument), PCHar(newname));
    Result := true;
  except
    Result := False;
  end;

end;

{ versuche zu scannen. um den Scanner zu erzeugen, braucht man den temporären
  Pfad um bmps zwischenzuspeichern, den Zielpfad und den endgültigen Dateinamen.
  True, wenn Scannen geklappt hat }
function TWorker.scanned(): boolean;
var
  rabscan: TRabScan;
begin
  rabscan := TRabScan.Create(zielverzeichnis, zieldatei, fmypath);
  Result := rabscan.scan_officially();
end;

// erhöhe den Zähler
function TWorker.upOne: boolean;
begin
  formdb := TFormDB.Create(nil);
  try
    Result := formdb.upOne(runningID);
  finally
    formdb.free;
  end;
end;

{ Hauptmethode um Zwischenablesungen zu verarbeiten }
function TWorker.doAll(FormMiddle: TFormMiddle; FormLeft: TFormLeft): boolean;
var
  Document: TDocument;
begin
  Document := col.collectAll(FormMiddle, FormLeft);
  getdefProperties(Document);
end;

{ Montage verarbeiten }
function TWorker.doMontage(FormMontage: TFormMontage; FormLeft: TFormLeft;
  mode: boolean): boolean;

var
  montg: TDocumentMontage;
begin
  hasToScan := mode;
  montg := col.collectmontage(FormMontage, FormLeft);
  // sammle alles ein, was in der Suchmaske rumfliegt}
  getMontProperties(montg);

  if not validLiegenschaft then
  begin
    showmessage('bitte gültige Liegenschaft eingeben');
    Result := False;
    exit;
  end;

  if not validDocType then
  begin
    showmessage('kein Dokumententyp ausgewählt');
    Result := False;
    exit;
  end;

  // ???Kundennummer wird noch aus der Liegenschaft erzeugt
  knummer := copy(lieg, 1, 2);
  zielverzeichnisname := createPath();
  zieldateiname := createFileName();

  if hasToScan then
    if not scanned() then
    begin
      Result := False;
      exit;
    end;

  // Dateiname muss escaped werden
  montg.dateiname := escapeText(pathname + datname);

  // und endlich der echte insert-Aufruf
  if not insertmontage(montg) then
  begin
    showmessage('Kein Datenbankeintrag möglich');
    Result := False;
    exit;
  end;

  // Zähler erhöhen in der Datenbank
  upOne();
  Result := true;

end;

function TWorker.doTelefonnotiz(FormNotiz: TFormTelefon;
  FormLeft: TFormLeft): boolean;
begin

end;

function TWorker.doTelefonnotizWithScan(FormNotiz: TFormTelefon;
  FormLeft: TFormLeft): boolean;
begin

end;

{ eine Zwischenablesung mit einem vorhandenen Dokument und einer Verarbeitungsart.
  Email oder Bild }
function TWorker.doZwischenablesung(FormZwischenablesung: TFormZwischenablesung;
  FormLeft: TFormLeft; filename: string; mode: boolean;
  verarbeitungstyp: integer): boolean;
begin
  scannedDocument := filename;
  Result := doZwischenablesung(FormZwischenablesung, FormLeft, mode);
  if verarbeitungstyp = emailverarbeitung then
    showmessage('eine Email bekommt noch zusätzliche Werte');

end;

function TWorker.doZwischenablesung(FormZwischenablesung: TFormZwischenablesung;
  FormLeft: TFormLeft; mode: boolean): boolean;

var
  // Zwablg: TDocumentZwischenablesung;
  col: TCollector;
  rabscan: TRabScan;
begin
  hasToScan := mode;
  self.FormZwischenablesung := FormZwischenablesung;
  zwablg := col.collectZwischenablesung(FormZwischenablesung, FormLeft);
  // sammle alles ein, was in der Suchmaske rumfliegt}
  getzwiProperties(zwablg);
  // kümmere dich um die richtigen Mysql Aufrufe
  // die akutelle ID - schon eins hochgezählt ;)

  if not validLiegenschaft then
  begin
    showmessage('bitte gültige Liegenschaft eingeben');
    Result := False;
    exit;
  end;

  if not validDocType then
  begin
    showmessage('kein Dokumententyp ausgewählt');
    Result := False;
    exit;
  end;

  zielverzeichnis := createPath();
  zieldatei := createFileName();


  // Dateiname muss escaped werden

  zwablg.dateiname := escapeText(zielverzeichnis + zieldatei);

  // scannen, wenn verlangt:

  if hasToScan then
  begin
    if not scanned() then
    begin
      Result := False;
      exit;
    end;
  end
  else
  begin
    if not moveonewlocation then
    begin
      showmessage('nicht verschoben');
      Result := False;
      exit;
    end;
    Result := True;
  end;

  // und endlich der echte insert-Aufruf
  if not InsertZwischenablesung(zwablg) then
  begin
    showmessage('Kein Datenbankeintrag möglich');
    Result := False;
    exit;
  end;

  // Zähler erhöhen in der Datenbank
  upOne();
  Result := true;

end;

{ hole die aktuelle anzahl an zeilen => ID und erhöhe um eins für die neue ID }
function TWorker.getCount(query: string): integer;
var
  formdb: TFormDB;
begin
  formdb := TFormDB.Create(nil);
  try
    Result := formdb.getNo() + 1;
  finally
    formdb.free;
  end;
end;

procedure TWorker.getdefProperties(Document: TDocument);
begin

  nnummer := Document.Nutzernummer;
  teilliegenschaft := Document.liegenschaft;
  Dok := inttostr(Document.doctype);
  anummer := Document.auftragsnummer;
  knummer := Document.kundennummer;
  erl := Document.erledigt;
  Dokname := Document.Dokument;
  PE := Document.Posteingang;
  ntzn := Document.notizen;
  datname := Document.dateiname;
  id := Document.id;
  if length(teilliegenschaft) = 7 then
  // der Benutzer hat die gesamte Liegenschaft angegeben
    lieg := teilliegenschaft
  else
    // else convertToLieg(knummer, teilliegenschaft);
    lieg := knummer + StringOFChar('0', 5 - length(teilliegenschaft)) +
      teilliegenschaft;
  try
    FormZwischenablesung.setliegenschaft(lieg);
  except
    showmessage('..');
    // document.id := id;
  end;

  Document.liegenschaft := lieg;
  // SHowmessage(lieg);
end;

procedure TWorker.getMontProperties(montg: TDocumentMontage);
begin
  getdefProperties(montg as TDocument);
  einbaudat := montg.einbaudatum;
  gueltigkeitsdat := montg.gueltigkeitsdatum;
end;

{ hole umständlich alle Properties aus der Zwischenablesung, weil delphi alt und verschrumpelt ist }
procedure TWorker.getzwiProperties(Zwischenablesg: TDocumentZwischenablesung);
begin
  getdefProperties(Zwischenablesg as TDocument);
  abldat := Zwischenablesg.ablesedatum;
  vertbg := Zwischenablesg.vertragsbeginn;
  nname := Zwischenablesg.nutzername;
end;

{ prüfe, ob ein Dokumententyp angegeben wurde }
function TWorker.validDocType(): boolean;
begin
  if strtoint(Dok) = -1 then
  begin
    Result := False;
  end
  else
    Result := true;
end;

{ Liegenschaft 7 Zeichen? }
function TWorker.validLiegenschaft: boolean;
begin
  Result := (length(lieg) = 7);
end;

end.
