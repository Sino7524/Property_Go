unit uStart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Math, StdCtrls, pngimage, ExtCtrls, ComCtrls, Mask, uDM, uMain,
  uValidator, DB, ADODB, uClient, uGlobal;

type
  TfrmStart = class(TForm)
    nbkStart: TNotebook;
    shpCreate: TShape;
    lblCreate: TLabel;
    lblSignIn: TLabel;
    imgSignUp: TImage;
    edtFirstName: TEdit;
    edtLastName: TEdit;
    edtEmail: TEdit;
    edtUsername: TEdit;
    edtPassword: TEdit;
    cmbUserType: TComboBox;
    dtpDoB: TDateTimePicker;
    imgSignIn: TImage;
    edtUser: TEdit;
    lblSignUp: TLabel;
    edtPass: TEdit;
    shpLogin: TShape;
    lblLogin: TLabel;
    chkRememberMe: TCheckBox;
    edtPhone: TEdit;
    imgEye: TImage;
    procedure shpCreateMouseEnter(Sender: TObject);
    procedure shpCreateMouseLeave(Sender: TObject);
    procedure lblSignInMouseEnter(Sender: TObject);
    procedure lblSignInMouseLeave(Sender: TObject);
    procedure lblSignInClick(Sender: TObject);
    procedure lblSignUpMouseEnter(Sender: TObject);
    procedure lblSignUpMouseLeave(Sender: TObject);
    procedure lblSignUpClick(Sender: TObject);
    procedure shpLoginMouseEnter(Sender: TObject);
    procedure shpLoginMouseLeave(Sender: TObject);
    procedure lblLoginMouseEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure shpCreateMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edtPasswordExit(Sender: TObject);
    procedure shpLoginMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lblLoginMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgEyeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgEyeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lblCreateClick(Sender: TObject);
    procedure lblLoginClick(Sender: TObject);
    procedure shpLoginMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetUserTable(sUser: String): TADOTable;
    function checkInfo(email: TEdit; Password: TEdit): Boolean;
    function CreateClientUsername(): String;
    function CreateRealtorUsername(): String;
    procedure NextScreen;
    procedure CreateAccount();
    procedure Login();
    function encrypt(plainText: String): String;
    function matchPassword(attempt: String; sPass: String): Boolean;
  end;

var
  frmStart: TfrmStart;
  { Custom Global Variables - (CGV) }
  { User Interface - (UI) }
  sCompanyPass: String;
  tf: textfile;

implementation

uses uSQLExplorer;

const
  delimiter = '~';
{$R *.dfm}

function TfrmStart.checkInfo(email, Password: TEdit): Boolean;
var
  objValidator: TValidator;
  isOkay: Boolean;
  arrErrorMessages: array [1 .. 11] of String;
  i, iErrorNum: Integer;
  table: TADOTable;
  tf: textfile;
  sMatch, aLine: String;
begin
  iErrorNum := 0;
  isOkay := False;

  if edtPassword.Color <> clWindow then
  begin
    inc(iErrorNum);
    arrErrorMessages[iErrorNum] := 'Error: Passwords do not match';
  end;

  if objValidator.isTEditEmpty(edtFirstName) then
  begin
    inc(iErrorNum);
    arrErrorMessages[iErrorNum] := 'Error: Please provide First Name';
  end;

  if objValidator.isTEditEmpty(edtLastName) then
  begin
    inc(iErrorNum);
    arrErrorMessages[iErrorNum] := 'Error: Please provide Last Name';
  end;

  if (cmbUserType.ItemIndex < 0) then
  begin
    inc(iErrorNum);
    cmbUserType.Color := $004A4AFF;
    arrErrorMessages[iErrorNum] := 'Error: Choose User Type';
  end;

  if objValidator.isEmailValid(edtEmail) = False then
  begin
    inc(iErrorNum);
    arrErrorMessages[iErrorNum] := 'Error: Email is invalid';
  end;

  if objValidator.isInRangeTEdit(edtPhone, 5, 15) = False then
  begin
    inc(iErrorNum);
    arrErrorMessages[iErrorNum] := 'Error: Invalid Phone number';
    edtPhone.Color := $004A4AFF;
  end
  else

    if objValidator.DetermineAge(dtpDoB.Date) < 18 then
  begin
    inc(iErrorNum);
    dtpDoB.Color := $004A4AFF;
    arrErrorMessages[iErrorNum] :=
      'Error: You are under the age of 18 and therefore are not allowed to create an account';
  end;

  if objValidator.isPasswordValid(edtPassword.text) = False then
  begin
    inc(iErrorNum);
    arrErrorMessages[iErrorNum] := 'Error: Password must :' + #10#13 + #10#13 +
      '- Be 8 to 16 characters long' + #10#13 +
      '- Contain at least one uppercase character' + #10#13 +
      '- Contain at least one lowercase character' + #10#13 +
      '- Contain at least one special character' + #10#13 +
      '- Contain at least one numerical charcter';
    edtPassword.Color := $004A4AFF;
  end;

  if self.cmbUserType.ItemIndex = 1 then
  begin
    sCompanyPass := InputBox('Confirm that you are a realtor',
      'Enter Employee ID', '');
    if objValidator.isValidRealtor(sCompanyPass) = True then
    begin
      inc(iErrorNum);
      arrErrorMessages[iErrorNum] := 'Inorrect Company Pass';
    end;
  end;

  if iErrorNum = 0 then
  begin
    isOkay := True;
  end
  else
  BEGIN
    for i := 1 to iErrorNum do
    begin
      showMessage(arrErrorMessages[i]);
    END;
  end;

  result := isOkay;

