unit uIOTable3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, Spin, ExtDlgs;

type
  TfrmIOTable3 = class(TForm)
    btnOkay: TBitBtn;
    btnCancel: TBitBtn;
    lblLabel1: TLabel;
    edtProperty_Name: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    lblProvince: TLabel;
    lblDescription: TLabel;
    spnProperty_Size: TSpinEdit;
    edtPrice: TEdit;
    chkSold: TCheckBox;
    edtProvince: TEdit;
    memDescription: TMemo;
    lblImage: TLabel;
    edtImage: TEdit;
    lblPropertyDataPrice: TLabel;
    edtPropDataPrice: TEdit;
    lblID: TLabel;
    edtID: TEdit;
    dlgImage: TOpenPictureDialog;
    procedure FormShow(Sender: TObject);
    procedure btnOkayClick(Sender: TObject);
    procedure edtImageClick(Sender: TObject);
    procedure dlgImageSelectionChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    mode : String;
  end;

var
  frmIOTable3: TfrmIOTable3;

implementation
Uses uDM, DateUtils;
{$R *.dfm}

procedure TfrmIOTable3.btnOkayClick(Sender: TObject);
begin
 if (edtID.Text <> '') or (self.edtPrice.Text <> '') then
  begin
   if mode = 'Edit' then
    DM.tblProperties.Edit;
  if mode = 'Insert' then
    DM.tblProperties.Insert;
  //... Write data to each data field as found in GUI component.
  DM.tblProperties['Property_Name'] := self.edtProperty_Name.Text;
  DM.tblProperties['Size'] := self.spnProperty_Size.Value;
  DM.tblProperties['Price'] := StrToInt(edtPrice.Text);
  DM.tblProperties['Province'] := edtProvince.Text;
  DM.tblProperties['Description'] := memDescription.Text;
  DM.tblProperties['Image'] := edtImage.Text;
  DM.tblProperties['PropertyDataPrice'] := StrToInt(edtPropDataPrice.Text);
  DM.tblProperties['Sold'] := self.chkSold.Checked;
  DM.tblProperties['Property_ID'] := edtID.Text;

  // Find the matching Names for easier displaying of the names...
  DM.tblProperties.Post;
  end
  else showMessage('Please input a Property ID and/or Please input Property Data Price');

end;

procedure TfrmIOTable3.dlgImageSelectionChange(Sender: TObject);
var sImage : String;
begin
sImage := dlgImage.FileName;

repeat
Delete(sImage, 1, Pos('\', sImage) )
until (Pos('\', sImage) = 0) ;

edtImage.Text := sImage;

end;

procedure TfrmIOTable3.edtImageClick(Sender: TObject);
begin
dlgImage.Execute();
end;

procedure TfrmIOTable3.FormShow(Sender: TObject);
begin
  self.Caption := 'Property['+self.Mode+']';
  if self.mode = 'Edit' then Begin
  edtID.Enabled := False;
    //... Read data from each data field and show in GUI component.
    self.edtProperty_Name.Text := DM.tblProperties.FieldByName('Property_Name').AsString;
    spnProperty_Size.Value := DM.tblProperties.FieldByName('Size').AsInteger;
    edtPrice.Text := DM.tblProperties.FieldByName('Price').AsString;
    edtProvince.Text := DM.tblProperties.FieldByName('Province').AsString;
    memDescription.Text := DM.tblProperties.FieldByName('Description').AsString;
    edtImage.Text := DM.tblProperties.FieldByName('Image').AsString;
    edtPropDataPrice.Text := DM.tblProperties.FieldByName('PropertyDataPrice').AsString;
    chkSold.Checked := DM.tblProperties.FieldByName('Sold').AsBoolean;
    self.edtID.Text := DM.tblProperties.FieldByName('Property_ID').AsString;
//    self.edtSurname.Text := DM.tblProperties.FieldByName('').AsString;
  End
  else edtID.Enabled := True;
end;

end.
