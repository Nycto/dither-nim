
type
    Palette*[Pixel] = concept p
        p.nearestColor(Pixel) is Pixel

    InputImage*[Pixel] = concept i
        i.width is SomeInteger
        i.height is SomeInteger
        i.getPixel(int, int) is Pixel
        (Pixel + int) is Pixel

    OutputImage*[Pixel] = concept var i
        i.setPixel(int, int, Pixel)
