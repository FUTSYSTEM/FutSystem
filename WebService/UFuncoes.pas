unit UFuncoes;

interface

uses System.SysUtils, Vcl.Dialogs, Vcl.Forms, Winapi.Windows;


  procedure GravaErro(Msg: string);
  function  iif(Expressao: Boolean; Valor1, Valor2: Variant): Variant;
  procedure MsgAviso(Msg: string);
  procedure MsgErro(Msg: string);
  procedure MsgInforma(Msg: string);

implementation

uses UFrmPrincipal;

procedure MsgAviso(Msg: string);
begin
  Application.MessageBox(PChar(Msg), 'Aviso', MB_OK + MB_ICONWARNING);
end;

procedure MsgErro(Msg: string);
begin
  Application.MessageBox(PChar(Msg), 'Erro', MB_OK + MB_ICONSTOP);
end;

procedure MsgInforma(Msg: string);
begin
  Application.MessageBox(PChar(Msg), 'Informação', MB_OK + MB_ICONINFORMATION);
end;

procedure GravaErro(Msg: string);
begin
  FrmPrincipal.mmoLog.Lines.Add(FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + ' - ' + Msg);
end;

function  iif(Expressao: Boolean; Valor1, Valor2: Variant): Variant;
begin
  if Expressao then
    Result := Valor1
  else
    Result := Valor2;
end;

end.
