unit UPsqAtletasTimes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UPsqPadrao, FMX.ListView.Types, MultiDetailAppearanceU, FMX.ListView,
  FMX.Controls.Presentation, FMX.Layouts, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFrmPsqAtletasTimes = class(TFrmPsqPadrao)
    fdmAtletas: TFDMemTable;
    fdmAtletasAtl_Codigo: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbAdicionarClick(Sender: TObject);
    procedure sbAtualizarClick(Sender: TObject);
    procedure lvPesquisaItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPsqAtletasTimes: TFrmPsqAtletasTimes;

implementation

{$R *.fmx}

uses UPsqAtletas, UDMWebService, UFuncoes, UCadTime, UCadAtleta, IWSFutSystem1;

procedure TFrmPsqAtletasTimes.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  I: Integer;
  TimeAtletas : TTimeAtleta;
begin
  inherited;

  SetLength(FrmCadTime.ListaAtletasTime, fdmAtletas.RecordCount);
  fdmAtletas.First;
  for I := Low(FrmCadTime.ListaAtletasTime) to High(FrmCadTime.ListaAtletasTime) do
  begin

    TimeAtletas            := TTimeAtleta.Create;
    TimeAtletas.Tim_Codigo := FrmCadTime.CodTime;
    TimeAtletas.Atl_Codigo := fdmAtletasAtl_Codigo.AsInteger;

    FrmCadTime.ListaAtletasTime[I] := TimeAtletas;
    fdmAtletas.Next;
  end;

  FrmPsqAtletasTimes := nil;
end;

procedure TFrmPsqAtletasTimes.FormCreate(Sender: TObject);
begin
  inherited;
  fdmAtletas.CreateDataSet;

  //carrega resultados
  try
    lvPesquisa.BeginUpdate;
    lvPesquisa.ClearItems;

    DMWebService.CarregarTimesAtletas(FrmCadTime.CodTime);
    DMWebService.fdmTimesAtletas.First;
    while not DMWebService.fdmTimesAtletas.Eof do
    begin
      with lvPesquisa.Items.Add do
      begin
        fdmAtletas.Append;
        fdmAtletasAtl_Codigo.AsInteger := DMWebService.fdmTimesAtletasAtl_Codigo.AsInteger;
        fdmAtletas.Post;
      end;

      DMWebService.fdmTimesAtletas.Next;
    end;
    lvPesquisa.EndUpdate;
  except
    on E: Exception do
      InterpretaMsgErro(e.Message);
  end;
end;

procedure TFrmPsqAtletasTimes.FormShow(Sender: TObject);
begin
  inherited;
  sbAtualizarClick(Self);
end;

procedure TFrmPsqAtletasTimes.lvPesquisaItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  inherited;
  if MsgConfirma('Deseja excluir o atleta?') then
  begin
    fdmAtletas.Locate('Atl_Codigo', StrToInt(AItem.Detail), []);
    fdmAtletas.Delete;
    sbAtualizarClick(Self);
  end;
end;

procedure TFrmPsqAtletasTimes.sbAdicionarClick(Sender: TObject);
begin
  inherited;
  if  not Assigned(FrmPsqAtletas) then
    FrmPsqAtletas := TFrmPsqAtletas.Create(Self);
  FrmPsqAtletas.Show;
end;

procedure TFrmPsqAtletasTimes.sbAtualizarClick(Sender: TObject);
begin
  inherited;
  //carrega resultados
  try
    lvPesquisa.BeginUpdate;
    lvPesquisa.ClearItems;

    fdmAtletas.First;
    while not fdmAtletas.Eof do
    begin
      with lvPesquisa.Items.Add do
      begin
        DMWebService.CarregarAtletas(fdmAtletasAtl_Codigo.AsInteger);
        Text  := DMWebService.fdmAtletasAtl_NomeCompleto.AsString;
        Detail:= fdmAtletasAtl_Codigo.AsString;
      end;

      fdmAtletas.Next;
    end;
    lvPesquisa.EndUpdate;
  except
    on E: Exception do
      InterpretaMsgErro(e.Message);
  end;
end;

end.
