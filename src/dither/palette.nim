import sequtils, chroma, std/algorithm, math

type
  FixedPalette* = ref object ## A palette made of explicit colors
    colors: seq[ColorRGBX]

  GreyScalePalette* = distinct uint8

proc newGreyScalePalette*(numberOfShades: SomeInteger): GreyScalePalette =
  GreyScalePalette(numberOfShades.uint8)

const BlackAndWhiteIntPalette* = newGreyScalePalette(2)
  ## A palette that uses integers to represent shades of gray, but the output palette is only black and white

proc palette*(colors: varargs[ColorRGBX]): FixedPalette =
  ## Creates a palette from the given set of colors
  FixedPalette(colors: colors.toSeq)

proc nearestColor*(palette: FixedPalette, color: ColorRGBX): ColorRGBX =
  ## Returns the nearest color that's in a given palette
  var currentDistance: float32 = high(float32)
  for possible in palette.colors:
    let thisDistance = distance(possible, color)
    if thisDistance < currentDistance:
      result = possible
      currentDistance = thisDistance

proc octetDistance(a, b: ColorRGBX): int =
  let r = abs(a.r.int - b.r.int)
  let g = abs(a.g.int - b.g.int)
  let b = abs(a.b.int - b.b.int)
  return (r + g + b) div 3

proc approxMaxColorDistance*(palette: FixedPalette): int =
  ## Returns an estimate for the maximum distance between colors
  let colors = palette.colors.sortedByIt(distance(rgbx(0, 0, 0, 255), it))
  result = 10
  for i, color in colors:
    if i > 0:
      result = max(result, octetDistance(color, colors[i - 1]))

proc `+`(a: uint8, b: SomeInteger): uint8 =
  clamp(a.int + b.int, 0, 255).uint8

proc `+`*(color: ColorRGBX, scalar: int): ColorRGBX =
  ## Add a scalar value to a color
  result = rgbx(color.r + scalar, color.g + scalar, color.b + scalar, color.a)

proc nearestColor*(palette: GreyScalePalette, color: int): int =
  ## Returns the nearest shade of grey that's in a given palette
  let shadesOfGreyInPalette = palette.uint8.int - 1
  let step = 255 div shadesOfGreyInPalette
  let nearestStep = (color + (step div 2)) div step
  return clamp(nearestStep, 0, shadesOfGreyInPalette) * step

proc approxMaxColorDistance*(palette: GreyScalePalette): int =
  ## Returns the maximum distance between colors
  256 div palette.uint8.int
