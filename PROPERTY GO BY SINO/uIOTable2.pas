unit uIOTable2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TfrmIOTable2 = class(TForm)
    edtSurname: TEdit;
    lblSurname: TLabel;
    lblEmail: TLabel;
    lblFirstName: TLabel;
    lblDoB: TLabel;
    lblPhone: TLabel;
    btnOkay: TBitBtn;
    btnCancel: TBitBtn;
    edtFirstname: TEdit;
    edtPhone: TEdit;
    edtEmail: TEdit;
    dtpDateOfBirth: TDateTimePicker;
    lblID: TLabel;
    edtID: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnOkayClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    mode : String;
  end;

var
  frmIOTable2: TfrmIOTable2;

implementation
Uses uDM, DateUtils;
{$R *.dfm}

procedure TfrmIOTable2.btnOkayClick(Sender: TObject);
begin
if edtID.Text <> '' then
  begin
    if mode = 'Edit' then
    DM.tblClients.Edit;
  if mode = 'Insert' then
    DM.tblClients.Insert;
  //... Write data to each data field as found in GUI component.
  DM.tblClients['Surname'] := self.edtSurname.Text;
  DM.tblClients['First_Name'] := self.edtFirstname.Text;
  DM.tblClients['Birth_Date'] := DateOf(self.dtpDateOfBirth.Date);
  DM.tblClients['Phone'] := self.edtPhone.Text;
  DM.tblClients['Email'] := self.edtEmail.Text;
   DM.tblClients['Client_ID'] := edtID.Text;

  // Find the matching Names for easier displaying of the names...
  DM.tblClients.Post;
  end
  else showMessage('Please input Client ID');
end;

procedure TfrmIOTable2.FormShow(Sender: TObject);
begin
  self.Caption := 'Client['+self.Mode+']';
  if self.mode = 'Edit' then Begin
    //... Read data from each data field and show in GUI component.
    edtID.Enabled := False;
    self.edtSurname.Text := DM.tblClients.FieldByName('Surname').AsString;
    self.edtFirstname.Text := DM.tblClients.FieldByName('First_Name').AsString;
    self.dtpDateOfBirth.DateTime := DM.tblClients.FieldByName('Birth_Date').AsDateTime;
    self.edtPhone.Text := DM.tblClients.FieldByName('Phone').AsString;
    self.edtEmail.Text := DM.tblClients.FieldByName('Email').AsString;
    self.edtID.Text := DM.tblClients.FieldByName('Client_ID').AsString;
  End
  else  edtID.Enabled := True;
end;

end.
