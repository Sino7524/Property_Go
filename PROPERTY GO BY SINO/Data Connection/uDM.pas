unit uDM;

interface

uses
  SysUtils, Classes, ADODB, DB, Dialogs, Messages, StdCtrls, Controls, Graphics;

type
  TDM = class(TDataModule)
    conData: TADOConnection;
    query: TADOQuery;
    dsTblClients: TDataSource;
    tblClients: TADOTable;
    tblRealtors: TADOTable;
    tblAppointments: TADOTable;
    tblPropertyLikes: TADOTable;
    tblProperties: TADOTable;
    dsQuery: TDataSource;
    dsTblRealtors: TDataSource;
    dsTblAppointments: TDataSource;
    dsTblProperties: TDataSource;
    dsTblPropertyLikes: TDataSource;
    tblPropertyData: TADOTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    errorMessages: String;
  public
    { Public declarations }
    function getErrors: String;
    procedure LoadSQL(fileName: String);
    procedure execSQL(SQL: String);
    procedure searchAllRecords(toFind, field: String; table: TADOTable);

    procedure fillComboBox(cboComponent: TComboBox;
      sql, fieldAsKey, fieldToShow: String);
    function getComboBoxKey(cboComponent: TComboBox): String;
    function getComboBoxValue(cboComponent: TComboBox): String;
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin

  try
    {
      query.Connection := conData;
      query.ConnectionString :=
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Data.mdb;Persist Security Info=False';
      }
    self.conData.Connected := False;
    self.conData.LoginPrompt := False;
    self.conData.ConnectionString :=
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Data.mdb;Persist Security Info=False';

    // Setting up the connections
    self.conData.Connected := True;
    self.tblClients.Active := True;
    self.tblRealtors.Active := True;
    self.tblAppointments.Active := True;
    self.tblProperties.Active := True;
    self.tblPropertyLikes.Active := True;
    self.tblPropertyData.Active := True;

    // Setting up the components to be connected
    self.tblClients.TableName := 'tblClients';
    self.tblRealtors.TableName := 'tblRealtors';
    self.tblAppointments.TableName := 'tblAppointments';
    self.tblProperties.TableName := 'tblProperties';
    self.tblPropertyLikes.TableName := 'tblPropertyLikes';

    // Setting up the Data Sets
    dsTblClients.DataSet := tblClients;
    dsTblRealtors.DataSet := tblRealtors;
    dsTblAppointments.DataSet := tblAppointments;
    dsTblProperties.DataSet := tblProperties;
    dsTblPropertyLikes.DataSet := tblPropertyLikes;

  except
    on E: Exception do

    end;

  end;

  procedure TDM.execSQL(SQL: String);
begin

end;

procedure TDM.fillComboBox(cboComponent: TComboBox; sql, fieldAsKey,
    fieldToShow: String);
  var
    aQuery: TADOQuery;
  begin
    cboComponent.Items.Clear;

    try
      aQuery := TADOQuery.Create(self);

      aQuery.Connection := self.conData;
      aQuery.Active := False;
      aQuery.sql.Clear;
      aQuery.sql.Add(sql);
      aQuery.Active := True;

      aQuery.First;
      WHILE NOT aQuery.Eof do
      BEGIN
        cboComponent.Items.Add('[' + aQuery.FieldByName(fieldAsKey)
            .AsString + '] ' + aQuery.FieldByName(fieldToShow).AsString);
        aQuery.Next;
      END;
    except
      on E: Exception do

      end;

    end;

    function TDM.getComboBoxKey(cboComponent: TComboBox): String;
    var
      strText: String;
    begin
      strText := cboComponent.Text;
      result := COPY(strText, POS('[', strText) + 1, POS(']', strText) - 2);
    end;

    function TDM.getComboBoxValue(cboComponent: TComboBox): String;
    var
      strText: String;
    begin
      strText := cboComponent.Text;
      result := COPY(strText, POS(']', strText) + 1, Length(strText));
    end;

    function TDM.getErrors: String;
    begin
      result := errorMessages;
    end;

    procedure TDM.LoadSQL(fileName: String);
    var
      tf: TextFile;
      aLine, sTemp: String;

      procedure storeVar(aLine: String);
      begin
        sTemp := InputBox('Phone', 'Phone', '');
      end;

      procedure substitute(aLine: String);
      var
        LHS, RHS: String;
      begin
        LHS := COPY(aLine, 1, POS('«', aLine) - 2);
        RHS := COPY(aLine, POS('»', aLine) + 1, Length(aLine));
        query.sql.Add(LHS + sTemp + RHS);
      end;

    begin
      if FileExists(fileName) then
      BEGIN
        AssignFile(tf, fileName);
        Reset(tf);
        query.Active := False;
        query.sql.Clear;

        while not Eof(tf) do
        begin
          Readln(tf, aLine);
          while NOT Eof(tf) do
          begin
            Readln(tf, aLine);
            // ...
            if (POS('«Input', aLine) > 0) then
              storeVar(aLine)
            else if (POS('«', aLine) > 0) then
              substitute(aLine)
            else
              // ...
              query.sql.Add(aLine);
          end;

          query.Active := True;
          CloseFile(tf);
        END
      end;
    end;

    procedure TDM.searchAllRecords(toFind, field: String; table: TADOTable);
    begin
      toFind := Uppercase(toFind);

      table.First;
      while NOT(table.Eof) and (Uppercase(table.FieldByName(field).AsString)
          <> toFind) do
        table.Next;

      if (Uppercase(table.FieldByName(field).AsString) = toFind) then
        showMessage('Match Found');
    end;

end.
