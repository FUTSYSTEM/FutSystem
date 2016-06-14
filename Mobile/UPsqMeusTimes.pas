unit UPsqMeusTimes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UPsqPadrao, FMX.ListView.Types, MultiDetailAppearanceU, FMX.ListView,
  FMX.Controls.Presentation, FMX.Layouts;

type
  TFrmPsqMeusTimes = class(TFrmPsqPadrao)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPsqMeusTimes: TFrmPsqMeusTimes;

implementation

{$R *.fmx}

procedure TFrmPsqMeusTimes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmPsqMeusTimes := nil;
end;

end.
