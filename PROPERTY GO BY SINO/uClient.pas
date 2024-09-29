unit uClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, pngimage, StdCtrls, uDM, Buttons, ImgList,
  uWeb, Menus, Dateutils, Grids, DBGrids;

type
  TfrmClient = class(TForm)
    imgBackground: TImage;
    shpLeft: TShape;
    shpRight: TShape;
    lblLeft: TLabel;
    lblRight: TLabel;
    lblSize: TLabel;
    shpPurchase: TShape;
    lblPrice: TLabel;
    lblName: TLabel;
    lblPropertyData: TLabel;
    lblDescription: TLabel;
    imgProperty: TImage;
    lblProvince: TLabel;
    imgsIcons: TImageList;
    btnAddAppointment: TButton;
    menu: TMainMenu;
    Menu1: TMenuItem;
    Appointments1: TMenuItem;
    Favorites1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    imgFavourites: TImage;
    lblSold: TLabel;
    Notifications1: TMenuItem;
    Properties1: TMenuItem;
    Report1: TMenuItem;
    Help1: TMenuItem;
    procedure shpLeftMouseLeave(Sender: TObject);
    procedure shpRightMouseLeave(Sender: TObject);
    procedure shpLeftMouseEnter(Sender: TObject);
    procedure shpRightMouseEnter(Sender: TObject);
    procedure lblLeftMouseEnter(Sender: TObject);
    procedure lblRightMouseEnter(Sender: TObject);
    procedure shpPurchaseMouseEnter(Sender: TObject);
    procedure shpPurchaseMouseLeave(Sender: TObject);
    procedure lblPropertyDataMouseEnter(Sender: TObject);
    procedure shpPurchaseMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure shpRightMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure shpLeftMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lblRightClick(Sender: TObject);
    procedure lblLeftClick(Sender: TObject);
    procedure btnAddAppointmentClick(Sender: TObject);
    procedure shpLeftMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure shpRightMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure shpPurchaseMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure imgFavouritesClick(Sender: TObject);
    procedure lblPropertyDataClick(Sender: TObject);
    procedure Appointments1Click(Sender: TObject);
    procedure Notifications1Click(Sender: TObject);
    procedure Properties1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Report1Click(Sender: TObject);
    procedure Help1Click(Sender: TObject);
    procedure Favorites1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure LoadPropertyData;
    procedure Purchase;
  public
    { Public declarations }
    sSQL: String;
  end;

var
  frmClient: TfrmClient;
  bLiked: Boolean;

implementation

uses uFavorites, uRealtor, uCardPayment, uAppointment_Scheduler, uGlobal,
  uSQLExplorer, uNotifications, uClient2,
  uStart, uFindSelection, uHelp, uPropData;
{$R *.dfm}

procedure TfrmClient.Appointments1Click(Sender: TObject);
begin

  if objGlobalUser.getIsClient = False then
  begin
    sSQL :=
      'SELECT Appointment_ID, Appointment_Date, Property_ID, Property_Name, Client_ID, State FROM tblAppointments WHERE (State = "Unknown") AND (Realtor_ID = ' + QuotedStr(objGlobalUser.getUsername) + ')';
    uRealtor.frmAppointmentsView.ShowModal;

  end
  else
  begin
    uClient2.frmClientAppointments.ShowModal;
   // self.CloseModal;
  end;

end;

procedure TfrmClient.btnAddAppointmentClick(Sender: TObject);
begin
  uAppointment_Scheduler.frmAppointments.ShowModal;
end;

procedure TfrmClient.Exit1Click(Sender: TObject);
begin
  if Dialogs.MessageDlg('Are you sure you want to log out?', mtConfirmation,
    [mbOK, mbCancel], 0) = mrOk then
  begin
    uClient.frmClient.Close;
    uClient.frmClient.Hide;
    uClient.frmClient.CloseModal;
    uStart.frmStart.ShowModal;
  end;

end;

procedure TfrmClient.Favorites1Click(Sender: TObject);
begin
  uFavorites.frmFavorites.ShowModal;
end;

procedure TfrmClient.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  uStart.frmStart.Close;
end;

