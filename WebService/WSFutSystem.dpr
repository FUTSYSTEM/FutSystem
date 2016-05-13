program WSFutSystem;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  UFrmPrincipal in 'UFrmPrincipal.pas' {FrmPrincipal},
  WebModulo in 'WebModulo.pas' {WebModule1: TWebModule},
  WSFutSystemImpl in 'WSFutSystemImpl.pas',
  WSFutSystemIntf in 'WSFutSystemIntf.pas',
  UDMDados in 'UDMDados.pas' {DMDados: TSoapDataModule},
  UFuncoes in 'UFuncoes.pas',
  UDModulo in 'UDModulo.pas' {DModulo: TDataModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TDModulo, DModulo);
  Application.Run;
end.
