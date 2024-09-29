unit uFindSelection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDM, StdCtrls, Buttons, Grids, DBGrids;

type
  TfrmFindSelection = class(TForm)
    dbFindSelection: TDBGrid;
    btnSelect: TBitBtn;
    btnCancel: TBitBtn;
    procedure btnSelectClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
      keyField : String;
    valueField : String;

    procedure setSQL( sql : String );
  end;

var
  frmFindSelection: TfrmFindSelection;
  var bCancel : boolean;

implementation

{$R *.dfm}

{ TForm2 }

procedure TfrmFindSelection.btnSelectClick(Sender: TObject);
begin valueField := DM.query.FieldByName( keyField ).AsString;
end;

procedure TfrmFindSelection.FormShow(Sender: TObject);
begin
bCancel := False;
end;

procedure TfrmFindSelection.btnCancelClick(Sender: TObject);
begin
bCancel := true;
end;

procedure TfrmFindSelection.setSQL(sql: String);
begin
  DM.query.Active := False;
  DM.query.SQL.Clear;
  DM.query.SQL.Add( sql );
  DM.query.Active := True;
end;

end.
