import dither, std/[os, algorithm, strutils], pixie

type
    Palette = ref object
        colors: seq[ColorRGBX]

    DitherModes {.pure.} = enum Bayer4x4

proc nearestColor(palette: Palette, color: ColorRGBX): ColorRGBX =
    var currentDistance: float32 = high(float32)
    for possible in palette.colors:
        let thisDistance = distance(possible, color)
        if thisDistance < currentDistance:
            result = possible
            currentDistance = thisDistance

proc approxMaxColorDistance(palette: Palette): int =
    let colors = palette.colors .sortedByIt(distance(rgbx(0, 0, 0, 255), it))
    result = 10
    for i, color in colors:
        if i > 0:
            result = max(result, distance(color, colors[i - 1]).toInt)

let img = readImage(paramStr(1))

var output = newImage(img.width, img.height)

proc getPixel(img: Image; x, y: int): ColorRGBX = img[x, y]

proc setPixel(img: var Image; x, y: int; pixel: ColorRGBX) = img[x, y] = pixel

proc `+`(a: uint8, b: SomeInteger): uint8 = clamp(a.int + b.int, 0, 255).uint8

proc `+`(pixel: ColorRGBX, scalar: int): ColorRGBX =
    result = rgbx(pixel.r + scalar, pixel.g + scalar, pixel.b + scalar, pixel.a)

var palette = Palette()
for param in 3..paramCount():
    palette.colors.add(parseHex(paramStr(param)).rgbx)

case parseEnum[DitherModes](paramStr(2))
of DitherModes.Bayer4x4: img.orderedDither(output, palette, Bayer4x4)

output.writeFile("output.png")