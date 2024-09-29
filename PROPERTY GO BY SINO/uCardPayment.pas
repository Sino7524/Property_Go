unit uCardPayment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, uDM, uGlobal, ComCtrls, DateUtils;

type
  TfrmCardPayment = class(TForm)
    imgBackground: TImage;
    cboAgreement: TCheckBox;
    edtCardName: TEdit;
    edtCVV: TEdit;
    edtCardNumber: TEdit;
    shpProceed: TShape;
    lblProceed: TLabel;
    dtpExpiryDate: TDateTimePicker;
    pnlDetails: TPanel;
    lblTotal: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblItem: TLabel;
    lblPropertyID: TLabel;
    lblClientID: TLabel;
    lblCardNumber: TLabel;
    procedure shpProceedMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure edtCardNumberExit(Sender: TObject);
    procedure shpProceedMouseEnter(Sender: TObject);
    procedure shpProceedMouseLeave(Sender: TObject);
    procedure shpProceedMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lblProceedClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Pay;
  end;

var
  frmCardPayment: TfrmCardPayment;
  bSuccess : Boolean;

implementation

{$R *.dfm}

procedure TfrmCardPayment.edtCardNumberExit(Sender: TObject);
var sMasked : String;
begin
  sMasked := Trim(edtCardNumber.Text);
  sMasked := Copy(sMasked, Length(sMasked)-3, 4);
  sMasked := '************' + sMasked;

  self.lblCardNumber.Caption := sMasked;
end;

procedure TfrmCardPayment.FormActivate(Sender: TObject);
var bFound : Boolean;
begin
bSuccess := False;

while ( not DM.tblClients.Eof ) and (bFound = False) do
begin
 if (DM.tblClients['Client_ID'] = objGlobalUser.getUsername) then
 begin

     self.edtCardName.Text := DM.tblClients.FieldByName('CardName').AsString ;
     self.edtCardNumber.Text := DM.tblClients.FieldByName('CardNumber').AsString;
     self.edtCVV.Text := DM.tblClients.FieldByName('CVV').AsString;
     self.dtpExpiryDate.Date := DM.tblClients.FieldByName('ExpiryDate').AsDateTime;

 bFound := True;
 end
 else
  DM.tblClients.Next;
end;

self.lblItem.Caption := 'Property Data for ' + DM.tblProperties.FieldByName('Property_Name').AsString;
self.lblPropertyID.Caption := DM.tblProperties.FieldByName('Property_ID').AsString;
self.lblTotal.Caption := FloatToStrF(DM.tblProperties.FieldByName('PropertyDataPrice').AsCurrency, ffCurrency,6, 2 );
self.lblClientID.Caption := objGlobalUser.getUsername;

end;

procedure TfrmCardPayment.FormClose(Sender: TObject; var Action: TCloseAction);
var bFound : Boolean;
begin

bFound := False;

DM.tblPropertyData.First;

while ( not DM.tblClients.Eof ) and (bFound = False) do
begin
 if (DM.tblClients['Client_ID'] = objGlobalUser.getUsername) then
 begin

 if bSuccess = True then
 begin
 if Dialogs.MessageDlg('Would you like to save your card details?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
  begin
    Dialogs.ShowMessage('Card details saved');
     DM.tblClients.Edit;
    DM.tblClients['CardName'] := self.edtCardName.Text;
    DM.tblClients['CardNumber'] := self.edtCardNumber.Text;
    DM.tblClients['CVV'] := self.edtCVV.Text;
    DM.tblClients['ExpiryDate'] := self.dtpExpiryDate.Date;
    DM.tblClients.Post;
  end;
 end;

 bFound := True;
 end
 else
  DM.tblClients.Next;
end;

if bSuccess = True then
    begin
    DM.tblPropertyData.Insert;
    DM.tblPropertyData['Client_ID'] := objGlobalUser.getUsername;
    DM.tblPropertyData['Property_ID'] := DM.tblProperties.FieldByName('Property_ID').AsString;
    DM.tblPropertyData['DatePurchased'] := Today;
    DM.tblPropertyData.Post;
  end;


end;

procedure TfrmCardPayment.lblProceedClick(Sender: TObject);
begin
Pay;
end;

procedure TfrmCardPayment.Pay;
var
  S: String;
  C: Char;
  CheckSum: string;
  i,j: Integer;
  bIsValid : Boolean;
  function ReverseStr(const Str: string): string;
  var
    i, Len: Integer;
  begin
    //Reverses string for checksum validation
    Len := Length(Str);
    SetLength(Result, Len);
    for i := 1 to Len do
      Result[i] := Str[Succ(Len-i)];
  end;
begin
shpProceed.Brush.Color := clGreen; //UI
   bIsValid := True;
  S:= self.edtCardNumber.Text;

  //Strip extra characters and validate numeric characters
  for i := Length(S) downto 1 do begin //From end to beginning
    C:= S[i];
    if C in ['-',' '] then begin
      Delete(S, i, 1);
    end else
    if not(C In ['0'..'9']) then begin
      bIsValid := False;
      Break;
    end;
  end;

  //Validate Length
  if bIsValid = True then
    bIsValid  := Length(S) in [15,16];

  //Check first digit for card type
  if bIsValid  then begin
    C:= S[1];
    //3 = American Express
    //4 = Visa
    //5 = MasterCard
    //6 = Discover
    bIsValid  := C In ['3'..'6'];
  end;

  //Validate Checksum
  //http://www.delphicode.co.uk/is-credit-card-number-valid/
  if bIsValid  then begin
    S := ReverseStr(S);
    CheckSum := '';
      for i := 1 to Length(S) do
        if Odd(i) then
          CheckSum := CheckSum + S[i]
        else
          CheckSum := CheckSum + IntToStr(StrToInt(S[i]) * 2);
    j := 0;
    for i := 1 to Length(CheckSum) do
      j := j + StrToInt(CheckSum[i]);
    bIsValid  := (j mod 10) = 0;
  end;

  if bIsValid = True then
  else showMessage('Invalid Card Number');

  if self.cboAgreement.Checked then
  else showMessage('Please check the agreement box');

    if (self.cboAgreement.Checked) and (bIsValid = True) then
    begin
     imgBackground.Picture.LoadFromFile('..\Phase 2 Version 3\Success.png');
     self.shpProceed.Visible := False;
     self.edtCardName.Visible := False;
     self.edtCVV.Visible := False;
     self.dtpExpiryDate.Visible := False;
     self.edtCardNumber.Visible := False;
     self.cboAgreement.Visible := False;
     self.pnlDetails.Visible := False;
     self.lblTotal.Visible := False;
     bSuccess := True;

    end;


end;

procedure TfrmCardPayment.shpProceedMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  begin
  Pay;
end;


procedure TfrmCardPayment.shpProceedMouseEnter(Sender: TObject);
begin
shpProceed.Brush.Color := $0000FF80;
end;

procedure TfrmCardPayment.shpProceedMouseLeave(Sender: TObject);
begin
shpProceed.Brush.Color := $002ED629;
end;

procedure TfrmCardPayment.shpProceedMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
shpProceed.Brush.Color := $002ED629;
end;

end.
