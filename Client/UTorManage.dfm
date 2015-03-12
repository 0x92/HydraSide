object Form8: TForm8
  Left = 0
  Top = 0
  Caption = 'Tor Manager'
  ClientHeight = 260
  ClientWidth = 661
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 645
    Height = 249
    ActivePage = TabSheet3
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Tor Services'
      ExplicitHeight = 249
      object LvTorHost: TListView
        Left = 3
        Top = 3
        Width = 631
        Height = 214
        Columns = <
          item
            Caption = 'HostName'
            Width = 150
          end
          item
            Caption = 'Local Port'
            Width = 120
          end
          item
            Caption = 'Remote Port'
            Width = 120
          end
          item
            Caption = 'Folder'
            Width = 230
          end>
        GridLines = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Add New Service'
      ImageIndex = 1
      ExplicitHeight = 353
      object Label1: TLabel
        Left = 3
        Top = 27
        Width = 103
        Height = 13
        Caption = 'Hidden Service Path :'
      end
      object Label2: TLabel
        Left = 3
        Top = 54
        Width = 110
        Height = 13
        Caption = 'Service Port (Remote):'
      end
      object Label3: TLabel
        Left = 0
        Top = 81
        Width = 119
        Height = 13
        Caption = 'Client Local Port (Local) :'
      end
      object EdtServicePath: TEdit
        Left = 128
        Top = 24
        Width = 289
        Height = 21
        TabOrder = 0
        Text = '%CurrentPath%\Tor\TorHost\%random%'
      end
      object EdtTorPort: TEdit
        Left = 128
        Top = 51
        Width = 289
        Height = 21
        TabOrder = 1
        Text = '1515'
      end
      object Edit1: TEdit
        Left = 128
        Top = 78
        Width = 289
        Height = 21
        TabOrder = 2
        Text = '1515'
      end
      object Button1: TButton
        Left = 342
        Top = 105
        Width = 75
        Height = 25
        Caption = 'Add Host'
        TabOrder = 3
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Remove Service'
      ImageIndex = 2
      ExplicitHeight = 353
    end
  end
end
