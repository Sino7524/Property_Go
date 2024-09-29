unit uSQLExplorer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, uDM, StdCtrls, Grids, DBGrids, Menus, ExtDlgs, ImgList,
  Buttons, ADODB, DB, uGlobal, uStart;

type
  TfrmSQLExplorer = class(TForm)
    nbkMain: TNotebook;
    lblWelcome: TLabel;
    lblName: TLabel;
    dbGrid: TDBGrid;
    cboTable: TComboBox;
    Menu: TMainMenu;
    Menu1: TMenuItem;
    LoadSQL1: TMenuItem;
    CreateNewSQL1: TMenuItem;
    dlgOpenFile: TOpenTextFileDialog;
    pnlBultInButtons: TPanel;
    btnPensioners: TButton;
    Label2: TLabel;
    Button2: TButton;
    Button4: TButton;
    btnApproved: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    btnToDelete: TButton;
    Button11: TButton;
    Button12: TButton;
    imgLstIcons: TImageList;
    Navigate: TMenuItem;
    First1: TMenuItem;
    Prior1: TMenuItem;
    Next1: TMenuItem;
    Last1: TMenuItem;
    time: TTimer;
    SQL1: TMenuItem;
    Select1: TMenuItem;
    Complex1: TMenuItem;
    Analysis11: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure cboTableChange(Sender: TObject);
    procedure LoadSQL1Click(Sender: TObject);
    procedure btnToDeleteClick(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure First1Click(Sender: TObject);
    procedure Prior1Click(Sender: TObject);
    procedure Next1Click(Sender: TObject);
    procedure Last1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure btnApprovedClick(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure timeTimer(Sender: TObject);
    procedure Button12Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sSQL: String;
    procedure runSQL(sSQL: String);
    procedure execSQL(sSQL: String);
    function DetermineDataSource: TDataSource;
    function DetermineTable: TADOTable;

  var
    iSec: Integer;
    bClient : Boolean;
  end;

var
  frmSQLExplorer: TfrmSQLExplorer;

implementation

// uses uStart;
{$R *.dfm}

procedure TfrmSQLExplorer.btnToDeleteClick(Sender: TObject);
begin
  sSQL := 'SELECT * FROM tblRealtors WHERE Reports = 3 AND Deleted = False';
  runSQL(sSQL);
end;

procedure TfrmSQLExplorer.Button11Click(Sender: TObject);
begin
  sSQL := 'SELECT * FROM tblProperties WHERE Sold = False';
  runSQL(sSQL);
end;

procedure TfrmSQLExplorer.Button12Click(Sender: TObject);
begin
  sSQL :=
    'Select Property_ID, Price, Client_ID, First_Name, Surname, Birth_Date, Format(Price * 0.9, "Currency")' + ' As Pensioner_Discount, Format(Year(Date) – Year(Birth_Date)) As Age Where (Age > 60) From tblProperties  ';

  showMessage(sSQL);
  runSQL(sSQL);
end;

procedure TfrmSQLExplorer.Button4Click(Sender: TObject);
var
  sClient: String;
  bIsClient: Boolean;
begin
  sClient := InputBox('ID', 'Enter ID of Client or Realtor', '');

  if DM.tblClients.Locate('Client_ID', sClient, []) = True then
    bIsClient := True
  else if DM.tblClients.Locate('Client_ID', sClient, []) = True then
    bIsClient := False
  else
    Dialogs.showMessage('ID not found!');

  sSQL :=
    'Select Client_ID, Appointment_Date From tblAppointments Where (Client_ID = '
    + QuotedStr(sClient) + ') Order By Appointment_Date DESC';
  runSQL(sSQL);
end;

procedure TfrmSQLExplorer.Button9Click(Sender: TObject);
var
  coefficient: Real;
  discount: Real;
  sDiscount: String;
begin
  coefficient := StrToFloat(InputBox('Discount',
      'Insert the discount co-efficient', ''));
  discount := (1 - coefficient);

  sDiscount := FloatToStr(discount);
  sDiscount := StringReplace(sDiscount, ',', '.', [rfReplaceAll, rfIgnoreCase]);

  try
    sSQL := 'Select Property_ID, ' + 'Format(Price * ' + sDiscount +
      ', "Currency") AS [Discounted Price]' + 'From tblProperties';

    runSQL(sSQL);
  except
    on E: Exception do
      showMessage('Syntax Error! ');
  end;
end;

procedure TfrmSQLExplorer.btnApprovedClick(Sender: TObject);
begin
  sSQL :=
    'Select tblClients.Client_ID, First_Name, Surname, Appointment_ID, Appointment_Date, Realtor_ID'
    + ' From tblClients, tblAppointments' +
    ' Where (tblClients.Client_ID = tblAppointments.Client_ID) AND (tblAppointments.Approved = True) AND (tblAppointments.Rejected = False)';

  runSQL(sSQL);
end;

procedure TfrmSQLExplorer.cboTableChange(Sender: TObject);
begin
  dbGrid.DataSource := DetermineDataSource;
end;

function TfrmSQLExplorer.DetermineDataSource: TDataSource;
begin
  if cboTable.Items[cboTable.ItemIndex] = 'Appointments' then
    result := DM.dsTblAppointments;

  if cboTable.Items[cboTable.ItemIndex] = 'Clients' then
    result := DM.dsTblClients;

  if cboTable.Items[cboTable.ItemIndex] = 'Realtors' then
    result := DM.dsTblRealtors;

  if (cboTable.Items[cboTable.ItemIndex] = 'Query') OR
    (cboTable.ItemIndex = -1) then
    result := DM.dsQuery;

  if cboTable.Items[cboTable.ItemIndex] = 'Properties' then
    result := DM.dsTblProperties;

  if cboTable.Items[cboTable.ItemIndex] = 'Property Likes' then
    result := DM.dsTblPropertyLikes;
end;

function TfrmSQLExplorer.DetermineTable: TADOTable;
begin
  if cboTable.Items[cboTable.ItemIndex] = 'Appointments' then
    result := DM.tblAppointments;

  if cboTable.Items[cboTable.ItemIndex] = 'Clients' then
    result := DM.tblClients;

  if cboTable.Items[cboTable.ItemIndex] = 'Realtors' then
    result := DM.tblRealtors;

  if cboTable.Items[cboTable.ItemIndex] = 'Properties' then
    result := DM.tblProperties;

  if cboTable.Items[cboTable.ItemIndex] = 'Property Likes' then
    result := DM.tblPropertyLikes;

end;

procedure TfrmSQLExplorer.execSQL(sSQL: String);
begin
  DM.query.SQL.Clear;
  DM.query.SQL.ADD(sSQL);
  DM.query.execSQL;
end;

procedure TfrmSQLExplorer.First1Click(Sender: TObject);
begin
  dbGrid.DataSource := DetermineDataSource;

  if DetermineDataSource = DM.dsQuery then
  begin
    showMessage('Navigation will delay since table was not chosen.');
    sSQL := 'Select * FROM tblClients';
    runSQL(sSQL);
    DM.query.First;
  end
  else
    DetermineTable.First;

end;

procedure TfrmSQLExplorer.FormActivate(Sender: TObject);
begin

  if objGlobalUser <> Nil then
    lblName.Caption := objGlobalUser.getName;

  nbkMain.PageIndex := 0;
  time.Enabled := True;

end;

procedure TfrmSQLExplorer.Last1Click(Sender: TObject);
begin
  dbGrid.DataSource := DetermineDataSource;

  if DetermineDataSource = DM.dsQuery then
  begin
    showMessage('Navigation will delay since table was not chosen.');
    sSQL := 'Select * FROM tblClients';
    runSQL(sSQL);
    DM.query.First;
  end
  else
    DetermineTable.Last;
end;

procedure TfrmSQLExplorer.LoadSQL1Click(Sender: TObject);
begin
  if self.dlgOpenFile.Execute then
  begin
    DM.LoadSQL(self.dlgOpenFile.FileName);
  end;
end;

procedure TfrmSQLExplorer.Next1Click(Sender: TObject);
begin
  dbGrid.DataSource := DetermineDataSource;

  if DetermineDataSource = DM.dsQuery then
  begin
    showMessage('Navigation will delay since table was not chosen.');
    sSQL := 'Select * FROM tblClients';
    runSQL(sSQL);
    DM.query.First;
  end
  else
    DetermineTable.Next;
end;

procedure TfrmSQLExplorer.Prior1Click(Sender: TObject);
begin
  dbGrid.DataSource := DetermineDataSource;

  if DetermineDataSource = DM.dsQuery then
  begin
    showMessage('Navigation will delay since table was not chosen.');
    sSQL := 'Select * FROM tblClients';
    runSQL(sSQL);
    DM.query.First;
  end
  else
    DetermineTable.Prior;
end;

procedure TfrmSQLExplorer.runSQL(sSQL: String);
begin
DM.query.SQL.Clear;
  DM.query.SQL.ADD(sSQL);
  DM.query.Open;
  DM.query.refresh;
end;

procedure TfrmSQLExplorer.timeTimer(Sender: TObject);
{ This mini algorithm ensures that the welcome screen displayed when the form is
  activated is only shown for 3 seconds. Every second var iSec is incremented by 1.
  if it is not equal to 3, it is incremented again until it is equal to 3 which is
  when the timer will be disabled }
begin

  inc(iSec);

  if iSec = 3 then
  begin
    time.Enabled := False;
    if bClient = True then
    self.CloseModal
    else
    nbkMain.PageIndex := 1;

    iSec := 0;
  end;
end;

end.
