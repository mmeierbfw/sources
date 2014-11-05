unit ULeftFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, cyBaseSpeedButton, cySpeedButton,
  mxFlatControls, udocs;

  type
  
  TFrame3 = class(TFrame)
    FlowPanel1: TFlowPanel;
    Panel1: TPanel;
    Label4: TLabel;
    RGDocumentType: TmxFlatRadioGroup;
    BScanAndSave: TSpeedButton;


  end;

implementation

{$R *.dfm}

end.
