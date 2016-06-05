unit UPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListBox, FMX.Layouts,
  FMX.MultiView, FMX.VirtualKeyboard, FMX.Platform;

type
  TFrmPrincipal = class(TForm)
    lytMain: TLayout;
    recBackground: TRectangle;
    lblTituloT: TLabel;
    sbMenu: TSpeedButton;
    MultiView1: TMultiView;
    lstMnuMain: TListBox;
    lstPesquisas: TListBoxGroupHeader;
    lstAtletas: TListBoxItem;
    ListBoxItem1: TListBoxItem;
    sbSair: TSpeedButton;
    lstCampos: TListBoxItem;
    lstTimes: TListBoxItem;
    lstPerfil: TListBoxItem;
    lstConfig: TListBoxGroupHeader;
    lstMeusTimes: TListBoxItem;
    lstPartidas: TListBoxItem;
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure sbSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }

    procedure ShowBackground(AParent: TFmxObject; AOnClick: TNotifyEvent = nil);
    procedure HideBackground;
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses ULogin;

{ TFrmPrincipal }

procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FrmLogin.EdUsuario.Text := EmptyStr;
  FrmLogin.EdSenha.Text   := EmptyStr;
  FrmLogin.EdUsuario.SetFocus;

  FrmPrincipal := nil;
end;

procedure TFrmPrincipal.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
var
  FService : IFMXVirtualKeyboardService;
begin
  {Recebe o estado do teclado virtual}
  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));

  {Se o bot�o back pressionado e o teclado virtual ativo, n�o faz nada}
  if Key = vkHardwareBack then
  begin
    if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) then
    begin
      //Reservado, n�o faz nada
    end
    else
    begin
      {Verifica qual formul�rio est� ativo e ent�o chama o m�todo Voltar}
      {Se N�O estiver com a listagem de pedidos aberta}
      if MultiView1.IsShowed then
      begin
        MultiView1.HideMaster;
        Key := 0;
      end;

      Key := 0;
    end;
  end
  {Bot�o Menu do Android}
  else if Key = vkMenu then
  begin
    if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) then
    begin
      //Reservado, n�o faz nada
    end
    {O menu est� sendo mostrado, apenas fecha o menu}
    else
    begin
      if MultiView1.IsShowed then
        HideBackground;

      Key := 0;
    end;
  end;

end;

procedure TFrmPrincipal.HideBackground;
begin
  recBackground.AnimateFloat('opacity', 0, 0.1);
  recBackground.Visible := False;
end;

procedure TFrmPrincipal.sbSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmPrincipal.ShowBackground(AParent: TFmxObject;
  AOnClick: TNotifyEvent);
begin
  recBackground.OnClick := AOnClick;
  recBackground.Parent  := AParent;
  recBackground.BringToFront;
  recBackground.Opacity := 0;
  recBackground.Visible := True;
  recBackground.AnimateFloat('opacity', 0.5, 0.1);
end;

end.