unit uFormMiddle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,  ComCtrls,
  Buttons,   uutils, udbconnector,
   uconstants, FileCtrl, NxEdit6;

type
  TFormMiddle = class(TForm)
    panel3: TPanel;
    panel4: TPanel;
    PCNotizen: TPanel;
    PCTermine: TPanel;
    PCStatus: TPanel;
    LEingangsdatum: TLabel;
    LMOntagedatum: TLabel;
    LGueltigkeitsdatum: TLabel;
    LAuftragsnummer: TLabeledEdit;
    LNutzernummer: TLabeledEdit;
    Panel6: TPanel;
    Panel7: TPanel;
    menotiz: TRichEdit;
    PAUftragsdaten: TPanel;
    pnotiz: TPanel;
    Panel5: TPanel;
    gpokcancel: TPanel;
    bok: TButton;
    bcancel: TButton;
    FlowPanel1: TFlowPanel;
    Panel8: TPanel;
    gpouter: TGridPanel;
    lid: TLabeledEdit;
    lkundennummer: TLabeledEdit;
    PFile: TPanel;
    PType: TPanel;
    ldateiname: TLabel;
    Button1: TButton;
    LLIEGENSCHAFT: TLabeledEdit;
    FileListBox1: TFileListBox;
    rgerledigt: TRadioGroup;
    dteingangsdatum: TNxDatePicker6;
    dtmontagedatum: TNxDatePicker6;
    dtgueltigkeitsdatum: TNxDatePicker6;
    Panel9: TPanel;

    procedure empty();
    procedure FormShow(Sender: TObject);
//    procedure ELiegenschaftKeyPress(Sender: TObject; var Key: Char);
    procedure HighLightLabel(lab: TLabel);
    procedure DeHightlightLabel(lab: TLabel);
  //  procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DTEingangsdatumEnter(Sender: TObject);
    procedure DTEingangsdatumExit(Sender: TObject);
    procedure DTMontageDatumEnter(Sender: TObject);
    procedure DTMontageDatumExit(Sender: TObject);
    procedure DTGueltigkeitsdatumEnter(Sender: TObject);
    procedure DTGueltigkeitsdatumExit(Sender: TObject);
    procedure LabeledEnter(Sender: TObject);
