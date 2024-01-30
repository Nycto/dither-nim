import dither, std/os, pixie

type BlackAndWhite = object

let black = rgbx(0, 0, 0, 255)
let white = rgbx(255, 255, 255, 255)

proc nearestColor(palette: BlackAndWhite, color: ColorRGBX): ColorRGBX =
    result = if distance(color, black) > distance(color, white): white else: black

proc approxMaxColorDistance(palette: BlackAndWhite): int = 128

let img = readImage(paramStr(1))

var output = newImage(img.width, img.height)

proc getPixel(img: Image; x, y: int): ColorRGBX = img[x, y]

proc setPixel(img: var Image; x, y: int; pixel: ColorRGBX) = img[x, y] = pixel

proc `+`(a: uint8, b: SomeInteger): uint8 = clamp(a.int + b.int, 0, 255).uint8

proc `+`(pixel: ColorRGBX, scalar: int): ColorRGBX =
    result = rgbx(pixel.r + scalar, pixel.g + scalar, pixel.b + scalar, pixel.a)

orderedDither(img, output, BlackAndWhite(), Bayer4x4)

output.writeFile("output.png")