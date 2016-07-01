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
    fdmAtletasAtl_DataNasc: TDateField;
    fdmAtletasAtl_Sexo: TStringField;
    fdmAtletasAtl_Telefone: TStringField;
    fdmAtletasAtl_Celular: TStringField;
    fdmAtletasAtl_Endereco: TStringField;
    fdmAtletasAtl_Bairro: TStringField;
    fdmAtletasAtl_NumEndereco: TIntegerField;
    fdmAtletasAtl_CEP: TStringField;
    fdmAtletasCid_IBGE: TIntegerField;
    fdmAtletasAtl_Email: TStringField;
    fdmAtletasAtl_Senha: TStringField;
    fdmAtletasAtl_Posicao: TIntegerField;
    fdmAtletasAtl_Status: TStringField;
    fdmAtletasAtl_Caracteristica: TStringField;
    fdmAtletasAtl_Obs: TStringField;
    fdmTimesAtletas: TFDMemTable;
    fdmTimesAtletasTim_Codigo: TIntegerField;
    fdmTimesAtletasAtl_Codigo: TIntegerField;
    fdmCampos: TFDMemTable;
    fdmCamposCam_Codigo: TIntegerField;
    fdmCamposCam_Nome: TStringField;
    fdmCamposCam_Endereco: TStringField;
    fdmCamposCam_NumEndereco: TIntegerField;
    fdmCamposCam_Bairro: TStringField;
    fdmCamposCam_CEP: TStringField;
    fdmCamposCid_IBGE: TIntegerField;
    fdmCamposCam_Email: TStringField;
    fdmCamposCam_Senha: TStringField;
    fdmCamposCam_TipoCampo: TIntegerField;
    fdmCamposCam_Telefone: TStringField;
    fdmCamposCam_Celular: TStringField;
    fdmCamposCam_Obs: TStringField;
    fdmCamposCam_Responsavel: TStringField;
    fdmCamposCam_Status: TStringField;
    fdmPartidas: TFDMemTable;
    fdmPartidasPar_Codigo: TIntegerField;
    fdmPartidasPar_Data: TDateField;
    fdmPartidasPar_Horario: TTimeField;
    fdmPartidasCam_Codigo: TIntegerField;
    fdmPartidasPar_Status: TStringField;
    fdmPartidasPar_TimeA: TIntegerField;
    fdmPartidasPar_TimeB: TIntegerField;
    fdmPartidasAtletas: TFDMemTable;
    fdmPartidasAtletasPar_Codigo: TIntegerField;
    fdmPartidasAtletasTim_Codigo: TIntegerField;
    fdmPartidasAtletasAtl_Codigo: TIntegerField;
    fdmPartidasAtletasPta_Compareceu: TStringField;
    fdmPartidasAtletasPta_Gols: TIntegerField;
    fdmPartidasAtletasPta_CAmarelos: TIntegerField;
    fdmPartidasAtletasPta_CVermelhos: TIntegerField;
    fdmPartidasAtletasPta_Assistencias: TIntegerField;
    fdmAtletasEst_Codigo: TIntegerField;
    fdmCamposEst_Codigo: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    //procedimentos que buscam dados do webservice
    procedure CarregarAtletas(const Atl_Codigo: Integer = 0);
    procedure CarregarCampos(const Cam_Codigo: Integer = 0);
    procedure CarregarCidades(UF: string);
    procedure CarregarEstados();
    procedure CarregarPartidas(const Atl_Codigo: Integer = 0; const Par_Codigo: Integer = 0);
    procedure CarregarPartidasAtletas(Par_Codigo: Integer);
    procedure CarregarTimes(const Tim_Codigo: Integer = 0);
    procedure CarregarTimesAtletas(const Tim_Codigo: Integer = 0; const Atl_Codigo: Integer = 0);
    function  ValidaLogin( Email, Senha: string; TipoLogin: TTipoLogin): Boolean;

    //fun��es que enviam dados ao webservice
    function SalvarAtletas(Atleta: TAtleta): Boolean;
    function SalvarCampos(Campo: TCampo): Boolean;
    function SalvarPartida(Partida: TPartida): Boolean;
    function SalvarPartidaAtletas(ListaAtletas: TListPartidasAtletas): Boolean;
    function SalvarTime(Time: TTimes): Integer;
    function SalvarTimeAtletas(ListaAtletas: TListTimesAtletas): Boolean;

    //apagar
    function DeletarTimesAtletas(Tim_Codigo: Integer): Boolean;
  end;

var
  DMWebService: TDMWebService;
  Usuario : TUsuario;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}


{$R *.dfm}

function TDMWebService.SalvarAtletas(Atleta: TAtleta): Boolean;
var
  WS : IWSFutSystem;  //vari�vel webservice
