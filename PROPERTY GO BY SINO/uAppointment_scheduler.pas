unit uAppointment_scheduler;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, ComCtrls, CheckLst, uDM, DateUtils, uGlobal,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTPRelay,
  IdSMTP, IdMessage, ShellAPI;

type
  TfrmAppointments = class(TForm)
    imgBackground: TImage;
    edtAppointmentID: TEdit;
    edtPropertyID: TEdit;
    dtpDate: TDateTimePicker;
    dtpTime: TDateTimePicker;
    edtRealtor: TEdit;
    btnEllipsis: TButton;
    lblPropertyName: TLabel;
    shpCreateAppointment: TShape;
    lblCreateAppointment: TLabel;
    SMTP: TIdSMTP;
    Msg: TIdMessage;
    procedure btnEllipsisClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure shpCreateAppointmentMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure shpCreateAppointmentMouseEnter(Sender: TObject);
    procedure shpCreateAppointmentMouseLeave(Sender: TObject);
    procedure shpCreateAppointmentMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lblCreateAppointmentMouseEnter(Sender: TObject);
    procedure lblCreateAppointmentMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure lblCreateAppointmentMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lblCreateAppointmentClick(Sender: TObject);
  private
    { Private declarations }
    function CheckDetails : Boolean;
    procedure Schedule;
  public
    { Public declarations }
  end;

var
  frmAppointments: TfrmAppointments;

implementation
uses uFindSelection, uClient;
{$R *.dfm}


procedure TfrmAppointments.btnEllipsisClick(Sender: TObject);
begin
  frmFindSelection.keyField := 'Realtor_ID';
  frmFindSelection.setSQL('SELECT Realtor_ID, Surname, First_Name from tblRealtors  ORDER BY Surname');
  frmFindSelection.ShowModal;
  edtRealtor.Text := frmFindSelection.valueField;
end;

function TfrmAppointments.CheckDetails: Boolean;
var isOkay : Boolean;
    hour: Integer;
begin
isOkay := True;

 hour := HourOf(dtpTime.Time);

 if NOT(hour IN[7..17]) then
 BEGIN
 isOkay := False;
 showMessage('Our working hours are 07:00 - 17:00. Please select a time in this range');
 END;

if dtpDate.Date - Today < 10 then
begin
showMessage('You have to book an appointment at least 10 days prior.');
isOkay := False;
end;

if (DM.tblRealtors.Locate('Realtor_ID', edtRealtor.Text, []) = False) AND NOT (edtRealtor.Text = '') then
begin
showMessage('The chosen realtor does not exist');
isOkay := False;
edtRealtor.Color := $007777FF;
end;

if edtRealtor.Text = '' then
begin
showMessage('Please choose a realtor');
  isOkay := False;
  edtRealtor.Color := $007777FF;
end;

result := isOkay;

end;


procedure TfrmAppointments.FormShow(Sender: TObject);
var sAppointment_ID, sPick : String;
iLoop : integer;
begin
edtPropertyID.Text := DM.tblProperties.FieldByName('Property_ID').AsString;
lblPropertyName.Caption := DM.tblProperties.FieldByName('Property_Name').AsString;

DM.tblAppointments.Last;
edtAppointmentID.Text := IntToStr(DM.tblAppointments.FieldByName('Appointment_ID').AsInteger + 1);
{Because the field 'Appointments_ID' in tblAppointments is an autonumber, one is added to the last
 Appointment_ID for display purposes (since it will be the new "last" Appointment_ID after the
 Appointment details are inserted into the table)}

end;

procedure TfrmAppointments.lblCreateAppointmentClick(Sender: TObject);
begin
Schedule;
end;

procedure TfrmAppointments.lblCreateAppointmentMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
shpCreateAppointment.Brush.Color := $00800040;  //UX Design
end;

procedure TfrmAppointments.lblCreateAppointmentMouseEnter(Sender: TObject);
begin
 shpCreateAppointment.Brush.Color := $00FF2291; //UX Design
end;

procedure TfrmAppointments.lblCreateAppointmentMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
shpCreateAppointment.Brush.Color := $00EB175E; //UX Design
end;

procedure TfrmAppointments.Schedule;
 var sRealtorName, sPropertyName, sEmail : String;
  bFound : Boolean;
begin
bFound := False;
shpCreateAppointment.Brush.Color := $00800040;  //UX Design

if (DM.tblRealtors.Locate('Realtor_ID', self.edtRealtor.Text, []))  then
begin
sRealtorName := DM.tblRealtors.FieldByName('First_Name').AsString;
sPropertyName := uClient.frmClient.lblName.Caption;
{VALIDATION}
if CheckDetails() = True then
begin
DM.tblAppointments.Insert;
DM.tblAppointments['Property_ID'] := edtPropertyID.Text;

if objGlobalUser <> Nil then
DM.tblAppointments['Client_Name'] := objGlobalUser.getName;

DM.tblAppointments['Property_Name'] := sPropertyName;
DM.tblAppointments['Realtor_Name'] := sRealtorName;
DM.tblAppointments['Realtor_ID'] := edtRealtor.Text;
DM.tblAppointments['State'] := 'Unknown';

if objGlobalUser <> Nil then
DM.tblAppointments['Client_ID'] := objGlobalUser.getUsername;

DM.tblAppointments['Appointment_date'] := dtpDate.Date + dtpTime.Time;
DM.tblAppointments.Post;
showMessage('Appointment has been successfully created. You will soon recieve an email with the details of the appointment.');

end
else showMessage('Realtor does not exist. Please choose another realtor');
{SMTP.Host := 'smtp.gmail.com';
      SMTP.Port := 25;
      SMTP.AuthType := satDefault;
      SMTP.Username := 'sinothandonokuphila@gmail.com';
      SMTP.Password := '@sno1thando3';
      SMTP.Connect;

          Msg.From.Address := 'sinodlamini3@gmail.com';
    Msg.Recipients.EMailAddresses := 'sinothandonokuphila@gmail.com';
    Msg.Body.Text := 'This email is a delphi experiment';
    Msg.Subject := 'Email from PropertyGo';
      SMTP.free;
      Msg.free;

    SMTP.UseTLS := utUseExplicitTLS;

      SMTP.Send(Msg);  }

      while not(DM.tblClients.eof) and (bFound = False) do
      begin
      if DM.tblClients['Client_ID'] = objGLobalUser.getUsername then
      begin
        bFound := True;
        sEmail := DM.tblClients.FieldByName('Email').AsString;
      end
      else DM.tblClients.Next;
      end;

    {  ShellExecute(Self.Handle,
             nil,
             'mailto:' +
             sEmail +
             '?Subject=Test Message Subject' +
             '&Body=Test Message Body,
             nil,
             nil,
             SW_NORMAL); }

end;

end;

procedure TfrmAppointments.shpCreateAppointmentMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
 begin
 Schedule;
end;

procedure TfrmAppointments.shpCreateAppointmentMouseEnter(Sender: TObject);
begin
shpCreateAppointment.Brush.Color := $00FF2291; // UX Design
end;

procedure TfrmAppointments.shpCreateAppointmentMouseLeave(Sender: TObject);
begin
shpCreateAppointment.Brush.Color := $00EB175E; // UX Design
end;

procedure TfrmAppointments.shpCreateAppointmentMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
shpCreateAppointment.Brush.Color := $00EB175E; //UX Design
end;

end.
