program PClient;

uses
  Vcl.Forms,
  windows,
  UMian in 'UMian.pas' {Form1},
  USettings in 'USettings.pas',
  UAbout in 'UAbout.pas' {Form2},
  UFunctions in 'UFunctions.pas',
  UDownloader in 'UDownloader.pas' {Form3},
  UAutoDownloader in 'UAutoDownloader.pas' {Form4},
  UAutoUpdate in 'UAutoUpdate.pas' {Form5},
  UMassDownloaderpas in 'UMassDownloaderpas.pas' {Form6},
  Updater in 'Updater.pas' {Form7},
  UClientSettings in 'UClientSettings.pas',
  UTorManage in 'UTorManage.pas' {Form8};

{$R *.res}

begin
  //check local user for settings
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm8, Form8);
  Application.Run;
end.
