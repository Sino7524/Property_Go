object frmIOAppointment: TfrmIOAppointment
  Left = 0
  Top = 0
  Caption = 'Appointment - Details'
  ClientHeight = 249
  ClientWidth = 280
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
  object PageControl1: TPageControl
    Left = -1
    Top = -1
    Width = 289
    Height = 250
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Property'
      object Label4: TLabel
        Left = 16
        Top = 16
        Width = 46
        Height = 13
        Caption = 'Property:'
      end
      object Label5: TLabel
        Left = 16
        Top = 72
        Width = 23
        Height = 13
        Caption = 'Size:'
      end
      object Label6: TLabel
        Left = 16
        Top = 94
        Width = 27
        Height = 13
        Caption = 'Price:'
      end
      object Label7: TLabel
        Left = 16
        Top = 48
        Width = 45
        Height = 13
        Caption = 'Province:'
      end
      object lblProvince: TLabel
        Left = 120
        Top = 45
        Width = 49
        Height = 13
        Caption = '[Province]'
      end
      object lblSize: TLabel
        Left = 120
        Top = 72
        Width = 27
        Height = 13
        Caption = '[Size]'
      end
      object lblPrice: TLabel
        Left = 120
        Top = 94
        Width = 31
        Height = 13
        Caption = '[Price]'
      end
      object Label8: TLabel
        Left = 16
        Top = 126
        Width = 57
        Height = 13
        Caption = 'Description:'
      end
      object Label9: TLabel
        Left = 116
        Top = 126
        Width = 149
        Height = 61
        AutoSize = False
        Caption = '[Description]'
        WordWrap = True
      end
      object cboProperty: TComboBox
        Left = 120
        Top = 13
        Width = 145
        Height = 21
        TabOrder = 0
        TextHint = 'Please select Property'
      end
      object BitBtn1: TBitBtn
        Left = 120
        Top = 193
        Width = 75
        Height = 25
        Caption = '&Next'
        Default = True
        DoubleBuffered = True
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        ParentDoubleBuffered = False
        TabOrder = 1
        OnClick = BitBtn1Click
      end
      object BitBtn2: TBitBtn
        Left = 201
        Top = 193
        Width = 75
        Height = 25
        DoubleBuffered = True
        Kind = bkCancel
        ParentDoubleBuffered = False
        TabOrder = 2
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Appointment'
      ImageIndex = 2
      object Label1: TLabel
        Left = 64
        Top = 132
        Width = 35
        Height = 13
        Caption = 'Status:'
      end
      object Label2: TLabel
        Left = 64
        Top = 75
        Width = 26
        Height = 13
        Caption = 'Time:'
      end
      object Label3: TLabel
        Left = 64
        Top = 56
        Width = 27
        Height = 13
        Caption = 'Date:'
      end
      object Label10: TLabel
        Left = 51
        Top = 3
        Width = 39
        Height = 13
        Caption = 'Realtor:'
      end
      object dtpDate: TDateTimePicker
        Left = 168
        Top = 48
        Width = 97
        Height = 21
        Date = 45475.463884143520000000
        Time = 45475.463884143520000000
        TabOrder = 0
        OnChange = dtpDateChange
      end
      object dtpTime: TDateTimePicker
        Left = 168
        Top = 75
        Width = 97
        Height = 21
        Date = 45475.463884143520000000
        Time = 45475.463884143520000000
        Kind = dtkTime
        TabOrder = 1
        OnChange = dtpDateChange
      end
      object cboState: TComboBox
        Left = 120
        Top = 129
        Width = 145
        Height = 21
        TabOrder = 2
        TextHint = 'Please select State'
        Items.Strings = (
          'Unknown'
          'Accepted'
          'Rejected'
          'Completed')
      end
      object btnOkay: TBitBtn
        Left = 120
        Top = 194
        Width = 75
        Height = 25
        DoubleBuffered = True
        Kind = bkOK
        ParentDoubleBuffered = False
        TabOrder = 3
        OnClick = btnOkayClick
      end
      object edtDateOf: TEdit
        Left = 120
        Top = 102
        Width = 145
        Height = 21
        Enabled = False
        ReadOnly = True
        TabOrder = 4
      end
      object cboRealtor: TComboBox
        Left = 120
        Top = 0
        Width = 145
        Height = 21
        TabOrder = 5
        TextHint = 'Please select Realtor'
        Items.Strings = (
          'Unknown'
          'Accepted'
          'Rejected'
          'Completed')
      end
      object btnCancel: TBitBtn
        Left = 201
        Top = 194
        Width = 75
        Height = 25
        DoubleBuffered = True
        Kind = bkCancel
        ParentDoubleBuffered = False
        TabOrder = 6
      end
    end
  end
end
