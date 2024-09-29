unit uValidator;

interface
 uses stdCtrls, Forms, Graphics, DateUtils, Math, Dialogs;
type
TValidator = class(TObject)
private

public
function isTEditEmpty( var item : TEdit) : Boolean;
function isInRangeTEdit(var item: TEdit; min,max: integer): Boolean;
function isEmailValid(var item: TEdit):Boolean;
function isDateInFuture(Date : TDate): Boolean;
function DetermineAge(DoB : TDate) : Integer;
function isPasswordValid(Password : String) : Boolean;
function isValidRealtor(sCompanyPass : String) : Boolean;

//function isEmailValid( var item : TEdit ): Boolean;

end;
implementation

{ TValidator }



function TValidator.DetermineAge(DoB: TDate): Integer;
begin
result := Floor((Today - DoB)/365.25);
end;

function TValidator.isDateInFuture(Date: TDate): Boolean;
var isOkay : Boolean;
begin

end;

function TValidator.isEmailValid(var item: TEdit): Boolean;
begin
if (pos('@', item.Text) = 0) AND (pos('.',item.Text) = 0) then
 item.Color :=  $004A4AFF;

 result := (pos('@' ,item.Text) > 0) AND (pos('.', item.text) > 0);
end;

function TValidator.isInRangeTEdit(var item: TEdit; min, max: integer): Boolean;
begin

  if (min >= Length(item.Text))
  or (max <= Length(item.Text))
  then Item.Color := $004A4AFF
  else Item.Color := clWindow;

  result := (min <= Length(item.Text)) and
            (max >= Length(item.Text))

end;
function TValidator.isPasswordValid(Password: String): Boolean;
var isOkay : Boolean;
criterias, i : integer;
begin
criterias := 0;
isOkay := False;

if (Length(Password) > 8) And (Length(Password) < 16) then
inc(criterias);

for i := 1 to Length(Password) do
begin
  if (Ord(Password[i]) in[33..46]) or (Ord(Password[i]) in[58..64]) then
  inc(criterias);

  if (Ord(Password[i]) in[65..90]) then
  inc(criterias);

  if (Ord(Password[i]) in[97..122]) then
  inc(criterias);

  if (Ord(Password[i]) in[48..57]) then
  inc(criterias);
end;

if criterias > 4 then
result := True
else
 result := False;


end;

function TValidator.isTEditEmpty(var item: TEdit): Boolean;
begin
if Length(item.text) = 0
then item.color := $004A4AFF
else
item.color := clCream;

result := Length(item.text) = 0;

end;

function TValidator.isValidRealtor(sCompanyPass : String): Boolean;
begin
if sCompanyPass <> 'SinoPropertyGo' then
result := False
else result := True;
end;

end.
