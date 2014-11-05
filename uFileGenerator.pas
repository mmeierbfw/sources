unit uFileGenerator;

interface


uses
type
  TPathGenerator = class(TObject)
    public
    function createFileName(part1, part2, ending: string):string;
  end;
implementation

{ TPathGenerator }



end.
