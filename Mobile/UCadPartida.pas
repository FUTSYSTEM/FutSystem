unit UCadPartida;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UPadrao, FMX.Controls.Presentation, FMX.Layouts, FMX.ListBox, FMX.Edit,
  FMX.DateTimeCtrls, IWSFutSystem1;

type
  TFrmCadPartida = class(TFrmPadrao)
    btnCancelar: TButton;
    btnSalvar: TButton;
    edtData: TDateEdit;
    edtHorario: TTimeEdit;
    Label1: TLabel;
    Label2: TLabel;
    lblLocal: TLabel;
    edtLocal: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    cbbEquipeA: TComboBox;
    cbbEquipeB: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbbEquipeAClick(Sender: TObject);
    procedure cbbEquipeBClick(Sender: TObject);
    procedure edtLocalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
    Partida: TPartida;
    Editando : Boolean;
    procedure LimparDados;
  public
    { Public declarations }
  end;

var
  FrmCadPartida: TFrmCadPartida;

implementation

{$R *.fmx}

uses UPsqTimes, UPsqCampos, UDMWebService, UPsqPartidas, UFuncoes;

procedure TFrmCadPartida.btnSalvarClick(Sender: TObject);
begin
  inherited;
  Partida.Data    := edtData.Date;
  Partida.Horario := edtHorario.Time;

  if DMWebService.SalvarPartida(Partida) then
  begin
    FrmPsqPartidas.sbAtualizarClick(Self);
    Close;
  end
  else
    MsgAviso('Falha ao salvar registro. Tente novamente mais tarde.');
end;

procedure TFrmCadPartida.cbbEquipeAClick(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmPsqTimes) then
    FrmPsqTimes := TFrmPsqTimes.Create(Self);
  FrmPsqTimes.Show;
end;

procedure TFrmCadPartida.cbbEquipeBClick(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmPsqTimes) then
    FrmPsqTimes := TFrmPsqTimes.Create(Self);
  FrmPsqTimes.Show;
end;

procedure TFrmCadPartida.edtLocalClick(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmPsqCampos) then
    FrmPsqCampos := TFrmPsqCampos.Create(Self);
  FrmPsqCampos.Show;
end;

procedure TFrmCadPartida.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmCadPartida := nil;
end;

procedure TFrmCadPartida.FormCreate(Sender: TObject);
begin
  inherited;
  LimparDados;
end;

procedure TFrmCadPartida.LimparDados;
begin
  Editando      := False;
  if Partida = nil then
    Partida := TPartida.Create;

  Partida.Codigo       := 0;
  Partida.Data         := Date;
  Partida.Horario      := Time;
  Partida.Cam_Codigo   := 0;
  Partida.Status       := TStatus.tsAtivo;
  Partida.TimeA        := 0;
  Partida.TimeB        := 0;

  edtData.Text         := '__/__/____';
  edtHorario.Text      := '__:__';
  edtLocal.Text        := '';
  cbbEquipeA.ItemIndex := -1;
  cbbEquipeB.ItemIndex := -1;
end;

end.
