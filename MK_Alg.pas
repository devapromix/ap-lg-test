unit MK_Alg;

interface

type
  TAlgor = class(TObject)
  private
    FP1: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Run;
    property P1: string read FP1;
  end;

implementation

uses
  SysUtils, Dialogs;

{ TAlgor }

constructor TAlgor.Create;
begin

end;

destructor TAlgor.Destroy;
begin

  inherited;
end;

procedure TAlgor.Run;
begin

end;

end.
