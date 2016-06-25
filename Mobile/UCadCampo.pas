unit UCadCampo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UPadrao, FMX.Controls.Presentation, FMX.Layouts, FMX.ListBox, FMX.Edit, IWSFutSystem1;

type
  TFrmCadCampo = class(TFrmPadrao)
    btnSalvar: TButton;
    Label16: TLabel;
    edtObs: TEdit;
    edtResponsavel: TEdit;
    Label15: TLabel;
    edtSenha: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    cbbTipo: TComboBox;
    edtEmail: TEdit;
    Label12: TLabel;
    cbbUF: TComboBox;
    Label10: TLabel;
    Label11: TLabel;
    cbbCidade: TComboBox;
    Label9: TLabel;
    edtCEP: TEdit;
    edtBairro: TEdit;
    Label8: TLabel;
    edtNroEndereco: TEdit;
    Label7: TLabel;
    edtEndereco: TEdit;
    Label6: TLabel;
    edtTelefone: TEdit;
    Label4: TLabel;
    edtNome: TEdit;
    Label1: TLabel;
    Label5: TLabel;
    edtCelular: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbbUFClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure cbbUFChange(Sender: TObject);
    procedure cbbUFExit(Sender: TObject);
  private
    { Private declarations }
    Campo: TCampo;
    Editando : Boolean;
    procedure AtualizarComboCidades;
    procedure LimparDados;
  public
    { Public declarations }
  end;

var
  FrmCadCampo: TFrmCadCampo;

implementation

{$R *.fmx}

uses UDMWebService, UFuncoes;

procedure TFrmCadCampo.AtualizarComboCidades;
begin
  if cbbUF.ItemIndex > -1 then
    DMWebService.CarregarCidades(cbbUF.Items.ValueFromIndex[cbbUF.ItemIndex]);

  //carrega cidades
  DMWebService.fdmCidades.First;
  cbbCidade.Items.Clear;
  while not DMWebService.fdmCidades.Eof do
  begin
    cbbCidade.Items.Add(DMWebService.fdmCidadesCid_Nome.AsString);
    DMWebService.fdmCidades.Next;
  end;
end;

procedure TFrmCadCampo.btnSalvarClick(Sender: TObject);
begin
  inherited;

  DMWebService.fdmCidades.Locate('CID_NOME', cbbCidade.Items.ValueFromIndex[cbbCidade.ItemIndex], []);

  with Campo do
  begin
    Nome         := edtNome.Text;
    Telefone     := edtTelefone.Text;
    Celular      := edtCelular.Text;
    Endereco     := edtEndereco.Text;
    Bairro       := edtBairro.Text;
    NumEndereco  := StrToIntDef(edtNroEndereco.Text, 0);
    CEP          := edtCEP.Text;
    Cid_IBGE     := DMWebService.fdmCidadesCid_IBGE.AsInteger;
    Email        := edtEmail.Text;
    Senha        := edtSenha.Text;
    TipoCampo    := TTipoCampo(cbbTipo.ItemIndex);
    Status       := TStatus.tsAtivo;
    Responsavel  := edtResponsavel.Text;
    Observacao   := edtObs.Text;
  end;

  if DMWebService.SalvarCampos(Campo) then
    Close
  else
    MsgAviso('Falha ao salvar registro. Tente novamente mais tarde.');
end;

procedure TFrmCadCampo.cbbUFChange(Sender: TObject);
begin
  inherited;
  AtualizarComboCidades;
end;

procedure TFrmCadCampo.cbbUFClick(Sender: TObject);
begin
  inherited;
  AtualizarComboCidades;
end;

procedure TFrmCadCampo.cbbUFExit(Sender: TObject);
begin
  inherited;
  AtualizarComboCidades;
end;

procedure TFrmCadCampo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmCadCampo := nil;
end;

procedure TFrmCadCampo.FormCreate(Sender: TObject);
begin
  inherited;
  LimparDados;
end;

procedure TFrmCadCampo.LimparDados;
begin
  Editando      := False;
  if Campo = nil then
    Campo := TCampo.Create;

  DMWebService.CarregarCidades('PR');

  //carrega estados
  DMWebService.fdmEstados.First;
  while not DMWebService.fdmEstados.Eof do
  begin
    cbbUF.Items.Add(DMWebService.fdmEstadosEst_Sigla.AsString);
    DMWebService.fdmEstados.Next;
  end;

  AtualizarComboCidades;

  with Campo do
  begin
    Nome         := EmptyStr;
    Telefone     := EmptyStr;
    Celular      := EmptyStr;
    Endereco     := EmptyStr;
    Bairro       := EmptyStr;
    NumEndereco  := 0;
    CEP          := EmptyStr;
    Cid_IBGE     := 0;
    Email        := EmptyStr;
    Senha        := EmptyStr;
    TipoCampo    := TTipoCampo.tcSociety;
    Status       := TStatus.tsAtivo;
    Responsavel  := EmptyStr;
    Observacao   := EmptyStr;
  end;

  edtNome.Text        := EmptyStr;
  edtTelefone.Text    := EmptyStr;
  edtCelular.TexT     := EmptyStr;
  edtEndereco.Text    := EmptyStr;
  edtNroEndereco.Text := EmptyStr;
  edtBairro.Text      := EmptyStr;
  edtCEP.Text         := EmptyStr;
  cbbUF.ItemIndex     := -1;
  cbbCidade.ItemIndex := -1;
  edtEmail.Text       := EmptyStr;
  edtSenha.Text       := EmptyStr;
  edtResponsavel.Text := EmptyStr;
  edtObs.Text         := EmptyStr;
  cbbTipo.ItemIndex   := -1;
end;

end.
