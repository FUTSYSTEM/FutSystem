unit UPsqAtletas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UPsqPadrao, FMX.ListView.Types, MultiDetailAppearanceU, FMX.ListView,
  FMX.Controls.Presentation, FMX.Layouts, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope;

type
  TFrmPsqAtletas = class(TFrmPsqPadrao)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbAtualizarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPsqAtletas: TFrmPsqAtletas;

implementation

{$R *.fmx}

uses IWSFutSystem1, UDMWebService, UFuncoes;

procedure TFrmPsqAtletas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmPsqAtletas := nil;
end;

procedure TFrmPsqAtletas.FormCreate(Sender: TObject);
begin
  inherited;
  sbAtualizarClick(Self);
end;

procedure TFrmPsqAtletas.sbAtualizarClick(Sender: TObject);
begin
  inherited;

  //carrega resultados
  try
    lvPesquisa.BeginUpdate;
    lvPesquisa.ClearItems;

    DMWebService.CarregarAtletas;
    DMWebService.fdmAtletas.First;
    while not DMWebService.fdmAtletas.Eof do
    begin
      with lvPesquisa.Items.Add do
      begin
        Text  := DMWebService.fdmAtletasAtl_NomeCompleto.AsString;
        Detail:= DMWebService.fdmAtletasAtl_Codigo.AsString;
      end;

      DMWebService.fdmAtletas.Next;
    end;
    lvPesquisa.EndUpdate;
  except
    on E: Exception do
      InterpretaMsgErro(e.Message);
  end;
end;

end.
