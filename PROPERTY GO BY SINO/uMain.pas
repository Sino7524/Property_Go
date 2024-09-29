unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ImgList, ToolWin, ExtCtrls, DBCtrls, StdCtrls,
  Grids, DBGrids, uDM, ExtDlgs, DB, ADODB;

type
  TfrmSQL_Main = class(TForm)
    pgcData: TPageControl;
    TabSheet2: TTabSheet;
    DBGrid: TDBGrid;
    GroupBox1: TGroupBox;
    DBNavigator: TDBNavigator;
    icons32: TImageList;
    MainMenu1: TMainMenu;
    User1: TMenuItem;
    Logout1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    DataWizard1: TMenuItem;
    menu_Table1: TMenuItem;
    menu_Table2: TMenuItem;
    N2: TMenuItem;
    Sort1: TMenuItem;
    Search1: TMenuItem;
    Insert1: TMenuItem;
    Delete1: TMenuItem;
    Edit1: TMenuItem;
    Query1: TMenuItem;
    Selection1: TMenuItem;
    Complex1: TMenuItem;
    Analysis11: TMenuItem;
    Analysis21: TMenuItem;
    Join1: TMenuItem;
    QueryBuilder1: TMenuItem;
    TabSheet3: TTabSheet;
    redOutput: TRichEdit;
    Report1: TMenuItem;
    View1: TMenuItem;
    edtSearchFor: TLabeledEdit;
    btnSearch: TButton;
    pmTable: TPopupMenu;
    recordInsert: TMenuItem;
    recordEdit: TMenuItem;
    recordDelete: TMenuItem;
    sbStatus: TStatusBar;
    lblHeader: TLabel;
    menu_Table3: TMenuItem;
    FromFile1: TMenuItem;
    dlgOpenFile: TOpenTextFileDialog;
    menu_Table4: TMenuItem;
    SQLExplorer1: TMenuItem;
    Explore1: TMenuItem;
    ComboBox1: TComboBox;
    tlbGrey: TToolBar;
    ToolButton1: TToolButton;
    procedure menu_Table1Click(Sender: TObject);
    procedure menu_Table2Click(Sender: TObject);
    procedure recordInsertClick(Sender: TObject);
    procedure recordEditClick(Sender: TObject);
    procedure QueryBuilder1Click(Sender: TObject);
    procedure menu_Table3Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure Search1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Sort1Click(Sender: TObject);
    procedure recordDeleteClick(Sender: TObject);
    procedure Selection1Click(Sender: TObject);
    procedure FromFile1Click(Sender: TObject);
    procedure menu_Table4Click(Sender: TObject);
    procedure Properties1Click(Sender: TObject);
    procedure Realtors1Click(Sender: TObject);
    procedure Appointment2Click(Sender: TObject);
    procedure Explore1Click(Sender: TObject);
    procedure Complex1Click(Sender: TObject);
    procedure Analysis11Click(Sender: TObject);
    procedure Analysis21Click(Sender: TObject);
    procedure Join1Click(Sender: TObject);
    procedure Logout1Click(Sender: TObject);
    procedure Register1Click(Sender: TObject);
    procedure View1Click(Sender: TObject);
  private
    { Private declarations }
    function activeTableIndex(current : String) : Integer;
    procedure menuTableSelect(current : String; ds : TDataSource);
  public
    { Public declarations }
    sCurrentTable : String;
  end;

var
  frmSQL_Main: TfrmSQL_Main;

implementation
uses uGlobal, uSQLExplorer, uIOTable1, uIOTable2, uIOTable3, uIOTable4, uIOAppointment, uStart, uPropData;
{$R *.dfm}

function TfrmSQL_Main.activeTableIndex(current: String): Integer;
begin
      if current = table1Name then result := 1
 else if current = table2Name then result := 2
 else if current = table3Name then result := 3
 else if current = table4Name then result := 4
 else result := -1;
end;

procedure TfrmSQL_Main.Analysis11Click(Sender: TObject);
begin
  self.menuTableSelect('Query', DM.dsQuery);
end;

procedure TfrmSQL_Main.Analysis21Click(Sender: TObject);
begin
  self.menuTableSelect('Query', DM.dsQuery);
end;

procedure TfrmSQL_Main.Appointment2Click(Sender: TObject);
var clientID : String;
begin
  frmIOAppointment.mode := 'Insert';
  frmIOAppointment.ShowModal;
end;

procedure TfrmSQL_Main.btnSearchClick(Sender: TObject);
var toFind : String;

begin
  toFind := edtSearchFor.Text;

  if toFind <> '' then
  case activeTableIndex(sCurrentTable) of
   1: DM.searchAllRecords(toFind,'Appointment_date',DM.tblAppointments);
   2: DM.searchAllRecords(toFind,'Surname',DM.tblClients);
   3: DM.searchAllRecords(toFind,'Property_Name',DM.tblProperties);
   4: DM.searchAllRecords(toFind,'Surname',DM.tblRealtors);
   else showMessage('Feature not developed');
  end;
end;

procedure TfrmSQL_Main.Complex1Click(Sender: TObject);
begin
  self.menuTableSelect('Query', DM.dsQuery);
end;

procedure TfrmSQL_Main.Delete1Click(Sender: TObject);
begin

  case activeTableIndex(sCurrentTable) of
   1: DM.tblAppointments.Delete;
   2: DM.tblClients.Delete;
   3: DM.tblProperties.Delete;
   else ShowMessage('Table Not Selected');
  end;

end;

procedure TfrmSQL_Main.Explore1Click(Sender: TObject);
begin   frmSQLExplorer.ShowModal;
end;

