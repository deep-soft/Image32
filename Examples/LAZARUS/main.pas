﻿unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, StdCtrls, ExtCtrls,
  Img32, Img32.Text, Img32.Fmt.SVG, Img32.Vector, Img32.Draw;

type

  { TMainForm }

  TMainForm = class(TForm)
    btnClose: TButton;
    Image1: TImage;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    img: TImage32;
    copyTxtPaths: TPathsD;
    penColor: TColor32;
    procedure DrawImage;
  end;

var
  MainForm: TMainForm;
const
  margin = 20;

{$IFDEF FPC}
  RT_RCDATA = PChar(10);
{$ENDIF}

implementation

{$R *.lfm}
{$R font.res}

//------------------------------------------------------------------------------
// TMainForm
//------------------------------------------------------------------------------

procedure TMainForm.FormCreate(Sender: TObject);
var
   copyright  : UnicodeString;
   fontReader2: TFontReader;
   fontCache  : TFontCache;
   nextX      : double;
begin
  penColor := clMaroon32;
{$IFNDEF MSWINDOWS}
  bkColor  := SwapRedBlue(bkColor);
  penColor := SwapRedBlue(penColor);
  txtColor := SwapRedBlue(txtColor);
{$ENDIF}
  img := TImage32.create;
  Image1.Picture.Bitmap.PixelFormat := pf32bit;

  copyright := UnicodeString('© 2022 Angus Johnson');
  // Create a TFontReader object to access a truetype font stored as font
  // resource. This can be destroyed here, otherwise the FontManager
  // will automatically destroy it on close.
  fontReader2 := FontManager.LoadFromResource('FONT_2', RT_RCDATA);
  //fontReader2 := FontManager.Load('Arial'); //only Windows
  if not Assigned(fontReader2) or not fontReader2.IsValidFontFormat then Exit;
  //get the 'copyright' text glyphs outline
  fontCache := TFontCache.Create(fontReader2, DPIAware(15));
  try
    copyTxtPaths := fontCache.GetTextOutline(0,0, copyright, nextX);
  finally
    fontCache.Free;
    fontReader2.Free;
  end;
end;
//------------------------------------------------------------------------------

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  img.Free;
end;

//------------------------------------------------------------------------------

procedure TMainForm.btnCloseClick(Sender: TObject);
begin
  Close;
end;
//------------------------------------------------------------------------------

procedure TMainForm.DrawImage;
var
  tmpImg: TImage32;
  tmpPath: TPathD;
  dstRec: TRect;
begin
  with Image1.Picture.Bitmap do
    img.SetSize(Width, Height);
  if img.IsEmpty then Exit;
  img.Clear();

  dstRec := img.Bounds;
  dstRec.Bottom := btnClose.Top - 10;

  //load an SVG image stored as a resource (Img32)
  tmpImg := TImage32.Create(img.Width, img.Height);
  try
    tmpImg.LoadFromResource('IMAGE32', RT_RCDATA);
    // now stretch copy the resource image into 'img'
    img.Copy(tmpImg, tmpImg.Bounds, dstRec);
  finally
    tmpImg.Free;
  end;

  tmpPath := Img32.Vector.Rectangle(img.Bounds);
  DrawLine(img, tmpPath, 10, penColor, esPolygon);

  dstRec := GetBounds(copyTxtPaths);
  copyTxtPaths := OffsetPath(copyTxtPaths, 10- dstRec.Left, 10 - dstRec.Top);
  DrawPolygon(img, copyTxtPaths, frNonZero, clBlack32);
  img.CopyToBitmap(Image1.Picture.Bitmap);
end;
//------------------------------------------------------------------------------

procedure TMainForm.FormResize(Sender: TObject);
begin
  Image1.Picture.Bitmap.SetSize(ClientWidth, ClientHeight);
  DrawImage;
end;
//------------------------------------------------------------------------------

end.

