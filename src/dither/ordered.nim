import types

type ThresholdMap*[N: static int] = array[N, array[N, int]]

const Bayer4x4*: ThresholdMap[4]  = [
    [ 1,  9,  3,  11 ],
    [ 13, 5,  15, 7  ],
    [ 4,  12, 2,  10 ],
    [ 16, 8,  14, 6  ]
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