procedure TfrmSQL_Main.FormShow(Sender: TObject);
begin
  menu_Table1.Click;


end;

procedure TfrmSQL_Main.FromFile1Click(Sender: TObject);
begin
  if Self.dlgOpenFile.Execute then
   begin
      sCurrentTable := 'Query';
      self.lblHeader.Caption := sCurrentTable;
      DBGrid.DataSource := DM.dsQuery;
      DBNavigator.DataSource := DM.dsQuery;

      DM.LoadSQL(self.dlgOpenFile.FileName);
   end;
end;

procedure TfrmSQL_Main.Join1Click(Sender: TObject);
begin
  self.menuTableSelect('Query', DM.dsQuery);
end;

procedure TfrmSQL_Main.Logout1Click(Sender: TObject);
begin
uStart.frmStart.nbkStart.PageIndex := 0;
uStart.frmStart.ShowModal;

end;

procedure TfrmSQL_Main.menuTableSelect(current: String; ds: TDataSource);
begin
  sCurrentTable := current;
  self.lblHeader.Caption := current;
  DBGrid.DataSource := ds;
  DBNavigator.DataSource := ds;
end;

procedure TfrmSQL_Main.menu_Table1Click(Sender: TObject);
begin self.menuTableSelect(table1Name, DM.dsTblAppointments);
end;

procedure TfrmSQL_Main.menu_Table2Click(Sender: TObject);
begin  self.menuTableSelect(table2Name, DM.dsTblClients);
end;

procedure TfrmSQL_Main.menu_Table3Click(Sender: TObject);
begin  self.menuTableSelect(table3Name, DM.dsTblProperties);
end;

procedure TfrmSQL_Main.menu_Table4Click(Sender: TObject);
begin  self.menuTableSelect(table4Name, DM.dsTblRealtors);
end;

procedure TfrmSQL_Main.Properties1Click(Sender: TObject);
begin self.menuTableSelect(table3Name, DM.dsTblProperties);

end;

procedure TfrmSQL_Main.QueryBuilder1Click(Sender: TObject);
begin
  // To Do
  frmSQLExplorer.ShowModal;
end;

procedure TfrmSQL_Main.Realtors1Click(Sender: TObject);
begin self.menuTableSelect(table4Name, DM.dsTblRealtors);
end;

procedure TfrmSQL_Main.recordDeleteClick(Sender: TObject);
var rowDeleted : Boolean;
begin
rowDeleted := (MessageDlg('Are you sure you want to delete this row?'
                      ,mtConfirmation,[mbYes, mbNo], 0) = mrYes);

if rowDeleted then
  case activeTableIndex(sCurrentTable) of
   1: DM.tblAppointments.Delete;
   2: DM.tblClients.Delete;
   3: DM.tblProperties.Delete;
   4: DM.tblRealtors.Delete;
   else begin
      ShowMessage('Table Not Selected');
      rowDeleted := False;
   end;
  end;

 if rowDeleted
 then Dialogs.MessageDlg('Row deleted successfully',mtInformation,[], 0);
end;

procedure TfrmSQL_Main.recordEditClick(Sender: TObject);
begin
 // Handles the selection of the correct Modal Form
  case activeTableIndex(sCurrentTable) of
   1: begin frmIOTable1.mode := 'Edit'; frmIOTable1.ShowModal; End;
   2: begin frmIOTable2.mode := 'Edit'; frmIOTable2.ShowModal; End;
   3: begin frmIOTable3.mode := 'Edit'; frmIOTable3.ShowModal; End;
   4: begin frmIOTable4.mode := 'Edit'; frmIOTable4.ShowModal; End;
   else ShowMessage('Table Not Selected');
  end;
end;

procedure TfrmSQL_Main.recordInsertClick(Sender: TObject);
begin
 // Handles the selection of the correct Modal Form
  case activeTableIndex(sCurrentTable) of
   1: begin frmIOTable1.mode := 'Insert'; frmIOTable1.ShowModal; End;
   2: begin frmIOTable2.mode := 'Insert'; frmIOTable2.ShowModal; End;
   3: begin frmIOTable3.mode := 'Insert'; frmIOTable3.ShowModal; End;
   4: begin frmIOTable4.mode := 'Insert'; frmIOTable4.ShowModal; End;
   else ShowMessage('Table Not Selected');
  end;

end;

procedure TfrmSQL_Main.Register1Click(Sender: TObject);
begin
if Dialogs.MessageDlg('Are you sure you want to log out?', mtConfirmation, [mbOK, mbCancel], 0) = mrOk then
   uMain.frmSQL_Main.Close;

 end;

procedure TfrmSQL_Main.Search1Click(Sender: TObject);
begin self.edtSearchFor.SetFocus;
end;

procedure TfrmSQL_Main.Selection1Click(Sender: TObject);
begin
 // Setup the form for the showing of the Query
  self.menuTableSelect('Query', DM.dsQuery);
 // Runs the query saved in the file "SELECT.Txt"
  DM.LoadSQL('./SQL/SELECT.txt');
end;

procedure TfrmSQL_Main.Sort1Click(Sender: TObject);
begin
   case activeTableIndex(sCurrentTable) of
   1: DM.tblAppointments.Sort := 'Appointment_date';
   2: DM.tblClients.Sort := 'Surname';
   3: DM.tblProperties.Sort := 'Property_Name';
   4: DM.tblRealtors.Sort := 'Surname';
   else showMessage('Feature not developed');
  end;
end;

procedure TfrmSQL_Main.View1Click(Sender: TObject);
begin
uPropData.frmPropData.ShowModal;
end;

end.
