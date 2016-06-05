program FutSystem;

uses
  System.StartUpCopy,
  FMX.Forms,
  ULogin in 'ULogin.pas' {FrmLogin},
  UPrincipal in 'UPrincipal.pas' {FrmPrincipal},
  UFuncoes in 'UFuncoes.pas',
  IWSFutSystem1 in 'IWSFutSystem1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
