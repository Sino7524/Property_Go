unit uClient2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls;

type
  TfrmClientAppointments = class(TForm)
    dbgAppointments: TDBGrid;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmClientAppointments: TfrmClientAppointments;

implementation
uses uDM, uSQLExplorer, UGlobal;

{$R *.dfm}

procedure TfrmClientAppointments.FormActivate(Sender: TObject);
begin
 uSQLExplorer.frmSQLExplorer.runSQL('SELECT Appointment_ID, Appointment_Date, State, Realtor_Name, Realtor_ID from tblAppointments WHERE Client_ID = ' + QuotedStr(objGlobalUser.getUsername));

end;

end.
