unit uframedpanel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls;

type
  Tframedpanel = class(TForm)
    Panel1: TPanel;
    Shape1: TShape;
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  framedpanel: Tframedpanel;

implementation

{$R *.dfm}

procedure Tframedpanel.FormCreate(Sender: TObject);
begin
  Shape1.Height := Panel1.Height + 2;
  Shape1.Width := Panel1.Width + 2;
  Shape1.Left := Panel1.Left  - 1;
  Shape1.Top := Panel1.Top -1;
end;

end.
