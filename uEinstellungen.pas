unit uEinstellungen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, NxEdit, uutils;

type
  TEinstellungen = class(TForm)
    FileOpenDialog1: TFileOpenDialog;
    BSaveSettings: TButton;
    Button1: TButton;
    CheckBox1: TCheckBox;
    Panel1: TPanel;
    epassword: TNxEdit;
    everzeichnis: TNxEdit;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ekundennummer: TNxEdit;
    esachbearbeiter: TNxEdit;
    procedure Bsave(Sender: TObject);
    procedure Babbrechen(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ekundennummerKeyPress(Sender: TObject; var Key: Char);
    procedure everzeichnisChange(Sender: TObject);
  private
    showPassword: boolean;
  end;

var
  Einstellungen: TEinstellungen;

implementation

{$R *.dfm}

uses umain, uupperframe;

procedure TEinstellungen.Babbrechen(Sender: TObject);
begin
  self.close;

end;

procedure TEinstellungen.Bsave(Sender: TObject);
var
  passwort, kundennummer, sachbearbeiter, verzeichnis: string;
begin
  passwort        := epassword.Text;
  kundennummer    := ekundennummer.Text;
  sachbearbeiter  := esachbearbeiter.Text;
  verzeichnis     := everzeichnis.Text;

  if not DirectoryExists(verzeichnis) then
  begin
    MessageDlg('bitte ein gültiges Verzeichnis auswählen', mtError,mbOKCancel,0);
    exit;
  end;

  formmain.saveSettings(passwort, kundennummer, sachbearbeiter, verzeichnis);
  self.close;
end;

procedure TEinstellungen.Button1Click(Sender: TObject);
begin
  if FileOpenDialog1.execute then
    everzeichnis.Text := FileOpenDialog1.FileName;
end;

procedure TEinstellungen.CheckBox1Click(Sender: TObject);
begin
  showPassword := not(showPassword);
  if showPassword then
    epassword.PasswordChar := #0
  else
    epassword.PasswordChar := '*';
end;

procedure TEinstellungen.ekundennummerKeyPress(Sender: TObject; var Key: Char);
begin
  Key := ignoreNonNumerics(Key);
end;

procedure TEinstellungen.everzeichnisChange(Sender: TObject);
begin

    if not FileExists(everzeichnis.Text) then
    begin
      everzeichnis.Color := clRed;
    end;
end;

procedure TEinstellungen.FormShow(Sender: TObject);
begin
//  Einstellungen.Top := formmain.Top;
//  Einstellungen.Left := FormMain.Left;

  try
    ekundennummer.Text   := formmain.getKundennummer;
    everzeichnis.Text    := formmain.getVerzeichnis;
    esachbearbeiter.Text := formmain.getSachbearbeiter;
    everzeichnis.Text := FormMain.getVerzeichnis;

    if not FileExists(everzeichnis.Text) then
    begin
      everzeichnis.Color := clRed;
    end;
  except
    ekundennummer.Text := '';
    everzeichnis.Text := '';
    esachbearbeiter.Text := '';
  end;
  ekundennummer.SetFocus;
end;

end.
