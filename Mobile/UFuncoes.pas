unit UFuncoes;

interface

uses FMX.Dialogs, System.UITypes;

    type TUsuario = record
        Codigo : Integer;
        NomeAcesso : string;

        procedure LimparDados;
    end;

    //fun��es diversas
    function  MsgConfirma(Msg: string): Boolean;
    procedure MsgAviso(Msg: string);
    procedure MsgErro(Msg: string);
    procedure MsgInforma(Msg: string);

implementation

{$IFDEF ANDROID}uses FMX.Helpers.Android,  FMX.Platform.Android; {$ENDIF}

function MsgConfirma(Msg: string): Boolean;
var
  Resultado : Boolean;
begin
  Resultado := False;
  MessageDlg(Msg, TMsgDlgType.mtConfirmation,[TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
    procedure (const AResult: TModalResult)
    begin
      if AResult = mrYes then
        Resultado := True;
    end);

  Result :=  Resultado;
end;

procedure MsgAviso(Msg: string);
begin
  MessageDlg(Msg, TMsgDlgType.mtWarning,[TMsgDlgBtn.mbOK], 0,
    procedure (const AResult: TModalResult)
    begin
    end);
end;

procedure MsgErro(Msg: string);
begin
  MessageDlg(Msg, TMsgDlgType.mtError,[TMsgDlgBtn.mbOK], 0,
    procedure (const AResult: TModalResult)
    begin
    end);
end;

procedure MsgInforma(Msg: string);
begin
  MessageDlg(Msg, TMsgDlgType.mtInformation,[TMsgDlgBtn.mbOK], 0,
    procedure (const AResult: TModalResult)
    begin
    end);
end;
{ TUsuario }

procedure TUsuario.LimparDados;
begin
 Codigo      := 0;
  NomeAcesso := '';
end;

end.
