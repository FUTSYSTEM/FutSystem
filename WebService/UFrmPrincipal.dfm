object FrmPrincipal: TFrmPrincipal
  Left = 271
  Top = 114
  Caption = '..:::WebService FutSystem:::..'
  ClientHeight = 298
  ClientWidth = 403
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 73
    Width = 26
    Height = 13
    Caption = 'Porta'
  end
  object Label2: TLabel
    Left = 24
    Top = 119
    Width = 17
    Height = 13
    Caption = 'Log'
  end
  object ButtonStart: TButton
    Left = 104
    Top = 83
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = ButtonStartClick
  end
  object ButtonStop: TButton
    Left = 185
    Top = 83
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 1
    OnClick = ButtonStopClick
  end
  object EditPort: TEdit
    Left = 24
    Top = 87
    Width = 75
    Height = 21
    TabOrder = 2
    Text = '8080'
  end
  object ButtonOpenBrowser: TButton
    Left = 266
    Top = 83
    Width = 107
    Height = 25
    Caption = 'Open Browser'
    TabOrder = 3
    OnClick = ButtonOpenBrowserClick
  end
  object pnlTitulo: TPanel
    Left = 0
    Top = 0
    Width = 403
    Height = 41
    Align = alTop
    Caption = 'WebService FutSystem'
    Color = clGrayText
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 4
  end
  object mmoLog: TMemo
    Left = 24
    Top = 136
    Width = 349
    Height = 153
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    OnMinimize = ApplicationEvents1Minimize
    Left = 304
    Top = 48
  end
  object TrayIcon1: TTrayIcon
    OnDblClick = TrayIcon1DblClick
    Left = 304
    Top = 96
  end
  object tmrMinimizar: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = tmrMinimizarTimer
    Left = 304
    Top = 152
  end
end
