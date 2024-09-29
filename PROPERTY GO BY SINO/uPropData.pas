unit uPropData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDM, DB, ADODB, Grids, DBGrids, StdCtrls, TeEngine, Series, ExtCtrls,
  TeeProcs, Chart;

type
  TfrmPropData = class(TForm)
    qryChart: TADOQuery;
    dsQuery: TDataSource;
    conChartData: TADOConnection;
    DBGrid1: TDBGrid;
    btnPopularity: TButton;
    Chart: TChart;
    Series1: TBarSeries;
    btnLikes: TButton;
    btnAccounts: TButton;
    procedure FormActivate(Sender: TObject);
    procedure btnPopularityClick(Sender: TObject);
    procedure DisplayOnChart(sSQL, y, x : String);
    procedure btnLikesClick(Sender: TObject);
    procedure btnAccountsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPropData: TfrmPropData;
  sPropID : String;

implementation

{$R *.dfm}

procedure TfrmPropData.btnPopularityClick(Sender: TObject);
begin
//Chart.Series[0].MaxYValue := 50;
DisplayOnChart('Select Realtor_ID, COUNT(Realtor_ID) AS Popularity from tblAppointments Group by Realtor_ID', 'Popularity', 'Realtor_ID' );
end;

procedure TfrmPropData.btnAccountsClick(Sender: TObject);
begin
DisplayOnChart('Select Count(tblRealtors.Realtor_ID) As Realtors,  COUNT(tblClients.Client_ID) AS Clients from tblRealtors, tblClients;','Realtors', 'Clients');
end;

procedure TfrmPropData.btnLikesClick(Sender: TObject);
begin
DisplayOnChart('Select  Month(DateLiked),  COUNT(Client_ID) AS Likes from tblPropertyLikes Group by Month(DateLiked)', 'Likes', 'Expr1000');
end;

procedure TfrmPropData.DisplayOnChart(sSQL, y, x: String);
begin
qryChart.SQL.Clear;
  qryChart.SQL.ADD(sSQL);
  QryChart.Active;
QryChart.Open;
QryChart.First;
while not qryChart.eof do
Begin
Chart.Series[0].Add(qryChart[y], qryChart[x], RGB(random(255), random(255), random(255) ) );
qryChart.Next;
end;
end;

procedure TfrmPropData.FormActivate(Sender: TObject);
begin
 conChartData.Connected := False;
    conChartData.LoginPrompt := False;
    conChartData.ConnectionString :=
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Data.mdb;Persist Security Info=False';
       conChartData.Connected := True;
       sPropID := DM.tblProperties.FieldByName('Property_ID').AsString;
end;


end.
