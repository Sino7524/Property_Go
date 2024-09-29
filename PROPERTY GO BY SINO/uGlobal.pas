unit uGlobal;

interface

const
  table1Name = 'tblAppointments';

const
  table2Name = 'tblClients';

const
  table3Name = 'tblProperties';

const
  table4Name = 'tblRealtors';

type
  TUser = class(TObject)

  private
    f_sUsername: String;
    f_sPassword: String;
    f_sName: String;
    f_bIsClient: Boolean;
  public
    constructor Create(p_sUsername, p_sPassword : String);
    procedure setName(p_sName : String);
    function getName(): String;
    function getUsername(): String;
    function getIsClient(): Boolean;
    procedure setIsClient(p_bIsClient: Boolean);
  end;

var
  objGlobalUser : TUser;
implementation

{ TUser }

{ TUser }

constructor TUser.Create(p_sUsername, p_sPassword : String);
begin
  self.f_sUsername := p_sUsername;
  self.f_sPassword := p_sPassword;
end;

function TUser.getIsClient: Boolean;
begin
 result := self.f_bIsClient;
end;

function TUser.getName : String;
begin
result := self.f_sName;
end;

function TUser.getUsername: String;
begin result := self.f_sUsername;
end;

procedure TUser.setIsClient(p_bIsClient: Boolean);
begin
self.f_bIsClient := p_bIsClient;
end;

procedure TUser.setName(p_sName: String);
begin self.f_sName := p_sName;
end;

end.
