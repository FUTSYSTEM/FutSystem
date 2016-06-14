unit UPsqTimes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  UPsqPadrao, FMX.ListView.Types, MultiDetailAppearanceU, FMX.ListView,
  FMX.Controls.Presentation, FMX.Layouts;

type
  TFrmPsqTimes = class(TFrmPsqPadrao)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPsqTimes: TFrmPsqTimes;

implementation

{$R *.fmx}

procedure TFrmPsqTimes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmPsqTimes := nil;
end;

end.
