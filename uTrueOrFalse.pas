unit uTrueOrFalse;

interface

uses Classes;

const
  CurrVersionFilePref = 'ckbvkfascl';

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
    procedure LoadFromFile(FileName: string);
    function GetImage: string;
    function GetQuest: string;
    function GetTrue: string;
    function GetFalse: string;
    function GetText: string;
    function Count: Integer;
    function IsFinal: Boolean;
    function BaseFileName: string;
    function TempFileName: string;
    function SaveFileName: string;
    procedure Random;
    procedure Clear;
    procedure Load;
    procedure Save;
    procedure New;
  end;

implementation

uses System.SysUtils, System.Math, uCommon;

{ TTrueOrFalse }

procedure TTrueOrFalse.Add(const S: string);
begin
  FSL.Append(S);
end;

function TTrueOrFalse.BaseFileName: string;
begin
  Result := GetPath + 'trueorfalse.txt';
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
end;

destructor TTrueOrFalse.Destroy;
begin
  FreeAndNil(FSL);
  inherited;
end;

type
  TExplodeResult = array of string;

function Explode(const Separator: Char; Source: string): TExplodeResult;
var
  I: Integer;
  S: string;
begin
  S := Source;
  SetLength(Result, 0);
  I := 0;
  while Pos(Separator, S) > 0 do
  begin
    SetLength(Result, Length(Result) + 1);
    Result[I] := Copy(S, 1, Pos(Separator, S) - 1);
    Inc(I);
    S := Copy(S, Pos(Separator, S) + Length(Separator), Length(S));
  end;
  SetLength(Result, Length(Result) + 1);
  Result[I] := Copy(S, 1, Length(S));
end;

function TTrueOrFalse.Get(const QEnum: TQEnum): string;
var
  R: TExplodeResult;
  S: string;
begin
  S := Trim(FSL[Index]);
  if S = '' then
  begin
    Result := '';
    Exit;
  end;
  R := Explode('|', S);
  Result := Trim(R[Ord(QEnum)]);
end;

function TTrueOrFalse.GetFalse: string;
const
  S: array [0 .. 19] of string = ('Вы ошиблись.', 'И все-таки это правда.',
    'Неправда.', 'Неправильно.', 'Вы подзабыли.', 'В этот раз не повезло.',
    'Вы не угадали!', 'Неверно!', 'Вы перепутали.', 'Ошибка!',
    'Какая досадная ошибка!', 'Нет, что вы!', 'Разумеется, нет.',
    'Конечно, нет!', 'Нет.', 'На самом деле это неправда!',
    'Увы, ваш ответ неверен.', 'Ой, ошибка.', 'Не угадали!',
    'Увы, ответ неправильный.');
begin
  Result := S[RandomRange(0, Length(S))];
end;

function TTrueOrFalse.GetText: string;
begin
  if Get(qeInfo) = '' then
    Result := Get(qeQuest).Replace('?', '.')
  else
    Result := Get(qeInfo);
end;

function TTrueOrFalse.GetTrue: string;
const
  S: array [0 .. 19] of string = ('Верно!', 'Да!', 'Да, это так!', 'Все верно!',
    'Это так!', 'Именно так!', 'Это правда!', 'Невероятно, но это так.',
    'Правильно!', 'Конечно!', 'Действительно!', 'Абсолютно верно!',
    'Это, и правда, так!', 'Это, действительно, так!', 'Вы ответили правильно.',
    'Правда!', 'Вы абсолютно правы!', 'Вы совершенно правы!', 'Вы угадали!',
    'Вы правы.');
begin
  Result := S[RandomRange(0, Length(S))];
end;

function TTrueOrFalse.GetImage: string;
begin
  Result := Get(qeImage);
  if Result = '' then
    Result := 'question-mark.jpg';
end;

function TTrueOrFalse.GetQuest: string;
begin
  Result := Get(qeQuest);
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
  F := SaveFileName;
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
    FreeAndNil(SL);
  end;
end;

procedure TTrueOrFalse.LoadFromFile(FileName: string);
begin
  FSL.LoadFromFile(FileName, TEncoding.UTF8);
end;

procedure TTrueOrFalse.New;
begin
  Clear;
  LoadFromFile(BaseFileName);
  Random;
end;

procedure TTrueOrFalse.Random;
var
  I, A, B: Integer;
  S: string;
begin
  for I := 0 to FSL.Count div 2 do
  begin
    A := RandomRange(0, FSL.Count);
    B := RandomRange(0, FSL.Count);
    if A = B then
      Continue;
    S := FSL[A];
    FSL[A] := FSL[B];
    FSL[B] := S;
  end;
end;

procedure TTrueOrFalse.Save;
var
  SL: TStringList;
  F: string;
begin
  F := SaveFileName;
  SL := TStringList.Create;
  try
    SL.Append(IntToStr(Index));
    SL.Append(IntToStr(Score));
    SL.SaveToFile(F, TEncoding.UTF8);
  finally
    FreeAndNil(SL);
  end;
  F := TempFileName;
  FSL.SaveToFile(F, TEncoding.UTF8);
end;

function TTrueOrFalse.SaveFileName: string;
begin
  Result := GetHomePath + PathDelim + CurrVersionFilePref + 'trueorfalse.sav';
end;

function TTrueOrFalse.TempFileName: string;
begin
  Result := GetHomePath + PathDelim + CurrVersionFilePref + 'trueorfalse.txt';
end;

end.
