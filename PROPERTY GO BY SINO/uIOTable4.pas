unit uIOTable4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TfrmIOTable4 = class(TForm)
    lblSurname: TLabel;
    lblEmail: TLabel;
    lblFirstName: TLabel;
    lblDoB: TLabel;
    lblPhone: TLabel;
    edtSurname: TEdit;
    btnOkay: TBitBtn;
    btnCancel: TBitBtn;
    edtFirstname: TEdit;
    edtPhone: TEdit;
    edtEmail: TEdit;
    dtpDateOfBirth: TDateTimePicker;
    cboDeleted: TCheckBox;
    Label5: TLabel;
    edtID: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnOkayClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    mode: String;
  end;

var
  frmIOTable4: TfrmIOTable4;

implementation

Uses uDM, DateUtils;
{$R *.dfm}

procedure TfrmIOTable4.btnOkayClick(Sender: TObject);
begin
 if edtID.Text <> '' then
  begin
  if mode = 'Edit' then
    DM.tblRealtors.Edit;
  if mode = 'Insert' then
    DM.tblRealtors.Insert;
  // ... Write data to each data field as found in GUI component.
  DM.tblRealtors['Surname'] := self.edtSurname.Text;
  DM.tblRealtors['First_Name'] := self.edtFirstname.Text;
  DM.tblRealtors['Birth_Date'] := DateOf(self.dtpDateOfBirth.Date);
  DM.tblRealtors['Phone'] := self.edtPhone.Text;
  DM.tblRealtors['Email'] := self.edtEmail.Text;
  DM.tblRealtors['Deleted'] := cboDeleted.Checked;
  DM.tblRealtors['Realtor_ID'] := edtID.Text;

  // Find the matching Names for easier displaying of the names...
  DM.tblRealtors.Post;
  end
  else showMessage('Please input Realtor ID');

end;

procedure TfrmIOTable4.FormShow(Sender: TObject);
begin
  self.Caption := 'Realtors[' + self.mode + ']';
  if self.mode = 'Edit' then
  Begin
    // ... Read data from each data field and show in GUI component.
    edtID.Enabled := False;
    self.edtSurname.Text := DM.tblRealtors.FieldByName('Surname').AsString;
    self.edtFirstname.Text := DM.tblRealtors.FieldByName('First_Name').AsString;
    self.dtpDateOfBirth.DateTime := DM.tblRealtors.FieldByName('Birth_Date')
      .AsDateTime;
    self.edtPhone.Text := DM.tblRealtors.FieldByName('Phone').AsString;
    self.edtEmail.Text := DM.tblRealtors.FieldByName('Email').AsString;
    cboDeleted.Checked := DM.tblRealtors.FieldByName('Deleted').AsBoolean;
    self.edtID.Text := DM.tblRealtors.FieldByName('Realtor_ID').AsString;
    // self.edtSurname.Text := DM.tblRealtors.FieldByName('').AsString;
  End
  else  edtID.Enabled := True;
end;

end.
