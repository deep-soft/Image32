object Form1: TForm1
  Left = 298
  Top = 205
  Width = 443
  Height = 522
  Caption = 'Svg101'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object ImagePanel: TImage32Panel
    Left = 0
    Top = 0
    Width = 427
    Height = 464
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 12
    Color = clBtnFace
    ParentBackground = False
    TabOrder = 0
    TabStop = True
    AutoCenter = True
    FocusedColor = clActiveCaption
    UnFocusedColor = clBtnFace
    Scale = 1.000000000000000000
    ScaleMin = 0.050000000000000000
    ScaleMax = 20.000000000000000000
    ShowScrollButtons = ssbFocused
    AllowScroll = True
    AllowZoom = True
  end
  object MainMenu1: TMainMenu
    Left = 192
    Top = 104
    object File1: TMenuItem
      Caption = '&File'
      object Exit1: TMenuItem
        Caption = 'E&xit'
        ShortCut = 27
        OnClick = Exit1Click
      end
    end
  end
end