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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPsqCampos: TFrmPsqCampos;

implementation

{$R *.fmx}

procedure TFrmPsqCampos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmPsqCampos:= nil;
end;

end.
