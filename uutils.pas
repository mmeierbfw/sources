unit uutils;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {Delphi Encryption Compendium (DEC) 5.x}
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Buttons, ShellAPI, IniFiles,
  System.Generics.collections, tlhelp32, ShlObj, ActiveX, registry, strutils,
  FileCtrl, System.math, RegularExpressions;

function strcontains(const substr, str: string): boolean;
function getnotsentlist: string;
function Shellmyex(const CmdLine: string; WindowState: Word): integer;
function numeric(Key: Word): boolean; overload;
function numeric(Key: char): boolean; overload;
function ignoreNonNumerics(Key: Word): Word; overload;
function ignoreNonNumerics(Key: char): char; overload;
function formatDateTimeMinus(value: TDatetime): string;
function createFileName(part1, part2, ending: string): string;
function escapeText(text: string): string;
function formatDateTimeOhneTrenner(value: TDatetime): string;
function formatDateOhneTrenner(value: string): string;
function isDirEmpty(dirname: string): boolean;
function isvalidDate(date: string): boolean;
function gettmpversion(programmname: string): string;
function getquerylogger(programmname: string): string;
function writetofile(textfile, text: string): boolean;
function isexerunning(const aexename: string): boolean;
function KillTask(ExeFileName: string): integer;
function Killprocess(pid: integer): boolean;
function formatdateohnetrennertmj(value: string): string;
function formatedatefrom4jto2j(datestring: string): string;
function getMultilinestring(line: string; len: integer): string;
function getTmpfile(programmname, filename: string): string;
function gettmpshowfile(programmname, filename: string): string;
function Runfile(const aFile, CmdLine: string; WindowState: Word)
  : TShellExecuteInfo;

function replaceslashbybackslash(var astring: string): string;
function contains(list: tstringlist; attr: string): boolean;
procedure ListFileDir(Path: string; FileList: tstringlist);
function ShowSpecialFolder(const AFolder: integer): string;
function getlocalfolder(programmname: string): string;
function getsetuplocation(programmname: string): string;
function ShellWait(const CmdLine: string; WindowState: Word): boolean;
procedure copydictionary(var source, target: TDictionary<string, string>);
function getaenderungsfile(programmname: string): string;
function getauftragsdaten(programmname: string): string;
function RenameFileEx(const AOldName, ANewName: string;
  ARenameCheck: boolean = false): boolean;
function GetAssociation(const DocFileName: string): string;
function DeleteFiles(const aFile: string): boolean;
function getCollectorfolder(programmname: string): string;
function copytotmp(programmname, filename: string): string;
function writeToIni(programmname,inidatei, passwort, kundennummer, sachbearbeiternummer,
  verzeichnis, postausgang: string; idanzeigen, splitno: boolean)
  : boolean; overload;

function writeToIni(programmname,inidatei, bfwpfad: string): boolean; overload;
function writeToIni(programmname,inidatei, kundennummer, sachbearbeiter: string)
  : boolean; overload;
function readfromini(const inidatei, section, schluessel,
  default: string): string;

function gettmpfolder(programmname: string): string;
function GetCurrentVersion: String;
function getcurrentversionforcheck: string;
function getcommonDocFolder(): string;
function getlocalsetupdirection(programmname: string): string;
function getlocaldocfolder: string;
function getIniFile(programmanme, inidatei: string): string;
function getlocaltmpfolder(programmname: string): string;
function gettable(index: integer): string;
function getcollectorlistfile(programmname: string): string;
function getpipefolder: string;

function getlast(const achar: char; str: string): string;

function to64(num: String): String; overload;
function to64(num: integer): String; overload;

function getVersionsnummer(): string;
//
// function getReverseSortedKeyArray(dictionary: TDictionary<TKey, TValue>)
// : TArray<TKey>;

const
  localsetup = 'setup.exe';

const
  pool: String =
    'ABCDFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_=';
  base: integer = 64;

implementation

uses
  ubaseconstants;

function getVersionsnummer(): string;
var
  version    : tstringlist;
  versionpath: string;
