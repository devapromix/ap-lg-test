unit Elvion.MediaPlayer;

interface

uses System.Classes, FMX.Media;

type
  TMPlayer = class(TObject)
  private
    FFileName: string;
    procedure SetFileName(const Value: string);
  public
    MediaPlayer: TMediaPlayer;
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    property FileName: string read FFileName write SetFileName;
    procedure Play(const AFileName: string; AFilePath: string = ''); overload;
    procedure Play; overload;
    procedure Click;
    procedure ChPlay;
  end;

implementation

uses System.SysUtils, System.IOUtils, Elvion.Utils, FMX.Dialogs;

{ TPlayer }

procedure TMPlayer.Click;
begin
  Play('click.wav', 'fx\sound\');
end;

constructor TMPlayer.Create(AOwner: TComponent);
begin
  MediaPlayer := TMediaPlayer.Create(AOwner);
end;

destructor TMPlayer.Destroy;
begin
  FreeAndNil(MediaPlayer);
  inherited;
end;

procedure TMPlayer.ChPlay;
begin
  if MediaPlayer.State = TMediaState.Stopped then
    Play;
end;

procedure TMPlayer.Play;
begin
  MediaPlayer.FileName := FileName;
  MediaPlayer.Play;
end;

procedure TMPlayer.Play(const AFileName: string; AFilePath: string = '');
begin
{$IF DEFINED(ANDROID)}
  AFilePath := '';
{$ENDIF}
  FileName := Utils.GetPath + AFilePath + AFileName;
  Play;
end;

procedure TMPlayer.SetFileName(const Value: string);
begin
  FFileName := Value;
end;

end.
