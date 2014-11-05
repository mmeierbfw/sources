unit updfmaker;

   interface
uses
  Windows, Classes,Graphics, SynPdf, SysUtils,Messages, dialogs;




type
  TPDFMaker = class(TObject)
    lPdf   : TPdfDocument;
    lPage,
    lPage1 : TPdfPage;
    lImage : TPdfImage;
    aImage : TPicture;
    pfad   : String;
  private
    function createPDF(Author, Creator, path, targetFile, targetPath: string; date: TDAtetime; count: integer): TPDFDocument;overload;
    { Private-Deklarationen }
  public
    function  createAndSavePDF(Author, Creator, path, targetFile, targetPath: string; date: TDateTIme; count: integer): boolean;overload;
    function  createPDFtoFTP(Author, Creator, path, targetFile, targetPath: string; date: TDateTIme; count: integer): boolean;  overload;
    { Public-Deklarationen }
  end;

   
var
    PDFmaker  : TPDFMaker;


//********* neu
  const a4w : Integer = 1240;
        a4h : Integer = 1754;

implementation


{ TPDFMaker }

function TPDFMaker.createAndSavePDF(Author, Creator, path, targetFile, targetPath: string;
  date: TDateTIme; count: integer): boolean;

  var
      tmpFile, graphname: string;
      cnt : integer;
begin
  Result := False;
    lpdf := CreatePdf(Author, Creator, path, targetFile, targetPath, date, count);
    // Pfad der laufenden Exe-Datei ermitteln
    path := IncludeTrailingBackslash(path);
    targetPath := IncludeTrailingBackslash(targetPath);

    lPdf := TPdfDocument.Create;
    try
        // PDF-Infos
        lPdf.Info.Author        := Author;
        lPdf.Info.CreationDate  := date;
        lPdf.Info.Creator       := author;
        lPdf.DefaultPaperSize   := psA4;


        for cnt := 0 to count - 1 do
        begin

          // neue Seite
          lPage := lPDF.AddPage;
          lPdf.Canvas.SetPage(lPage);

          graphname := inttostr(cnt);
          tmpFile := graphname + '.bmp';


//********* neu       // Größe einstellen
        lPage.PageWidth := a4w;
        lPage.PageHeight := a4h;

        lPdf.Canvas.SetPage(lPage);

        // Grafik öffnen
        aImage := TPicture.Create;

        aImage.LoadFromFile(path + inttostr(cnt)+'.bmp');

//********* neu        // DIN-A4 Bitmap 150 DPI - beschneiden:
        aImage.Bitmap.SetSize(a4w,a4h);

        lImage := TPdfImage.Create(lPdf, aImage.Graphic, True);
        lpdf.AddXObject( inttostr(cnt), lImage);

        // Positionieren und Zeichnen
        lPdf.Canvas.DrawXObject(-10,0, lImage.PixelWidth, lImage.PixelHeight, inttostr(cnt));

        end;

    except
        on E:Exception do
        begin
            ShowMessage('Fehler in ConncectDB: ' + E.ClassName+ ', ' + E.Message);
        end;
    end;
    //finally
      if not DirectoryExists(targetpath) then

        ForceDirectories(targetpath);
      setcurrentdir(targetPath);
      tmpfile := targetpath +  targetfile ;

      lpdf.saveToFile(tmpfile);
      lPdf.Free;
      Result := True;
       
end;


function TPDFMaker.createPDF(Author, Creator, path, targetFile,
  targetPath: string; date: TDAtetime; count: integer): TPDFDocument;
begin

end;

function TPDFMaker.createPDFtoFTP(Author, Creator, path, targetFile, targetPath: string;
  date: TDateTIme; count: integer): boolean;

  var
      tmpFile, graphname: string;
      cnt : integer;
begin

    Result := false;
    // Pfad der laufenden Exe-Datei ermitteln
    path := IncludeTrailingBackslash(path);
    targetPath := IncludeTrailingBackslash(targetPath);

    lPdf := TPdfDocument.Create;
    try
        // PDF-Infos
        lPdf.Info.Author        := Author;
        lPdf.Info.CreationDate  := date;
        lPdf.Info.Creator       := author;
        lPdf.DefaultPaperSize   := psA4;


        for cnt := 0 to count - 1 do
        begin

          // neue Seite
          lPage := lPDF.AddPage;
          lPdf.Canvas.SetPage(lPage);

          graphname := inttostr(cnt);
          tmpFile := graphname + '.bmp';


//********* neu       // Größe einstellen
        lPage.PageWidth := a4w;
        lPage.PageHeight := a4h;

        lPdf.Canvas.SetPage(lPage);

        // Grafik öffnen
        aImage := TPicture.Create;
        aImage.LoadFromFile(pfad + inttostr(cnt)+'.bmp');

//********* neu        // DIN-A4 Bitmap 150 DPI - beschneiden:
        aImage.Bitmap.SetSize(a4w,a4h);

        lImage := TPdfImage.Create(lPdf, aImage.Graphic, True);
        lpdf.AddXObject( inttostr(cnt), lImage);

        // Positionieren und Zeichnen
        lPdf.Canvas.DrawXObject(-10,0, lImage.PixelWidth, lImage.PixelHeight, inttostr(cnt));

        end;

    except
        on E:Exception do begin
            ShowMessage('Fehler in ConncectDB: ' + E.ClassName+ ', ' + E.Message);
            Result := false;
            exit;
        end;
    end;

    if not DirectoryExists(targetpath) then
      ForceDirectories(targetpath);

    try
      setcurrentdir(targetPath);
      tmpfile := targetfile ;
      lpdf.saveToFile(tmpfile);
      lPdf.Free;
      Result := true;
    except
        on E:Exception do begin
            ShowMessage('Fehler in ConncectDB: ' + E.ClassName+ ', ' + E.Message);
            Result := false;
            exit;
        end;
    end;
    end;
end.