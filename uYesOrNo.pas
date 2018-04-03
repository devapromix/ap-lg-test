unit uYesOrNo;

interface

uses Classes;

type
  TQEnum = (qeAnswer, qeQuest, qeInfo);

type
  TYesOrNo = class(TObject)
  private
    FSL: TStringList;
    procedure Add(const S: string);
  public
    Index: Integer;
    Score: Integer;
    constructor Create;
    destructor Destroy; override;
    function Get(const QEnum: TQEnum): string;
    function GetQuest: string;
    function GetTrue: string;
    function GetFalse: string;
    function Count: Integer;
    function IsFinal: Boolean;
    procedure Clear;
  end;

var
  YesOrNo: TYesOrNo;

implementation

uses SysUtils, Math;

{ TYesOrNo }

procedure TYesOrNo.Add(const S: string);
begin
  FSL.Append(S);
end;

procedure TYesOrNo.Clear;
begin
  Index := 0;
  Score := 0;
end;

function TYesOrNo.Count: Integer;
begin
  Result := FSL.Count;
end;

constructor TYesOrNo.Create;
begin
  FSL := TStringList.Create;
  Clear;
end;

destructor TYesOrNo.Destroy;
begin
  FSL.Free;
  FSL := nil;
  inherited;
end;

function TYesOrNo.Get(const QEnum: TQEnum): string;
var
  R: TArray<string>;
  S: string;
begin
  S := Trim(FSL[Index]);
  R := S.Split(['|']);
  Result := R[Ord(QEnum)];
end;

function TYesOrNo.GetFalse: string;
const
  S: array [0 .. 2] of string = ('Вы ошиблись!', 'И все-таки это правда!',
    'Неправда!');
begin
  Result := S[RandomRange(0, Length(S))];
end;

function TYesOrNo.GetQuest: string;
begin
  Result := Get(qeQuest);
end;

function TYesOrNo.GetTrue: string;
const
  S: array [0 .. 3] of string = ('Все верно!', 'Это так!', 'Именно так!', 'Это правда!');
begin
  Result := S[RandomRange(0, Length(S))];
end;

function TYesOrNo.IsFinal: Boolean;
begin
  Result := Index >= Count;
end;

initialization

YesOrNo := TYesOrNo.Create;
with YesOrNo do
begin
  Add('True|Молоко бегемота желтого цвета?|Смешиваясь с потом, молоко самки бегемота приобретает желтый цвет.');
  Add('False|Синие киты дышат жабрами?|Все млекопитающие дышат легкими и у них жабры отсутствуют. Киты - млекопитающие, ведущие водный образ жизни.');
  Add('False|"Сентябрь" переводится с латыни как "восьмой"?|Слово "Сентябрь" означает седьмой. В древности год начинался в марте. Поэтому сентябрь был седьмым месяцем.');
  // Add('||');
end;

finalization

YesOrNo.Free;
YesOrNo := nil;

end.
