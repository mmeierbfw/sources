unit uScanningVIAWIA;

interface

uses  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,  StdCtrls, ComCtrls,
    WindowsImageAquisition, WIA_TLB, ComObj,
  Contnrs, ShellApi, uutils,
  SynGDIPlus,  updfmaker, uconstants;

type
  // Damit werden Dokumente eingescannt
  TRabScan = class(TObject)
    WIA: TWIAScanner;
    public  
      Constructor Create(p, f, t: string);
      function scan_officially(): boolean;
    private
      continue: boolean;
      path, tmppath, filename: string;
      function answerDialog(MessageText: string; informative: boolean ): boolean;
      function scan(): IimageFile;
      function alreadyDone: boolean;
      function paperInsert: boolean;
      
    // Speichere die Bilder aus der Liste im mitgegebenen Verzeichnis + Dateiname
     function saveImages(): boolean;
  end;

  { Zwischenklasse, dank altem Delphi (und Sven). Generics gibts noch nicht,
   Pointer durch Svens Beispiel umgangen mit einer "Pseudoklasse". In die Liste der
   zu speichernden gescannten Blätter wird je eine Instanz dieser Klasse hinzugefügt.
   Darin enthalten ist ein Imagefile}
  TImageObject = class


    public
      image : imageFile;
      function getImage(): imageFile;
  end;

var
  imageObject:     TImageObject;
  imageList:  TObjectList;




implementation

uses umain;
{ TRabScan }

   
{Pfad und Dateiname für das gescannte Dokument werden übergeben}
constructor TRabScan.Create(p, f, t: string);
begin
  path := p;
  filename := f;
  tmppath := t;
end;

{Nutzer wird per Message Dialog darüber informiert, dass kein Papier eingezogen
werden kann.}
function TRabScan.paperInsert(): boolean;
var id: boolean;
begin
  id := answerDialog(nopaper, false);
  Result := id;
end;

{Nutzer wird mit Message Dialog gefragt, ob Scannen abgeschlossen wurde}
function TRabScan.alreadyDone(): boolean;
begin
  if messageDlg(tooslow, mtInformation, mbYesNo,0) = 0 then
    Result := True
  else Result := False;
end;

{es wird endlos die private Methode Scan aufgerufen, bis "continue" auf false
gesetzt wird. Damit werden pro Auftrag x Seiten eingescannt.
 Es wird endlos gescannt, mit einem Sleep von 2 Sekunden. Passiert in
dieser Zeit nichts, wird der Benutzer in einem Dialog gefragt, ob es weitergehen soll.
Evtl. sollte man die Sleeptime später auch in den Einstellungen ändern könnne. ...}
function TRabScan.scan_officially: boolean;
var
  resImageFile: IIMagefile;
begin

  Result := False;

  imageList := TObjectList.Create;
  Result := False;

  resImageFile := scan(); // ein Blatt Papier scannen und als imageFile speichern
//  if  (resImageFile = nil) then // wenns klappt
//
//      if not  (paperInsert()) then  // Nutzer aufmerksam machen. Vielleicht mag er noch Papier nachlegen
//      begin
//        Result := false;
//        exit;
//      end
//      else scan_all()
//  else

  if resimagefile = nil then
  begin
    Showmessage('fehler beim scannen');
      Result := false;
      exit;
  end;
    imageObject := TImageObject.Create;
    imageObject.image := resImageFile;
    imageList.add(imageObject);       // imageFile in Liste speichern

                      // wenn nicht weitergemacht werden soll, wurde das Scannen erfolgreich abgeschlossen. Juhu!
  saveImages(); // bisher sind die Bilder nur in Variablen gespeichert. Müssen noch auf Festplatte
  Result := True;
  exit;
end;



{nicht jedes Mal einen eigenen Dialog aufrufen müssen... je nach Aufruf wird
ein Confirmation-oder Error-Dialog aufgerufen mit dem übergegebenen Messagetext}
function TRabScan.answerDialog(MessageText: string; informative: boolean): boolean;
var
  dlgRes : integer;
begin
  Result := False;
  if informative then
  begin
    dlgRes := MessageDlg(MessageText, mtConfirmation, mbOKCancel, 0);
  end
  else
    dlgRes := MessageDlg(MessageText, mtError, mbOKCancel, 0);
  if dlgRes = 1 then
    Result := True;
end;


{Größtenteils im Internet zusammengefrickelt. Scannt ohne einen Dialog anzuzeigen
in schwarz/weiß.}
function TRabScan.scan(): IImageFile;
var
  lDevice : IDevice;
  lImage : IImageFile;
  lCommonDialog : ICommonDialog;
  DevMgr: IDeviceManager;
  idx,                 // potthässlich, muss aber so!
  Image: OleVariant;
begin

  idx := 1;                 //s.o.
  try
    DevMgr := CreateOleObject('WIA.DeviceManager') as IDeviceManager;
    lDevice := DevMgr.DeviceInfos.Item[idx].Connect as IDevice;
    lCommonDialog := CoCommonDialog.Create;
    lImage := IUnknown(lCommonDialog.ShowTransfer(lDevice.Items[1],
    WiaFormatBMP,cancelError)) as IImageFile;
    //lImage.PixelDepth := 150;

    Result := lImage;
  except
    try
        {hochmoderne Scankamera?}
         limage := lCommonDialog.ShowAcquireImage(2, GrayscaleIntent,
         MinimizeSize,WiaFormatBMP,false,false,false );
         Result := limage;
    except
      {anscheinend nicht}
      Result := nil;
    end;
  end;
end;




function TRabScan.saveImages(): boolean;

{damit werden die einzelnen Blätter numeriert in einem entsprechenden Ordner gespeichert.
Weniger schön
 }
var
  cnt, size: integer;
  fimage: ImageFile;
  io: TImageObject;
  tmpfile: string;
  bmp: TBitmap;
  Picture: TPicture;
//  showImage: TShowImage;
  pdfMaker: TPdfmaker;
  aPicture: TPicture;
  fileExtension: string;
  pathtmp : string;
//  imager: TShowImage;
  saveit: boolean;
  test: boolean;
begin

  {wichtig, keine Experimente und nicht rauslöschen!}
  Gdip := TGDIPlusFull.Create('gdiplus.dll');
//
//  showImage := TShowImage.Create(nil);

  if not DirectoryExists(tmpPath) then
    CreateDir(tmppath);

  {erstmal in ein lokales Verzeichnis und dort die Bitmaps speichern.
    könnte man bei Gelegenheit ein wenig weniger ungeschickt machen}
  chdir(tmppath);

  if not isDirEmpty(tmppath) then
  begin
      DeleteFiles(tmppath + '\*.*');
  end;
  size := imageList.Count;
  for cnt := 0 to size - 1 do
  begin
    io := imagelist[cnt] as TImageObject;
    fimage := io.image;
    tmpfile := inttostr(cnt) + '.'  + fimage.FileExtension;
    fimage.SaveFile(tmpfile);
  end;

  pdfMaker := TPDFMaker.Create;

  pathtmp := path  + filename;
  test := pdfMaker.createAndSavePDF('melanie', 'ScannerTool', tmppath, filename, path, NOW, size);
  if not test then
  
  begin
    ShowMessage('NO PDF');
    Result := false;
    
    exit;
  end;
  Result := true;
end;

{ Timages }

function TImageObject.getImage: imageFile;
begin
  Result := image;
end;

end.