procedure TfrmClient.FormShow(Sender: TObject);
begin
showMessage('Welcome ' + objGlobalUser.getName);
  if objGlobalUser.getIsClient = False then
  begin
    menu.Items[0].Delete(1);
    menu.Items[0].Delete(1);
    menu.Items[0].Delete(1);
    menu.Items[0].Delete(2);
  end;

  imgProperty.Picture.LoadFromFile
    ('..\Phase 2 Version 3\Properties\' + DM.tblProperties.FieldByName('Image')
      .AsString);

  if objGlobalUser.getIsClient = False then
    self.btnAddAppointment.Visible := False;
  DM.tblProperties.First;
  lblPrice.Caption := DM.tblProperties.FieldByName('Price').AsString;
  lblName.Caption := DM.tblProperties.FieldByName('Property_Name').AsString;
  lblSize.Caption := DM.tblProperties.FieldByName('Size').AsString + ' m²';
  lblDescription.Caption := DM.tblProperties.FieldByName('Description')
    .AsString;
  imgProperty.Stretch := True;
  LoadPropertyData;
end;

procedure TfrmClient.Help1Click(Sender: TObject);
begin
  uHelp.frmHelp.ShowModal;
end;

procedure TfrmClient.imgFavouritesClick(Sender: TObject);
var
  bFound: Boolean;
begin
  bFound := False;

  if bLiked = False then
  begin
    imgFavourites.Picture.LoadFromFile('liked.png');
    bLiked := True;

    DM.tblPropertyLikes.First;
    while (not DM.tblPropertyLikes.Eof) and (bFound = False) do
    begin
      if (DM.tblPropertyLikes['Property_ID'] = DM.tblProperties.FieldByName
          ('Property_ID').AsString) and
        (DM.tblPropertyLikes['Client_ID'] = objGlobalUser.getUsername) then
      begin
        bFound := True;
      end
      else
        DM.tblPropertyLikes.Next;
    end;

    if bFound = False then
    begin
      DM.tblPropertyLikes.Insert;
      DM.tblPropertyLikes['Property_ID'] := DM.tblProperties.FieldByName
        ('Property_ID').AsString;
      DM.tblPropertyLikes['Client_ID'] := objGlobalUser.getUsername;
      DM.tblPropertyLikes['DateLiked'] := today;
      DM.tblPropertyLikes.Post;
    end;

  end
  else
  begin
    imgFavourites.Picture.LoadFromFile('unliked.png');
    bLiked := False;

    bFound := False;
    DM.tblPropertyLikes.First;
    while (not DM.tblPropertyLikes.Eof) and (bFound = False) do
    begin
      if (DM.tblPropertyLikes['Property_ID'] = DM.tblProperties.FieldByName
          ('Property_ID').AsString) and
        (DM.tblPropertyLikes['Client_ID'] = objGlobalUser.getUsername) then
      begin
        bFound := True;
        DM.tblPropertyLikes.Delete;
      end
      else
        DM.tblPropertyLikes.Next;

    end;

  end;
end;

procedure TfrmClient.lblPropertyDataClick(Sender: TObject);
begin
Purchase;
end;

procedure TfrmClient.lblPropertyDataMouseEnter(Sender: TObject);
begin
  if lblSold.Caption = '' then
    shpPurchase.Brush.Color := $0000FF80
  else
    shpPurchase.Brush.Color := clGray; // UI
end;

procedure TfrmClient.lblLeftClick(Sender: TObject);
begin
 shpLeft.Brush.Color := $00EB175E;
  DM.tblProperties.Prior;
  LoadPropertyData;
end;

procedure TfrmClient.lblLeftMouseEnter(Sender: TObject);
begin
  shpLeft.Brush.Color := $00FF9D88;
end;

procedure TfrmClient.lblRightClick(Sender: TObject);
begin
  shpRight.Brush.Color := $00EB175E;
  DM.tblProperties.Next;
  LoadPropertyData;
end;

procedure TfrmClient.lblRightMouseEnter(Sender: TObject);
begin
  shpRight.Brush.Color := $00FF9D88;
end;

procedure TfrmClient.LoadPropertyData;
var
  bFound: Boolean;
  sProvince : String;
