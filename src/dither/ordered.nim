import types

type ThresholdMap*[N: static int] = array[N, array[N, int]]

const Bayer4x4*: ThresholdMap[4]  = [
    [ 1,  9,  3,  11 ],
    [ 13, 5,  15, 7  ],
    [ 4,  12, 2,  10 ],
    [ 16, 8,  14, 6  ]
]

const RATIO = 3

proc orderedDither*[N, P](
    input: InputImage[P],
    output: var OutputImage[P],
    palette: Palette[P],
    thresholds: ThresholdMap[N]
) =
    for y in 0..<input.height:
        for x in 0..<input.width:
            let factor = thresholds[y mod N][x mod N]
            let actualPixel = input.getPixel(x, y)
            let adjustdPixel = actualPixel + (factor * RATIO)
            let final = palette.nearestColor(adjustdPixel)
            output.setPixel(x, y, final)
