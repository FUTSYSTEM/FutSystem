unit UCadPartida;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UPadrao, FMX.Controls.Presentation, FMX.Layouts;

type
  TFrmCadPartida = class(TFrmPadrao)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadPartida: TFrmCadPartida;

implementation

{$R *.fmx}

procedure TFrmCadPartida.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmCadPartida := nil;
end;

end.
