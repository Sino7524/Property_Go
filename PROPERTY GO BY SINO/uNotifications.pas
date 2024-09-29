unit uNotifications;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls;

type
  TfrmNotifications = class(TForm)
    Image1: TImage;
    lblMessage: TLabel;
    pnlNotifications: TScrollBox;
    procedure FormShow(Sender: TObject);
    procedure NotificationClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNotifications: TfrmNotifications;
  arrPnlNotifications: array [1 .. 1000] of TPanel;

implementation

uses uDM, uGlobal, uClient;
{$R *.dfm}

procedure TfrmNotifications.FormShow(Sender: TObject);
var
  bFound: boolean;
  iNotifications, i, iPlace, iTimes: integer;
begin
  iPlace := 20;

//  iTimes := iNotifications div 8;
//  pnlNotifications.Height := pnlNotifications.Height * iNotifications;
  DM.tblAppointments.Filtered := False;
  DM.tblAppointments.Filter := 'Client_ID = ' + QuotedStr
    (objGlobalUser.GetUsername) + 'AND Message <> Null';
  DM.tblAppointments.Filtered := True;
  //DM.tblAppointments.Filter := 'Message <> Null';
  iNotifications := DM.tblAppointments.RecordCount;
  DM.tblAppointments.First;

  for i := 1 to iNotifications do
  begin
    arrPnlNotifications[i] := TPanel.Create(frmClient);

    with arrPnlNotifications[i] do
    begin
      Parent := pnlNotifications;
      Caption := IntToStr(DM.tblAppointments.FieldByName('Appointment_ID')
          .AsInteger) + ' ' + DM.tblAppointments.FieldByName('Realtor_Name')
        .AsString;

      if DM.tblAppointments.FieldByName('Viewed').AsBoolean = False then
      begin
        Font.Style := [fsBold];
      end
      else
        Font.Style := [];

      Width := 420;
      Height := 49;
      Left := 14;
      Color := clWhite;
      Top := iPlace;
      onClick := NotificationClick;
      iPlace := iPlace + 53;
      DM.tblAppointments.Next;
    end;
  end;

end;

procedure TfrmNotifications.NotificationClick(Sender: TObject);
var
  bFound: boolean;
  sAppointment_ID: String;
begin
  sAppointment_ID := Copy(((Sender AS TPanel).Caption), 1,
    (Pos(' ', (Sender AS TPanel).Caption) - 1));
  bFound := False;

  DM.tblAppointments.First;
  While not(DM.tblAppointments.eof) and (bFound = False) do
  Begin

    If IntToStr(DM.tblAppointments.FieldByName('Appointment_ID').AsInteger)
      = sAppointment_ID then
    Begin
      bFound := True;

      lblMessage.Caption := DM.tblAppointments.FieldByName('Message').AsString;

      DM.tblAppointments.Edit;
      DM.tblAppointments['Viewed'] := True;
      DM.tblAppointments.Post; (Sender AS TPanel)
     // .Font.Color := clRed;
     .Font.Style := [];
    End
    else
      DM.tblAppointments.Next;

  End;

end;

end.
