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
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Campo: TCampo;
    procedure AtualizarComboCidades;
    procedure AtualizarComboEstados;
    procedure CarregarDados;
    procedure LimparDados;
    procedure DesabilitarCampos;
    function  ValidarCampos: Boolean;
  public
    { Public declarations }
    CodCampo : Integer;
    Editando, ApenasVisualizar : Boolean;
  end;

var
  FrmCadCampo: TFrmCadCampo;

implementation

{$R *.fmx}

uses UDMWebService, UFuncoes;

procedure TFrmCadCampo.AtualizarComboCidades;
begin
  if cbbUF.ItemIndex > -1 then
    DMWebService.CarregarCidades(cbbUF.Items[cbbUF.ItemIndex]);

  //carrega cidades
  DMWebService.fdmCidades.First;
  cbbCidade.Items.Clear;
  while not DMWebService.fdmCidades.Eof do
  begin
    cbbCidade.Items.Add(DMWebService.fdmCidadesCid_Nome.AsString);
    DMWebService.fdmCidades.Next;
  end;
end;

procedure TFrmCadCampo.AtualizarComboEstados;
begin
  DMWebService.CarregarEstados;
  //carrega estados
  DMWebService.fdmEstados.First;
  while not DMWebService.fdmEstados.Eof do
  begin
    cbbUF.Items.Add(DMWebService.fdmEstadosEst_Sigla.AsString);
    DMWebService.fdmEstados.Next;
  end;
end;

procedure TFrmCadCampo.btnSalvarClick(Sender: TObject);
begin
  inherited;
  if not ValidarCampos then
    Exit;

  //localiza estado
  DMWebService.fdmEstados.Locate('Est_Sigla',  cbbUF.Items.ValueFromIndex[cbbUF.ItemIndex], []);

  //localiza cidade
  DMWebService.fdmCidades.Filter   := ' Est_Codigo = ' +  DMWebService.fdmEstadosEst_Codigo.AsString;
  DMWebService.fdmEstados.Filtered := True;
  DMWebService.fdmCidades.Locate('Cid_Nome', cbbCidade.Items[cbbCidade.ItemIndex], []);
  DMWebService.fdmCidades.Filter   := EmptyStr;
  DMWebService.fdmEstados.Filtered := false;

  with Campo do
  begin
    Nome        := edtNome.Text;
    Telefone    := edtTelefone.Text;
    Celular     := edtCelular.Text;
    Endereco    := edtEndereco.Text;
    Bairro      := edtBairro.Text;
    NumEndereco := StrToIntDef(edtNroEndereco.Text, 0);
    CEP         := edtCEP.Text;
    Cid_IBGE    := DMWebService.fdmCidadesCid_IBGE.AsInteger;
    Email       := edtEmail.Text;
    Senha       := edtSenha.Text;
    TipoCampo   := TTipoCampo(cbbTipo.ItemIndex);
    Status      := TStatus.tsAtivo;
    Responsavel := edtResponsavel.Text;
    Observacao  := edtObs.Text;
  end;

  if DMWebService.SalvarCampos(Campo) then
    Close
  else
    MsgAviso('Falha ao salvar registro. Tente novamente mais tarde.');
end;

