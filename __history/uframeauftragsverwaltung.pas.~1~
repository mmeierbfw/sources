unit uframeauftragsverwaltung;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls, fEdit, NxEdit, fMemo, fComboBox, NxCollection,
  Vcl.Mask, umaskedit, System.Generics.collections, uutils, strutils,
  NxPageControl, NxControls6, NxEdit6, Vcl.ComCtrls, NxScrollControl, NxToolBox,
  NxLinkMenu, Vcl.Imaging.pngimage, NxCustomGridControl, NxCustomGrid, NxDBGrid,
  NxColumns, NxDBColumns;

type
  Tframeauftragsdaten = class(TFrame)
    pager: TNxPageControl;
    NxTabSheet1: TNxTabSheet;
    FlowPanel1: TFlowPanel;
    pliegenschaft: TPanel;
    Label7: TLabel;
    lauftragsnummer: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    eliegenschaft: TfEdit;
    fauftragsnummer: TfEdit;
    dperstellungsdatum: TNxDatePicker;
    cbauftragstyp: TfComboBox;
    pauftragsdaten: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    ename1: TfEdit;
    estrasse: TfEdit;
    eort: TfEdit;
    eplz: TfEdit;
    ename2: TfEdit;
    perreichbarkeit: TPanel;
    lnutzername: TLabel;
    lerreichbarkeit: TLabel;
    lemail: TLabel;
    ltelefon: TLabel;
    lnutzernr: TLabel;
    lausfürhung: TLabel;
    enutzername1: TfEdit;
    eemail: TfEdit;
    etelefon: TfEdit;
    enutzernummer: TfEdit;
    pausführung: TPanel;
    ldayOM: TLabel;
    Lmy: TLabel;
    pdivisor: TPanel;
    Button1: TButton;
    pnotizen: TPanel;
    lcharleft: TLabel;
    notizen: TfMemo;
    NxButton1: TNxButton;
    NxButton4: TNxButton;
    NxTabSheet2: TNxTabSheet;
    lvon: TLabel;
    Label4: TLabel;
    perreichtdetails: TPanel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    NxComboBox2: TNxComboBox;
    NxCheckBox62: TNxCheckBox6;
    NxButton8: TNxButton;
    NxButton9: TNxButton;
    NxTabSheet3: TNxTabSheet;
    ptermindetails: TNxPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label3: TLabel;
    mitHA: TCheckBox;
    NxButton2: TNxButton;
    NxButton3: TNxButton;
    nxdate: TNxMonthCalendar;
    externGeplant: TCheckBox;
    einfodate: TfEdit;
    NxMonthCalendar2: TNxMonthCalendar;
    edate: TfEdit;
    evon: TfEdit;
    ebis: TfEdit;
    Label6: TLabel;
    Label15: TLabel;
    NxComboBox1: TNxComboBox;
    Label16: TLabel;
    Label17: TLabel;
    dpabrechnungsende: TNxDatePicker;
    enutzername2: TfEdit;
    NxTimePicker1: TNxTimePicker;
    NxHeaderPanel1: TNxHeaderPanel;
    hptermin: TNxHeaderPanel;
    cbableser: TfComboBox;
    procedure FrameResize(Sender: TObject);
    procedure notizenKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure enutzernummerExit(Sender: TObject);
    procedure eliegenschaftExit(Sender: TObject);
    procedure NxButton2Click(Sender: TObject);
    procedure NxButton3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure nxdateChange(Sender: TObject);
    procedure mitHAClick(Sender: TObject);
    procedure tfdateExit(Sender: TObject);
    procedure NxButton1Click(Sender: TObject);
    procedure NxButton7Click(Sender: TObject);
    procedure NxButton5Click(Sender: TObject);
    procedure NxButton8Click(Sender: TObject);
    procedure tfvonExit(Sender: TObject);
    procedure tfbisExit(Sender: TObject);
    procedure DateTimePicker1KeyPress(Sender: TObject; var Key: Char);
    procedure NxMonthCalendar2Change(Sender: TObject);
    procedure evonExit(Sender: TObject);
    procedure hpterminExpand(Sender: TObject; var Accept: Boolean);
    procedure hpterminCollapse(Sender: TObject; var Accept: Boolean);
    procedure cbableserChange(Sender: TObject);
  private
    writtenchars: integer;
    // function getmonth(monthasstring: string): string;
    procedure createmonthdic;
    function getmonthstring(mon: integer): string;
  public
    function getausführungstermin: string;
    procedure getinshape(panel: TPanel; shape: TShape);
    procedure resetpage;
    { Public-Deklarationen }
  end;

  TDictconstant = array [0 .. 11, 0 .. 1] of string;