begin
  version     := tstringlist.Create;
  versionpath := IncludeTrailingPathDelimiter(Application.ExeName) +
    'tmp/version.txt';
  try
    version.LoadFromFile(versionpath);
    Result      := version[0];
  except Result := '0';
  end;
end;
// ------------------------------------------

function to64(num: String): String; overload;
begin
  Result := to64(StrToInt(num));
end;

// -------------------------------------------

function to64(num: integer): String; overload;
var
  q, i, rest, rnd: integer;
  tmp            : Array of char;
  rnd_Arr        : Array [0 .. 4] of char;
  res            : String;
begin
  try
    // Basis-Anlagennummer
    rest := num Mod base;
    res  := pool[rest + 1];
    q    := Trunc(num / base);

    while q > 0 do begin
      rest := q Mod base;
      q    := Trunc(q / base);
      res  := pool[rest + 1] + res;
    end;

    SetLength(tmp, Length(res));
    Move(res, tmp, Length(res));

    // Zufallswerte
    Randomize;
    for i        := 0 to High(rnd_Arr) do begin
      rnd        := RandomRange(1, base);
      rnd_Arr[i] := pool[rnd];
    end;

    // endgültiger Wert
    Result := rnd_Arr[0] + tmp[0] + rnd_Arr[1] + tmp[1] + rnd_Arr[2] + tmp[2] +
      rnd_Arr[3] + tmp[3] + rnd_Arr[4];
  except
    on e: Exception do begin
      if IsConsole then
          writeln('Fehler in to64: ', e.Message + ', ' +
          Inttostr(e.HelpContext))
      else ShowMessage('Fehler in to64: ' + e.Message + ', ' +
          Inttostr(e.HelpContext));
    end;
  end;
end;
// ------------------------------------------------------------------------

// function getReverseSortedKeyArray(dictionary: TDictionary<TKey, TValue>)
// : TArray<TKey>;
// var
// keyArray: TArray<TKey>;
// keyCollecttion: TDictionary<TKey, TValue>.TKeyCollection;
// begin
// keyCollecttion := TDictionary<TKey, TValue>.TKeyCollection.Create(dictionary);
// try
// keyArray := valueCollecttion.ToArray;
// TArray.Sort<TKey>(keyArray, TComparer<TKey>.Construct(compareKeyReverse));
// finally keyCollecttion.Free;
// end;
//
// Result := keyArray;
// end;

function replaceslashbybackslash(var astring: string): string;
begin
end;

function formatedatefrom4jto2j(datestring: string): string;
var
  dl              : tstringlist;
  tag, monat, jahr: string;
begin
  if datestring = '' then begin
    Result := '00.00.00';
    exit;
  end;

  dl               := tstringlist.Create;
  dl.Delimiter     := '.';
  dl.DelimitedText := datestring;
  tag              := dl[0];
  monat            := dl[1];
  jahr             := dl[2];
  jahr             := Copy(jahr, 3, 2);

  Result := tag + '.' + monat + '.' + jahr;
end;

function getlast(const achar: char; str: string): string;
var
  list   : tstringlist;
  sources: integer;
begin
  list               := tstringlist.Create;
  list.Delimiter     := char(achar);
  list.DelimitedText := str;
  sources            := list.Count;
  Result             := list[sources - 1];

end;

function strcontains(const substr, str: string): boolean;
var
  index, len: integer;
  helper    : string;
begin
  Result := false;
  index  := 0;
  len    := Length(str);
  while index < len do begin
    helper := Copy(str, index, len);
    if AnsiStartsStr(substr, helper) then begin
      Result := true;
      exit;
    end;
    inc(index);
  end;

end;

function gettmpfolder(programmname: string): string;
var
  Path: string;
begin
  Path := IncludeTrailingPathDelimiter(getlocalfolder(programmname));
  Path := IncludeTrailingPathDelimiter(Path + 'tmp');
  if not SysUtils.DirectoryExists(Path) then SysUtils.ForceDirectories(Path);
  Result := Path;
end;

function getnotsentlist: string;
var
  Path: string;
