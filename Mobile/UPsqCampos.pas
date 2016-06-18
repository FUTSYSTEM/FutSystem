unit UPsqCampos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UPsqPadrao, FMX.ListView.Types, MultiDetailAppearanceU, FMX.ListView,
  FMX.Controls.Presentation, FMX.Layouts;

type
  TFrmPsqCampos = class(TFrmPsqPadrao)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbAtualizarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPsqCampos: TFrmPsqCampos;

implementation

{$R *.fmx}

uses IWSFutSystem1, UDMWebService, UFuncoes;

procedure TFrmPsqCampos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmPsqCampos:= nil;
end;

procedure TFrmPsqCampos.FormCreate(Sender: TObject);
begin
  inherited;
  sbAtualizarClick(Self);
end;

procedure TFrmPsqCampos.sbAtualizarClick(Sender: TObject);
begin
  inherited;

  //carrega resultados
  try
    lvPesquisa.BeginUpdate;
    lvPesquisa.ClearItems;

    DMWebService.CarregarCampos;
    DMWebService.fdmCampos.First;
    while not DMWebService.fdmCampos.Eof do
    begin
      with lvPesquisa.Items.Add do
      begin
        Text  := DMWebService.fdmCamposCam_Nome.AsString;
        Detail:= DMWebService.fdmCamposCam_Email.AsString;
      end;

      DMWebService.fdmCampos.Next;
    end;
    lvPesquisa.EndUpdate;
  except
    on E: Exception do
      InterpretaMsgErro(e.Message);
  end;
end;

end.