const
  abschar = 612;
  dict_constant: TDictconstant = (('Jan', '1'), ('Feb', '2'), ('Mar', '3'),
    ('Apr', '4'),

    ('Mai', '5'), ('Jun', '6'),

    ('Jul', '7'), ('Aug', '8'), ('Sep', '9'), ('Okt', '10'), ('Nov', '11'),
    ('Dez', '12'));

const
  charlefttext = 'Noch %d Zeichen übrig';

var
  monthdict: TDictionary<string, string>;

implementation

uses umain;
{$R *.dfm}
{ Tframeauftragsdaten }

procedure Tframeauftragsdaten.Button1Click(Sender: TObject);
begin
  pager.ActivePage := NxTabSheet3;
  ptermindetails.show;
  ptermindetails.Align := TAlign.alClient;
  try edate.SetFocus;
  except
    ;

  end;
  edate.Text := DateToStr(nxdate.SelectedDate);
end;

procedure Tframeauftragsdaten.mitHAClick(Sender: TObject);
var
  enable: boolean;
begin
  enable := not(externGeplant.Checked or mitHA.Checked);
  nxdate.Enabled := enable;

  evon.Enabled := enable;
  ebis.Enabled := enable;
  edate.Enabled := enable;
  if Sender = externGeplant then begin
    mitHA.Checked := false;
  end else begin
    externGeplant.Checked := false;
  end;
end;

procedure Tframeauftragsdaten.cbableserChange(Sender: TObject);
begin
//  hpmonteurtermine.Expanded := true;
end;

procedure Tframeauftragsdaten.createmonthdic;
var
  // dict: TDictionary<string, string>;
  index: integer;
begin
  if assigned(monthdict) then exit;
  monthdict := TDictionary<string, string>.create();
  for index := 0 to high(dict_constant) do begin
    monthdict.Add(dict_constant[index][0], dict_constant[index][1]);
  end;

end;

procedure Tframeauftragsdaten.DateTimePicker1KeyPress(Sender: TObject;
  var Key: Char);
var
  test: string;

begin

end;

procedure Tframeauftragsdaten.eliegenschaftExit(Sender: TObject);
var
  len: integer;
  lg: string;
  kunde: string;
begin
  lg := eliegenschaft.Text;
  if length(lg) = 0 then exit;
  kunde := formmain.getkundennummer;
  if (length(lg) <= 5) then begin
    len := length(kunde);
    len := 7 - len;
    lg := kunde + StringOfChar('0', len - length(lg)) + lg;
    eliegenschaft.Text := lg;
  end;
end;

procedure Tframeauftragsdaten.enutzernummerExit(Sender: TObject);
begin
  // enutzernummer.Text := Format('%.3d', [strtoint(enutzerummer.text)]);
  try enutzernummer.Text := Format('%.3d', [strtoint(enutzernummer.Text)]);
  except enutzernummer.Text := Format('%.3d', [0]);
  end;
end;

procedure Tframeauftragsdaten.evonExit(Sender: TObject);
var time: string;
begin
  time := (sender as tfedit).Text;
  if not length(time) = 4 then exit;
  time := copy(time, 1, 2) + ':' + copy(time, 3,2);
  (Sender as tfedit).Text := time;

end;

procedure Tframeauftragsdaten.FrameResize(Sender: TObject);
begin
  // getinshape(pauftragsdaten, shapeauftrag);
  // getinshape(perreichbarkeit, Shapeerreichbarkeit);
