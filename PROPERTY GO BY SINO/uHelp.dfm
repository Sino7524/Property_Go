object frmHelp: TfrmHelp
  Left = 0
  Top = 0
  Caption = 'frmHelp'
  ClientHeight = 798
  ClientWidth = 789
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
  object redHelp: TRichEdit
    Left = 0
    Top = 40
    Width = 789
    Height = 758
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'redHelp')
    ParentFont = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 9
    Width = 107
    Height = 25
    Caption = 'Text to Speech'
    TabOrder = 1
    OnClick = Button1Click
  end
end
