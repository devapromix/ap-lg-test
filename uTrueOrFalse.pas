unit uTrueOrFalse;

interface

uses Classes;

type
  TQEnum = (qeAnswer, qeQuest, qeInfo);

type
  TTrueOrFalse = class(TObject)
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
  TrueOrFalse: TTrueOrFalse;

implementation

{ TTrueOrFalse }

procedure TTrueOrFalse.Add(const S: string);
begin

end;

procedure TTrueOrFalse.Clear;
begin

end;

function TTrueOrFalse.Count: Integer;
begin

end;

constructor TTrueOrFalse.Create;
begin

end;

destructor TTrueOrFalse.Destroy;
begin

  inherited;
end;

function TTrueOrFalse.Get(const QEnum: TQEnum): string;
begin

end;

function TTrueOrFalse.GetFalse: string;
begin

end;

function TTrueOrFalse.GetQuest: string;
begin

end;

function TTrueOrFalse.GetTrue: string;
begin

end;

function TTrueOrFalse.IsFinal: Boolean;
begin

end;

end.
