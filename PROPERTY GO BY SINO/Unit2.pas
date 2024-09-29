unit Unit2;

interface

uses
  SysUtils, Classes, Controls, Forms,
  IWVCLBaseContainer, IWColor, IWContainer, IWRegion, ExtCtrls, IWHTMLContainer,
  IWHTML40Container;

type
  TIWFrame2 = class(TFrame)
    IWFrameRegion: TIWRegion;
    LinkLabel1: TLinkLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.