begin
  try
    Result := False;
    WS     := HTTPRIO1 as IWSFutSystem;
    if Atleta <> nil then
    begin
      WS.SetAtleta(Atleta);
      Result := True;
    end;
  except
    on e: Exception do
       InterpretaMsgErro(e.Message);
  end;
end;

function TDMWebService.SalvarCampos(Campo: TCampo): Boolean;
var
  WS : IWSFutSystem;  //vari�vel webservice
begin
  try
    Result := False;
    WS     := HTTPRIO1 as IWSFutSystem;
    if Campo <> nil then
    begin
      WS.SetCampo(Campo);
      Result := True;
    end;
  except
    on e: Exception do
       InterpretaMsgErro(e.Message);
  end;
end;

function TDMWebService.SalvarPartida(Partida: TPartida): Boolean;
var
  WS : IWSFutSystem;  //vari�vel webservice
begin
  try
    Result := False;
    WS     := HTTPRIO1 as IWSFutSystem;
    if Partida <> nil then
    begin
      WS.SetPartida(Partida);
      Result := True;
    end;
  except
    on e: Exception do
       InterpretaMsgErro(e.Message);
  end;
end;

function TDMWebService.SalvarPartidaAtletas(
  ListaAtletas: TListPartidasAtletas): Boolean;
var
  WS : IWSFutSystem;  //vari�vel webservice
begin
  try
    Result := False;
    WS     := HTTPRIO1 as IWSFutSystem;
    if ListaAtletas <> nil then
    begin
      WS.SetPartidaAtletas(ListaAtletas);
      Result := True;
    end;
  except
    on e: Exception do
       InterpretaMsgErro(e.Message);
  end;
end;

function TDMWebService.SalvarTime(Time: TTimes): Integer;
var
  WS : IWSFutSystem;  //vari�vel webservice
begin
  try
    Result := 0;
    WS     := HTTPRIO1 as IWSFutSystem;
    if Time <> nil then
      Result := WS.SetTime(Time);
  except
    on e: Exception do
       InterpretaMsgErro(e.Message);
  end;
end;

procedure TDMWebService.CarregarAtletas(const Atl_Codigo: Integer = 0);
var
  ListaAtletas : TListAtletas;
  WS         : IWSFutSystem;  //vari�vel webservice
  I: Integer;
begin
  try
    if fdmAtletas.RecordCount > 0 then
      fdmAtletas.EmptyDataSet;
    WS         := HTTPRIO1 as IWSFutSystem;
    ListaAtletas := WS.GetAtletas(Atl_Codigo);

    for I := Low(ListaAtletas) to High(ListaAtletas) do
    begin
      fdmAtletas.Append;
      fdmAtletasAtl_Codigo.AsInteger       := ListaAtletas[I].Codigo;
      fdmAtletasAtl_NomeCompleto.AsString  := ListaAtletas[I].NomeCompleto;
      fdmAtletasAtl_DataNasc.AsDateTime    := ListaAtletas[I].DataNasc;
      fdmAtletasAtl_Sexo.AsString          := iif(ListaAtletas[I].Sexo = TSexo.tsMasculino, 'M', 'F');
      fdmAtletasAtl_Telefone.AsString      := ListaAtletas[I].Telefone;
      fdmAtletasAtl_Celular.AsString       := ListaAtletas[I].Celular;
      fdmAtletasAtl_Endereco.AsString      := ListaAtletas[I].Endereco;
      fdmAtletasAtl_NumEndereco.AsInteger  := ListaAtletas[I].NumEndereco;
      fdmAtletasAtl_Bairro.AsString        := ListaAtletas[I].Bairro;
      fdmAtletasAtl_CEP.AsString           := ListaAtletas[I].CEP;
      fdmAtletasEst_Codigo.AsInteger       := ListaAtletas[I].Est_Codigo;
      fdmAtletasCid_IBGE.AsInteger         := ListaAtletas[I].Cid_IBGE;
      fdmAtletasAtl_Email.AsString         := ListaAtletas[I].Email;
      fdmAtletasAtl_Senha.AsString         := ListaAtletas[I].Senha;
      fdmAtletasAtl_Posicao.AsInteger      := Ord(ListaAtletas[I].Posicao);
      fdmAtletasAtl_Status.AsString        := iif(ListaAtletas[I].Status = TStatus.tsAtivo, 'A', 'I');
      fdmAtletasAtl_Caracteristica.AsString:= ListaAtletas[I].Caracteristicas;
      fdmAtletasAtl_Obs.AsString           := ListaAtletas[I].Observacao;
      fdmAtletas.Post;
    end;
    Finalize(ListaAtletas);
  except
    on e: Exception do
       InterpretaMsgErro(e.Message);
  end;
end;

