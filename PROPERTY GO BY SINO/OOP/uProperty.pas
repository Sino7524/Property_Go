unit uProperty;

interface

type
  TProperty = class(TObject)

  private
    f_sPropertyID: String;
    f_sDescription: String;
    f_rSize: Real;
    f_rDefaultPrice: Real;
    f_sProvince: String;
    f_iLikes: Integer;
    f_cRating: Char;
    f_bSold: Boolean;

  public
    constructor Create(sPropertyID, sProvince: String;
      sDescription: UniCodeString; rSize, rPrice: Real; bSold: Boolean);
    function getPropertyID: String;
    function getDescription: UniCodeString;
    function getSize: Real;
    function getProvince: String;
    function getLikes: Integer;
    function getRating: Char;
    function getSold: Boolean;
    function getDefaultPrice: Real;

    procedure setPropertyID(sID: String);
    procedure setDescription(sDescription: UniCodeString);
    procedure setSize(rSize: Real);
    procedure setProvince(sProvince: String);
    procedure setLikes(iLikes: Integer);
    procedure setRating(cRating: Char);
    procedure setSold(bSold: Boolean);
    procedure setDefaultPrice(rPrice: Real);
    procedure setAll(sPropertyID, sProvince: String;
      sDescription: UniCodeString; rSize, rPrice: Real;
      bSold: Boolean; iLikes: Integer; cRating: Char);

    function calcPriceWithCharges(): Real;
    function calcDiscountedPrice(Discount: Real): Real;

  end;

implementation

{ TProperty }

function TProperty.calcDiscountedPrice(Discount: Real): Real;
begin
  result := calcPriceWithCharges - (calcPriceWithCharges * Discount)
end;

function TProperty.calcPriceWithCharges: Real;
var
  iCharges: Integer;
begin

  case self.f_iLikes of
    0 .. 99:
      begin
        f_cRating := 'E'
      end;
    100 .. 199:
      begin
        f_cRating := 'D'
      end;
    200 .. 499:
      begin
        f_cRating := 'C'
      end;
    500 .. 999:
      begin
        f_cRating := 'B'
      end;
  else
    begin
      f_cRating := 'A'
    end;
  end;

  case f_cRating of
    'A':
      begin
        iCharges := 500000
      end;
    'B':
      begin
        iCharges := 200000
      end;
    'C':
      begin
        iCharges := 100000
      end;
    'D':
      begin
        iCharges := 50000
      end;
  else
    begin
      iCharges := 0
    end;
  end;

  result := self.f_rDefaultPrice + iCharges;

end;

constructor TProperty.Create(sPropertyID, sProvince: String;
  sDescription: UniCodeString; rSize, rPrice: Real; bSold: Boolean);
begin
  self.f_sPropertyID := sPropertyID;
  self.f_sDescription := sDescription;
  self.f_rSize := rSize;
  self.f_rDefaultPrice := rPrice;
  self.f_sProvince := sProvince;
  self.f_bSold := bSold;
  self.f_cRating := 'E';
end;

function TProperty.getDefaultPrice: Real;
begin
  result := self.f_rDefaultPrice;
end;

function TProperty.getDescription: String;
begin
  result := self.f_sDescription;
end;

function TProperty.getLikes: Integer;
begin
  result := self.f_iLikes;
end;

function TProperty.getPropertyID: String;
begin
  result := self.f_sPropertyID;
end;

function TProperty.getProvince: String;
begin
  result := self.f_sProvince;
end;

function TProperty.getRating: Char;
begin
  result := self.f_cRating;
end;

function TProperty.getSize: Real;
begin
  result := self.f_rSize;
end;

function TProperty.getSold: Boolean;
begin
  result := self.f_bSold;
end;

procedure TProperty.setAll(sPropertyID, sProvince: String;
  sDescription: UniCodeString; rSize, rPrice: Real; bSold: Boolean;
  iLikes: Integer; cRating: Char);
begin
  self.f_sPropertyID := sPropertyID;
  self.f_sDescription := sDescription;
  self.f_sProvince := sProvince;
  self.f_rSize := rSize;
  self.f_rDefaultPrice := rPrice;
  self.f_bSold := bSold;
  self.f_iLikes := iLikes;
  self.f_cRating := cRating;
end;

procedure TProperty.setDefaultPrice(rPrice: Real);
begin
  self.f_rDefaultPrice := rPrice;
end;

procedure TProperty.setDescription(sDescription: UniCodeString);
begin
  self.f_sDescription := sDescription;
end;

procedure TProperty.setLikes(iLikes: Integer);
begin
  self.f_iLikes := iLikes;
end;

procedure TProperty.setPropertyID(sID: String);
begin
  self.f_sPropertyID := sID;
end;

procedure TProperty.setProvince(sProvince: String);
begin
  self.f_sProvince := sProvince;
end;

procedure TProperty.setRating(cRating: Char);
begin
  self.f_cRating := cRating;
end;

procedure TProperty.setSize(rSize: Real);
begin
  self.f_rSize := rSize;
end;

procedure TProperty.setSold(bSold: Boolean);
begin
  self.f_bSold := bSold;
end;

end.
