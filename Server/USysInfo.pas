unit USysInfo;

interface
uses
  Windows,winsock,sysutils,IdHttp,uConfig;

function GetOS: string;
function LocalIP: string;
Function GetExternalIp:string;

implementation

Function GetExternalIp:string;
var
  lHTTP: TIdHTTP;
begin
  lHTTP := TIdHTTP.Create(nil);
  lHTTP.Request.UserAgent := UserAgents[Random(High(UserAgents) - 1) + 1];
  try
    Result := lHTTP.Get(_Get_external_ip_);     // change later
  finally
    lHTTP.Free;
  end;
end;

function LocalIP: string;
var phoste: PHostEnt;
    Buffer: array [0..100] of ansichar;
    WSAData: TWSADATA;
begin
    result := '';
    if WSAStartup($0101, WSAData) <> 0 then exit;
    GetHostName(Buffer,Sizeof(Buffer));
    phoste:=GetHostByName(buffer);
    if phoste = nil then
    result := '127.0.0.1'
    else
    result := StrPas(inet_ntoa(PInAddr(phoste^.h_addr_list^)^));
    WSACleanup;
end;

function GetOS: string;
const
  cOsUnknown  = 'Unknown';
  cOsWin95    = 'windows-95';
  cOsWin98    = 'windows-98';
  cOsWin98SE  = 'Windows-98SE';
  cOsWinME    = 'Windows-ME';
  cOsWinNT3   = 'Windows-NT3';
  cOsWinNT4   = 'Windows-NT4';
  cOsWin2000  = 'Windows-2000';
  cOsXP       = 'Windows-XP';
  cOsVista    = 'Windows-Vista';
  cOsSeven    = 'Windows-Seven';
  cOsWin8     = 'Windows-8';
var
  OS: TOSVersionInfo;
  majorVer, minorVer: Integer;
begin
  Result := cOsUnknown;
  OS.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);

  if GetVersionEx(OS) then
  begin
    majorVer := OS.dwMajorVersion;
    minorVer := OS.dwMinorVersion;
    case OS.dwPlatformId of
      VER_PLATFORM_WIN32_NT: { Windows NT/2000/XP/Vista/Seven }
        begin
          if majorVer <= 4 then
            Result := cOsWinNT3
          else if majorVer = 5 then
            Result := cOsWinNT4
          else if (majorVer = 5) and (minorVer = 0) then
            Result := cOsWin2000
          else if (majorVer = 5) and (minorVer = 1) then
            Result := cOsXP
          else if (majorVer = 6) and (minorVer = 0) then
            Result := cOsVista
          else if (majorVer = 6) and (minorVer = 1) then
            Result := cOsSeven
          else if (majorVer = 6) and (minorVer = 2) then
            Result := cOswin8
          else
            Result := cOsUnknown;
        end;
      VER_PLATFORM_WIN32_WINDOWS:  { Windows 9x/ME }
        begin
          if (majorVer = 4) and (minorVer = 0) then
            Result := cOsWin95
          else if (majorVer = 4) and (minorVer = 10) then
          begin
            if OS.szCSDVersion[1] = 'A' then
              Result := cOsWin98SE
            else
              Result := cOsWin98;
          end
          else if (majorVer = 4) and (minorVer = 90) then
            Result := cOsWinME
          else
            Result := cOsUnknown;
        end;
      else
        Result := cOsUnknown;
    end;
  end
  else
    Result := cOsUnknown;
end;

end.
