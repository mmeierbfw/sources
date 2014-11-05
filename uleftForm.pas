unit uleftForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, mxFlatControls, StdCtrls, ExtCtrls;

type
  TFormLeft = class(TForm)
    FlowPanel1: TFlowPanel;
    Panel1: TPanel;
    Label4: TLabel;
    BScanAndSave: TSpeedButton;
    PDocs: TFlowPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    procedure Label1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label1MouseLeave(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
  
    fchosenDoc: Integer;
    procedure highlight(lab: TLabel);
    procedure unhighlight(lab: TLabel);
    procedure fatten(lab: TLabel);
  public
    procedure setChosenDoc(index: integer);
    property chosenDoc: Integer read fchosenDOc write setChosenDoc;
  end;



var
  FormLeft: TFormLeft;

implementation

{$R *.dfm}

procedure TFormLeft.fatten(lab: TLabel);
begin
  lab.Font.Style := [fsbold];
  lab.Font.Color := clWebWhite;
end;

procedure TFormLeft.highlight(lab: TLabel);
begin
  lab.Font.Color := clWebWhite;
  lab.Font.Style := [fsUnderline];
end;

procedure TFormLeft.Label1Click(Sender: TObject);
var selected: TLabel;
    size, cnt: Integer;
begin
  size := PDocs.ControlCount;
  for cnt := 0 to size - 1 do begin
    selected := PDocs.Controls[cnt] as TLabel;
    if fsbold in selected.Font.Style then
      unhighlight(selected);
      break;
  end;

  selected := Sender as TLabel;
  fatten(selected);
  setChosenDoc(selected.Tag);
end;

procedure TFormLeft.Label1MouseLeave(Sender: TObject);
var selected: TLabel;
begin
  selected := Sender as TLabel;
  if not (fsbold in selected.Font.Style) then
    unhighlight(selected);
end;

procedure TFormLeft.Label1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);

var selected: TLabel;
begin
  selected := Sender as TLabel;
  if not (fsbold in selected.Font.Style) then
    highlight(selected);

end;

procedure TFormLeft.setChosenDoc(index: integer);
begin
  fchosenDoc := index;
end;

procedure TFormLeft.unhighlight(lab: TLabel);
begin
  lab.Font.Color := clgray;
  lab.Font.Style := [];
end;

end.