end;

procedure TfrmStart.CreateAccount;
var
  table: TADOTable;
  sUser, sLine: String;
  myFile: textfile;

begin

  sUser := '';
  table := GetUserTable(self.cmbUserType.Items[0]);
  if table = DM.tblClients then
    sUser := 'Client_ID'
  else if table = DM.tblRealtors then
  begin
    sUser := 'Realtor_ID';
  end;

  if checkInfo(edtEmail, edtPassword) = True then
  begin
    if self.cmbUserType.ItemIndex = 0 then
      edtUsername.text := CreateClientUsername
    else if self.cmbUserType.ItemIndex = 1 then
      edtUsername.text := CreateRealtorUsername;

    table.Insert;
    table[sUser] := edtUsername.text;
    table['First_Name'] := edtFirstName.text;
    table['Surname'] := edtEmail.text;
    table['Email'] := edtEmail.text;
    table['Birth_Date'] := dtpDoB.Date;
    table['Phone'] := edtPhone.text;
    table.Post;

    { Dialogs.showMessage('Account Created :) ');
      nbkStart.PageIndex := 0;
      edtUser.text := edtUsername.text;
      edtUser.Visible := True; }
    sLine := self.edtUsername.text + delimiter + encrypt(self.edtPassword.text);
    // showMessage(sLine);
    if FileExists('Cookie.txt') then
    begin
      AssignFile(myFile, 'Cookie.txt');
      Append(myFile);
      Writeln(myFile, sLine);
      CloseFile(myFile);

      Dialogs.showMessage('Account Created :) ');
      Dialogs.showMessage('Your username is ' + edtUsername.text + #10#13 +
          'Please remember to save it. It will be available for you to copy on the next screen.');
      nbkStart.PageIndex := 0;
      edtUser.Enabled := True;
      edtUser.text := edtUsername.text;
      edtUser.Visible := True;
      chkRememberMe.Visible := True;
      chkRememberMe.Enabled := True;
      edtPass.text := '';

    end
    else
      showMessage(
        'SYSTEM ERROR: System file missing. Please contact Admin to assist you.'
        );

  end
  else
    Dialogs.showMessage('Account not created :(');
end;

function TfrmStart.CreateClientUsername: String;
const
  PossibleChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
var
  sUser: String;
  iLoop: Integer;
  iSize: Integer;
begin
  repeat
    sUser := '';

    iSize := length(PossibleChars);
    for iLoop := 1 to 9 do
      sUser := sUser + PossibleChars[Random(iSize) + 1];

    // result := sUser;
  until DM.tblClients.Locate('Client_ID', sUser, []) = False;
  result := sUser;
end;

function TfrmStart.CreateRealtorUsername: String;
var
  i: Integer;
  sUser: string;
begin
  repeat
    sUser := '';

    for i := 1 to 10 do
      sUser := sUser + IntToStr(Random(10) + 1);

    sUser[Random(10) + 1] := '-';

  until DM.tblRealtors.Locate('Realtor_ID', sUser, []) = False;
  result := sUser;
end;

procedure TfrmStart.edtPasswordExit(Sender: TObject);
var
  sConfirm: String;
