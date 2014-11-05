unit doppelstart;

interface

implementation
uses windows,Dialogs,sysutils;

var mHandle: THandle; // Mutexhandle


Initialization
  mHandle := CreateMutex(nil,True,'Programmname');
  if GetLastError = ERROR_ALREADY_EXISTS then begin // Anwendung l‰uft bereits
     //showMessage('Anwendung l‰uft bereits!!!!!');
     halt;
  end;

finalization // ... und Schluﬂ
  if mHandle <> 0 then CloseHandle(mHandle)
end.
