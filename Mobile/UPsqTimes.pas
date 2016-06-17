unit UPsqTimes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UPsqPadrao, FMX.ListView.Types, MultiDetailAppearanceU, FMX.ListView,
  FMX.Controls.Presentation, FMX.Layouts, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope;

type
  TFrmPsqTimes = class(TFrmPsqPadrao)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbAdicionarClick(Sender: TObject);
    procedure sbAtualizarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPsqTimes: TFrmPsqTimes;

implementation

{$R *.fmx}

uses UDMWebService, UCadTime, UFuncoes;

procedure TFrmPsqTimes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmPsqTimes := nil;
end;

procedure TFrmPsqTimes.FormCreate(Sender: TObject);
begin
  sbAtualizarClick(Self);
  inherited;
end;

procedure TFrmPsqTimes.sbAdicionarClick(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmCadTime) then
    FrmCadTime := TFrmCadTime.Create(Self);
  FrmCadTime.Show;
end;

procedure TFrmPsqTimes.sbAtualizarClick(Sender: TObject);
begin
  inherited;

  //carrega resultados
  try
    lvPesquisa.BeginUpdate;
    lvPesquisa.ClearItems;

    DMWebService.CarregarTimes;
    DMWebService.fdmTimes.First;
    while not DMWebService.fdmTimes.Eof do
    begin
      with lvPesquisa.Items.Add do
      begin
        Text  := DMWebService.fdmTimesTim_Nome.AsString;
        Detail:= DMWebService.fdmTimesTim_DataFundacao.AsString;
      end;
      DMWebService.fdmTimes.Next;
    end;
    lvPesquisa.EndUpdate;
  except
    on E: Exception do
      InterpretaMsgErro(e.Message);
  end;
end;

end.
