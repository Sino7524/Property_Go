object frmIOTable1: TfrmIOTable1
  Left = 0
  Top = 0
  Caption = 'Appointment - Details'
  ClientHeight = 465
  ClientWidth = 469
  Color = 16760767
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblSchedule: TLabel
    Left = 56
    Top = 16
    Width = 47
    Height = 13
    Caption = 'Schedule:'
  end
  object lblStatus: TLabel
    Left = 73
    Top = 144
    Width = 30
    Height = 13
    Caption = 'State:'
  end
  object lblRealtor: TLabel
    Left = 64
    Top = 59
    Width = 39
    Height = 13
    Caption = 'Realtor:'
  end
  object lblClient: TLabel
    Left = 72
    Top = 86
    Width = 31
    Height = 13
    Caption = 'Client:'
  end
  object lblProperty: TLabel
    Left = 57
    Top = 111
    Width = 46
    Height = 13
    Caption = 'Property:'
  end
  object lblMessage: TLabel
    Left = 57
    Top = 192
    Width = 46
    Height = 13
    Caption = 'Message:'
  end
  object cboRealtor: TComboBox
    Left = 120
    Top = 56
    Width = 233
    Height = 21
    TabOrder = 0
    TextHint = 'Please select Realtor'
  end
  object dtpDate: TDateTimePicker
    Left = 120
    Top = 8
    Width = 97
    Height = 21
    Date = 45475.463884143520000000
    Time = 45475.463884143520000000
    TabOrder = 1
    OnChange = dtpDateChange
  end
  object dtpTime: TDateTimePicker
    Left = 223
    Top = 8
    Width = 90
    Height = 21
    Date = 45475.463884143520000000
    Time = 45475.463884143520000000
    Kind = dtkTime
    TabOrder = 2
    OnChange = dtpDateChange
  end
  object edtDateOf: TEdit
    Left = 120
    Top = 32
    Width = 145
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 3
  end
  object cboClient: TComboBox
    Left = 120
    Top = 83
    Width = 233
    Height = 21
    TabOrder = 4
    TextHint = 'Please select Client'
  end
  object cboProperty: TComboBox
    Left = 120
    Top = 110
    Width = 233
    Height = 21
    TabOrder = 5
    TextHint = 'Please select Property'
  end
  object cboState: TComboBox
    Left = 120
    Top = 141
    Width = 145
    Height = 21
    TabOrder = 6
    TextHint = 'Please select State'
    Items.Strings = (
      'Unknown'
      'Accepted'
      'Rejected'
      'Completed')
  end
  object btnOkay: TBitBtn
    Left = 176
    Top = 424
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkOK
    ParentDoubleBuffered = False
    TabOrder = 7
    OnClick = btnOkayClick
  end
  object btnCancel: TBitBtn
    Left = 278
    Top = 424
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkCancel
    ParentDoubleBuffered = False
    TabOrder = 8
  end
  object chkViewed: TCheckBox
    Left = 304
    Top = 145
    Width = 97
    Height = 17
    Caption = 'Viewed'
    TabOrder = 9
  end
  object memMessage: TMemo
    Left = 120
    Top = 189
    Width = 341
    Height = 229
    Lines.Strings = (
      'memMessage')
    TabOrder = 10
  end
end