//    procedure BSuchenMouseEnter(Sender: TObject);
    procedure Labeledleave(Sender: TObject);
    procedure BNotizClick(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure BokClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure WMMenuChar(var MessageRec: TWMMenuChar);
    procedure LockControl(c: TWinControl; bLock: Boolean);
    procedure DTEingangsdatumKeyPress(Sender: TObject; var Key: Char);
    procedure LLIegenschaftKeyPress(Sender: TObject; var Key: Char);
    procedure lfileClick(Sender: TObject);
    procedure NxDatePicker1KeyPress(Sender: TObject; var Key: Char);
    procedure EPosteingangExit(Sender: TObject);
    procedure DateEditPress(Sender: TObject; var Key: Char);
    function  isvalidDate(date: string): boolean;
    function validDayOfMonth(day, month: integer): boolean;
    function validmonth(month: integer): boolean;
//    procedure Button1Click(Sender: TObject);
    procedure FileListBox1DblClick(Sender: TObject);
private
  validDate: boolean;
  procedure CMDialogKey(Var Msg: TWMKey); message CM_DIALOGKEY;
  public
  runningID: integer;
  notizkritzeln: boolean;
  IgnoreOneMenuChar: boolean;
  function getKundennummer():string;
  procedure setliegenschaft(lieg: string);
  end;


  var
    FormMiddle: TFormMiddle;
    IgnoreOneMenuChar: boolean;

  

implementation



uses umain;
{$R *.dfm}



{Datum setzen bei den drei Datumsfeldern, running ID festlegen}
procedure TFormMiddle.FormShow(Sender: TObject);
var
  FormDB: TFormDB;
begin

  validdate := true;
  FlowPanel1.Color := hellgrau;
  FormDB := TFormDB.create(nil);
  DTGueltigkeitsdatum.Date := Now;
  DTMontageDatum.Date := Now;
  DTEingangsdatum.Date := Now;
  LLIegenschaft.SetFocus;
//  runningID := FormDB.getNo();
  // das ist die aktuelle ID. Wir brauchen eine neue
  runningID := runningID + 1;
  lid.Editlabel.caption := runningLabelText;
  lid.text := Format('%.4d', [runningID]);
  //lid.Font.Color := blau;
 // FlowPanel1.Color := dunkelblau;
  menotiz.Text := '';
  menotiz.SelLength := 0;
  menotiz.SelStart := 0;
  //pfileaction.Visible := false;
end;



procedure TFormMiddle.NxDatePicker1KeyPress(Sender: TObject; var Key: Char);

var
  date: string;
  taste: Char;
  tastestring: string;
  position: integer;
  month: integer;
  day: integer;
  edit1: TEdit;
begin
   edit1 := Sender as tedit;
  date := edit1.Text;
  taste := Key;
  key := #0;
  if not (taste in ['0' .. '9', #13, #9]) then // numerisch
    exit;
  tastestring := taste + '';
  position := edit1.selstart;
  case position of

    0:                                     //erstes Zeichen
      if strtoint(tastestring) < 4 then
      begin
        Edit1.Text := Taste + Copy(date, 2, 9);
        edit1.SelStart := 1;
      end
      else
      begin
        Edit1.Text := '0' + Taste + Copy(date, 3, 8);
        edit1.SelStart := 3;  // der Punkt darf auch nicht geändert werden
      end;
    1:
      begin
        Edit1.Text := Copy(date, 0, 1) + Taste + Copy(date, 3, 8);   // prüfen, ob > 1 erlaubt ist!
        edit1.SelStart :=  3;
      end;
    3:if strtoint(tastestring) < 2 then
      begin
        Edit1.Text := Copy(date, 0,3) +  Taste + Copy(date, 5,6);
        Edit1.SelStart := 4;
      end
      else if strtoint(tastestring) > 2  then
      begin
        Edit1.Text := Copy(date, 0, 3) + '0' +Taste + Copy(date, 6, 5);
        Edit1.SelStart := 8;
      end;
    4: begin
        Edit1.Text := Copy(date, 0, 4) + Taste  + Copy(date, 6, 5);
        Edit1.SelStart := 8;
       end;
    8:
      begin
        Edit1.Text := Copy(date, 0, 8) + Taste + Copy(date, 10,1);
        Edit1.SelStart := 9;
      end;
    9:
      begin
        Edit1.Text := COpy(date,0,9)  + Taste;
        Edit1.SelStart := 10;
      end;
    end;
  end;


procedure TFormMiddle.setliegenschaft(lieg: string);
begin
  LLIegenschaft.Text := lieg;
end;

function TFormMiddle.getKundennummer: string;
begin
  Result := formmain.getKundennummer();
end;


procedure TFormMiddle.CMDialogKey(var Msg: TWMKey);
begin 
  with msg do begin 
    case charcode of 
    VK_LEFT,VK_UP : if ActiveControl is TCheckBox then
                         SendMessage(Self.Handle,WM_NEXTDLGCTL,1,0);
//    VK_RIGHT,VK_DOWN : if ActiveControl is TCheckBox then
//                         SendMessage(Self.Handle,WM_NEXTDLGCTL,0,0);
    VK_TAB: if ActiveControl is tlabelededit then
      Showmessage('..');
    else 
      inherited;//Standardverhalten sicherstellen 
    end; 
  end; 
end;

procedure TFormMiddle.DeHightlightLabel(lab: TLabel);
begin
      lab.Font.Color := clgray;
      lab.Font.Style := [];
end;

procedure TFormMiddle.DTEingangsdatumEnter(Sender: TObject);
begin
  HighLightLabel(LEingangsdatum);
end;

procedure TFormMiddle.DTEingangsdatumExit(Sender: TObject);
var text: String;
    actField: TNxdatePicker6;
begin
  actField := Sender as TNxDatePicker6;
  text := actfield.Text;
  if not isvalidDate(text) then
  begin
    actfield.SetFocus;
    actfield.Color := clred;
    validDate := False;
  end
  else
   // DeHightlightLabel(actfield);   { TODO : datumfelder wieder hell }
   actField.Color := clwhite;
   validDate := true;



end;

procedure TFormMiddle.DTEingangsdatumKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    FormMain.buttonsave(nil);
end;

procedure TFormMiddle.DTGueltigkeitsdatumEnter(Sender: TObject);
begin
    HighLightLabel(LGueltigkeitsdatum);
end;

procedure TFormMiddle.DTGueltigkeitsdatumExit(Sender: TObject);
begin
   DeHightlightLabel(LGueltigkeitsdatum);
end;

procedure TFormMiddle.DTMontageDatumEnter(Sender: TObject);
begin
  HighLightLabel(LMontagedatum);
end;

procedure TFormMiddle.DTMontageDatumExit(Sender: TObject);
begin
  DeHightlightLabel(LMontagedatum);
end;

procedure TFormMiddle.EPosteingangExit(Sender: TObject);
begin
  if not isvaliddate((Sender as TEdit).Text)  then
  begin
    validDate := False;
    (Sender as TEdit).Color := clred;
    (Sender as TEdit).SetFocus;
    (Sender as TEdit).selstart := 0;
    (Sender as TEdit).Font.Color := clblack;
  end
  else
  begin
    (Sender as TEdit).Color := clwhite;
    (Sender as TEdit).Font.Color := clgray;
  end;


end;

procedure TFormMiddle.empty;
begin
  LLIegenschaft.Text := '';
  LAuftragsnummer.text := '';
  LNutzernummer.Text := '';
  menotiz.Text := '';
  DTEingangsdatum.Date := now;
  DTMontagedatum.Date := now;
  dtGueltigkeitsdatum.Date := now;
  LLIegenschaft.SetFocus;
end;



procedure TFormMiddle.DateEditPress(Sender: TObject; var Key: Char);

var
  sendr: tnxdatepicker6;
  date: string;
  taste: Char;
  tastestring: string;
  position: integer;
  month: integer;
  day: integer;
begin
  sendr := Sender as tnxdatepicker6;
  sendr.Color := clwhite;
  date := sendr.Text;
  taste := Key;
  key := #0;
  if not (taste in ['0' .. '9', #13, #9]) then // numerisch
    exit;
  tastestring := taste + '';
  position := sendr.SelStart;
  case position of

    0:                                     //erstes Zeichen
      if strtoint(tastestring) < 4 then
      begin
        sendr.Text := Taste + Copy(date, 2, 9);
        sendr.SelStart := 1;
      end
      else
      begin
        sendr.Text := '0' + Taste + Copy(date, 3, 8);
        sendr.SelStart := 3;  // der Punkt darf auch nicht geändert werden
      end;
    1:
      begin
        sendr.Text := Copy(date, 0, 1) + Taste + Copy(date, 3, 8);   // prüfen, ob > 1 erlaubt ist!
        sendr.SelStart :=  3;
      end;
    3:if strtoint(tastestring) < 2 then
      begin
        sendr.Text := Copy(date, 0,3) +  Taste + Copy(date, 5,6);
        sendr.SelStart := 4;
      end
      else if strtoint(tastestring) > 2  then
      begin
        sendr.Text := Copy(date, 0, 3) + '0' +Taste + Copy(date, 6, 5);
        sendr.SelStart := 8;
      end;
    4: begin
        sendr.Text := Copy(date, 0, 4) + Taste  + Copy(date, 6, 5);
        sendr.SelStart := 8;
       end;
    8:
      begin
        sendr.Text := Copy(date, 0, 8) + Taste + Copy(date, 10,1);
        sendr.SelStart := 9;
      end;
    9:
      begin
        sendr.Text := Copy(date,0,9)  + Taste;
        sendr.SelStart := 10;
      end;
    end;
  end;

// Beep bei Systemtasten unterdrücken
 procedure TFormMiddle.WMMenuChar(var MessageRec: TWMMenuChar);
 begin
     inherited;
     if IgnoreOneMenuChar then begin
         MessageRec.Result := MakeLong(0, 1);
         IgnoreOneMenuChar := false;
     end;
 end;

procedure TFormMiddle.LockControl(c: TWinControl; bLock: Boolean);
begin
  if (c = nil) or (c.Handle = 0) then Exit;
  if bLock then
    SendMessage(c.Handle, WM_SETREDRAW, 0, 0)
  else
  begin
    SendMessage(c.Handle, WM_SETREDRAW, 1, 0);
    RedrawWindow(0, nil, 0,
      RDW_ERASE or RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN);
  end;
end;
procedure TFormMiddle.FileListBox1DblClick(Sender: TObject);
var selectedFile: string;
  listBox: TFileListBox;
begin
  listbox := Sender as TFileListBox;
  selectedFile := listBox.FileName;
  FormMain.setFile(selectedFile);

end;

procedure TFormMiddle.FormKeyPress(Sender: TObject; var Key: Char);
 var length: integer;
 begin
  if key = #13 then       // Enter immer speichern lassen
  begin
    if validDate then     // vorausgesetzt das Datum ist legitim
      FormMain.buttonsave(nil);
  end;

  if notizkritzeln then exit;
     if (Sender = Lliegenschaft) or (Sender = LNutzernummer) or
         (Sender = Lauftragsnummer) then
     begin
        Key := ignoreNonNumerics(key);
        exit;
     end;
 end;




procedure TFormMiddle.LabeledEnter(Sender: TObject);
var labed: TLabeledEdit;
begin
  labed := Sender as TLabeledEdit;
  labed.EditLabel.Font.color := dunkelblau;
  labed.EditLabel.Font.Style := [fsbold] + [fsitalic];
  labed.Color := blau;

end;


procedure TFormMiddle.Labeledleave(Sender: TObject);
var labed: TLabeledEdit;
  inhalt: string;
  kundennummer: string;
begin
  labed := (Sender as TLabeledEdit);
  labed.Color := clwhite;
  labed.EditLabel.Font.Color := clgray;
  labed.EditLabel.Font.Style := [];
  
  
   if ( length(lliegenschaft.text) < 7 ) and (length(lliegenschaft.text) > 0)then
  begin
    kundennummer := getKundennummer;
    inhalt := Trim((Sender as TLabeledEDit).Text);
    inhalt := Format('%.2d%.5d',[strtoint(kundennummer),StrToInt(inhalt)]);
    lliegenschaft.Text := inhalt;
  end;
 if length(lnutzernummer.text)> 0 then
    LNutzernummer.text := Format('%.4d',[strtoint(LNutzernummer.text)]);
   if length(lid.text) > 0 then
   begin
     inhalt := Trim(lid.Text);
     inhalt := Format('%.5d',[strtoint(inhalt)]);
     lid.Text := inhalt;
   end;


end;

procedure TFormMiddle.lfileClick(Sender: TObject);
var fop: TFileOPenDialog;
begin
  fop := TFileOpenDialog.create(self);
  if fop.Execute then
  begin
    ShowMessage('File: ' + fop.FileName);
  end;


end;

procedure TFormMiddle.LLIegenschaftKeyPress(Sender: TObject; var Key: Char);
begin

end;

{Notiz verwerfen und Fenster schließen}
procedure TFormMiddle.BCancelClick(Sender: TObject);
begin
  PNotiz.Visible := false;
  MENotiz.Text := '';
  //GPOUter.Visible := true;
  notizkritzeln := False;
end;




procedure TFormMiddle.HighLightLabel(lab: TLabel);
begin
  lab.Font.Color := dunkelblau;
  lab.Font.Style := [fsbold] + [fsItalic];
end;




function TFormMiddle.isvalidDate(date: string): boolean;
var dayofMonth, month: integer;
begin
  dayofMonth := strtoint(Copy(date, 1, 2));
  month := strtoint(Copy(date, 4, 2));
  if not validDayOfMonth(dayOfMonth, month) or not validMonth(month) then
    Result := False
  else Result := true;
end;

function TFormMiddle.validDayOfMonth(day, month: integer): boolean;
begin
  case month of
    2: if day <= 29 then
        Result := True;
    1,3,5,7,8,10,12: if day <= 31 then
                      Result := True;
    4,6,9,11: if day <=30 then
              Result := True;
    else Result := False;
  end;
end;


function TFormMiddle.validmonth(month: integer): boolean;
begin

  if month > 12 then
    Result := False
  else Result := True;

end;

procedure TFormMiddle.BNotizClick(Sender: TObject);
begin
  //GPOUter.Visible := false;
  Pnotiz.Visible  := true;
  notizkritzeln := true;
  MENotiz.SetFocus;
end;


{Fenster schließen und Hauptfenster wieder sichtbar machen}
procedure TFormMiddle.BokClick(Sender: TObject);
begin
  PNotiz.Visible := False;
  //GPOUter.Visible := True;
  notizkritzeln := false;

end;

end.
