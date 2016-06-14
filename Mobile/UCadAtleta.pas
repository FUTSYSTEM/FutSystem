unit UCadAtleta;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UPadrao, FMX.Controls.Presentation, FMX.Layouts;

type
  TFrmCadAtleta = class(TFrmPadrao)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadAtleta: TFrmCadAtleta;

implementation

{$R *.fmx}

procedure TFrmCadAtleta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmCadAtleta := nil;
end;

end.