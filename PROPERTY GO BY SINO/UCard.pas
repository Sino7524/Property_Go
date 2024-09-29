unit UCard;

interface

uses
sysUtils;

type
  TCardType = (ctUnknown = 0, ctAmex = 1, ctDiscover = 2, ctMastercard = 3, ctVisa = 4,
    ctDebit = 5, ctEbt = 6, ctEgc = 7, ctWex = 8, ctVoyager = 9, ctJcb = 10, ctCup = 11);

  TCardNumber = record
    Num: String;
    function GetStr(const Delim: String = ''): String;
    function Masked: String;
    function IsValid: Boolean;
    function CardType: TCardType;
  end;

implementation

{ TCardNumber }

function TCardNumber.IsValid: Boolean;
var
  S: String;
  C: Char;
  CheckSum: string;
  i,j: Integer;
  function ReverseStr(const Str: string): string;
  var
    i, Len: Integer;
  begin
    //Reverses string for checksum validation
    Len := Length(Str);
    SetLength(Result, Len);
    for i := 1 to Len do
      Result[i] := Str[Succ(Len-i)];
  end;
begin
  Result:= True;
  S:= Num;

  //Strip extra characters and validate numeric characters
  for i := Length(S) downto 1 do begin //From end to beginning
    C:= S[i];
    if C in ['-',' '] then begin
      Delete(S, i, 1);
    end else
    if not(C In ['0'..'9']) then begin
      Result:= False;
      Break;
    end;
  end;

  //Validate Length
  if Result then
    Result:= Length(S) in [15,16];

  //Check first digit for card type
  if Result then begin
    C:= S[1];
    //3 = American Express
    //4 = Visa
    //5 = MasterCard
    //6 = Discover
    Result:= C In ['3'..'6'];
  end;

  //Validate Checksum
  //http://www.delphicode.co.uk/is-credit-card-number-valid/
  if Result then begin
    S := ReverseStr(S);
    CheckSum := '';
      for i := 1 to Length(S) do
        if Odd(i) then
          CheckSum := CheckSum + S[i]
        else
          CheckSum := CheckSum + IntToStr(StrToInt(S[i]) * 2);
    j := 0;
    for i := 1 to Length(CheckSum) do
      j := j + StrToInt(CheckSum[i]);
    Result := (j mod 10) = 0;
  end;
end;

function TCardNumber.CardType: TCardType;
var
  I: Integer;
begin
  Result:= TCardType.ctUnknown;
  if IsValid then begin
    I:= StrToIntDef(Num[1], 0);
    case I of
      3: Result:= ctAmex;
      4: Result:= ctVisa;
      5: Result:= ctMasterCard;
      6: Result:= ctDiscover;
    end;
  end;
end;

function TCardNumber.GetStr(const Delim: String): String;
var
  X: Integer;
  S: String;
begin
  S:= Num;
  if (Delim <> '') and (IsValid) then begin
    if CardType = ctAmex then begin
      //4 - 6 - 5
      //xxxx-xxxxxx-xxxxx (15 --> 17)
      Insert(Delim, S, 5);
      Insert(Delim, S, 12);
    end else begin
      //4 - 4 - 4 - 4
      //xxxx-xxxx-xxxx-xxxx (16 --> 19)
      Insert(Delim, S, 5);
      Insert(Delim, S, 10);
      Insert(Delim, S, 15);
    end;
  end;
  Result:= S;
end;

function TCardNumber.Masked: String;
begin
  //Return last 4 digits, prefixed by asterisk characters
  Result:= Trim(Num);
  Result:= Copy(Result, Length(Result)-3, 4);
  Result:= '************'+Result;
end;

end.
