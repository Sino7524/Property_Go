unit uIOTable1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TfrmIOTable1 = class(TForm)
    cboRealtor: TComboBox;
    dtpDate: TDateTimePicker;
    dtpTime: TDateTimePicker;
    edtDateOf: TEdit;
    lblSchedule: TLabel;
    lblStatus: TLabel;
    lblRealtor: TLabel;
    lblClient: TLabel;
    cboClient: TComboBox;
    lblProperty: TLabel;
    cboProperty: TComboBox;
    cboState: TComboBox;
    btnOkay: TBitBtn;
    btnCancel: TBitBtn;
    chkViewed: TCheckBox;
    lblMessage: TLabel;
    memMessage: TMemo;
    procedure FormShow(Sender: TObject);
    procedure btnOkayClick(Sender: TObject);
    procedure dtpDateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    mode : String;
  end;

var
  frmIOTable1: TfrmIOTable1;

implementation
Uses uDM, DateUtils;
{$R *.dfm}

procedure TfrmIOTable1.btnOkayClick(Sender: TObject);
var sPropID : String;
    sRealID : String;
    sClinID : String;
begin
try
  sPropID := Copy(cboProperty.Text, 2, POS(']', cboProperty.Text) - 2);
  sRealID := Copy(cboRealtor.Text, 2, POS(']', cboRealtor.Text) - 2);
  sClinID := Copy(cboClient.Text, 2, POS(']', cboClient.Text) - 2);

  if mode = 'Edit'   then DM.tblAppointments.Edit;
  if mode = 'Insert' then DM.tblAppointments.Insert;
  //... Write data to each data field as found in GUI component.

  DM.tblAppointments['Appointment_date'] := StrToDateTime(self.edtDateOf.Text);
  DM.tblAppointments['State'] := self.cboState.Text;
  DM.tblAppointments['Realtor_Name'] := DM.getComboBoxValue(cboRealtor);
  DM.tblAppointments['Property_Name'] := DM.getComboBoxValue(cboProperty);
  DM.tblAppointments['Client_Name'] := DM.getComboBoxValue(cboClient);
  DM.tblAppointments['Realtor_ID'] := sRealID;
  DM.tblAppointments['Property_ID'] := sPropID;
  DM.tblAppointments['Client_ID'] := sClinID;
  DM.tblAppointments['Message'] := memMessage.Text;

  if mode = 'Insert' then   DM.tblAppointments['Viewed'] := False;
  if mode = 'Edit' then     DM.tblAppointments['Viewed'] := chkViewed.Checked;

  // Find the matching Names for easier displaying of the names...
  DM.tblAppointments.Post;

finally
end;
end;


procedure TfrmIOTable1.dtpDateChange(Sender: TObject);
begin
  self.edtDateOf.Text := DateTimeToStr(DateOf(dtpDate.Date)+TimeOf(dtpTime.Time));
end;

procedure TfrmIOTable1.FormShow(Sender: TObject);
const sql1 = 'SELECT First_Name, Realtor_ID FROM tblRealtors ORDER BY First_Name';
      sql2 = 'SELECT Client_ID, ([Surname]+[First_Name]) AS Fullanme FROM tblClients ORDER BY Surname;';
      sql3 = 'SELECT Property_ID, Property_Name FROM tblProperties ORDER BY Property_Name;';
begin
  self.Caption := 'Appointment['+self.Mode+']';

  chkViewed.Visible := self.mode = 'Edit';

  DM.fillComboBox( cboRealtor,   sql1 ,'Realtor_ID','First_Name' );
  DM.fillComboBox( cboClient ,   sql2 ,'Client_ID','Fullanme' );
  DM.fillComboBox( cboProperty , sql3 ,'Property_ID','Property_Name' );
//  DM.fillComboBox( cboRealtor,'SELECT Surname, Realtor_ID FROM tblRealtors ORDER BY Surname','Realtor_ID','Surname' );

  if self.mode = 'Edit' then Begin
    //... Read data from each data field and show in GUI component.
    self.cboState.Text := DM.tblAppointments['State'];
    memMessage.Text := DM.tblAppointments['Message'];
    chkViewed.Checked := DM.tblAppointments['Viewed'];
    self.edtDateOf.Text := DateTimeToStr(DM.tblAppointments['Appointment_Date']);
    cboRealtor.Text := '[' + DM.tblAppointments.FieldByName('Realtor_ID').AsString + '] ' + DM.tblAppointments.FieldByName('Realtor_Name').AsString;
    cboClient.Text := '[' + DM.tblAppointments.FieldByName('Client_ID').AsString + '] ' + DM.tblAppointments.FieldByName('Client_Name').AsString;
    cboProperty.Text := '[' + DM.tblAppointments.FieldByName('Property_ID').AsString + '] ' + DM.tblAppointments.FieldByName('Property_Name').AsString;
    // self.cboProperty.Text :=
  End;


end;

end.