begin
  Path := IncludeTrailingPathDelimiter
    (IncludeTrailingPathDelimiter(ShowSpecialFolder(CSIDL_COMMON_APPDATA))
    + 'pool');
  if not SysUtils.DirectoryExists(Path) then SysUtils.ForceDirectories(Path);
  Result := IncludeTrailingPathDelimiter(Path) + 'notsentlist.txt';
end;

function getpipelist: string;
var
  Path: string;
begin
  Path := IncludeTrailingPathDelimiter
    (IncludeTrailingPathDelimiter(ShowSpecialFolder(CSIDL_COMMON_APPDATA))
    + 'pool');
  if not SysUtils.DirectoryExists(Path) then MkDir(Path);
  Result := IncludeTrailingPathDelimiter(Path) + 'pipelist.txt';

end;

function getpipefolder: string;
begin
  Result := IncludeTrailingPathDelimiter(ShowSpecialFolder(CSIDL_COMMON_APPDATA)
    ) + 'pipe';
end;

function getcollectorlistfile(programmname: string): string;
var
  listfile: string;
begin
  listfile := IncludeTrailingPathDelimiter(getlocalfolder(programmname));
  if not SysUtils.DirectoryExists(listfile) then
      SysUtils.ForceDirectories(listfile);
  listfile := listfile + 'collectorlist.txt';
  Result   := listfile;
end;

function getlocaltmpfolder(programmname: string): string;
var
  Path: string;
begin
  Path := IncludeTrailingPathDelimiter(getlocalfolder(programmname));
  if not SysUtils.DirectoryExists(Path) then SysUtils.ForceDirectories(Path);
  Path := IncludeTrailingPathDelimiter(Path + ' tmp');
  if not SysUtils.DirectoryExists(Path) then SysUtils.ForceDirectories(Path);
  Result := Path;

end;

function getCollectorfolder(programmname: string): string;
var
  collectorfolder: string;
begin
  collectorfolder := IncludeTrailingPathDelimiter(getlocalfolder(programmname));
  if not SysUtils.DirectoryExists(collectorfolder) then
      SysUtils.ForceDirectories(collectorfolder);
  collectorfolder := IncludeTrailingPathDelimiter
    (collectorfolder + 'collector');
  if not SysUtils.DirectoryExists(collectorfolder) then
      SysUtils.ForceDirectories(collectorfolder);
  Result := collectorfolder;
end;

function gettable(index: integer): string;
var
  table: string;
  cons : tbaseconstants;
begin

  cons := tbaseconstants.Create;
  try
    with cons do begin
      case index of
        ZwischenablsgINT: table  := zwischenablesung;
        MontageINT: table        := montage;
        ReklamationINT: table    := reklamation;
        EnergieausweisINT: table := Energieausweis;
        KostenINT: table         := kostenermittlungen;
        Nutzerint: table         := nutzerlisten;
        SonstigesInt: table      := sonstiges;
        Vertragsint: table       := vertrag;
        Angebotsint: table       := angebote;
        Auftragsint: table       := auftrag;
      end;
    end;
  finally
    Result := table;
    cons.Free;
  end;
end;

function copytotmp(programmname, filename: string): string;
var
  tmpfile: string;
begin
  tmpfile := getlocaltmpfolder(programmname);
  if not SysUtils.DirectoryExists(tmpfile) then
      SysUtils.ForceDirectories(tmpfile);
  tmpfile := tmpfile + ExtractFileName(filename);
  CopyFile(pchar(filename), pchar(tmpfile), true);
  Result := tmpfile;
end;

function GetAssociation(const DocFileName: string): string;
var
  FileClass: string;
  Reg      : TRegistry;
  app      : string;
  list     : tstringlist;
begin
  Result      := '';
  Reg         := TRegistry.Create(KEY_EXECUTE);
  Reg.RootKey := HKEY_CLASSES_ROOT;
  FileClass   := '';
  if Reg.OpenKeyReadOnly(ExtractFileExt(DocFileName)) then begin
    FileClass := Reg.ReadString('');
    Reg.CloseKey;
  end;
  if FileClass <> '' then begin
    if Reg.OpenKeyReadOnly(FileClass + '\Shell\Open\Command') then begin
      app                := Reg.ReadString('');
      list               := tstringlist.Create;
      list.Delimiter     := '"';
      list.DelimitedText := app;
      Result             := (list[0]);
      Reg.CloseKey;
    end;
  end;
  Reg.Free;
