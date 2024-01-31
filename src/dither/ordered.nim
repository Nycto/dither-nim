import types

type ThresholdMap*[N: static int] = array[N, array[N, int]]

const Bayer2x2*: ThresholdMap[2]  = [
    [ 0, 2 ],
    [ 3, 1 ]
]

const Bayer4x4*: ThresholdMap[4]  = [
    [ 1,  9,  3,  11 ],
    [ 13, 5,  15, 7  ],
    [ 4,  12, 2,  10 ],
    [ 16, 8,  14, 6  ]
]

const Bayer8x8*: ThresholdMap[8] = [
    [ 0, 32,  8, 40,  2, 34, 10, 42],
    [48, 16, 56, 24, 50, 18, 58, 26],
    [12, 44,  4, 36, 14, 46,  6, 38],
    [60, 28, 52, 20, 62, 30, 54, 22],
    [ 3, 35, 11, 43,  1, 33,  9, 41],
    [51, 19, 59, 27, 49, 17, 57, 25],
    [15, 47,  7, 39, 13, 45,  5, 37],
    [63, 31, 55, 23, 61, 29, 53, 21]
]

proc orderedDither*[N, P](
    input: InputImage[P],
    output: var OutputImage[P],
    palette: Palette[P],
    thresholds: ThresholdMap[N]
) =
    ## Ordered dithering
    ## * https://en.wikipedia.org/wiki/Ordered_dithering`
    ## * https://bisqwit.iki.fi/story/howto/dither/jy/

    let maxThresholdMap = N * N

    # The likely distance between colors in the palette
    let threshold = palette.approxMaxColorDistance

    for y in 0..<input.height:
        for x in 0..<input.width:
            let factor = thresholds[y mod N][x mod N]
            let actualPixel = input.getPixel(x, y)
            let adjustdPixel = actualPixel + (factor * threshold div maxThresholdMap)
            let final = palette.nearestColor(adjustdPixel)
            output.setPixel(x, y, final)
