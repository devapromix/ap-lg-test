unit MK_Alg;

interface

uses
  Classes;

type
  TUState = (usNone, usTrue, usFalse);

type
  TAlgor = class(TObject)
  private
    FN: Byte;
    FNN: array [1 .. 255] of string;
    FP1: string;
    FP2: string;
    FP3: string;
    FP4: string;
    FP5: string;
    FP6: string;
    FP7: string;
    FP8: string;
    FU1: string;
    FU2: string;
    FIsU2: TUState;
    FIsU1: TUState;
    FLog: TStringList;
    FNMax: Byte;
  public
    constructor Create;
    destructor Destroy; override;
    procedure EvalP(const Code: string);
    function EvalU1(const Code: string): Boolean;
    function EvalU2(const Code: string): Boolean;
    function EvalN: Boolean;
    procedure EvalNN;
    procedure Run;
    procedure SetNN(const I: Integer; const Code: string);
    function GetNN(const I: Integer): string;
    property N: Byte read FN write FN;
    property NMax: Byte read FNMax write FNMax;
    property P1: string read FP1 write FP1;
    property P2: string read FP2 write FP2;
    property P3: string read FP3 write FP3;
    property P4: string read FP4 write FP4;
    property P5: string read FP5 write FP5;
    property P6: string read FP6 write FP6;
    property P7: string read FP7 write FP7;
    property P8: string read FP8 write FP8;
    property U1: string read FU1 write FU1;
    property U2: string read FU2 write FU2;
    property IsU1: TUState read FIsU1 write FIsU1;
    property IsU2: TUState read FIsU2 write FIsU2;
    function GetLog: string;
  end;

implementation

uses
  SysUtils;

{ TAlgor }

constructor TAlgor.Create;
var
  I: Byte;
begin
  N := 1;
  NMax := 1;
  FIsU1 := usNone;
  FIsU2 := usNone;
  for I := 1 to 255 do
    FNN[I] := '';
  FLog := TStringList.Create;
end;

destructor TAlgor.Destroy;
begin
  FreeAndNil(FLog);
  inherited;
end;

function TAlgor.EvalN: Boolean;
begin
  Result := False;

end;

procedure TAlgor.EvalNN;
var
  Code: string;
begin
  Code := Trim(FNN[FN]);
  FLog.Append(Code);
end;

procedure TAlgor.EvalP(const Code: string);
begin
  FLog.Append(Code);
end;

function TAlgor.EvalU1(const Code: string): Boolean;
begin
  Result := False;
  case FIsU1 of
    usNone:
      FLog.Append(Code);
    usTrue:
      Result := True;
    usFalse:
      Result := False;
  end;
end;

function TAlgor.EvalU2(const Code: string): Boolean;
begin
  Result := True;
  case FIsU2 of
    usNone:
      FLog.Append(Code);
    usTrue:
      Result := False;
    usFalse:
      Result := True;
  end;
end;

function TAlgor.GetLog: string;
begin
  Result := FLog.Text;
end;

function TAlgor.GetNN(const I: Integer): string;
begin
  Result := FNN[I];
end;

procedure TAlgor.Run;
label
  lab1, lab2;
begin
  EvalP(P1);
lab1:
  EvalP(P2);
  if EvalU1(U1) then
  begin
    EvalP(P3);
    if (N < 1) or (N > NMax) then
    begin
      EvalP(P6);
      goto lab2;
    end;

    begin
      EvalNN;
    end;

    EvalP(P4);
    if EvalU2(U2) then
      goto lab1;
    EvalP(P7);
  end
  else
    EvalP(P5);
lab2:
  EvalP(P8);
end;

procedure TAlgor.SetNN(const I: Integer; const Code: string);
begin
  FNN[I] := Trim(Code);
end;

end.
