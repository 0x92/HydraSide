unit UFunctions;

interface

uses shellapi,windows,tlHelp32,shfolder,SysUtils,IdTCPClient;

Procedure runapp(Path:string);
function KillTask(ExeFileName: string): Integer;
function IsPortActive(AHost : string; APort : Word): boolean;
Procedure CheckForTorPort;


implementation

uses umian;

Procedure CheckForTorPort;
begin
Repeat
 if not IsPortActive('localhost',strtoint(Form1.EdtTorPort.Text)) then
    begin
     form1.Torstate.Caption := 'Not Running';
    end
    else
    begin
      Form1.Torstate.Caption := 'Running';
    end;
    Sleep(6000);
Until 1 = 3;
end;

function IsPortActive(AHost : string; APort : Word): boolean;
var
  IdTCPClient : TIdTCPClient;
begin
  Result := False;
  try
    IdTCPClient := TIdTCPClient.Create(nil);
    try
      IdTCPClient.Host := AHost;
      IdTCPClient.Port := APort;
      IdTCPClient.Connect;
      Result := True;
    finally
      IdTCPClient.Free;
    end;
  except
    //Ignore exceptions
  end;
end;

Procedure runapp(Path:string);
begin
ShellExecute(0, 'open',Pchar(path), nil, nil,1);
end;

function KillTask(ExeFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(
                        OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

end.
