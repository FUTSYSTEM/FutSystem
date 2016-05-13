unit UDModulo;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.Client, Vcl.Forms, System.IniFiles, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDModulo = class(TDataModule)
    fdcConexao: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    fdqAuxiliar: TFDQuery;
    fdqGerador: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    //CONEXÃO
    function ConectarBD: Boolean;

    //BASES DE DADOS
    procedure DBCommit;
    procedure DBRollback;
    procedure DBStartTrans;
    function  RetornaProxCodigo(Tabela, Campo: string): Integer;
  end;

var
  DModulo: TDModulo;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UFuncoes;

{$R *.dfm}

{ TDataModule1 }

function TDModulo.ConectarBD: Boolean;
var
  Arq: TIniFile;
begin
  try
    Result:= False;

    Arq:= TIniFile.Create(ExtractFilePath(Application.ExeName) +'WSFutSystem.ini');

    if not Arq.ValueExists('SERVER', 'Host') then
      Arq.WriteString('SERVER', 'Host', 'localhost');

    if not Arq.ValueExists('SERVER', 'Database') then
      Arq.WriteString('SERVER', 'Database', 'futsystem');

    if not Arq.ValueExists('SERVER', 'User') then
      Arq.WriteString('SERVER', 'User', 'root');

    if not Arq.ValueExists('SERVER', 'Password') then
      Arq.WriteString('SERVER', 'Password', '123');

    if not Arq.ValueExists('SERVER', 'Porta') then
      Arq.WriteInteger('SERVER', 'Porta', 3306);

    //Banco de dados
    with fdcConexao do
    begin
      Close;
      Params.Clear;
      Params.Add('database='+ Arq.ReadString('SERVER', 'Database', ''));
      Params.Add('drivername='+ DriverName);
      Params.Add('SERVER='+ Arq.ReadString('SERVER', 'Host', ''));
      Params.Add('user_name='+ Arq.ReadString('SERVER', 'User', ''));
      Params.Add('password='+ Arq.ReadString('SERVER', 'Password', ''));
      Params.Add('port=' + IntToStr(Arq.ReadInteger('SERVER', 'Porta', 0)));
      Params.DriverID := 'MySQL';
      Open();

      Arq.Free;
      Connected := False;
      Connected := True;
    end;

    if fdcConexao.Connected then
      Result:= True;
  except

  end;
end;

procedure TDModulo.DataModuleCreate(Sender: TObject);
begin
  if not ConectarBD then
  begin
    MsgAviso('Falha ao conectar com o banco de dados.');
    Application.Terminate;
  end;
end;

procedure TDModulo.DBCommit;
begin
  fdcConexao.Commit;
end;

procedure TDModulo.DBRollback;
begin
  fdcConexao.Rollback;
end;

procedure TDModulo.DBStartTrans;
begin
  if not fdcConexao.InTransaction then
    fdcConexao.StartTransaction;
end;

function TDModulo.RetornaProxCodigo(Tabela, Campo: string): Integer;
begin
  Result:= 0;

  with fdqGerador do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT MAX(' + Campo +') + 1 AS CODIGO');
    SQL.Add('FROM ' + Tabela);
    Open();
    if not IsEmpty then
      Result := FieldByName('CODIGO').AsInteger;
  end;
end;

end.
