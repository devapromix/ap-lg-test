unit uPairs;

interface

type
  TPairs = class(TObject)
  private
    FField: array of array of Integer;
    FWidth: Integer;
    FHeight: Integer;
  public
    constructor Create(const Width, Height: Integer);
    destructor Destroy; override;
    function Width: Integer;
    function Height: Integer;
    procedure Clear;
  end;

implementation

{ TPairs }

procedure TPairs.Clear;
var
  X, Y: Integer;
begin
  for Y := 0 to Height - 1 do
    for X := 0 to Width - 1 do
      FField[X, Y] := 0;
end;

constructor TPairs.Create(const Width, Height: Integer);
begin
  FWidth := Width;
  FHeight := Height;
  SetLength(FField, Width, Height);
  Self.Clear;
end;

destructor TPairs.Destroy;
begin

  inherited;
end;

function TPairs.Height: Integer;
begin
  Result := FHeight;
end;

function TPairs.Width: Integer;
begin
  Result := FWidth;
end;

end.
