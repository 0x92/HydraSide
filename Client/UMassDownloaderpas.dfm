object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'Form6'
  ClientHeight = 133
  ClientWidth = 496
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 4
    Width = 481
    Height = 125
    Caption = 'Downloader'
    TabOrder = 0
    object Label2: TLabel
      Left = 32
      Top = 59
      Width = 52
      Height = 13
      Caption = 'Filename : '
    end
    object Label1: TLabel
      Left = 53
      Top = 19
      Width = 26
      Height = 13
      Caption = 'URL :'
    end
    object Button1: TButton
      Left = 392
      Top = 83
      Width = 75
      Height = 25
      Caption = 'Send'
      TabOrder = 0
      OnClick = Button1Click
    end
    object EdtPath: TEdit
      Left = 90
      Top = 56
      Width = 377
      Height = 21
      TabOrder = 1
      Text = 'File.exe'
    end
    object EdtUrl: TEdit
      Left = 90
      Top = 16
      Width = 377
      Height = 21
      TabOrder = 2
      Text = 'www.example.com/update.exe'
    end
  end
end
