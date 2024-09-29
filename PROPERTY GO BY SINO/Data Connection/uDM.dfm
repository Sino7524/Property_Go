object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 422
  Width = 615
  object conData: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Data.mdb;Persist Se' +
      'curity Info=False;'
    KeepConnection = False
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 232
    Top = 24
  end
  object query: TADOQuery
    Connection = conData
    Parameters = <>
    Prepared = True
    Left = 288
    Top = 24
  end
  object dsTblClients: TDataSource
    DataSet = tblClients
    Left = 168
    Top = 112
  end
  object tblClients: TADOTable
    Connection = conData
    CursorType = ctStatic
    TableName = 'tblClients'
    Left = 472
    Top = 144
  end
  object tblRealtors: TADOTable
    Connection = conData
    CursorType = ctStatic
    TableDirect = True
    TableName = 'tblRealtors'
    Left = 384
    Top = 216
  end
  object tblAppointments: TADOTable
    Connection = conData
    CursorType = ctStatic
    TableDirect = True
    TableName = 'tblAppointments'
    Left = 384
    Top = 272
  end
  object tblPropertyLikes: TADOTable
    Connection = conData
    CursorType = ctStatic
    TableDirect = True
    TableName = 'tblPropertyLikes'
    Left = 480
    Top = 48
  end
  object tblProperties: TADOTable
    Connection = conData
    CursorType = ctStatic
    TableDirect = True
    TableName = 'tblProperties'
    Left = 384
    Top = 48
  end
  object dsQuery: TDataSource
    DataSet = query
    Left = 56
    Top = 120
  end
  object dsTblRealtors: TDataSource
    DataSet = tblRealtors
    Left = 56
    Top = 168
  end
  object dsTblAppointments: TDataSource
    DataSet = tblAppointments
    Left = 56
    Top = 232
  end
  object dsTblProperties: TDataSource
    DataSet = tblProperties
    Left = 168
    Top = 160
  end
  object dsTblPropertyLikes: TDataSource
    DataSet = tblProperties
    Left = 168
    Top = 224
  end
  object tblPropertyData: TADOTable
    Connection = conData
    CursorType = ctStatic
    TableName = 'tblPropertyData'
    Left = 384
    Top = 144
  end
end
