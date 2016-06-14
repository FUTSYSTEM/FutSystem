program FutSystem;

uses
  System.StartUpCopy,
  FMX.Forms,
  ULogin in 'ULogin.pas' {FrmLogin},
  UPrincipal in 'UPrincipal.pas' {FrmPrincipal},
  UFuncoes in 'UFuncoes.pas',
  UDMWebService in 'UDMWebService.pas' {DMWebService: TDataModule},
  IWSFutSystem1 in 'IWSFutSystem1.pas',
  UPadrao in 'UPadrao.pas' {FrmPadrao},
  UCadTime in 'UCadTime.pas' {FrmCadTime},
  UCadPartida in 'UCadPartida.pas' {FrmCadPartida},
  UCadAtleta in 'UCadAtleta.pas' {FrmCadAtleta},
  UCadCampo in 'UCadCampo.pas' {FrmCadCampo},
  UPsqPadrao in 'UPsqPadrao.pas' {FrmPsqPadrao},
  UPsqAtletas in 'UPsqAtletas.pas' {FrmPsqAtletas},
  UPsqTimes in 'UPsqTimes.pas' {FrmPsqTimes},
  UPsqCampos in 'UPsqCampos.pas' {FrmPsqCampos},
  UPsqPartidas in 'UPsqPartidas.pas' {FrmPsqPartidas},
  UPsqMeusTimes in 'UPsqMeusTimes.pas' {FrmPsqMeusTimes},
  UPsqAtletasTimes in 'UPsqAtletasTimes.pas' {FrmPsqAtletasTimes};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TDMWebService, DMWebService);
  Application.CreateForm(TFrmPsqAtletasTimes, FrmPsqAtletasTimes);
  Application.Run;
end.
