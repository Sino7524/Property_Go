unit uIOAppointment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TfrmIOAppointment = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet3: TTabSheet;
    cboProperty: TComboBox;
    dtpDate: TDateTimePicker;
    dtpTime: TDateTimePicker;
    cboState: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnOkay: TBitBtn;
    BitBtn1: TBitBtn;
    edtDateOf: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lblProvince: TLabel;
    lblSize: TLabel;
    lblPrice: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    cboRealtor: TComboBox;
    btnCancel: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnOkayClick(Sender: TObject);
    procedure dtpDateChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    mode : String;
  end;

var
  frmIOAppointment: TfrmIOAppointment;

implementation
Uses uDM, DateUtils;
{$R *.dfm}

procedure TfrmIOAppointment.BitBtn1Click(Sender: TObject);
begin
  self.PageControl1.ActivePageIndex :=   self.PageControl1.ActivePageIndex + 1;
end;

procedure TfrmIOAppointment.btnOkayClick(Sender: TObject);
begin
  if mode = 'Edit'   then DM.tblAppointments.Edit;
  if mode = 'Insert' then DM.tblAppointments.Insert;
  //... Write data to each data field as found in GUI component.

  DM.tblAppointments['Appointment_date'] := StrToDateTime(self.edtDateOf.Text);
  DM.tblAppointments['State'] := self.cboState.Text;
  DM.tblAppointments['Realtor_ID'] := self.cboRealtor.Text;
  DM.tblAppointments['Property_ID'] := self.cboProperty.Text;

  // Find the matching Names for easier displaying of the names...
  DM.tblAppointments.Post;
end;

procedure TfrmIOAppointment.dtpDateChange(Sender: TObject);
begin
  self.edtDateOf.Text := DateTimeToStr(DateOf(dtpDate.Date)+TimeOf(dtpTime.Time));
end;

procedure TfrmIOAppointment.FormShow(Sender: TObject);
begin
  self.Caption := 'Appointment['+self.Mode+']';
  self.PageControl1.ActivePageIndex := 0;

  if self.mode = 'Edit' then Begin
    //... Read data from each data field and show in GUI component.
  End;
end;

end.
