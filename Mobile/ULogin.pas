unit ULogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Edit, FMX.Layouts;

type
  TFrmLogin = class(TForm)
    Layout1: TLayout;
    Label2: TLabel;
    EdUsuario: TEdit;
    Label3: TLabel;
    EdSenha: TEdit;
    Layout2: TLayout;
    btnEntrar: TButton;
    btnFechar: TButton;
    Layout3: TLayout;
    Label1: TLabel;
    SwTipoUsuario: TSwitch;
    LabelAtleta: TLabel;
    LabelCampo: TLabel;
    lbl1: TLabel;
    btnCriarConta: TButton;
    procedure btnEntrarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SwTipoUsuarioClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.fmx}

uses UPrincipal, UFuncoes, IWSFutSystem1;
{$R *.SmXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.GGlass.fmx ANDROID}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.iPhone4in.fmx IOS}

procedure TFrmLogin.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmLogin.btnEntrarClick(Sender: TObject);
begin
  if  then

  if  not Assigned(FrmPrincipal) then
    FrmPrincipal := TFrmPrincipal.Create(Self);
  if EdSenha.Text = '132513' then
    FrmPrincipal.Show
  else
  begin
    MsgAviso('Senha inv�lida.');
    EdSenha.SetFocus;
  end
end;

procedure TFrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FrmLogin := nil;
end;

procedure TFrmLogin.FormShow(Sender: TObject);
begin
  EdUsuario.Setfocus;
end;

procedure TFrmLogin.SwTipoUsuarioClick(Sender: TObject);
begin
  if SwTipoUsuario.IsChecked then
  begin
    LabelAtleta.TextSettings.Font.Style := [];
    LabelCampo.TextSettings.Font.Style  := [TFontStyle.fsBold];
  end
  else
  begin
    LabelAtleta.TextSettings.Font.Style := [TFontStyle.fsBold];
    LabelCampo.TextSettings.Font.Style  := [];
  end;
end;

end.
