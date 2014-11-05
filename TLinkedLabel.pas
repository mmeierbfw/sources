unit uLinkedLabel;

interface

uses
  SysUtils, Classes, Controls, StdCtrls;

type
  TLinkedLabel = class(TLabel)
  private
    test: boolean;
    { Private-Deklarationen }
  protected
    { Protected-Deklarationen }
  public
    Constructor Create(AOwner: TComponent); override;
  published
    { Published-Deklarationen }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TLinkedLabel]);
end;

{ TLinkedLabel }

constructor TLinkedLabel.Create(AOwner: TComponent);// Methode des Vorfahrn ausführen
begin
  inherited Create(AOwner);
  TLinkedLabel.font.Color := clwebwhite;

end;

end.