end;

function Runfile(const aFile, CmdLine: string; WindowState: Word)
  : TShellExecuteInfo;
var
  sei: TShellExecuteInfo;
begin
  FillChar(sei, SizeOf(sei), 0);
  sei.cbSize       := SizeOf(sei);
  sei.fMask        := SEE_MASK_FLAG_NO_UI or SEE_MASK_NOCLOSEPROCESS;
  sei.lpVerb       := 'open';
  sei.lpFile       := pchar(aFile);
  sei.lpDirectory  := pchar(ExtractFileDir(aFile));
  sei.lpParameters := pchar(CmdLine);
  sei.nShow        := WindowState;

  if not ShellExecuteEx(@sei) then RaiseLastOSError;
  if sei.hProcess <> 0 then begin
    while WaitForSingleObject(sei.hProcess, 50) = WAIT_TIMEOUT do
        Application.ProcessMessages;
    CloseHandle(sei.hProcess);
  end;
  Result := sei;
end;

function getlocaldocfolder: string;
begin
  Result := ShowSpecialFolder(CSIDL_MYDOCUMENTS);
end;

function getlocalsetupdirection(programmname: string): string;
var
  Path: string;
begin
  Path   := IncludeTrailingPathDelimiter(getlocalfolder(programmname));
  Result := Path + localsetup;
end;

function getauftragsdaten(programmname: string): string;
var
  Path: string;
  cons: tbaseconstants;
begin
  cons := tbaseconstants.Create;
  try
    with cons do begin
      Path := IncludeTrailingPathDelimiter(getlocalfolder(programmname));
      if not SysUtils.DirectoryExists(Path) then
          SysUtils.ForceDirectories(Path);
      Path := Path + auftragsdatei;
    end;
  finally
    Result := Path;
    cons.Free;
  end;
end;

function getaenderungsfile(programmname: string): string;
var
  Path: string;
  cons: tbaseconstants;
begin
  cons := tbaseconstants.Create;
  try
    with cons do begin
      Path := IncludeTrailingPathDelimiter(getlocalfolder(programmname));
      if not SysUtils.DirectoryExists(Path) then
          SysUtils.ForceDirectories(Path);
      Result := Path + aenderungsdatei;
    end;
  finally cons.Free;
  end;
end;

function contains(list: tstringlist; attr: string): boolean;
var
  elem: string;
  res : boolean;
begin
  Result := false;
  for elem in list do begin
    if elem = attr then begin
      Result := true;
      exit;
    end;
  end;
end;

procedure ListFileDir(Path: string; FileList: tstringlist);
var
  SR: TSearchRec;
begin
  if FindFirst(Path + '*.*', faAnyFile and not faDirectory, SR) = 0 then begin
    repeat
      if (SR.attr <> faDirectory) and not contains(FileList, SR.Name) then
          FileList.Add(SR.Name);
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

// -------------------------------------------
function gettmpshowfile(programmname, filename: string): string;
var
  Path     : string;
  tmpstring: string;
begin
  Path := IncludeTrailingPathDelimiter(gettmpfolder(programmname));
  Path := IncludeTrailingPathDelimiter(Path) + 'show';
  if not DirectoryExists(Path) then ForceDirectories(Path);
  Result := IncludeTrailingPathDelimiter(Path) + filename;

end;

// -------------------------------------------
function getTmpfile(programmname, filename: string): string;
var
  Path     : string;
  tmpstring: string;
begin
  Path   := IncludeTrailingPathDelimiter(gettmpfolder(programmname));
  Path   := IncludeTrailingPathDelimiter(Path) + filename;
  Result := Path;
end;

// -------------------------------------------
function getcommonDocFolder(): string;
begin
  Result := ShowSpecialFolder(CSIDL_COMMON_DOCUMENTS);
end;

