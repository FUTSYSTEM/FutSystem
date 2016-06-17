unit UCadTime;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UPadrao, FMX.Controls.Presentation, FMX.Layouts, FMX.Edit, IWSFutSystem1;

type
  TFrmCadTime = class(TFrmPadrao)
    Label1: TLabel;
    edtNomeTime: TEdit;
    btnCancelar: TButton;
    btnSalvar: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Equipe: TTimes;
    Editando : Boolean;
    procedure LimparDados;
  public
    { Public declarations }
  end;

var
  FrmCadTime: TFrmCadTime;

implementation

{$R *.fmx}

uses UDMWebService, UFuncoes, UPsqTimes;

procedure TFrmCadTime.btnCancelarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmCadTime.btnSalvarClick(Sender: TObject);
begin
  inherited;
  Equipe.Nome := edtNomeTime.Text;

  if DMWebService.SalvarTime(Equipe) then
  begin
    FrmPsqTimes.sbAtualizarClick(Self);
    Close;
  end
  else
    MsgAviso('Falha ao salvar registro. Tente novamente mais tarde.');
end;

procedure TFrmCadTime.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmCadTime := nil;
end;

procedure TFrmCadTime.FormCreate(Sender: TObject);
begin
  inherited;
  LimparDados;
end;

procedure TFrmCadTime.FormShow(Sender: TObject);
begin
  inherited;
  edtNomeTime.SetFocus;
end;

//procedimento para limpar dados e campos a serem utilizados na grava��o
procedure TFrmCadTime.LimparDados;
begin
  Editando      := False;
  if Equipe = nil then
    Equipe := TTimes.Create;
  Equipe.Codigo       := 0;
  Equipe.Nome         := EmptyStr;
  Equipe.DataFundacao := Date;
  Equipe.Atl_Codigo   := Usuario.Codigo;

  edtNomeTime.Text    := '';
end;

end.
