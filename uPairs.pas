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
    procedure SetField(const X, Y, Index: Integer);
    function GetField(const X, Y: Integer): Integer;
    procedure Gen;
  end;

implementation

uses System.Math;

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

procedure TPairs.Gen;
var
  I, D, C, F, X, Y: Integer;
begin
  D := Width * Height;
  C := 1;
  F := 1;
  for I := 0 to D - 1 do
  begin
    while True do
    begin
      X := RandomRange(0, Width);
      Y := RandomRange(0, Height);
      if FField[X, Y] = 0 then
      begin
        FField[X, Y] := C;
        Inc(F);
        if F > 2 then
        begin
          F := 1;
          Inc(C);
        end;
        Break;
      end;
    end;
  end;
end;

function TPairs.GetField(const X, Y: Integer): Integer;
begin
  Result := FField[X, Y];
end;

function TPairs.Height: Integer;
begin
  Result := FHeight;
end;

procedure TPairs.SetField(const X, Y, Index: Integer);
begin
  FField[X, Y] := Index;
end;

function TPairs.Width: Integer;
begin
  Result := FWidth;
end;

end.
