import types

type
    Thresholds* = concept t
        ## Describes the values to add that vary the colors at different offsets
        t.maxThreshold is int
        t.threshold(int, int) is int

proc orderedDither*[P](
    input: InputImage[P],
    output: var OutputImage[P],
    palette: Palette[P],
    thresholds: Thresholds
) =
    ## Ordered dithering
    ## * https://en.wikipedia.org/wiki/Ordered_dithering`
    ## * https://bisqwit.iki.fi/story/howto/dither/jy/

    let maxThresholdMap = thresholds.maxThreshold

    # The likely distance between colors in the palette
    let threshold = palette.approxMaxColorDistance

    for y in 0..<input.height:
        for x in 0..<input.width:
            let factor = thresholds.threshold(x, y)
            let actualPixel = input.getPixel(x, y)
            let adjustdPixel = actualPixel + (factor * threshold div maxThresholdMap)
            let final = palette.nearestColor(adjustdPixel)
            output.setPixel(x, y, final)
