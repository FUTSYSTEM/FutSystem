unit UDMWebService;

interface

uses
  System.SysUtils, System.Classes, Soap.InvokeRegistry, Soap.Rio,
  Soap.SOAPHTTPClient, IWSFutSystem1, UFuncoes;

type
  TDMWebService = class(TDataModule)
    HTTPRIO1: THTTPRIO;
  private
    { Private declarations }
  public
    { Public declarations }
    function ValidaLogin( Email, Senha: string; TipoLogin: TTipoLogin): Boolean;
  end;

var
  DMWebService: TDMWebService;
  Usuario : TUsuario;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}


{$R *.dfm}

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