unit UCadAtleta;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UPadrao, FMX.Controls.Presentation, FMX.Layouts, FMX.ListBox,
  FMX.DateTimeCtrls, FMX.Edit, IWSFutSystem1;

type
  TFrmCadAtleta = class(TFrmPadrao)
    btnSalvar: TButton;
    edtNome: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    dtpDataNasc: TDateEdit;
    Label3: TLabel;
    cbbSexo: TComboBox;
    edtTelefone: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    edtCelular: TEdit;
    edtEndereco: TEdit;
    Label6: TLabel;
    edtNroEndereco: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    edtBairro: TEdit;
    edtCEP: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    cbbUF: TComboBox;
    cbbCidade: TComboBox;
    Label11: TLabel;
    edtEmail: TEdit;
    Label12: TLabel;
    edtSenha: TEdit;
    Label13: TLabel;
    cbbPosicao: TComboBox;
    Label14: TLabel;
    Label15: TLabel;
    edtCaracteristicas: TEdit;
    Label16: TLabel;
    edtObs: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbbUFClick(Sender: TObject);
    procedure cbbUFChange(Sender: TObject);
    procedure cbbUFExit(Sender: TObject);
  private
    { Private declarations }
    Atleta: TAtleta;
    Editando : Boolean;
    procedure AtualizarComboCidades;
    procedure LimparDados;
  public
    { Public declarations }
  end;

var
  FrmCadAtleta: TFrmCadAtleta;

implementation

{$R *.fmx}

uses UFuncoes, UPsqAtletas, UDMWebService;
{$R *.LgXhdpiPh.fmx ANDROID}

procedure TFrmCadAtleta.AtualizarComboCidades;
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

procedure TFrmCadAtleta.btnSalvarClick(Sender: TObject);
begin
  inherited;

  DMWebService.fdmCidades.Locate('CID_NOME', cbbCidade.Items.ValueFromIndex[cbbCidade.ItemIndex], []);


  with Atleta do
  begin
    NomeCompleto   := edtNome.Text;
    DataNasc       := dtpDataNasc.Date;
    Sexo           := TSexo(cbbSexo.ItemIndex);
    Telefone       := edtTelefone.Text;
    Celular        := edtCelular.Text;
    Endereco       := edtEndereco.Text;
    Bairro         := edtBairro.Text;
    NumEndereco    := StrToIntDef(edtNroEndereco.Text, 0);
    CEP            := edtCEP.Text;
    Cid_IBGE       := DMWebService.fdmCidadesCid_IBGE.AsInteger;
    Email          := edtEmail.Text;
    Senha          := edtSenha.Text;
    Posicao        := TPosicao(cbbPosicao.ItemIndex);
    Status         := TStatus.tsAtivo;
    Caracteristicas:= edtCaracteristicas.Text;
    Observacao     := edtObs.Text;
  end;

  if DMWebService.SalvarAtletas(Atleta) then
    Close
  else
    MsgAviso('Falha ao salvar registro. Tente novamente mais tarde.');
end;

procedure TFrmCadAtleta.cbbUFChange(Sender: TObject);
begin
  inherited;
  AtualizarComboCidades;
end;

procedure TFrmCadAtleta.cbbUFClick(Sender: TObject);
begin
  inherited;
  AtualizarComboCidades;
end;

procedure TFrmCadAtleta.cbbUFExit(Sender: TObject);
begin
  inherited;
  AtualizarComboCidades;
end;

procedure TFrmCadAtleta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmCadAtleta := nil;
end;

procedure TFrmCadAtleta.FormCreate(Sender: TObject);
begin
  inherited;
  LimparDados;
end;

procedure TFrmCadAtleta.LimparDados;
begin
  Editando      := False;
  if Atleta = nil then
    Atleta := tAtleta.Create;

  DMWebService.CarregarCidades('PR');

  //carrega estados
  DMWebService.fdmEstados.First;
  while not DMWebService.fdmEstados.Eof do
  begin
    cbbUF.Items.Add(DMWebService.fdmEstadosEst_Sigla.AsString);
    DMWebService.fdmEstados.Next;
  end;

  AtualizarComboCidades;

  with Atleta do
  begin
    Codigo         := 0;
    NomeCompleto   := EmptyStr;
    DataNasc       := Date;
    Sexo           := TSexo.tsMasculino;
    Telefone       := EmptyStr;
    Celular        := EmptyStr;
    Endereco       := EmptyStr;
    Bairro         := EmptyStr;
    NumEndereco    := 0;
    CEP            := EmptyStr;
    Cid_IBGE       := 0;
    Email          := EmptyStr;
    Senha          := EmptyStr;
    Posicao        := TPosicao.tpGoleiro;
    Status         := TStatus.tsAtivo;
    Caracteristicas:= EmptyStr;
    Observacao     := EmptyStr;
  end;

  edtNome.Text                := EmptyStr;
  dtpDataNasc.IsEmpty         := True;
  cbbSexo.ItemIndex           := -1;
  edtTelefone.Text            := EmptyStr;
  edtCelular.TexT             := EmptyStr;
  edtEndereco.Text            := EmptyStr;
  edtNroEndereco.Text         := EmptyStr;
  edtBairro.Text              := EmptyStr;
  edtCEP.Text                 := EmptyStr;
  cbbUF.ItemIndex             := -1;
  cbbCidade.ItemIndex         := -1;
  edtEmail.Text               := EmptyStr;
  edtSenha.Text               := EmptyStr;
  edtCaracteristicas.Text     := EmptyStr;
  edtObs.Text                 := EmptyStr;
  cbbPosicao.ItemIndex        := -1;
end;

end.
