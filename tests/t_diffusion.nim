import unittest, dither, stubs, sequtils

let img = newInput[20, int](
    intArray[10](0..100).toSeq.mapIt(intArray[20](it..(it + 128)))
)

suite "Error diffusion dithering":
    test "Can perform Floyd Steinberg dithering":
        var output = newOutput[20, int]()

        errorDiffusionDither(img, output, BlackAndWhite(), IntQuantizer(), FloydSteinberg)

        check(output == [
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 0, 255, 0, 255, 0, 255],
            [ 0, 0, 0, 0, 0, 0, 0, 255, 0, 255, 0, 255, 0, 0, 255, 0, 0, 255, 0, 255],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 255, 0, 255, 0, 0],
            [ 0, 0, 0, 0, 0, 255, 0, 0, 255, 0, 255, 0, 255, 0, 0, 0, 255, 0, 255, 255],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 255, 0, 255, 0, 0],
            [ 0, 0, 0, 0, 0, 0, 255, 0, 0, 255, 0, 255, 0, 0, 255, 0, 0, 255, 0, 255],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 0, 255, 0, 255, 0, 255],
            [ 0, 0, 0, 0, 255, 0, 0, 255, 0, 255, 0, 255, 0, 0, 255, 0, 255, 0, 255, 0],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 0, 255, 0, 0, 255, 0],
            [ 0, 0, 0, 0, 0, 0, 255, 0, 0, 255, 0, 0, 0, 255, 0, 0, 255, 0, 255, 0],
        ])

    test "Can perform Jarvis, Judice, and Ninke dithering":
        var output = newOutput[20, int]()

        errorDiffusionDither(img, output, BlackAndWhite(), IntQuantizer(), JarvisJudiceNinke)

        check(output == [
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 0, 255, 0],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 255, 0, 0, 255, 0, 255, 255, 0],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 0, 0, 255, 0, 255, 0, 0, 255, 0, 255],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 0, 255, 0, 0, 255, 0, 0],
            [ 0, 0, 0, 0, 0, 0, 255, 0, 0, 255, 0, 0, 0, 255, 0, 255, 0, 255, 255, 0],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 0, 255, 0, 0, 255, 0, 0, 255, 255],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 0, 255, 0, 0, 255, 0, 0],
            [ 0, 0, 0, 0, 0, 0, 255, 0, 255, 0, 0, 0, 0, 255, 0, 0, 255, 255, 0, 255],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 0, 255, 0, 0, 255, 0, 0, 255, 0],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 255, 0, 255, 0, 0, 255, 255, 0],
        ])

    test "Can perform Stucki dithering":
        var output = newOutput[20, int]()

        errorDiffusionDither(img, output, BlackAndWhite(), IntQuantizer(), Stucki)

        check(output == [
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 0, 255, 0],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 255],
            [ 0, 0, 0, 0, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 0, 255, 0, 255, 0, 0],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 0, 0, 255, 0, 0, 255, 0, 255, 0],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 255, 0, 255, 0, 0, 255, 0, 255],
            [ 0, 0, 0, 0, 0, 0, 255, 0, 0, 0, 0, 0, 0, 255, 0, 255, 0, 255, 0, 255],
            [ 0, 0, 0, 0, 0, 0, 0, 255, 0, 255, 0, 255, 0, 0, 0, 255, 0, 0, 255, 0],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 255, 0, 255, 0, 255, 0],
            [ 0, 0, 0, 0, 0, 0, 255, 0, 0, 255, 0, 0, 0, 255, 0, 0, 255, 0, 255, 255],
            [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 0, 0, 255, 0, 0, 255, 0, 0, 255],
        ])