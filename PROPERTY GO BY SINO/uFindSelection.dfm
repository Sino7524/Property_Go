object frmFindSelection: TfrmFindSelection
  Left = 0
  Top = 0
  Caption = 'frmFindSelection'
  ClientHeight = 242
  ClientWidth = 527
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dbFindSelection: TDBGrid
    Left = 0
    Top = 0
    Width = 524
    Height = 210
    DataSource = DM.dsQuery
    FixedColor = 16744576
    GradientEndColor = 16744576
    GradientStartColor = 16766421
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = 8388672
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
  end
  object btnSelect: TBitBtn
    Left = 368
    Top = 216
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkOK
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = btnSelectClick
  end
  object btnCancel: TBitBtn
    Left = 449
    Top = 216
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkCancel
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = btnCancelClick
  end
end
