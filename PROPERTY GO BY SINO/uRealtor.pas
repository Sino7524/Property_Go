unit uRealtor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, StdCtrls, Buttons;

type
  TfrmAppointmentsView = class(TForm)
    dbAppointments: TDBGrid;
    btnAccept: TBitBtn;
    btnReject: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure btnAcceptClick(Sender: TObject);
    procedure btnRejectClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAppointmentsView: TfrmAppointmentsView;
  id : integer;

implementation
uses uMessage, uDM, uSQLExplorer, uClient;

{$R *.dfm}

procedure TfrmAppointmentsView.btnAcceptClick(Sender: TObject);
var id : integer;
begin
 id := dm.query.FieldByName('Appointment_ID').AsInteger;
 uSQLExplorer.frmSQLExplorer.execSQL('UPDATE tblAppointments SET State = "Accepted" WHERE Appointment_ID ='+IntToStr(id));
 uSQLExplorer.frmSQLExplorer.runSQL(uClient.frmClient.sSQL);
 showMessage('Appointment Accepted');
end;

procedure TfrmAppointmentsView.btnRejectClick(Sender: TObject);
begin
 uMessage.frmMessages.ShowModal;
end;

procedure TfrmAppointmentsView.FormActivate(Sender: TObject);
begin
uSQLExplorer.frmSQLExplorer.runSQL(uClient.frmClient.sSQL);
end;

end.
