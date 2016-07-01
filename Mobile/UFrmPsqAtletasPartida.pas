unit UFrmPsqAtletasPartida;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UPsqPadrao, FMX.ListView.Types, MultiDetailAppearanceU, FMX.ListView,
  FMX.Controls.Presentation, FMX.Layouts;

type
  TFrmPsqAtletasPartida = class(TFrmPsqPadrao)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPsqAtletasPartida: TFrmPsqAtletasPartida;

implementation

{$R *.fmx}

procedure TFrmPsqAtletasPartida.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmPsqAtletasPartida := nil;
end;

end.