end;

function Tframeauftragsdaten.getausführungstermin: string;
var
  d, m, y: integer;
  helper: string;
begin
  createmonthdic;
  y := strtoint(copy(Lmy.Caption, 7, 2));
  helper := copy(Lmy.Caption, 1, 3);
  m := strtoint(monthdict.Items[helper]);
  d := strtoint(ldayOM.Caption);
  Result := inttostr(y) + '.' + Format('%.2d', [m]) + '.' +
    Format('%0.2d', [d]);

end;

procedure Tframeauftragsdaten.getinshape(panel: TPanel; shape: TShape);
begin
  shape.Left := panel.Left - 1;
  shape.Top := panel.Top - 1;
  shape.Height := panel.Height + 2;
  shape.Width := panel.Width + 2;
end;
//
// function Tframeauftragsdaten.getmonth(monthasstring: string): string;
// begin
// createmonthdic;
// monthdict.Keys.ToArray[mon]
// end;

function Tframeauftragsdaten.getmonthstring(mon: integer): string;
var
  // list: Tlist<string>;
  helper1, helper2: string;
  elem: string;
begin
  createmonthdic;
  for elem in monthdict.Keys do begin
    if monthdict.Items[elem] = inttostr(mon) then begin
      Result := elem;
      exit;
    end;
  end;
end;

procedure Tframeauftragsdaten.notizenKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  charleft: integer;
begin
  Inc(writtenchars);
  charleft := abschar - writtenchars;
  lcharleft.Caption := Format(charlefttext, [charleft]);

end;

procedure Tframeauftragsdaten.NxButton1Click(Sender: TObject);
begin
  resetpage;
end;

procedure Tframeauftragsdaten.NxButton2Click(Sender: TObject);
var
  date: Tdate;
  jahr, monat, tag: Word;
begin
  if mitHA.Checked then begin
    ldayOM.Caption := '';

    Lmy.Caption := '';
    lvon.Caption := 'mit Hauptablesung';
    lvon.Alignment := TAlignment.taRightJustify;
    lvon.Left := 0;
    pager.ActivePage := NxTabSheet1;
    pdivisor.Visible := false;
    exit;
  end;
  if externGeplant.Checked then begin
    ldayOM.Caption := '';
    Lmy.Caption := '';
    lvon.Caption := 'extern geplant';
    lvon.Alignment := TAlignment.taRightJustify;
    pdivisor.Visible := false;
    lvon.Left := 0;
    pager.ActivePage := NxTabSheet1;
    exit;
  end;
  createmonthdic;
  date := nxdate.SelectedDate;
  DecodeDate(date, jahr, monat, tag);
  pdivisor.Visible := true;
  Lmy.Caption := getmonthstring(monat) + ' ' + inttostr(jahr);
  ldayOM.Caption := inttostr(tag);
  if AnsiStartsText('  ', evon.Text) then begin
    lvon.Visible := false;
//    lbis.Visible := false;
    pager.ActivePage := NxTabSheet1;
    // ptermindetails.Hide;
    exit;
  end;

  if not(AnsiStartsText('  ', ebis.Text)) then begin
    lvon.Caption := 'von ' + evon.Text;
//    lbis.Caption := 'bis  ' + ebis.Text;
//    lbis.Visible := true;
    lvon.Alignment := TAlignment.taLeftJustify;
//    lbis.Alignment := TAlignment.taLeftJustify;
    lvon.Left := 67;
//    lbis.Left := 67;
  end else begin
    lvon.Alignment := TAlignment.taCenter;
    // lbis.Alignment := TAlignment.taLeftJustify;
    lvon.Caption := evon.Text;
//    lbis.Visible := false;
    lvon.Left := 90;
  end;
  pager.ActivePage := NxTabSheet1;
end;

procedure Tframeauftragsdaten.NxButton3Click(Sender: TObject);
begin
  pager.ActivePage := NxTabSheet1;
end;