procedure TFrmCadCampo.CarregarDados;
begin
  if CodCampo > 0 then
    DMWebService.CarregarCampos(CodCampo)
  else
    DMWebService.CarregarCampos(Usuario.Codigo);

  Campo.Codigo        := Usuario.Codigo;
  edtNome.Text        := DMWebService.fdmCamposCam_Nome.AsString;
  edtTelefone.Text    := DMWebService.fdmCamposCam_Telefone.AsString;
  edtCelular.Text     := DMWebService.fdmCamposCam_Celular.AsString;
  edtEndereco.Text    := DMWebService.fdmCamposCam_Endereco.AsString;
  edtNroEndereco.Text := DMWebService.fdmCamposCam_NumEndereco.AsString;
  edtBairro.Text      := DMWebService.fdmCamposCam_Bairro.AsString;
  edtCEP.Text         := DMWebService.fdmCamposCam_CEP.AsString;

  AtualizarComboEstados;
  DMWebService.fdmEstados.Locate('Est_Codigo', DMWebService.fdmCamposEst_Codigo.AsInteger, []);
  cbbUF.ItemIndex     := cbbUF.Items.IndexOf(DMWebService.fdmEstadosEst_Sigla.AsString);

  AtualizarComboCidades;
  DMWebService.fdmCidades.Locate('Cid_IBGE', DMWebService.fdmCamposCid_IBGE.AsInteger, []);

  cbbCidade.ItemIndex := cbbCidade.Items.IndexOf(DMWebService.fdmCidadesCid_Nome.AsString);
  edtEmail.Text       := DMWebService.fdmCamposCam_Email.AsString;
  edtSenha.Text       := DMWebService.fdmCamposCam_Senha.AsString;
  cbbTipo.ItemIndex   := DMWebService.fdmCamposCam_TipoCampo.AsInteger;
  edtResponsavel.Text := DMWebService.fdmCamposCam_Responsavel.AsString;
  edtObs.Text         := DMWebService.fdmCamposCam_Obs.AsString;
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

procedure TFrmCadCampo.DesabilitarCampos;
begin
  edtNome.Enabled        := False;
  edtTelefone.Enabled    := False;
  edtCelular.Enabled     := False;
  edtEndereco.Enabled    := False;
  edtNroEndereco.Enabled := False;
  edtBairro.Enabled      := False;
  edtCEP.Enabled         := False;
  cbbUF.Enabled          := False;
  cbbCidade.Enabled      := False;
  edtEmail.Enabled       := False;
  edtSenha.Enabled       := False;
  edtResponsavel.Enabled := False;
  edtObs.Enabled         := False;
  cbbTipo.Enabled        := False;
  btnSalvar.Visible      := False;
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

procedure TFrmCadCampo.FormShow(Sender: TObject);
begin
  inherited;
  if Editando then
    CarregarDados;
  if ApenasVisualizar then
    DesabilitarCampos;
end;

procedure TFrmCadCampo.LimparDados;
begin
  Editando        := False;
  ApenasVisualizar:= False;
  if Campo = nil then
    Campo := TCampo.Create;

  AtualizarComboEstados;

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
  CodCampo            := 0;
end;

function TFrmCadCampo.ValidarCampos: Boolean;
begin
  Result := False;

  //valida nome
  if edtNome.Text.IsEmpty then
  begin
    MsgAviso('Informe o nome do seu estabelecimento.');
    edtNome.SetFocus;
    Exit;
  end;

  //valida data de nascimento
  if edtTelefone.Text.IsEmpty then
  begin
    MsgAviso('Informe o telefone do seu estabelecimento.');
    edtTelefone.SetFocus;
    Exit;
  end;

  //valida UF
  if cbbUF.ItemIndex = -1 then
  begin
    MsgAviso('Selecione seu estado de residência.');
    cbbUF.SetFocus;
    Exit;
  end;

  //valida cidade
  if cbbCidade.ItemIndex = -1 then
  begin
    MsgAviso('Selecione sua cidade de residência.');
    cbbCidade.SetFocus;
    Exit;
  end;

  //valida email
  if edtEmail.Text.IsEmpty then
  begin
    MsgAviso('Informe seu e-mail.');
    edtEmail.SetFocus;
    Exit;
  end;

  //valida senha
  if edtSenha.Text.IsEmpty then
  begin
    MsgAviso('Informe a senha do usuário.');
    edtSenha.SetFocus;
    Exit;
  end;

  //valida tipo
  if cbbTipo.ItemIndex = -1 then
  begin
    MsgAviso('Selecione o tipo do estabelecimento.');
    cbbTipo.SetFocus;
    Exit;
  end;

  //valida responsavel
  if edtResponsavel.Text.IsEmpty then
  begin
    MsgAviso('Informe o nome do responsável pelo estabelecimento.');
    edtResponsavel.SetFocus;
    Exit;
  end;

  Result := True;
end;

end.
