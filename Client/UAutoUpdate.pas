unit UAutoUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,usettings;

type
  TForm5 = class(TForm)
    Button1: TButton;
    EdtUrl: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

uses UMian;

procedure TForm5.Button1Click(Sender: TObject);
begin
if form1.a9.Checked = false then
  begin
    AutoCommand := 'Supdate|' + EdtUrl.Text;
    AutoCommandSet := true;
    showmessage('Command Set');
    form1.a9.Checked := true;
    form5.Close;
  end
  else
  begin
    showmessage('Command Reset');
    AutoCommand := '';
    AutoCommandSet := false;
    form1.a9.Checked := false;
  end;
end;

end.
