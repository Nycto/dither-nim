import sequtils, strutils, math

type
    TestInput*[W: static int, T] = object
        pixels: seq[array[W, T]]

    OutputImage*[N: static int, T] = object
        pixels: seq[array[N, T]]

    BlackAndWhite* = object

    IntQuantizer* = object

proc newInput*[W: static int, T](pixels: varargs[array[W, T]]): auto = TestInput[W, T](pixels: pixels.toSeq)

proc width*[W: static int, T](image: TestInput[W, T]): int = W

proc height*[W: static int, T](image: TestInput[W, T]): int = image.pixels.len

proc getPixel*[W: static int, T](image: TestInput[W, T]; x, y: int): T = image.pixels[y][x]

proc nearestColor*(palette: BlackAndWhite, color: int): int =
    return if color > 128: 255 else: 0

proc quantError*(a, b: int): int = a - b

proc approxMaxColorDistance*(palette: BlackAndWhite): int = 128

proc newOutput*[N: static int, T](): auto = OutputImage[N, T](pixels: newSeq[array[N, T]]())

proc setPixel*[N: static int, T](img: var OutputImage[N, T]; x, y: int, color: T) =
    img.pixels.setLen(max(y + 1, img.pixels.len))
    img.pixels[y][x] = color

proc `$`*[N: static int, T](img: var OutputImage[N, T]): string =
    img.pixels.mapIt("[ " & it.join(", ") & "],").join("\n")

proc `==`*[N: static int, M: static int, T](img: var OutputImage[N, T]; values: openarray[array[M, T]]): bool =
    when N == M: return img.pixels == values.toSeq else: return false

proc intArray*[N: static int](values: Slice[int]): array[N, int] =
    let increment = (values.b - values.a) / (N - 1)
    for i in 0..<N:
        result[i] = round(increment * i.float).toInt

proc quantizeError*(q: IntQuantizer, a, b: int): int = a - b