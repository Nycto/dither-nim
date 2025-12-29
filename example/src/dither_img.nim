import dither, std/[os, strutils], pixie, sequtils

proc getPixel*(img: Image, x, y: int): ColorRGBX =
  img[x, y]

proc setPixel*(img: var Image, x, y: int, pixel: ColorRGBX) =
  img[x, y] = pixel

let img = readImage(paramStr(1))

var output = newImage(img.width, img.height)

let palette = palette((3 .. paramCount()).mapIt(parseHex(paramStr(it)).rgbx))

let mode: DitherModes = parseEnum[DitherModes](paramStr(2))

dither(img, output, mode, palette, ColorQuantizer)

output.writeFile("output.png")
