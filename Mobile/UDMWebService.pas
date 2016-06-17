unit UDMWebService;

interface

uses
  System.SysUtils, System.Classes, Soap.InvokeRegistry, Soap.Rio,
  Soap.SOAPHTTPClient, IWSFutSystem1, UFuncoes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.DBClient, Data.FireDACJSONReflect;

type
  TDMWebService = class(TDataModule)
    HTTPRIO1: THTTPRIO;
    fdmTimes: TFDMemTable;
    fdmTimesTim_Codigo: TIntegerField;
    fdmTimesTim_Nome: TStringField;
    fdmTimesTim_DataFundacao: TDateField;
    fdmTimesAtl_Codigo: TIntegerField;
    fdmAtletas: TFDMemTable;
    fdmAtletasAtl_Codigo: TIntegerField;
    fdmAtletasAtl_NomeCompleto: TStringField;
    fdmCidades: TFDMemTable;
    fdmEstados: TFDMemTable;
    fdmEstadosEst_Codigo: TIntegerField;
    fdmEstadosEst_Nome: TStringField;
    fdmEstadosEst_Sigla: TStringField;
    fdmCidadesCid_IBGE: TIntegerField;
    fdmCidadesCid_Nome: TStringField;
    fdmCidadesEst_Codigo: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    //procedimentos que buscam dados do webservice
    procedure CarregarAtletas();
    procedure CarregarCampos();
    procedure CarregarCidades();
    procedure CarregarEstados();
    procedure CarregarPartidas();
    procedure CarregarPartidasAtletas();
    procedure CarregarTimes();
    procedure CarregarTimesAtletas();
    function  ValidaLogin( Email, Senha: string; TipoLogin: TTipoLogin): Boolean;

    //fun��es que enviam dados ao webservice
    function SalvarAtletas(Atleta: TAtleta): Boolean;
    function SalvarCampos(Campo: TCampo): Boolean;
    function SalvarPartida(Partida: TPartida): Boolean;
    function SalvarPartidaAtletas(ListaAtletas: TListPartidasAtletas): Boolean;
    function SalvarTime(Time: TTimes): Boolean;
    function SalvarTimeAtletas(ListaAtletas: TListTimesAtletas): Boolean;
  end;

var
  DMWebService: TDMWebService;
  Usuario : TUsuario;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}


{$R *.dfm}

function TDMWebService.SalvarAtletas(Atleta: TAtleta): Boolean;
begin

end;

function TDMWebService.SalvarCampos(Campo: TCampo): Boolean;
begin

end;

function TDMWebService.SalvarPartida(Partida: TPartida): Boolean;
begin

end;

function TDMWebService.SalvarPartidaAtletas(
  ListaAtletas: TListPartidasAtletas): Boolean;
begin

end;

function TDMWebService.SalvarTime(Time: TTimes): Boolean;
var
  WS : IWSFutSystem;  //vari�vel webservice
begin
  try
    Result := False;
    WS     := HTTPRIO1 as IWSFutSystem;
    if Time <> nil then
    begin
      WS.SetTime(Time);
      Result := True;
    end;
  except
    on e: Exception do
       InterpretaMsgErro(e.Message);
  end;
end;

procedure TDMWebService.CarregarAtletas;
var
  ListaAtletas : TListAtletas;
  WS         : IWSFutSystem;  //vari�vel webservice
  I: Integer;
begin
  try
    if fdmAtletas.RecordCount > 0 then
      fdmAtletas.EmptyDataSet;
    WS         := HTTPRIO1 as IWSFutSystem;
    ListaAtletas := WS.GetAtletas();

    for I := Low(ListaAtletas) to High(ListaAtletas) do
    begin
      fdmAtletas.Append;
      fdmAtletasAtl_Codigo.AsInteger     := ListaAtletas[I].Codigo;
      fdmAtletasAtl_NomeCompleto.AsString:= ListaAtletas[I].NomeCompleto;
      fdmAtletas.Post;
    end;
    Finalize(ListaAtletas);
  except
    on e: Exception do
       InterpretaMsgErro(e.Message);
  end;
end;

procedure TDMWebService.CarregarCampos;
begin

end;

procedure TDMWebService.CarregarCidades;
var
  ListaCidades : TListCidades;
  WS         : IWSFutSystem;  //vari�vel webservice
  I: Integer;