// -------------------------------------------
function getMultilinestring(line: string; len: integer): string;
var
  multiline, helper: string;
  min, size        : integer;
begin
  min       := 0;
  helper    := Copy(line, min, len);
  multiline := helper + #13#10;
  while len > min do begin
    min       := min + len + 1;
    len       := min + len;
    helper    := Copy(line, min, len);
    multiline := multiline + helper + #13#10;
  end;
  multiline := Copy(multiline, 0, Length(multiline) - 6);
  Result    := multiline;
end;


// -------------------------------------------

function getsetuplocation(programmname: string): string;
var
  Path: string;
  s   : tstringlist;
begin
  Path := IncludeTrailingPathDelimiter(getlocalfolder(programmname)) +
    localsetup;
  if not DirectoryExists(ExtractFilePath(Path)) then begin
    ForceDirectories(ExtractFilePath(Path));
    s := tstringlist.Create;
    try s.SaveToFile(Path);
    finally s.Free;
    end;
  end;
  Result := Path;
end;

function getcurrentversionforcheck: string;
var
  VerInfoSize : Cardinal;
  VerValueSize: Cardinal;
  Dummy       : Cardinal;
  PVerInfo    : Pointer;
  PVerValue   : PVSFixedFileInfo;
begin
  Result      := '';
  VerInfoSize := GetFileVersionInfoSize(pchar(paramstr(0)), Dummy);
  GetMem(PVerInfo, VerInfoSize);
  try
    if GetFileVersionInfo(pchar(paramstr(0)), 0, VerInfoSize, PVerInfo) then
      if VerQueryValue(PVerInfo, '\', Pointer(PVerValue), VerValueSize) then
        with PVerValue^ do
            Result := Format('%d.%d.%d.%d', [HiWord(dwFileVersionMS), // Major
            LoWord(dwFileVersionMS), // Minor
            HiWord(dwFileVersionLS),   // Release
            LoWord(dwFileVersionLS)]); // Build
  finally FreeMem(PVerInfo, VerInfoSize);
  end;
end;

function GetCurrentVersion: String;
var
  VerInfoSize : Cardinal;
  VerValueSize: Cardinal;
  Dummy       : Cardinal;
  PVerInfo    : Pointer;
  PVerValue   : PVSFixedFileInfo;
begin
  Result      := '';
  VerInfoSize := GetFileVersionInfoSize(pchar(paramstr(0)), Dummy);
  GetMem(PVerInfo, VerInfoSize);
  try
    if GetFileVersionInfo(pchar(paramstr(0)), 0, VerInfoSize, PVerInfo) then
      if VerQueryValue(PVerInfo, '\', Pointer(PVerValue), VerValueSize) then
        with PVerValue^ do
            Result := Format('v%d.%d.%d build %d', [HiWord(dwFileVersionMS),
            // Major
            LoWord(dwFileVersionMS),   // Minor
            HiWord(dwFileVersionLS),   // Release
            LoWord(dwFileVersionLS)]); // Build
  finally FreeMem(PVerInfo, VerInfoSize);
  end;
end;
// var
// VerInfoSize: DWORD;
// VerInfo: Pointer;
// VerValueSize: DWORD;
// VerValue: PVSFixedFileInfo;
// Dummy: DWORD;
// begin
// VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), dummy);
// GetMem(VerInfo, VerInfoSize);
// GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
// VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
// with VerValue^ do
// begin
// Result := IntToStr(dwFileVersionMS shr 16);
// Result := Result + '.' + IntToStr(dwFileVersionMS and $FFFF);
// Result := Result + '.' + IntToStr(dwFileVersionLS shr 16);
// end;
// FreeMem(VerInfo, VerInfoSize);
// end;

function gettmpversion(programmname: string): string;
var
  pathandfile: string;
  Path       : string;
begin
  Path := IncludeTrailingPathDelimiter(getlocaltmpfolder(programmname));
  if not DirectoryExists(Path) then ForceDirectories(Path);
  pathandfile := IncludeTrailingPathDelimiter(Path) + 'version.txt';

  Result := pathandfile;
end;

function writetofile(textfile, text: string): boolean;
var
  list: tstringlist;
begin
  list := tstringlist.Create;
  try
    try list.LoadFromFile(textfile);
    except outputdebugstring('datei existiert noch nicht');
    end;
    list.Add(text);
    list.SaveToFile(textfile);
  finally list.Free;
  end;
end;

function Killprocess(pid: integer): boolean;
var
  hProcess: THandle;
begin
  try
    hProcess    := OpenProcess(PROCESS_TERMINATE, false, pid);
    Result      := TerminateProcess(hProcess, 0);
  except Result := false;

  end;

end;

function ShowSpecialFolder(const AFolder: integer): string;
var
  ItemIDList: PItemIDList;
  hPath     : pchar;
  ShellH    : IMalloc;
begin
  if Succeeded(SHGetSpecialFolderLocation(Application.Handle, AFolder,
    ItemIDList)) then begin
    try
      hPath := StrAlloc(max_path);
      try
        if SHGetPathFromIDList(ItemIDList, hPath) then Result := hPath;
      finally StrDispose(hPath);
      end;
    finally
      if SHGetMalloc(ShellH) = NOERROR then ShellH.Free(ItemIDList);
    end;
  end
  else RaiseLastOSError;
end;

function getlocalfolder(programmname: string): string;
var
  Path: string;
  cons: tbaseconstants;
begin
  cons := tbaseconstants.Create;
  try
    with cons do begin
      Path := IncludeTrailingPathDelimiter
        (ShowSpecialFolder(CSIDL_COMMON_APPDATA)) + programmname;
      if not DirectoryExists(Path) then begin
        ForceDirectories(Path);
      end;
      Result := Path;

    end;
  finally

  end;
end;

function getquerylogger(programmname: string): string;
begin
  Result := IncludeTrailingPathDelimiter(getlocalfolder(programmname)) +
    'query.log';
end;

function isexerunning(const aexename: string): boolean;
var
  h: THandle;
  p: TProcessentry32;
begin
  p.dwSize := SizeOf(p);
  h        := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  try
    Process32First(h, p);
    repeat Result := AnsiUpperCase(aexename) = AnsiUpperCase(p.szExeFile);
    until Result or (not Process32Next(h, p));
  finally CloseHandle(h)
  end;
end;

function KillTask(ExeFileName: string): integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop   : BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessentry32;
begin
  Result                 := 0;
  FSnapshotHandle        := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop           := Process32First(FSnapshotHandle, FProcessEntry32);

  while integer(ContinueLoop) <> 0 do begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile))
      = UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile)
      = UpperCase(ExeFileName))) then
        Result := integer(TerminateProcess(OpenProcess(PROCESS_TERMINATE,
        BOOL(0), FProcessEntry32.th32ProcessID), 0));
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

