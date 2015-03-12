object Form5: TForm5
  Left = 0
  Top = 0
  Caption = 'Auto Mass Update'
  ClientHeight = 62
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 27
    Width = 23
    Height = 13
    Caption = 'Url : '
  end
  object Button1: TButton
    Left = 423
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Update'
    TabOrder = 0
    OnClick = Button1Click
  end
  object EdtUrl: TEdit
    Left = 45
    Top = 24
    Width = 372
    Height = 21
    TabOrder = 1
    Text = 'www.example.com\update.exe'
  end
end