procedure TDMWebService.CarregarCampos(const Cam_Codigo: Integer = 0);
var
  ListaCampos : TListCampos;
  WS         : IWSFutSystem;  //vari�vel webservice
  I: Integer;
begin
  try
    if fdmCampos.RecordCount > 0 then
      fdmCampos.EmptyDataSet;
    WS         := HTTPRIO1 as IWSFutSystem;
    ListaCampos := WS.GetCampos(Cam_Codigo);

    for I := Low(ListaCampos) to High(ListaCampos) do
    begin
      fdmCampos.Append;
      fdmCamposCam_Codigo.AsInteger        := ListaCampos[I].Codigo;
      fdmCamposCam_Nome.AsString           := ListaCampos[I].Nome;
      fdmCamposCam_Endereco.AsString       := ListaCampos[I].Endereco;
      fdmCamposCam_NumEndereco.AsInteger   := ListaCampos[I].NumEndereco;
      fdmCamposCam_Telefone.AsString       := ListaCampos[I].Telefone;
      fdmCamposCam_Celular.AsString        := ListaCampos[I].Celular;
      fdmCamposCam_Bairro.AsString         := ListaCampos[I].Bairro;
      fdmCamposCam_CEP.AsString            := ListaCampos[I].CEP;
      fdmCamposEst_Codigo.AsInteger        := ListaCampos[I].Est_Codigo;
      fdmCamposCid_IBGE.AsInteger          := ListaCampos[I].Cid_IBGE;
      fdmCamposCam_Email.AsString          := ListaCampos[I].Email;
      fdmCamposCam_Senha.AsString          := ListaCampos[I].Senha;
      fdmCamposCam_TipoCampo.AsInteger     := Ord(ListaCampos[I].TipoCampo);
      fdmCamposCam_Status.AsString         := iif(ListaCampos[I].Status = TStatus.tsAtivo, 'A', 'I');
      fdmCamposCam_Responsavel.AsString    := ListaCampos[I].Responsavel;
      fdmCamposCam_Obs.AsString            := ListaCampos[I].Observacao;
      fdmCampos.Post;
    end;
    Finalize(ListaCampos);
  except
    on e: Exception do
       InterpretaMsgErro(e.Message);
  end;
end;

procedure TDMWebService.CarregarCidades(UF: string);
var
  ListaCidades : TListCidades;
  WS         : IWSFutSystem;  //vari�vel webservice
  I: Integer;
begin
  try
    if fdmCidades.RecordCount > 0 then
      fdmCidades.EmptyDataSet;
    WS         := HTTPRIO1 as IWSFutSystem;
    ListaCidades := WS.GetCidades(UF);

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

procedure TDMWebService.CarregarPartidas(const Atl_Codigo: Integer = 0; const Par_Codigo: Integer = 0);
var
  ListaPartidas : TListPartidas;
  WS         : IWSFutSystem;  //vari�vel webservice
  I: Integer;
begin
  try
    if fdmPartidas.RecordCount > 0 then
      fdmPartidas.EmptyDataSet;
    WS         := HTTPRIO1 as IWSFutSystem;
    ListaPartidas := WS.GetPartidas(Atl_Codigo, Par_Codigo);

    for I := Low(ListaPartidas) to High(ListaPartidas) do
    begin
      fdmPartidas.Append;
      fdmPartidasPar_Codigo.AsInteger  := ListaPartidas[I].Codigo;
      fdmPartidasPar_Data.AsDateTime   := ListaPartidas[I].Data;
      fdmPartidasPar_Horario.AsDateTime:= ListaPartidas[I].Horario;
      fdmPartidasCam_Codigo.AsInteger  := ListaPartidas[I].Cam_Codigo;
      fdmPartidasPar_Status.AsString   := iif(ListaPartidas[I].Status = TStatus.tsAtivo, 'A', 'I');
      fdmPartidasPar_TimeA.AsInteger   := ListaPartidas[I].TimeA;
      fdmPartidasPar_TimeB.AsInteger   := ListaPartidas[I].TimeB;
      fdmPartidas.Post;
    end;
    Finalize(ListaPartidas);
  except
    on e: Exception do
       InterpretaMsgErro(e.Message);
  end;
end;

procedure TDMWebService.CarregarPartidasAtletas(Par_Codigo: Integer);
var
  ListaAtletas : TListPartidasAtletas;
  WS         : IWSFutSystem;  //vari�vel webservice
  I: Integer;
