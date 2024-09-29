object frmSQL_Main: TfrmSQL_Main
  Left = 0
  Top = 0
  Caption = 'PAT 2024 Appointment Scheduler'
  ClientHeight = 544
  ClientWidth = 576
  Color = clGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgcData: TPageControl
    Left = 0
    Top = 44
    Width = 576
    Height = 481
    ActivePage = TabSheet2
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object TabSheet2: TTabSheet
      Caption = 'Data Wizard'
      ImageIndex = 1
      object lblHeader: TLabel
        Left = 0
        Top = 0
        Width = 568
        Height = 16
        Align = alTop
        Caption = 'lblHeader'
        ExplicitWidth = 54
      end
      object DBGrid: TDBGrid
        Left = 0
        Top = 16
        Width = 568
        Height = 385
        Align = alClient
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        PopupMenu = pmTable
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 401
        Width = 568
        Height = 49
        Align = alBottom
        Caption = 'Data Controls'
        TabOrder = 1
        object DBNavigator: TDBNavigator
          Left = 3
          Top = 21
          Width = 240
          Height = 25
          TabOrder = 0
        end
        object edtSearchFor: TLabeledEdit
          Left = 340
          Top = 23
          Width = 144
          Height = 24
          Hint = 'Enter keyword'
          EditLabel.Width = 72
          EditLabel.Height = 16
          EditLabel.Caption = 'Search for...'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
        object btnSearch: TButton
          Left = 490
          Top = 22
          Width = 75
          Height = 25
          Caption = '&Search'
          TabOrder = 2
          OnClick = btnSearchClick
        end
        object ComboBox1: TComboBox
          Left = 249
          Top = 23
          Width = 85
          Height = 24
          TabOrder = 3
          Text = 'ComboBox1'
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Report'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object redOutput: TRichEdit
        Left = 0
        Top = 0
        Width = 568
        Height = 450
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Lines.Strings = (
          'redOutput')
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 525
    Width = 576
    Height = 19
    Panels = <>
  end
  object tlbGrey: TToolBar
    Left = 0
    Top = 0
    Width = 576
    Height = 44
    ButtonHeight = 38
    ButtonWidth = 39
    Caption = 'tlbGrey'
    Images = icons32
    TabOrder = 2
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Caption = 'Appointment'
      ImageIndex = 0
    end
  end
  object icons32: TImageList
    Height = 32
    Width = 32
    Left = 488
    Top = 120
  end
  object MainMenu1: TMainMenu
    Left = 496
    Top = 8
    object User1: TMenuItem
      Caption = 'User'
      object Logout1: TMenuItem
        Caption = 'Logout'
        OnClick = Register1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'E&xit'
      end
    end
    object DataWizard1: TMenuItem
      Caption = 'Data Wizard'
      object menu_Table1: TMenuItem
        Caption = 'Appointments'
        OnClick = menu_Table1Click
      end
      object menu_Table2: TMenuItem
        Caption = 'Clients'
        OnClick = menu_Table2Click
      end
      object menu_Table3: TMenuItem
        Caption = 'Properties'
        OnClick = menu_Table3Click
      end
      object menu_Table4: TMenuItem
        Caption = 'Realtors'
        OnClick = menu_Table4Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Sort1: TMenuItem
        Caption = 'Sort'
        OnClick = Sort1Click
      end
      object Search1: TMenuItem
        Caption = 'Search'
        OnClick = Search1Click
      end
      object Insert1: TMenuItem
        Caption = 'Insert'
        OnClick = recordInsertClick
      end
      object Delete1: TMenuItem
        Caption = 'Delete'
        OnClick = Delete1Click
      end
      object Edit1: TMenuItem
        Caption = 'Edit'
        OnClick = recordEditClick
      end
      object Query1: TMenuItem
        Caption = 'Query'
        object Selection1: TMenuItem
          Caption = 'Selection'
          OnClick = Selection1Click
        end
        object Complex1: TMenuItem
          Caption = 'Complex'
          OnClick = Complex1Click
        end
        object Analysis11: TMenuItem
          Caption = 'Analysis#1'
          OnClick = Analysis11Click
        end
        object Analysis21: TMenuItem
          Caption = 'Analysis#2'
          OnClick = Analysis21Click
        end
        object Join1: TMenuItem
          Caption = 'Join Data'
          OnClick = Join1Click
        end
        object QueryBuilder1: TMenuItem
          Caption = 'Query Builder'
          OnClick = QueryBuilder1Click
        end
        object FromFile1: TMenuItem
          Caption = 'From File'
          OnClick = FromFile1Click
        end
      end
    end
    object Report1: TMenuItem
      Caption = 'Report'
      object View1: TMenuItem
        Caption = 'View ...'
        OnClick = View1Click
      end
    end
    object SQLExplorer1: TMenuItem
      Caption = 'SQL Explorer'
      object Explore1: TMenuItem
        Caption = 'Explore'
        OnClick = Explore1Click
      end
    end
  end
  object pmTable: TPopupMenu
    Left = 488
    Top = 184
    object recordInsert: TMenuItem
      Caption = 'Insert'
      OnClick = recordInsertClick
    end
    object recordDelete: TMenuItem
      Caption = 'Delete'
      OnClick = recordDeleteClick
    end
    object recordEdit: TMenuItem
      Caption = 'Edit'
      OnClick = recordEditClick
    end
  end
  object dlgOpenFile: TOpenTextFileDialog
    Left = 488
    Top = 64
  end
end
