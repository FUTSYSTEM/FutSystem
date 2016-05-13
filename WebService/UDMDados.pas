Unit UDMDados;

interface

uses SysUtils, Classes, InvokeRegistry, Midas, SOAPMidas, SOAPDm,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client;

type
  IDMDados = interface(IAppServerSOAP)
    ['{17E4F239-5098-4DDA-B9A5-264926BD70CE}']
  end;

  TDMDados = class(TSoapDataModule, IDMDados, IAppServerSOAP, IAppServer)
  private

  public
  
  end;

implementation



{$R *.DFM}

procedure TDMDadosCreateInstance(out obj: TObject);
begin
 obj := TDMDados.Create(nil);
end;

initialization
   InvRegistry.RegisterInvokableClass(TDMDados, TDMDadosCreateInstance);
   InvRegistry.RegisterInterface(TypeInfo(IDMDados));
end.
