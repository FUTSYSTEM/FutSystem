unit UPadrao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts;

type
  TFrmPadrao = class(TForm)
    lytMain: TLayout;
    tlbTitulo: TToolBar;
    lblTitulo: TLabel;
    sbVoltar: TSpeedButton;
    procedure sbVoltarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPadrao: TFrmPadrao;

implementation

{$R *.fmx}

procedure TFrmPadrao.sbVoltarClick(Sender: TObject);
begin
  Close;
end;

end.