procedure Tframeauftragsdaten.NxButton5Click(Sender: TObject);
begin
  pager.ActivePage := NxTabSheet2;
  // perreichtdetails.Align:=TAlign.alClient;
  // perreichtdetails.show;
end;

procedure Tframeauftragsdaten.NxButton7Click(Sender: TObject);
begin
  pager.ActivePage := NxTabSheet1;
end;

procedure Tframeauftragsdaten.NxButton8Click(Sender: TObject);
begin
  // perreichtdetails.Hide;
  pager.ActivePage := NxTabSheet1;
end;

procedure Tframeauftragsdaten.nxdateChange(Sender: TObject);
begin
  edate.Text := DateToStr(nxdate.SelectedDate);
  try evon.SetFocus;
  except

  end;
end;

procedure Tframeauftragsdaten.hpterminCollapse(Sender: TObject;
  var Accept: Boolean);
var hp: TNxHeaderPanel;
begin
  hp := (Sender as TNxHeaderPanel);
  hp.Align := TAlign.alNone;
  hp.Height := 20;
  hp.Width := 29;
  hp.Left := 19;

end;

procedure Tframeauftragsdaten.hpterminExpand(Sender: TObject;
  var Accept: Boolean);
begin
  (Sender as TNxHeaderPanel).Align := TAlign.alClient;
end;

procedure Tframeauftragsdaten.NxMonthCalendar2Change(Sender: TObject);
var
  datestring: string;
begin
  datestring := DateToStr(NxMonthCalendar2.SelectedDate);
  datestring := formatedatefrom4jto2j(datestring);
  einfodate.Text := datestring;
end;

procedure Tframeauftragsdaten.resetpage;
var
  todstring: string;
begin
  createmonthdic;
  eliegenschaft.Clear;
  fauftragsnummer.Clear;
  ename1.Clear;
  ename2.Clear;
  dperstellungsdatum.Clear;
  dpabrechnungsende.Clear;
  cbauftragstyp.Clear;
  estrasse.Clear;
  eort.Clear;
  eplz.Clear;
  enutzernummer.Clear;
  enutzername1.Clear;
  enutzername2.Clear;
  eemail.Clear;
  etelefon.Clear;
  cbauftragstyp.Clear;
  notizen.Clear;
  todstring := DateToStr(now);
  ldayOM.Caption := copy(todstring, 1, 2);
  Lmy.Caption := getmonthstring(strtoint(copy(todstring, 4, 2))) + ' ' +
    copy(todstring, 7, 4);
  dperstellungsdatum.Text := DateToStr(now);

end;

procedure Tframeauftragsdaten.tfbisExit(Sender: TObject);
begin
  if (Sender as tfmaskedit).Text = ' :  ' then exit;

end;

procedure Tframeauftragsdaten.tfdateExit(Sender: TObject);
var

  day, month, year: integer;
  Mask: TMaskEdit;
  date: string;
  valid: boolean;
begin
  valid := true;
  Mask := Sender as TMaskEdit;
  date := Mask.Text;
  if AnsiStartsText('  ', date) or AnsiStartsText('__', date) then exit;

  day := strtoint(trimright(copy(date, 0, 2)));
  month := strtoint(trimright(copy(date, 4, 2)));
  year := strtoint(trimright(copy(date, 7, 4)));

  if (month < 1) or (month > 12) then begin
    valid := false;
  end;
  if day < 0 then begin
    valid := false;
  end;
  case month of
    1, 3, 5, 7, 8, 12: if day > 31 then begin
        valid := false;
      end;
    2: if day > 29 then begin
        valid := false;
      end;
    4, 6, 9, 11: if day > 30 then begin
        valid := false;
      end;
  end;
  if not valid then begin
    Mask.Color := clred;
    try Mask.SetFocus;
    except

    end;
    Mask.SelStart := 0;
  end
  else Mask.Color := clWhite;

  try
    nxdate.date := strtodate(edate.Text);
    nxdate.Update;
  except
    ;
  end;

end;

procedure Tframeauftragsdaten.tfvonExit(Sender: TObject);
begin
  if (Sender as tfmaskedit).Text = '  .  ' then exit;

end;

end.
