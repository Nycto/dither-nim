import chroma

type
  ColorQuantizeObj = object

  ColorQuantizeError* = object
    red, green, blue: int

  IntQuantizerObj = object

const ColorQuantizer* = ColorQuantizeObj()
  ## Quantizer that uses chroma to support RGB values

const IntQuantizer* = IntQuantizerObj()
  ## Quantizer that uses integers to represent a gray scale

proc quantizeError*(q: ColorQuantizeObj, a, b: ColorRGBX): ColorQuantizeError =
  return ColorQuantizeError(
    red: a.r.int - b.r.int, green: a.g.int - b.g.int, blue: a.b.int - b.b.int
  )

proc `*`*(error: ColorQuantizeError, scalar: int): ColorQuantizeError =
  return ColorQuantizeError(
    red: error.red * scalar, green: error.green * scalar, blue: error.blue * scalar
  )

proc `div`*(error: ColorQuantizeError, scalar: int): ColorQuantizeError =
  return ColorQuantizeError(
    red: error.red div scalar,
    green: error.green div scalar,
    blue: error.blue div scalar,
  )

proc `+`*(a, b: ColorQuantizeError): ColorQuantizeError =
  return ColorQuantizeError(
    red: a.red + b.red, green: a.green + b.green, blue: a.blue + b.blue
  )

proc `+`(a: uint8, b: SomeInteger): uint8 =
  clamp(a.int + b.int, 0, 255).uint8

proc `+`*(color: ColorRGBX, error: ColorQuantizeError): ColorRGBX =
  return rgbx(color.r + error.red, color.g + error.green, color.b + error.blue, color.a)

proc quantizeError*(q: IntQuantizerObj, a, b: int): int =
  a - b
