import types

type
    Quantizer*[Color, Error] = concept q
        ## Determines the logic for how color errors are determined, manipulated and applied
        q.quantizeError(Color, Color) is Error
        (Error * int) is Error
        (Error div int) is Error
        (Error + Error) is Error
        (Color + Error) is Color

    Diffusor* = concept d
        ## Defines the access patterns for a matrix of error diffusion values
        d.rows is int
        d.columns is int
        d.inset is int
        d.denominator
        d.numerator(int, int) is int

iterator coords(diffusor: Diffusor): tuple[row, column: int] =
    ## Yields all the coordinates in a diffusor
    for column in (diffusor.inset + 1)..<diffusor.columns:
        yield (0, column)
    for row in 1..<diffusor.rows:
        for column in 0..<diffusor.columns:
            yield (row, column)

iterator numerators(diffusor: Diffusor): tuple[row, column, numerator: int] =
    ## Yields the relative coordinates and numerator for a diffusor
    for (row, column) in diffusor.coords:
        yield (row, column - diffusor.inset, diffusor.numerator(row, column))

iterator relativeNumerators(diffusor: Diffusor; x, y, maxX, maxY: int): tuple[x, y, numerator: int] =
    ## Yields the relative coordinates and numerator for a diffusor
    for (row, column, numerator) in diffusor.numerators:
        let errorX = x + column
        let errorY = y + row
        if errorX >= 0 and errorX < maxX and errorY >= 0 and errorY < maxY:
            yield (errorX, errorY, numerator)

proc slot[E](errors: var seq[seq[E]]; x, y: int): var E = errors[y mod errors.len][x]

proc errorDiffusionDither*[C, E](
    input: InputImage[C],
    output: var OutputImage[C],
    palette: Palette[C],
    quantizer: Quantizer[C, E],
    diffusor: Diffusor,
) =
    ## Implementation of error diffusion based dithering
    ## https://tannerhelland.com/2012/12/28/dithering-eleven-algorithms-source-code.html

    let errorDenominator = diffusor.denominator

    # Allocate some sequences that allow us to store the error data for pixels that haven't been processed yet
    var errors = newSeq[seq[E]](diffusor.rows)
    for y in 0..<diffusor.rows:
        errors[y] = newSeq[E](input.width)

    for y in 0..<input.height:
        for x in 0..<input.width:
            let oldpixel = input.getPixel(x, y) + errors.slot(x, y)
            let newpixel = palette.nearestColor(oldpixel)
            output.setPixel(x, y, newpixel)

            # Once we use an error slot, reset the value so that the memory can be reused
            errors.slot(x, y) = default(E)

            # Apply the error to the pixels surrounding the current pixel
            let error = quantizer.quantizeError(oldpixel, newpixel)
            for (errorX, errorY, numerator) in diffusor.relativeNumerators(x, y, input.width, input.height):
                errors.slot(errorX, errorY) = errors.slot(errorX, errorY) + (error * numerator div errorDenominator)