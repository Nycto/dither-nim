import unittest, dither, stubs, math

proc intArray[N: static int](values: Slice[int]): array[N, int] =
    let increment = (values.b - values.a) / (N - 1)
    for i in 0..<N:
        result[i] = round(increment * i.float).toInt

suite "Ordered dithering":
    test "Can perform 4x4 dithering":
        var output = newOutput[20, int]()

        let img = newInput[20, int](
            intArray[20](0..255),
            intArray[20](0..255),
            intArray[20](0..255),
            intArray[20](0..255),
            intArray[20](0..255),
            intArray[20](0..255),
        )

        img.orderedDither(output, BlackAndWhite(), Bayer4x4)

        check(output == [
            [ 0, 0, 0, 0, 0, 255, 0, 255, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255],
            [ 0, 0, 255, 0, 255, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255],
            [ 0, 0, 0, 0, 0, 255, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255],
            [ 0, 0, 255, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255],
            [ 0, 0, 0, 0, 0, 255, 0, 255, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255],
            [ 0, 0, 255, 0, 255, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255],
        ])