begin
  try
    if fdmPartidasAtletas.RecordCount > 0 then
      fdmPartidasAtletas.EmptyDataSet;
    WS           := HTTPRIO1 as IWSFutSystem;
    ListaAtletas := WS.GetPartidasAtletas(Par_Codigo);

    for I := Low(ListaAtletas) to High(ListaAtletas) do
    begin
      fdmPartidasAtletas.Append;
      fdmPartidasAtletasAtl_Codigo.AsInteger       := ListaAtletas[I].Atl_Codigo;
      fdmPartidasAtletasTim_Codigo.AsInteger       := ListaAtletas[I].Tim_Codigo;
      fdmPartidasAtletasPar_Codigo.AsInteger       := ListaAtletas[I].Par_Codigo;
      fdmPartidasAtletasPta_Gols.AsInteger         := ListaAtletas[I].Gols;
      fdmPartidasAtletasPta_Assistencias.AsInteger := ListaAtletas[I].Assistencias;
      fdmPartidasAtletasPta_CAmarelos.AsInteger    := ListaAtletas[I].CartAmarelo;
      fdmPartidasAtletasPta_CVermelhos.AsInteger   := ListaAtletas[I].CartVermelho;
      fdmPartidasAtletasPta_Compareceu.AsString    := iif( ListaAtletas[I].Compareceu, 'S', 'N');
      fdmPartidasAtletas.Post;
    end;
    Finalize(ListaAtletas);
  except
    on e: Exception do
       InterpretaMsgErro(e.Message);
  end;
end;

function TDMWebService.SalvarTimeAtletas(
  ListaAtletas: TListTimesAtletas): Boolean;
var
  WS : IWSFutSystem;  //vari�vel webservice
begin
  try
    Result := False;
    WS     := HTTPRIO1 as IWSFutSystem;
    WS.SetTimeAtletas(ListaAtletas);
    Result := True;
  except
    on e: Exception do
       InterpretaMsgErro(e.Message);
  end;
end;

procedure TDMWebService.CarregarTimes(const Tim_Codigo: Integer = 0);
var
  ListaTimes : TListTimes;
  WS         : IWSFutSystem;  //vari�vel webservice
  I: Integer;
begin
  try
    if fdmTimes.RecordCount > 0 then
      fdmTimes.EmptyDataSet;
    WS         := HTTPRIO1 as IWSFutSystem;
    ListaTimes := WS.GetTimes(Tim_Codigo);

    for I := Low(ListaTimes) to High(ListaTimes) do
    begin
      fdmTimes.Append;
      fdmTimesTim_Codigo.AsInteger       := ListaTimes[I].Codigo;
      fdmTimesTim_Nome.AsString          := ListaTimes[I].Nome;
      fdmTimesTim_DataFundacao.AsDateTime:= ListaTimes[I].DataFundacao;
      fdmTimesAtl_Codigo.AsInteger       := ListaTimes[I].Atl_Codigo;
      fdmTimes.Post;
    end;
    Finalize(ListaTimes);
  except
    on e: Exception do
       InterpretaMsgErro(e.Message);
  end;
end;

procedure TDMWebService.CarregarTimesAtletas(const Tim_Codigo: Integer = 0; const Atl_Codigo: Integer = 0);
var
  ListaAtletas : TListTimesAtletas;
  WS         : IWSFutSystem;  //vari�vel webservice
  I: Integer;
begin
  try
    if fdmTimesAtletas.RecordCount > 0 then
      fdmTimesAtletas.EmptyDataSet;
    WS           := HTTPRIO1 as IWSFutSystem;
    ListaAtletas := WS.GetTimesAtletas(Tim_Codigo, Atl_Codigo);

    for I := Low(ListaAtletas) to High(ListaAtletas) do
    begin
      if ListaAtletas[I] <> nil then
      begin
        fdmTimesAtletas.Append;
        fdmTimesAtletasAtl_Codigo.AsInteger := ListaAtletas[I].Atl_Codigo;
        fdmTimesAtletasTim_Codigo.AsInteger := ListaAtletas[I].Tim_Codigo;
        fdmTimesAtletas.Post;
      end;
    end;
    Finalize(ListaAtletas);
  except
    on e: Exception do
       InterpretaMsgErro(e.Message);
  end;
end;

procedure TDMWebService.DataModuleCreate(Sender: TObject);
begin
  fdmTimes.CreateDataSet;
  fdmAtletas.CreateDataSet;
  fdmCidades.CreateDataSet;
  fdmEstados.CreateDataSet;
  fdmCampos.CreateDataSet;
  fdmTimesAtletas.CreateDataSet;
  fdmPartidas.CreateDataSet;
  fdmPartidasAtletas.CreateDataSet;

  CarregarEstados;
end;

function TDMWebService.DeletarTimesAtletas(Tim_Codigo: Integer): Boolean;
var
  WS : IWSFutSystem;  //vari�vel webservice
begin
  try
    Result := False;
    WS     := HTTPRIO1 as IWSFutSystem;
    WS.DeleteTimeAtleta(Tim_Codigo);
    Result := True;
  except
    on e: Exception do
       InterpretaMsgErro(e.Message);
  end;
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
