unit uFavorites;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DB, ADODB, DBGrids;

type
  TfrmFavorites = class(TForm)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFavorites: TfrmFavorites;

implementation
uses pngimage, uGlobal, uClient, uDM, uSQLExplorer;

{$R *.dfm}


{ TfrmFavorites }

procedure TfrmFavorites.FormShow(Sender: TObject);
var sSQL : String;
begin
sSQL := 'SELECT PL.Property_ID, P.Property_Name, P.Size, P.Price, P.Province, P.Sold, P.Description, P.Image FROM tblProperties P INNER JOIN tblPropertyLikes PL ON'
      + ' P.Property_ID = PL.Property_ID WHERE (PL.Property_ID = P.Property_ID)';

   frmSQLExplorer.runSQL(sSQL);

   showMessage('Success');
end;

end.
