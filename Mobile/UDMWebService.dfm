object DMWebService: TDMWebService
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 288
  Width = 381
  object HTTPRIO1: THTTPRIO
    WSDLLocation = 'http://localhost:8080/wsdl/IWSFutSystem'
    Service = 'IWSFutSystemservice'
    Port = 'IWSFutSystemPort'
    HTTPWebNode.UseUTF8InHeader = True
    HTTPWebNode.InvokeOptions = [soIgnoreInvalidCerts, soAutoCheckAccessPointViaUDDI]
    HTTPWebNode.WebNodeOptions = []
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soCacheMimeResponse, soUTF8EncodeXML]
    Left = 42
    Top = 24
  end
  object fdmTimes: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 40
    Top = 96
    object fdmTimesTim_Codigo: TIntegerField
      FieldName = 'Tim_Codigo'
    end
    object fdmTimesTim_Nome: TStringField
      FieldName = 'Tim_Nome'
      Size = 30
    end
    object fdmTimesTim_DataFundacao: TDateField
      FieldName = 'Tim_DataFundacao'
    end
    object fdmTimesAtl_Codigo: TIntegerField
      FieldName = 'Atl_Codigo'
    end
  end
  object fdmAtletas: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 2147483647
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 104
    Top = 96
    object fdmAtletasAtl_Codigo: TIntegerField
      FieldName = 'Atl_Codigo'
    end
    object fdmAtletasAtl_NomeCompleto: TStringField
      FieldName = 'Atl_NomeCompleto'
      Size = 60
    end
  end
  object fdmCidades: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 40
    Top = 168
    object fdmCidadesCid_IBGE: TIntegerField
      FieldName = 'Cid_IBGE'
    end
    object fdmCidadesCid_Nome: TStringField
      FieldName = 'Cid_Nome'
      Size = 50
    end
    object fdmCidadesEst_Codigo: TIntegerField
      FieldName = 'Est_Codigo'
    end
  end
  object fdmEstados: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 104
    Top = 168
    object fdmEstadosEst_Codigo: TIntegerField
      FieldName = 'Est_Codigo'
    end
    object fdmEstadosEst_Nome: TStringField
      FieldName = 'Est_Nome'
      Size = 30
    end
    object fdmEstadosEst_Sigla: TStringField
      FieldName = 'Est_Sigla'
      Size = 2
    end
  end
end
