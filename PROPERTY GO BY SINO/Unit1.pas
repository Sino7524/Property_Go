unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Math, StdCtrls, pngimage, ExtCtrls, ComCtrls;

type
  TfrmMain = class(TForm)
    nbkStart: TNotebook;
    shpCreate: TShape;
    lblCreate: TLabel;
    lblSignIn: TLabel;
    imgSignUp: TImage;
    Edit1: TEdit;
    procedure shpCreateMouseEnter(Sender: TObject);
    procedure shpCreateMouseLeave(Sender: TObject);
    procedure lblSignInMouseEnter(Sender: TObject);
    procedure lblSignInMouseLeave(Sender: TObject);
    procedure lblSignInClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.lblSignInClick(Sender: TObject);
begin
nbkStart.PageIndex := 0;
end;

procedure TfrmMain.lblSignInMouseEnter(Sender: TObject);
begin
self.lblSignIn.Font.Color := $00FF2291;
end;

procedure TfrmMain.lblSignInMouseLeave(Sender: TObject);
begin
self.lblSignIn.Font.Color := $00EB175E;
end;

procedure TfrmMain.shpCreateMouseEnter(Sender: TObject);
begin
shpCreate.Brush.Color := $00FF2291;
end;

procedure TfrmMain.shpCreateMouseLeave(Sender: TObject);
begin
shpCreate.Brush.Color := $00EB175E;
end;

end.
