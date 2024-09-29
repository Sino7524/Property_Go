object frmMessages: TfrmMessages
  Left = 0
  Top = 0
  Caption = 'Message'
  ClientHeight = 366
  ClientWidth = 527
  Color = 16760767
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object shpSend: TShape
    Left = 352
    Top = 321
    Width = 137
    Height = 37
    Brush.Color = 3069481
    Pen.Style = psClear
    Shape = stRoundRect
    OnMouseDown = shpSendMouseDown
    OnMouseEnter = shpSendMouseEnter
    OnMouseLeave = shpSendMouseLeave
    OnMouseUp = shpSendMouseUp
  end
  object lblSend: TLabel
    Left = 392
    Top = 328
    Width = 50
    Height = 23
    Caption = 'Send'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -20
    Font.Name = 'Cooper Black'
    Font.Style = []
    ParentFont = False
    OnClick = lblSendClick
  end
  object memMessage: TMemo
    Left = 32
    Top = 24
    Width = 457
    Height = 289
    Lines.Strings = (
      'Appointment Feedback')
    TabOrder = 0
  end
end
