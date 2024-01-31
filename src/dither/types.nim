type
    Palette*[Color] = concept p
        ## A set of available colors
        p.nearestColor(Color) is Color
        p.approxMaxColorDistance is int

    InputImage*[Color] = concept i
        ## An image from which to read colors
        i.width is SomeInteger
        i.height is SomeInteger
        i.getPixel(int, int) is Color
        (Color + int) is Color

    OutputImage*[Color] = concept var i
        ## An image that pixels can be written to
        i.setPixel(int, int, Color)

    DitherModes* {.pure.} = enum Bayer2x2, Bayer4x4, Bayer8x8
        ## A list of various available and standard dithering algorithms