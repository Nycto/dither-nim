import unittest, dither, stubs, sequtils

suite "Ordered dithering":

    test "Can perform 2x2 dithering":
        var output = newOutput[10, int]()

        let img = newInput[10, int](
            intArray[10](0..255),
            intArray[10](0..255),
            intArray[10](0..255),
            intArray[10](0..255),
        )

        img.orderedDither(output, BlackAndWhiteIntPalette, Bayer2x2)

        check(output == [
            [ 0, 0, 0, 0, 0, 0, 0, 255, 255, 255],
            [ 0, 0, 0, 0, 0, 0, 255, 255, 255, 255],
            [ 0, 0, 0, 0, 0, 0, 0, 255, 255, 255],
            [ 0, 0, 0, 0, 0, 0, 255, 255, 255, 255]
        ])

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

        img.orderedDither(output, BlackAndWhiteIntPalette, Bayer4x4)

        check(output == [
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 255, 255, 255, 255, 255, 255, 255],
            [ 0, 0, 0, 0, 0, 0, 255, 0, 255, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 255, 0, 255, 255, 255, 255, 255, 255, 255],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 255, 0, 255, 255, 255, 255, 255, 255, 255, 255],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 255, 255, 255, 255, 255, 255, 255],
            [ 0, 0, 0, 0, 0, 0, 255, 0, 255, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255],
        ])


    test "Can perform 8x8 dithering":
        var output = newOutput[20, int]()

        let img = newInput[20, int](
            intArray[10](0..100).toSeq.mapIt(intArray[20](it..(it + 128)))
        )

        img.orderedDither(output, BlackAndWhiteIntPalette, Bayer8x8)

        check(output == [
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 255, 0, 255, 0],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 255],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 255, 0, 255, 0, 255, 0],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 255, 0, 255, 0],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 255],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 255, 0, 255, 0, 255, 0],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 255, 0, 255, 0],
        ])