begin
  bFound := False;
  lblSold.Caption := '';
  shpPurchase.Brush.Color := $002ED629;
  DM.tblPropertyLikes.First;
  while (not DM.tblPropertyLikes.Eof) and (bFound = False) do
  begin

    if (DM.tblPropertyLikes['Property_ID'] = DM.tblProperties.FieldByName
        ('Property_ID').AsString) and
      (DM.tblPropertyLikes['Client_ID'] = objGlobalUser.getUsername) then
      bFound := True
    else
      DM.tblPropertyLikes.Next;

  end;

  if bFound = False then
  begin
    bLiked := False;
    imgFavourites.Picture.LoadFromFile('unliked.png');
  end
  else
  begin
    bLiked := True;
    imgFavourites.Picture.LoadFromFile('liked.png');
  end;

  lblPrice.Caption := 'R' + DM.tblProperties.FieldByName('Price')
    .AsString + ',00';
  lblName.Caption := DM.tblProperties.FieldByName('Property_Name').AsString;
  lblSize.Caption := DM.tblProperties.FieldByName('Size').AsString + ' m²';
  lblDescription.Caption := DM.tblProperties.FieldByName('Description')
    .AsString;

    if DM.tblProperties.FieldByName('Province').AsString = 'KwaZulu-Natal' then
   sProvince := 'KZN'
   else if DM.tblProperties.FieldByName('Province').AsString = 'Eastern Cape' then
   sProvince := 'EC'
   else
  if DM.tblProperties.FieldByName('Province').AsString = 'Western Cape' then
   sProvince := 'WC'
   else
   if DM.tblProperties.FieldByName('Province').AsString = 'Limpopo' then
   sProvince := 'LP'
   else
   if DM.tblProperties.FieldByName('Province').AsString = 'Mpumalanga' then
   sProvince := 'MP'
   else
   if DM.tblProperties.FieldByName('Province').AsString = 'Free State' then
   sProvince := 'FS'
   else
   if DM.tblProperties.FieldByName('Province').AsString = 'Nothern Cape' then
   sProvince := 'NC'
   else if DM.tblProperties.FieldByName('Province').AsString = 'North West' then
   sProvince := 'NW'
   else if DM.tblProperties.FieldByName('Province').AsString = 'Guateng' then
   sProvince := 'GT';
   lblProvince.Caption := sProvince;


  if DM.tblProperties.FieldByName('Sold').AsBoolean = True then
  begin
    lblSold.Caption := 'SOLD';
    self.btnAddAppointment.Enabled := False;
    self.imgsIcons.BlendColor := clGray;
    shpPurchase.Brush.Color := clGray;
    // shpPurchase.OnMouseEnter := False;
  end
  else
    lblSold.Caption := '';

  imgProperty.Picture.LoadFromFile
    ('..\Phase 2 Version 3\Properties\' + DM.tblProperties.FieldByName('Image')
      .AsString);

  bFound := False;

  DM.tblPropertyData.First;
  while (not DM.tblPropertyData.Eof) and (bFound = False) do
  begin
    if (DM.tblPropertyData['Property_ID'] = DM.tblProperties.FieldByName
        ('Property_ID').AsString) and
      (DM.tblPropertyData['Client_ID'] = objGlobalUser.getUsername) then
    begin
      bFound := True;
    end
    else
      DM.tblPropertyData.Next;
  end;

  if bFound = True then
  begin
    self.lblPropertyData.Font.Size := 12;
    self.lblPropertyData.Left := 652;
    self.lblPropertyData.Caption := 'View Property Data';
  end
  else
  begin
    self.lblPropertyData.Font.Size := 15;
    self.lblPropertyData.Left := 672;
    self.lblPropertyData.Caption := 'PURCHASE';
  end;

end;

procedure TfrmClient.Notifications1Click(Sender: TObject);
begin
  uNotifications.frmNotifications.ShowModal;
end;

procedure TfrmClient.Properties1Click(Sender: TObject);
begin

  if self.Caption <> 'frmClient' then
  begin
    self.ShowModal;
    uFavorites.frmFavorites.Hide;
    uAppointment_Scheduler.frmAppointments.Hide;
    uRealtor.frmAppointmentsView.Hide;
  end;
end;

