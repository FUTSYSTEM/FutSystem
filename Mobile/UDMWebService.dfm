object DMWebService: TDMWebService
  OldCreateOrder = False
  Height = 202
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
end
