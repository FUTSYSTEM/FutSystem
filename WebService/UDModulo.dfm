object DModulo: TDModulo
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 181
  Width = 399
  object fdcConexao: TFDConnection
    Params.Strings = (
      'DriverID=MySQL'
      'CharacterSet=utf8'
      'Database=futsystem'
      'Password=123'
      'User_Name=root'
      'Server=localhost')
    LoginPrompt = False
    Left = 32
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 136
    Top = 24
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Program Files (x86)\MySQL\MySQL Server 4.1\bin\libmySQL.dll'
    Left = 247
    Top = 24
  end
  object fdqAuxiliar: TFDQuery
    Connection = fdcConexao
    Left = 40
    Top = 88
  end
  object fdqGerador: TFDQuery
    Connection = fdcConexao
    Left = 120
    Top = 88
  end
end
