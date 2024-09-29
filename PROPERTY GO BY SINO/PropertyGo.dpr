program PropertyGo;

uses
  Forms,
  uStart in 'uStart.pas' {frmStart},
  uDM in 'Data Connection\uDM.pas' {DM: TDataModule},
  uProperty in 'OOP\uProperty.pas',
  uValidator in 'OOP\uValidator.pas',
  uIOTable4 in 'uIOTable4.pas' {frmIOTable4},
  uMain in 'uMain.pas' {frmSQL_Main},
  uGlobal in 'uGlobal.pas',
  uSQLExplorer in 'uSQLExplorer.pas' {frmSQLExplorer},
  uIOAppointment in 'uIOAppointment.pas' {frmIOAppointment},
  uIOTable2 in 'uIOTable2.pas' {frmIOTable2},
  uIOTable3 in 'uIOTable3.pas' {frmIOTable3},
  uIOTable1 in 'uIOTable1.pas' {frmIOTable1},
  uClient in 'uClient.pas' {frmClient},
  uAppointment_scheduler in 'uAppointment_scheduler.pas' {frmAppointments},
  uFindSelection in 'uFindSelection.pas' {frmFindSelection},
  uRealtor in 'uRealtor.pas' {frmAppointmentsView},
  uCardPayment in 'uCardPayment.pas' {frmCardPayment},
  UCard in 'UCard.pas',
  uMessage in 'uMessage.pas' {frmMessages},
  uNotifications in 'uNotifications.pas' {frmNotifications},
  uClient2 in 'uClient2.pas' {frmClientAppointments},
  uHelp in 'uHelp.pas' {frmHelp},
  uPropData in 'uPropData.pas' {frmPropData};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmStart, frmStart);
  Application.CreateForm(TfrmSQL_Main, frmSQL_Main);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmSQLExplorer, frmSQLExplorer);
  Application.CreateForm(TfrmIOTable4, frmIOTable4);
  Application.CreateForm(TfrmSQLExplorer, frmSQLExplorer);
  Application.CreateForm(TfrmIOAppointment, frmIOAppointment);
  Application.CreateForm(TfrmIOTable2, frmIOTable2);
  Application.CreateForm(TfrmIOTable3, frmIOTable3);
  Application.CreateForm(TfrmIOTable1, frmIOTable1);
  Application.CreateForm(TfrmClient, frmClient);
  Application.CreateForm(TfrmAppointments, frmAppointments);
  Application.CreateForm(TfrmFindSelection, frmFindSelection);
  Application.CreateForm(TfrmAppointmentsView, frmAppointmentsView);
  Application.CreateForm(TfrmCardPayment, frmCardPayment);
  Application.CreateForm(TfrmMessages, frmMessages);
  Application.CreateForm(TfrmNotifications, frmNotifications);
  Application.CreateForm(TfrmClientAppointments, frmClientAppointments);
  Application.CreateForm(TfrmHelp, frmHelp);
  Application.CreateForm(TfrmPropData, frmPropData);
  Application.Run;
end.