// WindowState = z.B. SW_NORMAL

function ShellWait(const CmdLine: string; WindowState: Word): boolean;
var
  SUInfo  : TStartupInfo;
  ProcInfo: TProcessInformation;
begin
  { Enclose filename in quotes to take care of
    long filenames with spaces. }
  FillChar(SUInfo, SizeOf(SUInfo), #0);
  with SUInfo do begin
    cb          := SizeOf(SUInfo);
    dwFlags     := STARTF_USESHOWWINDOW;
    wShowWindow := WindowState;
  end;
  Result := CreateProcess(nil, pchar(CmdLine), nil, nil, false,
    CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
    nil { PChar(ExtractFilePath(Filename)) } , SUInfo, ProcInfo);

  { Wait for it to finish. }
  if Result then WaitForSingleObject(ProcInfo.hProcess, INFINITE);
end;

function Shellmyex(const CmdLine: string; WindowState: Word): integer;
var
  SUInfo    : TStartupInfo;
  ProcInfo  : TProcessInformation;
  ProcHandle: THandle;
  started   : boolean;
  procid    : integer;
begin

  { Enclose filename in quotes to take care of
    long filenames with spaces. }
  FillChar(SUInfo, SizeOf(SUInfo), #0);
  with SUInfo do begin
    cb          := SizeOf(SUInfo);
    dwFlags     := STARTF_USESHOWWINDOW;
    wShowWindow := WindowState;
  end;
  try CreateProcess(nil, pchar(CmdLine), nil, nil, false, CREATE_NEW_CONSOLE or
      NORMAL_PRIORITY_CLASS, nil, nil, SUInfo, ProcInfo);
  except outputdebugstring('...');
  end;
  procid := ProcInfo.dwprocessid;
  Result := procid;
end;

{ prüft einen dd*yy*mmmm string auf Gültigkeit }
function isvalidDate(date: string): boolean;
var
  day, month: integer;
begin
  Result := false;
  day    := StrToInt(Copy(date, 1, 2));
  month  := StrToInt(Copy(date, 4, 2));

  if month > 12 then begin
    exit;
  end;
  case month of
    1, 3, 5, 7, 8, 10, 12: if day > 31 then exit;
    4, 6, 9, 11: if day > 30 then exit;
    2: if day > 29 then { TODO : Schaltjahre prüfen! }
          exit;
  else end;
  Result := true;
end;

function RenameFileEx(const AOldName, ANewName: string;
  ARenameCheck: boolean = false): boolean;
var
  sh: TSHFileOpStruct;
begin
  sh.Wnd   := Application.Handle;
  sh.wFunc := fo_Move;

  // String muss mit #0#0 Terminiert werden, um das Listenende zu setzen
  sh.pFrom                       := pchar(AOldName + #0);
  sh.pTo                         := pchar(ANewName + #0);
  sh.fFlags                      := fof_Silent or fof_MultiDestFiles;
  if ARenameCheck then sh.fFlags := sh.fFlags or fof_RenameOnCollision;
  Result                         := ShFileOperation(sh) = 0;
end;

function numeric(Key: Word): boolean;
begin
  Result := numeric(chr(Key));
end;

function numeric(Key: char): boolean;
begin
  Result                                            := false;
  if Key in ['0' .. '9', #8, #127, #13] then Result := true;
end;

function ignoreNonNumerics(Key: char): char;
begin
  Result                          := Key;
  if not numeric(Key) then Result := #0;
end;

function ignoreNonNumerics(Key: Word): Word;
begin
  Result                          := Key;
  if not numeric(Key) then Result := vkkeyscan(#0);
end;

function createFileName(part1, part2, ending: string): string;
begin
  // keine ewiglangen Dateinamen. Soll nur zur Orientierung dienen
  if Length(part2) > 5 then begin
    part2 := Copy(part2, 0, 4);
  end;
  Result := part1 + '-' + part2 + '-' + FormatDateTime('yy-mm-dd-hh-nn', now) +
    '.' + ending;
end;

function formatDateOhneTrenner(value: string): string;
var
  datestring      : tstringlist;
  jahr, monat, tag: string;
begin

  if not(tregex.ismatch(value, '^(31|30|[012]\d)\.(0\d|1[012]|\d).(\d{1,6})$'))
  then exit;

  if value = '' then begin
    Result := '00.00.00';
    exit;
  end;

  datestring               := tstringlist.Create;
  datestring.Delimiter     := '.';
  datestring.DelimitedText := value;
  tag                      := datestring[0];
  monat                    := datestring[1];
  jahr                     := datestring[2];

  Result := jahr + monat + tag;

end;

function formatdateohnetrennertmj(value: string): string;
var
  datestring: tstringlist;
begin
  datestring               := tstringlist.Create;
  datestring.Delimiter     := '.';
  datestring.DelimitedText := value;
  Result                   := datestring[0] + datestring[1] + datestring[2];

end;

function formatDateTimeOhneTrenner(value: TDatetime): string;

begin
  try
    // // Workaround für Bug in Windows 7
    // tmpDateSeparator    := DateSeparator;
    // tmpShortDateFormat  := ShortDateFormat;
    // tmpTimeSeparator    := TimeSeparator;
    // tmpShortTimeFormat  := ShortTimeFormat;
    // tmpLongTimeFormat   := LongTimeFormat;
    //
    // DateSeparator       := '.';
    // ShortDateFormat     := 'dd.mm.yyyy';
    // TimeSeparator       := ':';
    // ShortTimeFormat     := 'HH:mm';
    // LongTimeFormat      := 'HH:mm:ss';

      Result := FormatDateTime('dd.mm.yy', value);
  finally
    //
    // DateSeparator   := tmpDateSeparator;
    // ShortDateFormat := tmpShortDateFormat;
    // TimeSeparator   := tmpTimeSeparator;
    // ShortTimeFormat := tmpShortTimeFormat;
    // LongTimeFormat  := tmpLongTimeFormat;

  end;
end;

function formatDateTimeMinus(value: TDatetime): string;
begin
  Result := '';
  try

      Result := FormatDateTime('yyyy-mm-dd', value);
  except ShowMessage('noc result');
  end;
end;

function escapeText(text: string): string;
var
  size, cnt: integer;
  res      : string;
  cha      : char;
begin
  size                          := Length(text);
  for cnt                       := 1 to size do begin
    cha                         := text[cnt];
    res                         := res + cha;
    if text[cnt] = '\' then res := res + cha;
  end;
  Result := res;
end;

function isDirEmpty(dirname: string): boolean;

var
  LSearchRec: TSearchRec;
begin
  Result := true;
  if FindFirst(dirname + '*', faAnyFile, LSearchRec) = 0 then begin
    Result := false;
  end;
end;

function DeleteFiles(const aFile: string): boolean;
var
  sh: SHFileOpStruct;
begin
  ZeroMemory(@sh, SizeOf(sh));
  with sh do begin
    Wnd    := Application.Handle;
    wFunc  := FO_DELETE;
    pFrom  := pchar(aFile + #0);
    fFlags := fof_Silent or FOF_NOCONFIRMATION;
  end;
  Result := ShFileOperation(sh) = 0;
end;

function getIniFile(programmanme, inidatei: string): string;
begin

  Result := IncludeTrailingPathDelimiter(getlocalfolder(programmanme))
    + inidatei;
end;

function writeToIni(programmname,inidatei, passwort, kundennummer, sachbearbeiternummer,
  verzeichnis, postausgang: string; idanzeigen, splitno: boolean): boolean;
var
  ini: TIniFile;
  anz: string;
begin
  ini := TIniFile.Create(getIniFile(programmname,inidatei));
  try

    ini.WriteString('Section', 'Passwort', passwort);
    ini.WriteString('Section', 'Kundennummer', kundennummer);
    ini.WriteString('Section', 'Sachbearbeiter', sachbearbeiternummer);
    ini.WriteString('Section', 'Verzeichnis', verzeichnis);
    ini.WriteString('Section', 'Postausgang', postausgang);
    if idanzeigen then anz := '1'
    else anz               := '0';
    ini.WriteString('Section', 'Idanzeigen', anz);
    if splitno then anz := '1'
    else anz            := '0';
    ini.WriteString('Section', 'Splitnumber', anz);
    Result := true;
  finally ini.Free
  end;
end;

function writeToIni(programmname,inidatei, kundennummer, sachbearbeiter: string)
  : boolean; overload;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(getIniFile(programmname,inidatei));
  try
    ini.WriteString('Section', 'Kundennummer', kundennummer);
    ini.WriteString('Section', 'Sachbearbeiter', sachbearbeiter);
    Result := true;

  finally ini.Free;

  end;
end;

function writeToIni(programmname,inidatei, bfwpfad: string): boolean;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(getIniFile(programmname,inidatei));
  try
    ini.WriteString('Section', 'bfwpfad', bfwpfad);
    Result := true;
  finally ini.Free
  end;
end;

function readfromini(const inidatei, section, schluessel,
  default: string): string;

var
  ini: TIniFile;
begin
  ini        := TIniFile.Create(inidatei);
  try Result := ini.ReadString(section, schluessel, 'kein wert');
  finally ini.Free;
  end;
end;

procedure copydictionary(var source, target: TDictionary<string, string>);
var
  Key, value: string;
begin
  for Key in source.Keys do begin
    value := source.Items[Key];
    target.AddOrSetValue(Key, value);
  end;

end;

end.