begin
  sConfirm := InputBox('Confirm Password', 'Enter password again', '');

  if sConfirm <> edtPassword.text then
    self.edtPassword.Color := $004A4AFF
  else
    self.edtPassword.Color := clWindow;

end;

function TfrmStart.encrypt(plainText: String): String;
const
  alpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZzyxwvutsrqponmlkjihgfedcba ';
  beta = 'zyxwvutsrqponmlkjihgfedcbaABCDEFGHIJKLMNOPQRSTUVWXYZ-';
var
  i: Integer;
  find: Integer;
  cipher: String;
begin
  cipher := '';
  for i := 1 to length(plainText) do
  begin
    find := POS(plainText[i], alpha);
    if (find > 0) then
      cipher := cipher + beta[find]
    else
      cipher := cipher + plainText[i];
  end;
  result := cipher;

end;

procedure TfrmStart.FormActivate(Sender: TObject);
{ When the form is activated, the program sets the text for the username and password edit box
  to the first 2 lines on the textfile "cookie.txt" }
var
  aLine: String;
begin
  nbkStart.PageIndex := 0; // To ensure that the Sign in Screen is displayed everytime program runs
  /// /////////////////////TEXTFILE ALGORITHM FOR REMEMBER ME ALGORITHM////////////////////////
  if FileExists('RememberMe.txt') then
  BEGIN
    AssignFile(tf, 'RememberMe.txt');
    Reset(tf);
    Readln(tf, aLine);
    self.edtUser.text := aLine;
    Readln(tf, aLine);
    self.edtPass.text := aLine;
    CloseFile(tf);
  end;
end;

procedure TfrmStart.FormShow(Sender: TObject);
begin
  self.imgSignIn.Picture.LoadFromFile('..\Phase 2 Version 3\screenLogin.png');
end;

function TfrmStart.GetUserTable(sUser: String): TADOTable;
var
  table: TADOTable;
begin
  if sUser = 'Client' then
    table := DM.tblClients
  else if sUser = 'Realtor' then
    table := DM.tblRealtors;

  result := table;
end;

procedure TfrmStart.imgEyeMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  imgEye.Picture.LoadFromFile('Hide.png');
  edtPass.PasswordChar := #0;
end;

procedure TfrmStart.imgEyeMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  imgEye.Picture.LoadFromFile('Show.png');
  edtPass.PasswordChar := '*';
end;

procedure TfrmStart.lblCreateClick(Sender: TObject);
begin
  CreateAccount;
end;

procedure TfrmStart.lblLoginClick(Sender: TObject);
begin
  Login;
end;

procedure TfrmStart.lblLoginMouseEnter(Sender: TObject);
begin
  shpLogin.Brush.Color := $00FF2291; // UX Design
end;

procedure TfrmStart.lblLoginMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  shpLogin.Brush.Color := $00EB175E; // UX Design
end;

procedure TfrmStart.lblSignInClick(Sender: TObject);
begin
  nbkStart.PageIndex := 0;
end;

procedure TfrmStart.lblSignInMouseEnter(Sender: TObject);
begin
  self.lblSignIn.Font.Color := $00FF2291;
end;

procedure TfrmStart.lblSignInMouseLeave(Sender: TObject);
begin
  self.lblSignIn.Font.Color := $00EB175E;
end;

procedure TfrmStart.lblSignUpClick(Sender: TObject);
begin
  nbkStart.PageIndex := 1;
  edtUser.Visible := False;
  chkRememberMe.Visible := False;
end;

procedure TfrmStart.lblSignUpMouseEnter(Sender: TObject);
begin
  self.lblSignUp.Font.Color := $00FF2291;
end;

procedure TfrmStart.lblSignUpMouseLeave(Sender: TObject);
begin
  self.lblSignUp.Font.Color := $00EB175E;
end;

procedure TfrmStart.Login;
{ Text File Use: (and String Manipulation)

  In this procedure, a text file is read so that information required for
  the user to login is stored in the variables declared below.

  if the user is found, their username will be located in the database and if found,
  (login is successful) the user will be able to access the main program. If
  the user's username is not located in the database (but was found in the
  text file), an appropriate error message will be shown.
  If the user's username was not found in the textfile, the user will be prompted
  to create an account.

}
var
  tf: textfile;
  sLine, sUser, sPassword: String;
  bFound: Boolean;
