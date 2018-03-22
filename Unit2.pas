unit Unit2;

interface

uses System.Classes;

type
  TLangEnum = (lgEn, lgTr, lgRu);

type
  TWords = class(TObject)
  private
    FWords: TStringList;
    FCount: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddWord(const S: string);
    procedure Clear;
    function Count: Integer;
    function GetReady: Integer;
    function GetWord(const LangEnum: TLangEnum; const Index: Integer): string;
    function GetCount(const Index: Integer): Integer;
    procedure IncCount(const Index: Integer);
    procedure SetRandom;
    procedure GenWord;
  end;

var
  LastWordIndex: Integer = 0;
  CurrWordIndex: Integer = 0;
  RandWord1Index: Integer = 0;
  RandWord2Index: Integer = 0;
  RandWord3Index: Integer = 0;
  RandWord4Index: Integer = 0;
  RandWord5Index: Integer = 0;
  AnswerIndex: Integer = 0;
  Ready: Integer = 0;
  Errors: Integer = 0;
  WordsMaxCount: Integer = 1;
  IsFinal: Boolean = False;

implementation

uses System.Math, System.SysUtils, Unit4;

{ TWords }

procedure TWords.AddWord(const S: string);
begin
  FWords.Append(S);
  FCount.Append('0');
end;

procedure TWords.Clear;
begin
  LastWordIndex := 0;
  Ready := 0;
  Errors := 0;
  FWords.Clear;
  FCount.Clear;
end;

function TWords.Count: Integer;
begin
  Result := FWords.Count;
end;

constructor TWords.Create;
begin
  LastWordIndex := 0;
  FWords := TStringList.Create;
  FCount := TStringList.Create;
end;

destructor TWords.Destroy;
begin
  FreeAndNil(FWords);
  FreeAndNil(FCount);
  inherited;
end;

procedure TWords.GenWord;
var
  C: Integer;
begin
  C := 0;
  repeat
    CurrWordIndex := RandomRange(0, Count);
    Inc(C);
    if C > 255 then
    begin
      IsFinal := True;
      Break;
    end;
  until (CurrWordIndex <> LastWordIndex) and
    (GetCount(CurrWordIndex) <= WordsMaxCount);
  LastWordIndex := CurrWordIndex;
end;

function TWords.GetCount(const Index: Integer): Integer;
begin
  Result := FCount[Index].ToInteger;
end;

function TWords.GetReady: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    if GetCount(I) > WordsMaxCount then
      Inc(Result);
end;

function TWords.GetWord(const LangEnum: TLangEnum;
  const Index: Integer): string;
var
  S: string;
  R: TArray<string>;
begin
  S := Trim(FWords[Index].ToLower);
  R := S.Split(['|']);
  Result := R[Ord(LangEnum)];
end;

procedure TWords.IncCount(const Index: Integer);
begin
  FCount[Index] := IntToStr(GetCount(Index) + 1);
end;

procedure TWords.SetRandom;
begin
  // Случайное слово
  GenWord;
  //
  if IsFinal then
  begin
    Form4.Show;
    Exit;
  end;
  // Позиция правильного ответа
  AnswerIndex := RandomRange(1, 6);
  // Случайное слово #1
  repeat
    RandWord1Index := RandomRange(0, Count);
  until (RandWord1Index <> CurrWordIndex);
  // Случайное слово #2
  repeat
    RandWord2Index := RandomRange(0, Count);
  until (RandWord2Index <> CurrWordIndex) and
    (RandWord2Index <> RandWord1Index);
  // Случайное слово #3
  repeat
    RandWord3Index := RandomRange(0, Count);
  until (RandWord3Index <> CurrWordIndex) and (RandWord3Index <> RandWord1Index)
    and (RandWord3Index <> RandWord2Index);
  // Случайное слово #4
  repeat
    RandWord4Index := RandomRange(0, Count);
  until (RandWord4Index <> CurrWordIndex) and (RandWord4Index <> RandWord1Index)
    and (RandWord4Index <> RandWord2Index) and
    (RandWord4Index <> RandWord3Index);
  // Случайное слово #5
  repeat
    RandWord5Index := RandomRange(0, Count);
  until (RandWord5Index <> CurrWordIndex) and (RandWord5Index <> RandWord1Index)
    and (RandWord5Index <> RandWord2Index) and
    (RandWord5Index <> RandWord3Index) and (RandWord5Index <> RandWord4Index);
  //
end;

end.