procedure TfrmClient.Purchase;
begin
 if lblSold.Caption = '' then
  begin
    shpPurchase.Brush.Color := clGreen; // UI

    if self.lblPropertyData.Caption = 'PURCHASE' then
    begin
      uCardPayment.frmCardPayment.imgBackground.Picture.LoadFromFile
        ('..\Phase 2 Version 3\Card.png');
      uCardPayment.frmCardPayment.edtCardName.Visible := True;
      uCardPayment.frmCardPayment.edtCVV.Visible := True;
      uCardPayment.frmCardPayment.dtpExpiryDate.Visible := True;
      uCardPayment.frmCardPayment.edtCardNumber.Visible := True;
      uCardPayment.frmCardPayment.cboAgreement.Visible := True;
      uCardPayment.frmCardPayment.ShowModal;
    end
    else
    uPropData.frmPropData.Show;

  end
  else
    shpPurchase.Brush.Color := clGray;

end;

procedure TfrmClient.Report1Click(Sender: TObject);
var
  iNewReports: Integer;
begin
  frmFindSelection.setSQL(
    'SELECT Realtor_ID, Surname, First_Name, Reports from tblRealtors ORDER BY Surname');
  uFindSelection.frmFindSelection.keyField := 'Reports';
  uFindSelection.frmFindSelection.ShowModal;

  if (uFindSelection.bCancel = False) AND
    (StrToInt(uFindSelection.frmFindSelection.valueField) < 3) then
  begin
    iNewReports := StrToInt(uFindSelection.frmFindSelection.valueField);
    Inc(iNewReports);

    DM.tblRealtors.Edit;
    DM.tblRealtors['Reports'] := iNewReports;
    DM.tblRealtors.Post;

    ShowMessage('Report for ' + DM.query.FieldByName('First_Name')
        .AsString + ' ' + DM.query.FieldByName('Surname').AsString +
        ' was successfully sent!');
    // showmessage(IntToSTr(iNewReports));
  end
  else if (uFindSelection.bCancel = False) AND
    (StrToInt(uFindSelection.frmFindSelection.valueField) >= 3) then
    ShowMessage('Report for ' + DM.query.FieldByName('First_Name')
        .AsString + ' ' + DM.query.FieldByName('Surname').AsString +
        ' was successfully sent!');
end;

procedure TfrmClient.shpLeftMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  shpLeft.Brush.Color := $00EB175E;
  DM.tblProperties.Prior;
  LoadPropertyData;

end;

procedure TfrmClient.shpLeftMouseEnter(Sender: TObject);
begin
  shpLeft.Brush.Color := $00FF9D88;
end;

procedure TfrmClient.shpLeftMouseLeave(Sender: TObject);
begin
  shpLeft.Brush.Color := $00FF7152;
end;

procedure TfrmClient.shpLeftMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  shpLeft.Brush.Color := $00FF7152;
end;

procedure TfrmClient.shpPurchaseMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
Purchase;
end;

procedure TfrmClient.shpPurchaseMouseEnter(Sender: TObject);
begin
  if lblSold.Caption = '' then
    shpPurchase.Brush.Color := $0000FF80
  else
    shpPurchase.Brush.Color := clGray;
end;

procedure TfrmClient.shpPurchaseMouseLeave(Sender: TObject);
begin
  if lblSold.Caption = '' then
    shpPurchase.Brush.Color := $002ED629
  else
    shpPurchase.Brush.Color := clGray;
end;

procedure TfrmClient.shpPurchaseMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if lblSold.Caption = '' then
    shpPurchase.Brush.Color := $002ED629
  else
    shpPurchase.Brush.Color := clGray;
end;

procedure TfrmClient.shpRightMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  shpRight.Brush.Color := $00EB175E;
  DM.tblProperties.Next;
  LoadPropertyData;
end;

procedure TfrmClient.shpRightMouseEnter(Sender: TObject);
begin
  shpRight.Brush.Color := $00FF9D88;
end;

procedure TfrmClient.shpRightMouseLeave(Sender: TObject);
begin
  shpRight.Brush.Color := $00FF7152;
end;

procedure TfrmClient.shpRightMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  shpRight.Brush.Color := $00FF7152;
end;

end.
