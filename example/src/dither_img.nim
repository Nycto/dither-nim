import dither, std/[os, strutils], pixie, sequtils

let img = readImage(paramStr(1))

var output = newImage(img.width, img.height)

proc getPixel(img: Image; x, y: int): ColorRGBX = img[x, y]

proc setPixel(img: var Image; x, y: int; pixel: ColorRGBX) = img[x, y] = pixel

var palette = palette((3..paramCount()).mapIt(parseHex(paramStr(it)).rgbx))

case parseEnum[DitherModes](paramStr(2))
of DitherModes.Bayer4x4: img.orderedDither(output, palette, Bayer4x4)
of DitherModes.Bayer8x8: img.orderedDither(output, palette, Bayer8x8)

output.writeFile("output.png")