unit uTrueOrFalse;

interface

uses Classes;

type
  TQEnum = (qeAnswer, qeImage, qeQuest, qeInfo);

type
  TTrueOrFalse = class(TObject)
  private
    procedure Add(const S: string);
  public
    FSL: TStringList;
    Index: Integer;
    Score: Integer;
    constructor Create;
    destructor Destroy; override;
    function Get(const QEnum: TQEnum): string;
    function GetImage: string;
    function GetQuest: string;
    function GetTrue: string;
    function GetFalse: string;
    function Count: Integer;
    function IsFinal: Boolean;
    procedure Clear;
    procedure Load;
    procedure Save;
  end;

var
  TrueOrFalse: TTrueOrFalse;

implementation

uses System.SysUtils, System.Math;

{ TTrueOrFalse }

procedure TTrueOrFalse.Add(const S: string);
begin
  FSL.Append(S);
end;

procedure TTrueOrFalse.Clear;
begin
  Index := 0;
  Score := 0;
end;

function TTrueOrFalse.Count: Integer;
begin
  Result := FSL.Count;
end;

constructor TTrueOrFalse.Create;
begin
  FSL := TStringList.Create;
  Clear;
end;

destructor TTrueOrFalse.Destroy;
begin
  FreeAndNil(FSL);
  inherited;
end;

function TTrueOrFalse.Get(const QEnum: TQEnum): string;
var
  R: TArray<string>;
  S: string;
begin
  S := Trim(FSL[Index]);
  R := S.Split(['|']);
  Result := R[Ord(QEnum)];
end;

function TTrueOrFalse.GetFalse: string;
const
  S: array [0 .. 10] of string = ('Вы ошиблись.', 'И все-таки это правда.',
    'Неправда.', 'Неправильно.', 'Вы подзабыли.', 'В этот раз не повезло.',
    'Вы угадали!', 'Неверно!', 'Вы перепутали.', 'Ошибка!',
    'Какая досадная ошибка!');
begin
  Result := S[RandomRange(0, Length(S))];
end;

function TTrueOrFalse.GetImage: string;
begin
  Result := Get(qeImage);
end;

function TTrueOrFalse.GetQuest: string;
begin
  Result := Get(qeQuest);
end;

function TTrueOrFalse.GetTrue: string;
const
  S: array [0 .. 6] of string = ('Все верно!', 'Это так!', 'Именно так!',
    'Это правда!', 'Невероятно, но это так.', 'Правильно!', 'Вы ответили правильно.');
begin
  Result := S[RandomRange(0, Length(S))];
end;

function TTrueOrFalse.IsFinal: Boolean;
begin
  Result := Index >= Count;
end;

procedure TTrueOrFalse.Load;
var
  SL: TStringList;
  F: string;
begin
  Clear;
  F := GetHomePath + System.SysUtils.PathDelim + 'trueorfalse.sav';
  SL := TStringList.Create;
  try
    if FileExists(F) then
    begin
      SL.LoadFromFile(F, TEncoding.UTF8);
      if SL.Count > 0 then
        Index := StrToInt(SL[0]);
      if SL.Count > 1 then
        Score := StrToInt(SL[1]);
    end;
  finally
    SL.Free;
  end;

end;

procedure TTrueOrFalse.Save;
var
  SL: TStringList;
  F: string;
begin
  F := GetHomePath + System.SysUtils.PathDelim + 'trueorfalse.sav';
  SL := TStringList.Create;
  try
    SL.Append(IntToStr(Index));
    SL.Append(IntToStr(Score));
    SL.SaveToFile(F, TEncoding.UTF8);
  finally
    SL.Free;
  end;
end;

initialization

TrueOrFalse := TTrueOrFalse.Create;

finalization

FreeAndNil(TrueOrFalse);

end.
