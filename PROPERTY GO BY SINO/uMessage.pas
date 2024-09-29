unit uMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmMessages = class(TForm)
    memMessage: TMemo;
    shpSend: TShape;
    lblSend: TLabel;
    procedure shpSendMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure shpSendMouseEnter(Sender: TObject);
    procedure shpSendMouseLeave(Sender: TObject);
    procedure shpSendMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lblSendClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Send;
  end;

var
  frmMessages: TfrmMessages;
  sMessage : String;

implementation
uses uDM, uRealtor, uSQLExplorer, uClient;

{$R *.dfm}

procedure TfrmMessages.lblSendClick(Sender: TObject);
begin
Send;
end;

procedure TfrmMessages.Send;
var bfound : Boolean;
  i, id : Integer;
begin
shpSend.Brush.Color := clGreen;
 id := dm.query.FieldByName('Appointment_ID').AsInteger;
 //showmessage(Inttostr(id));

 sMessage := memMessage.Lines.GetText;

 //sMessage := '§';

   {for i := 1 to memMessage.Lines.Count do
     begin
       if memMessage.Lines[i] = '' then
       sMessage := sMessage + '§'
       else sMessage := sMessage + 'ß' + memMessage.Lines[i];
     end; }

{ DM.query.First;
      while (not DM.tblAppointments.Eof) and (bFound = True) do
 begin
   if DM.query.FieldByName('Appointment_ID').AsInteger = id then
   begin
   bFound := True;
     DM.query.Edit;
     DM.query['Message'] := sMessage;
     DM.query.Post;
   end
   else DM.query.Next;

 end;                    }

  uSQLExplorer.frmSQLExplorer.execSQL('UPDATE tblAppointments SET State = "Rejected" WHERE Appointment_ID ='+IntToStr(id));
  uSQLExplorer.frmSQLExplorer.execSQL('UPDATE tblAppointments SET Message = ' + QuotedStr(sMessage) + ' WHERE Appointment_ID ='+IntToStr(id));
 uSQLExplorer.frmSQLExplorer.runSQL(uClient.frmClient.sSQL);
 showMessage('Message sent. Appointment successfully rejected');

end;

procedure TfrmMessages.shpSendMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  begin
  Send;
end;

procedure TfrmMessages.shpSendMouseEnter(Sender: TObject);
begin
shpSend.Brush.Color := $0000FF80;
end;

procedure TfrmMessages.shpSendMouseLeave(Sender: TObject);
begin
shpSend.Brush.Color := $002ED629;
end;

procedure TfrmMessages.shpSendMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
shpSend.Brush.Color := $002ED629;
end;

end.