begin
  try
    if fdmCidades.RecordCount > 0 then
      fdmCidades.EmptyDataSet;
    WS         := HTTPRIO1 as IWSFutSystem;
    ListaCidades := WS.GetCidades('PR');

    for I := Low(ListaCidades) to High(ListaCidades) do
    begin
      fdmCidades.Append;
      fdmCidadesCid_IBGE.AsInteger    := ListaCidades[I].Codigo;
      fdmCidadesCid_Nome.AsString     := ListaCidades[I].Nome;
      fdmCidadesEst_Codigo.AsInteger  := ListaCidades[I].Est_Codigo;
      fdmCidades.Post;
    end;
    Finalize(ListaCidades);
  except
    on e: Exception do
       InterpretaMsgErro(e.Message);
  end;
end;

procedure TDMWebService.CarregarEstados;
var
  ListaEstados : TListEstados;
  WS         : IWSFutSystem;  //vari�vel webservice
  I: Integer;
begin
  try
    if fdmEstados.RecordCount > 0 then
      fdmEstados.EmptyDataSet;
    WS         := HTTPRIO1 as IWSFutSystem;
    ListaEstados := WS.GetEstados;

    for I := Low(ListaEstados) to High(ListaEstados) do
    begin
      fdmEstados.Append;
      fdmEstadosEst_Codigo.AsInteger:= ListaEstados[I].Codigo;
      fdmEstadosEst_Nome.AsString   := ListaEstados[I].Nome;
      fdmEstadosEst_Sigla.AsString  := ListaEstados[I].Sigla;
      fdmEstados.Post;
    end;
    Finalize(ListaEstados);
  except
    on e: Exception do
       InterpretaMsgErro(e.Message);
  end;
end;

procedure TDMWebService.CarregarPartidas;
begin

end;

procedure TDMWebService.CarregarPartidasAtletas;
begin

end;

function TDMWebService.SalvarTimeAtletas(
  ListaAtletas: TListTimesAtletas): Boolean;
begin

end;

procedure TDMWebService.CarregarTimes;
var
  ListaTimes : TListTimes;
  WS         : IWSFutSystem;  //vari�vel webservice
  I: Integer;
begin
  try
    if fdmTimes.RecordCount > 0 then
      fdmTimes.EmptyDataSet;
    WS         := HTTPRIO1 as IWSFutSystem;
    ListaTimes := WS.GetTimes();

    for I := Low(ListaTimes) to High(ListaTimes) do
    begin
      fdmTimes.Append;
      fdmTimesTim_Codigo.AsInteger       := ListaTimes[I].Codigo;
      fdmTimesTim_Nome.AsString          := ListaTimes[I].Nome;
      fdmTimesTim_DataFundacao.AsDateTime:= ListaTimes[I].DataFundacao;
      fdmTimesAtl_Codigo.AsInteger       := ListaTimes[I].Atl_Codigo;
      fdmTimes.Post;
    end;
    fdmTimes.ApplyUpdates(0);
    Finalize(ListaTimes);
  except
    on e: Exception do
       InterpretaMsgErro(e.Message);
  end;
end;

procedure TDMWebService.CarregarTimesAtletas;
begin

end;

procedure TDMWebService.DataModuleCreate(Sender: TObject);
begin
  fdmTimes.CreateDataSet;
  fdmAtletas.CreateDataSet;
end;

function TDMWebService.ValidaLogin(Email, Senha: string;
  TipoLogin: TTipoLogin): Boolean;
var
  Retorno : Integer;
  Atleta  : TAtleta;
  Campo   : TCampo;
  WS      : IWSFutSystem;  //vari�vel webservice
begin
  try
    WS      := HTTPRIO1 as IWSFutSystem;
    Retorno := 0;

    Retorno := WS.ValidaLogin(Email, Senha, TipoLogin);
    if Retorno > 0 then
    begin
      //pesquisa dados do usu�rio
      Usuario.LimparDados;

      if TipoLogin = TTipoLogin.tlAtleta then
      begin
        Atleta := TListAtletas(WS.GetAtletas(Retorno))[0];

        Usuario.Codigo    := Atleta.Codigo;
        Usuario.NomeAcesso:= Atleta.NomeCompleto;
      end
      else
      begin
        Campo  := TListCampos(WS.GetCampos(Retorno))[0];

        Usuario.Codigo    := Campo.Codigo;
        Usuario.NomeAcesso:= Campo.Nome;
      end;
      Usuario.TipoLogin := TipoLogin;

      Result := True;
    end
    else
      Result := False;
  except
    on e: Exception do
       InterpretaMsgErro(e.Message);
  end;
end;

end.
