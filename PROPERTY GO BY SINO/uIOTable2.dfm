object frmIOTable2: TfrmIOTable2
  Left = 0
  Top = 0
  Caption = 'Client - Details'
  ClientHeight = 224
  ClientWidth = 506
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
  object lblSurname: TLabel
    Left = 56
    Top = 16
    Width = 46
    Height = 13
    Caption = 'Surname:'
  end
  object lblEmail: TLabel
    Left = 72
    Top = 152
    Width = 28
    Height = 13
    Caption = 'Email:'
  end
  object lblFirstName: TLabel
    Left = 47
    Top = 51
    Width = 55
    Height = 13
    Caption = 'First Name:'
  end
  object lblDoB: TLabel
    Left = 50
    Top = 86
    Width = 52
    Height = 13
    Caption = 'Birth Date:'
  end
  object lblPhone: TLabel
    Left = 66
    Top = 117
    Width = 34
    Height = 13
    Caption = 'Phone:'
  end
  object lblID: TLabel
    Left = 320
    Top = 16
    Width = 15
    Height = 13
    Caption = 'ID:'
  end
  object edtSurname: TEdit
    Left = 120
    Top = 8
    Width = 186
    Height = 21
    TabOrder = 0
  end
  object btnOkay: TBitBtn
    Left = 120
    Top = 168
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkOK
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = btnOkayClick
  end
  object btnCancel: TBitBtn
    Left = 201
    Top = 168
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkCancel
    ParentDoubleBuffered = False
    TabOrder = 2
  end
  object edtFirstname: TEdit
    Left = 120
    Top = 48
    Width = 186
    Height = 21
    TabOrder = 3
  end
  object edtPhone: TEdit
    Left = 120
    Top = 114
    Width = 186
    Height = 21
    TabOrder = 4
  end
  object edtEmail: TEdit
    Left = 120
    Top = 141
    Width = 186
    Height = 21
    TabOrder = 5
  end
  object dtpDateOfBirth: TDateTimePicker
    Left = 120
    Top = 87
    Width = 186
    Height = 21
    Date = 45476.363499444440000000
    Time = 45476.363499444440000000
    TabOrder = 6
  end
  object edtID: TEdit
    Left = 341
    Top = 8
    Width = 123
    Height = 21
    MaxLength = 9
    TabOrder = 7
  end
end
