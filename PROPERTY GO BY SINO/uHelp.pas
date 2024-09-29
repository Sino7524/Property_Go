unit uHelp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, comObj;

type
  TfrmHelp = class(TForm)
    redHelp: TRichEdit;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHelp: TfrmHelp;

implementation

{$R *.dfm}

procedure TfrmHelp.Button1Click(Sender: TObject);
var ovRead : oleVariant;
begin
OvRead := CreateOleObject( 'SAPI.SPVoice' );
OvRead.Speak(redHelp.Text);
end;

procedure TfrmHelp.FormShow(Sender: TObject);
var tf : textfile;
sLine : String;
begin

if FileExists('ProjectNotes.txt') = True then
begin
AssignFile(tf, 'ProjectNotes.txt');
Reset(tf);

while not eof(tf) do
begin
ReadLn(tf, sLine);
redHelp.Lines.Add(sLine);
end;

CloseFile(tf);
end
else showMessage('Help files do not exist. This is because you might have deleted the files. Try Deleting the application and installing it again.');

end;

end.
