import dither, std/[os, strutils], pixie, sequtils

proc getPixel(img: Image; x, y: int): ColorRGBX = img[x, y]

proc setPixel(img: var Image; x, y: int; pixel: ColorRGBX) = img[x, y] = pixel

let img = readImage(paramStr(1))

var output = newImage(img.width, img.height)

var palette = palette((3..paramCount()).mapIt(parseHex(paramStr(it)).rgbx))

img.dither(output, parseEnum[DitherModes](paramStr(2)), palette)

output.writeFile("output.png")