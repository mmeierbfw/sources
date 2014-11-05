unit uFileOperations;

interface

uses ShellAPI,Windows, SysUtils;
       


implementation

        
function delete_File(filename: string): boolean;
  begin
    if FileExists(filename) then begin
        delete_File(filename);
        Result := true;
        exit;
    end;
    Result := False;



  end;
end.
