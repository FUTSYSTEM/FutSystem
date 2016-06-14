unit UCadTime;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UPadrao, FMX.Controls.Presentation, FMX.Layouts;

type
  TFrmCadTime = class(TFrmPadrao)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadTime: TFrmCadTime;

implementation

{$R *.fmx}

procedure TFrmCadTime.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmCadTime := nil;
end;

end.