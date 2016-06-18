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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPsqPartidas: TFrmPsqPartidas;

implementation

{$R *.fmx}

uses UCadPartida;

procedure TFrmPsqPartidas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmPsqPartidas := nil;
end;

procedure TFrmPsqPartidas.sbAdicionarClick(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmCadPartida) then
    FrmCadPartida := TFrmCadPartida.Create(Self);
  FrmCadPartida.Show;
//  sbAtualizarClick(Self);
end;

end.
