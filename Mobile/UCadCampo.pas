unit UCadCampo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UPadrao, FMX.Controls.Presentation, FMX.Layouts;

type
  TFrmCadCampo = class(TFrmPadrao)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadCampo: TFrmCadCampo;

implementation

{$R *.fmx}

procedure TFrmCadCampo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmCadCampo := nil;
end;

end.
