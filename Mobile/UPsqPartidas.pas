unit UPsqPartidas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UPsqPadrao, FMX.ListView.Types, MultiDetailAppearanceU, FMX.ListView,
  FMX.Controls.Presentation, FMX.Layouts;

type
  TFrmPsqPartidas = class(TFrmPsqPadrao)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbAdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbAtualizarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPsqPartidas: TFrmPsqPartidas;

implementation

{$R *.fmx}

uses UCadPartida, UFuncoes, UDMWebService;

procedure TFrmPsqPartidas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmPsqPartidas := nil;
end;

procedure TFrmPsqPartidas.FormCreate(Sender: TObject);
begin
  inherited;
  sbAtualizarClick(Self);
end;

procedure TFrmPsqPartidas.sbAdicionarClick(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmCadPartida) then
    FrmCadPartida := TFrmCadPartida.Create(Self);
  FrmCadPartida.Show;
  sbAtualizarClick(Self);
end;

procedure TFrmPsqPartidas.sbAtualizarClick(Sender: TObject);
begin
  inherited;

  //carrega resultados
  try
    lvPesquisa.BeginUpdate;
    lvPesquisa.ClearItems;

    DMWebService.CarregarPartidas(Usuario.Codigo);
    DMWebService.fdmPartidas.First;
    while not DMWebService.fdmPartidas.Eof do
    begin
      with lvPesquisa.Items.Add do
      begin
        DMWebService.CarregarTimes(DMWebService.fdmPartidasPar_TimeA.AsInteger);
        Text  := DMWebService.fdmTimesTim_Nome.AsString + ' x ';
        DMWebService.CarregarTimes(DMWebService.fdmPartidasPar_TimeB.AsInteger);
        Text  := Text + DMWebService.fdmTimesTim_Nome.AsString;
      end;

      DMWebService.fdmPartidas.Next;
    end;
    //lvPesquisa.EndUpdate;
  except
    on E: Exception do
      InterpretaMsgErro(e.Message);
  end;
end;

end.
