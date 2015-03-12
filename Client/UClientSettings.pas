unit UClientSettings;

interface

uses inifiles,windows,sysutils,ufunctions;

var
IniFile : TIniFile;

Procedure ReadClientSettings();
Procedure SaveClientSettings();

implementation

uses UMian;

Procedure ReadClientSettings();
var
Tmp,Tor:boolean;
begin
  iniFile := TIniFile.Create(getcurrentdir + '\' + 'UserSettings.ini');
  tmp := inifile.ReadBool('LoadSettings','LoadSettings',false);
  Tor := inifile.ReadBool('Tor','AutoStart',false);
  form1.EdtTorPath.Text := inifile.Readstring('Tor','TorPath','');
  if tmp = false then exit;
  if tor = true then
  begin
  if FileExists(GetCurrentDir + form1.EdtTorPath.Text) then
  begin
    runapp(GetCurrentDir + form1.EdtTorPath.Text);
    messagebox(0,'Tor Started','HydraSide Tor Started.',0);
  end
  else
  begin
   messagebox(0,'The Tor binary was not in the tor folder.','HydraSide Tor Not Found',0);
  end;
  end;

  form1.ConPasswrd.Text := inifile.ReadString('Client','ConnectionPassword','');
  form1.EdtPort.Text := inifile.ReadString('Client','ConnectionPort','');
  form1.CBStartSockOnOpen.Checked := inifile.ReadBool('Client','AutoConnect',false);
  form1.CBShowNotif.Checked := inifile.ReadBool('Notification','NotificationBalloon',false);
  form1.CBShowPopup.Checked := inifile.ReadBool('Notification','NotificationPopup',false);
  form1.CBNotifyOnCon.Checked := inifile.ReadBool('Notification','NotifyOnConect',false);
  form1.CBNotifyDisCon.Checked := inifile.ReadBool('Notification','NotifyOnDisconnect',false);
  form1.LogConns.Checked := inifile.ReadBool('Logs','LogConnections',false);
  form1.CBLogIncom.Checked := inifile.ReadBool('Logs','LogIncomming',false);
  form1.CBLogConns.Checked := inifile.ReadBool('Logs','logOnConnect',false);
  form1.CBLogDis.Checked := inifile.ReadBool('Logs','logOnDisconnect',false);
  form1.EdtTorPath.Text := inifile.Readstring('Tor','TorPath','');
  form1.edtTorFiles.Text := inifile.ReadString('Tor','TorFiles','');
  form1.edtTorPort.Text := inifile.ReadString('Tor','TorPort','');
  form1.EdtTorec.Text := inifile.ReadString('Tor','Torecc','');
  form1.CbOpenTor.Checked := inifile.ReadBool('Tor','AutoStart',false);
  form1.CBEnableDebug.Checked := inifile.ReadBool('Debugger','EnableDebugger',false);
  form1.CBLoadSettings.Checked := inifile.ReadBool('LoadSettings','LoadSettings',false);

end;

Procedure SaveClientSettings();
begin
  iniFile := TIniFile.Create(getcurrentdir + '\' + 'UserSettings.ini');
  iniFile.WriteString('Client','ConnectionPassword',form1.ConPasswrd.Text);
  iniFile.WriteString('Client','ConnectionPort',form1.EdtPort.Text);
  iniFile.WriteBool('Client','AutoConnect',form1.CBStartSockOnOpen.Checked);
  iniFile.WriteBool('Notification','NotificationBalloon',form1.CBShowNotif.Checked);
  iniFile.WriteBool('Notification','NotificationPopup',form1.CBShowPopup.Checked);
  iniFile.WriteBool('Notification','NotifyOnConect',form1.CBNotifyOnCon.Checked);
  iniFile.WriteBool('Notification','NotifyOnDisconnect',form1.CBNotifyDisCon.Checked);
  iniFile.WriteBool('Logs','LogConnections',form1.LogConns.Checked);
  iniFile.WriteBool('Logs','LogIncomming',form1.CBLogIncom.Checked);
  iniFile.WriteBool('Logs','logOnConnect',form1.CBLogConns.Checked);
  iniFile.WriteBool('Logs','logOnDisconnect',form1.CBLogDis.Checked);
  iniFile.WriteString('Tor','TorPath',form1.EdtTorPath.Text);
  iniFile.WriteString('Tor','TorFiles',form1.edtTorFiles.Text);
  iniFile.WriteString('Tor','TorPort',form1.edtTorPort.Text);
  iniFile.WriteString('Tor','Torecc',form1.EdtTorec.Text);
  iniFile.WriteBool('Tor','AutoStart',form1.CbOpenTor.Checked);
  iniFile.WriteBool('Debugger','EnableDebugger',form1.CBEnableDebug.Checked);
  iniFile.WriteBool('LoadSettings','LoadSettings',form1.CBLoadSettings.Checked);
end;


end.
