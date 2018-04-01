unit uYesOrNo;

interface

uses Classes;

type
  TYesOrNo = class(TObject)
  private
    FSL: TStringList;
    procedure Add(const S: string);
  public
    Index: Integer;
    constructor Create;
    destructor Destroy; override;
    function GetQuest: string;
    function GetTrue: string;
    function GetFalse: string;
    function Count: Integer;
  end;

var
  YesOrNo: TYesOrNo;

type
  TQEnum = (qeQuest, qeTrue, qeFalse);

implementation

uses SysUtils;

{ TYesOrNo }

procedure TYesOrNo.Add(const S: string);
begin
  FSL.Append(S);
end;

function TYesOrNo.Count: Integer;
begin
  Result := FSL.Count;
end;

constructor TYesOrNo.Create;
begin
  FSL := TStringList.Create;
  Index := 0;
end;

destructor TYesOrNo.Destroy;
begin
  FSL.Free;
  FSL := nil;
  inherited;
end;

function TYesOrNo.GetFalse: string;
var
  R: TArray<string>;
  S: string;
begin
  S := Trim(FSL[Index]);
  R := S.Split(['|']);
  Result := R[Ord(qeFalse)];
end;

function TYesOrNo.GetQuest: string;
var
  R: TArray<string>;
  S: string;
begin
  S := Trim(FSL[Index]);
  R := S.Split(['|']);
  Result := R[Ord(qeQuest)];
end;

function TYesOrNo.GetTrue: string;
var
  R: TArray<string>;
  S: string;
begin
  S := Trim(FSL[Index]);
  R := S.Split(['|']);
  Result := R[Ord(qeTrue)];
end;

initialization

YesOrNo := TYesOrNo.Create;
with YesOrNo do
begin
  Add('Молоко яка желтого цвета.|Все верно.|И все-таки это правда.');
//  Add('||');
end;

finalization

YesOrNo.Free;
YesOrNo := nil;

end.
