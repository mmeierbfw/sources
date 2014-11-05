unit FlowGroupPanel;

interface

uses
  SysUtils, Classes, Controls, ExtCtrls;

type
  TGroupLinkPanel = class(TFlowPanel)
  private
    fclicked: boolean;
  protected
    { Protected-Deklarationen }
  public
    procedure setClicked(clicked: boolean);
    property clicked: boolean read fclicked write setClicked;
  published
    { Published-Deklarationen }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Templates', [TGroupLinkPanel]);
end;

{ TGroupLinkPanel }

procedure TGroupLinkPanel.setClicked(clicked: boolean);
begin
  fclicked := clicked;
end;

end.
