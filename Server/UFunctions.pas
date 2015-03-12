unit UFunctions;

interface

uses WinInet, shfolder, shellapi, Windows, System.Classes,tlHelp32,sysutils,UConfig;

function DownloadFiles(const url: string; const destinationFileName: string): boolean;
function getHWID(): String;
function IsWow64: Boolean;
function LocalAppDataPath: string;
function ownTrim(strData: String): String;

implementation

function ownTrim(strData: String): String;
var
  i: Integer;
begin
  result := '';
  for i := 1 to Length(strData) do
  begin
    if strData[i] = #0 then
    begin
      result := Copy(strData, 1, i - 1);
      break;
    end;
  end;
end;

function LocalAppDataPath: string;
const
  SHGFP_TYPE_CURRENT = 0;
begin
  SetLength(result, MAX_PATH);
  SHGetFolderPathW(0, CSIDL_LOCAL_APPDATA, 0, SHGFP_TYPE_CURRENT, @result[1]);
  result := ownTrim(result);
  if result[Length(result)] <> '\' then
    result := result + '\';
end;

function getHWID(): String;
var
SerialNum,A,B: DWord;
C: array [0..255] of Char;
Buffer: array [0..255] of Char;
begin
if GetVolumeInformation(pChar('C:\'), Buffer, 256, @SerialNum, A, B, C, 256) then
  Result := inttostr(SerialNum * Cardinal(-1))
else Result := '';
end;

function IsWow64: Boolean;
type
  TIsWow64Process = function(Handle: Windows.THandle; var Res: Windows.BOOL): Windows.BOOL; stdcall;
var
  IsWow64Result: Windows.BOOL;
  IsWow64Process: TIsWow64Process;
begin
  IsWow64Process := Windows.GetProcAddress(Windows.GetModuleHandle('kernel32'), 'IsWow64Process');
  if Assigned(IsWow64Process) then
  begin
    if not IsWow64Process(Windows.GetCurrentProcess, IsWow64Result) then
      raise SysUtils.Exception.Create('IsWow64: bad process handle');
    Result := IsWow64Result;
  end
  else
    Result := False;
end;

function DownloadFiles(const url: string; const destinationFileName: string): boolean;
var
  hInet: HINTERNET;
  hFile: HINTERNET;
  localFile: File;
  buffer: array[1..1024] of byte;
  bytesRead: DWORD;
begin
  result := False;
  hInet := InternetOpen(Pchar(UserAgents[Random(High(UserAgents) - 1) + 1]),INTERNET_OPEN_TYPE_PRECONFIG,nil,nil,0);
  hFile := InternetOpenURL(hInet,PChar(url),nil,0,INTERNET_FLAG_DONT_CACHE,0);
  if Assigned(hFile) then
  begin
    AssignFile(localFile,destinationFileName);
    Rewrite(localFile,1);
    repeat
      InternetReadFile(hFile,@buffer,SizeOf(buffer),bytesRead);
      BlockWrite(localFile,buffer,bytesRead);
    until bytesRead = 0;
    CloseFile(localFile);
    result := true;
    InternetCloseHandle(hFile);
  end;
  InternetCloseHandle(hInet);
end;

end.
