object frmPropData: TfrmPropData
  Left = 0
  Top = 0
  Caption = 'Property Data'
  ClientHeight = 580
  ClientWidth = 817
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 729
    Height = 492
    DataSource = dsQuery
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Chart: TChart
    Left = 8
    Top = 8
    Width = 729
    Height = 492
    Title.Text.Strings = (
      'TChart')
    DepthAxis.Automatic = False
    DepthAxis.AutomaticMaximum = False
    DepthAxis.AutomaticMinimum = False
    DepthAxis.Maximum = 1.160000000000065000
    DepthAxis.Minimum = 0.160000000000079400
    DepthTopAxis.Automatic = False
    DepthTopAxis.AutomaticMaximum = False
    DepthTopAxis.AutomaticMinimum = False
    DepthTopAxis.Maximum = 1.160000000000065000
    DepthTopAxis.Minimum = 0.160000000000079400
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.ExactDateTime = False
    LeftAxis.Increment = 1.000000000000000000
    LeftAxis.Maximum = 50.000000000000000000
    RightAxis.Automatic = False
    RightAxis.AutomaticMaximum = False
    RightAxis.AutomaticMinimum = False
    RightAxis.Increment = 1.000000000000000000
    TopAxis.ExactDateTime = False
    TopAxis.Increment = 1.000000000000000000
    View3D = False
    Zoom.Animated = True
    TabOrder = 2
    PrintMargins = (
      29
      15
      29
      15)
    object Series1: TBarSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = True
      Gradient.Direction = gdTopBottom
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
    end
  end
  object btnLikes: TButton
    Left = 656
    Top = 191
    Width = 153
    Height = 25
    Caption = 'Monthly Likes'
    TabOrder = 3
    OnClick = btnLikesClick
  end
  object btnPopularity: TButton
    Left = 656
    Top = 222
    Width = 153
    Height = 25
    Caption = 'Realtor Popularity'
    TabOrder = 1
    OnClick = btnPopularityClick
  end
  object btnAccounts: TButton
    Left = 656
    Top = 253
    Width = 153
    Height = 25
    Caption = 'Accounts'
    TabOrder = 4
    OnClick = btnAccountsClick
  end
  object qryChart: TADOQuery
    Connection = conChartData
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'Select Count(tblRealtors.Realtor_ID) As Realtors,  COUNT(tblClie' +
        'nts.Client_ID) AS Clients from tblRealtors, tblClients;')
    Left = 432
    Top = 424
  end
  object dsQuery: TDataSource
    DataSet = qryChart
    Left = 728
    Top = 408
  end
  object conChartData: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=S:\Phase 2 Version ' +
      '3\Data.mdb;Persist Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 528
    Top = 416
  end
end
