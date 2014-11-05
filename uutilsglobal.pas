unit uutilsglobal;

interface
uses tlhelp32, Windows,  SysUtils;


function Shellmyex(const CmdLine: string; WindowState: Word): integer;
function isexerunning(const aexename: string): Boolean;

implementation


function Shellmyex(const CmdLine: string; WindowState: Word): integer;
var
  SUInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  ProcHandle: THandle;
  started: Boolean;
begin
  { Enclose filename in quotes to take care of
    long filenames with spaces. }
  FillChar(SUInfo, SizeOf(SUInfo), #0);
  with SUInfo do
  begin
    cb := SizeOf(SUInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := WindowState;
  end;
  started := CreateProcess(nil, PChar(CmdLine), nil, nil, false,
    CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
    nil, SUInfo, ProcInfo);
  ProcHandle := ProcInfo.hProcess;

  Result := ProcInfo.dwProcessId;
end;



function isexerunning(const aexename: string): Boolean;
var
  h: THandle;
  p: TProcessentry32;
begin
  Result := false;
  p.dwSize := SizeOf(p);
  h := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  try
    Process32First(h, p);
    repeat
      Result := AnsiUpperCase(aexename) = AnsiUpperCase(p.szExeFile);
    until Result or (not Process32Next(h, p));
  finally
    CloseHandle(h);

  end;

end;
end.
