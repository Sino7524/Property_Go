object frmIOTable3: TfrmIOTable3
  Left = 0
  Top = 0
  Caption = 'Property - Details'
  ClientHeight = 538
  ClientWidth = 450
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
  object lblLabel1: TLabel
    Left = 24
    Top = 16
    Width = 76
    Height = 13
    Caption = 'Property Name:'
  end
  object Label2: TLabel
    Left = 77
    Top = 51
    Width = 23
    Height = 13
    Caption = 'Size:'
  end
  object Label3: TLabel
    Left = 73
    Top = 86
    Width = 27
    Height = 13
    Caption = 'Price:'
  end
  object lblProvince: TLabel
    Left = 55
    Top = 120
    Width = 45
    Height = 13
    Caption = 'Province:'
  end
  object lblDescription: TLabel
    Left = 43
    Top = 160
    Width = 57
    Height = 13
    Caption = 'Description:'
  end
  object lblImage: TLabel
    Left = 66
    Top = 336
    Width = 34
    Height = 13
    Caption = 'Image:'
  end
  object lblPropertyDataPrice: TLabel
    Left = 8
    Top = 385
    Width = 98
    Height = 13
    Caption = 'Property Data Price:'
  end
  object lblID: TLabel
    Left = 289
    Top = 16
    Width = 15
    Height = 13
    Caption = 'ID:'
  end
  object btnOkay: TBitBtn
    Left = 144
    Top = 487
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkOK
    ParentDoubleBuffered = False
    TabOrder = 0
    OnClick = btnOkayClick
  end
  object btnCancel: TBitBtn
    Left = 241
    Top = 487
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkCancel
    ParentDoubleBuffered = False
    TabOrder = 1
  end
  object edtProperty_Name: TEdit
    Left = 120
    Top = 8
    Width = 145
    Height = 21
    TabOrder = 2
  end
  object spnProperty_Size: TSpinEdit
    Left = 120
    Top = 48
    Width = 145
    Height = 22
    MaxValue = 200000
    MinValue = 0
    TabOrder = 3
    Value = 0
  end
  object edtPrice: TEdit
    Left = 120
    Top = 83
    Width = 145
    Height = 21
    NumbersOnly = True
    TabOrder = 4
  end
  object chkSold: TCheckBox
    Left = 168
    Top = 440
    Width = 97
    Height = 17
    Caption = 'Sold'
    TabOrder = 5
  end
  object edtProvince: TEdit
    Left = 120
    Top = 117
    Width = 145
    Height = 21
    TabOrder = 6
  end
  object memDescription: TMemo
    Left = 120
    Top = 157
    Width = 313
    Height = 148
    TabOrder = 7
  end
  object edtImage: TEdit
    Left = 120
    Top = 333
    Width = 145
    Height = 21
    TabOrder = 8
    OnClick = edtImageClick
  end
  object edtPropDataPrice: TEdit
    Left = 120
    Top = 382
    Width = 145
    Height = 21
    NumbersOnly = True
    TabOrder = 9
  end
  object edtID: TEdit
    Left = 310
    Top = 8
    Width = 123
    Height = 21
    MaxLength = 5
    NumbersOnly = True
    TabOrder = 10
  end
  object dlgImage: TOpenPictureDialog
    OnSelectionChange = dlgImageSelectionChange
    Left = 272
    Top = 328
  end
end