begin

  /// /////////////////////TEXTFILE ALGORITHM FOR REMEMBER ME ALGORITHM////////////////////////
  if chkRememberMe.Checked then
  BEGIN
    AssignFile(tf, 'RememberMe.txt');
    Rewrite(tf); // Deletes file content in 'cookies.txt'
    Writeln(tf, edtUser.text); // First line of 'cookies.txt' is edtUsername.text
    Writeln(tf, edtPass.text); // Second line of 'cookies.txt' is edtPassword.text
    CloseFile(tf);
  END;

  shpLogin.Brush.Color := $00800040; // UX Design
  bFound := False; // default value of bFound is set to false;

  if FileExists('Cookie.txt') then
  begin
    AssignFile(tf, 'Cookie.txt');

    Reset(tf);
    while not eof(tf) do
    Begin
      Readln(tf, sLine);
      // sLine contains <username>+space+<password>+*+<Theme Colour>
      // example: sino_7524 password02*dark

      { CGV }
      sUser := Copy(sLine, 1, POS(delimiter, sLine) - 1);
      Delete(sLine, 1, length(sUser) + 1);

      // sLine now contains <password>+*+<Theme Colour>
      // example: password02*dark

      { CGV } sPassword := sLine;

      // sLine now contains <Theme Colour>
      // example: dark

      if (sUser = edtUser.text) And (matchPassword(edtPass.text,
          sPassword) = True) then
      begin
        bFound := True;
        break; // username is found
      end
      else // end of if statement

      End; // end of while loop

    end
    else
    begin

    end; // end of if then else statement
    CloseFile(tf);

    if bFound = True then
    begin

      if (DM.tblClients.Locate('Client_ID', sUser, [])) then
      begin
        objGlobalUser := TUser.Create(self.edtUser.text, self.edtPass.text);
        objGlobalUser.setName(DM.tblClients.FieldByName('First_Name').AsString);
        objGlobalUser.setIsClient(True);
        NextScreen;
      end
      else if (DM.tblRealtors.Locate('Realtor_ID', sUser, [])) then
      begin
        objGlobalUser := TUser.Create(self.edtUser.text, self.edtPass.text);
        objGlobalUser.setName(DM.tblRealtors.FieldByName('First_Name')
            .AsString);
        objGlobalUser.setIsClient(False);
        NextScreen;
      end
      else if ((sUser = 'Admin') and (matchPassword(edtPass.text,
            sPassword) = True)) then
      begin
        objGlobalUser := TUser.Create(self.edtUser.text, self.edtPass.text);
        objGlobalUser.setName('Admin');

        uStart.frmStart.Hide;
        uMain.frmSQL_Main.ShowModal;
        uStart.frmStart.Show;
        // uMain.frmSQL_Main.ShowModal;

      end
      else if (DM.tblClients.Locate('Client_ID', sUser, []) = False) or
        (DM.tblRealtors.Locate('Realtor_ID', sUser, []) = False) then
        showMessage(
          'Account was deleted. Contact Admin to recover it. To Programmer: Acoount was found in the cookie texfile but not found in the database.');

    end
    else
      showMessage('Incorrect username or password');

  end;

  function TfrmStart.matchPassword(attempt: String; sPass: String): Boolean;
  begin
    result := (sPass = self.encrypt(attempt));
  end;

  procedure TfrmStart.NextScreen;
  begin
    // uStart.frmStart.CloseModal;
    uStart.frmStart.Hide;
    uClient.frmClient.ShowModal;
    uStart.frmStart.Show;
    DM.tblProperties.First;
  end;

  procedure TfrmStart.shpCreateMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
  begin
    CreateAccount;
  end;

  procedure TfrmStart.shpCreateMouseEnter(Sender: TObject);
  begin
    shpCreate.Brush.Color := $00FF2291;
  end;

  procedure TfrmStart.shpCreateMouseLeave(Sender: TObject);
  begin
    shpCreate.Brush.Color := $00EB175E;
  end;

  procedure TfrmStart.shpLoginMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
  begin
    Login;
  end;

  procedure TfrmStart.shpLoginMouseEnter(Sender: TObject);
  begin
    shpLogin.Brush.Color := $00FF2291; // UX Design
  end;

  procedure TfrmStart.shpLoginMouseLeave(Sender: TObject);
  begin
    shpLogin.Brush.Color := $00EB175E; // UX Design
  end;

  procedure TfrmStart.shpLoginMouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
  begin
    shpLogin.Brush.Color := $00EB175E; // UX Design
  end;

end.
