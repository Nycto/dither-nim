type
    DiffusionMatrix*[Rows: static int, Cols: static int] = object
        ## Uses numerators in a matrix to determine the distribution of errors surrounding a pixel
        data: array[Rows, array[Cols, int]]
        inset*: int
        denominator*: int

proc matrix[Rows: static int, Cols: static int](inset, denom: int; data: array[Rows, array[Cols, int]]): auto =
    return DiffusionMatrix[Rows, Cols](data: data, inset: inset, denominator: denom)

const FloydSteinberg* = matrix[2, 3](1, 16, [
    [ 0, 0, 7 ],
    [ 3, 5, 1 ]
])
    ## Floyd Steinberg dithering

const JarvisJudiceNinke* = matrix[3, 5](2, 48, [
    [ 0, 0, 0, 7, 5 ],
    [ 3, 5, 7, 5, 3 ],
    [ 1, 3, 5, 3, 1 ]
])
    ## Jarvis, Judice, and Ninkey dithering

const Stucki* = matrix[3, 5](2, 42, [
    [ 0, 0, 0, 8, 4 ],
    [ 2, 4, 8, 4, 2 ],
    [ 1, 2, 4, 2, 1 ]
])
    ## Stucki dithering

const Atkinson* = matrix[3, 4](1, 8, [
    [ 0, 0, 1, 1 ],
    [ 1, 1, 1, 0 ],
    [ 0, 1, 0, 0 ]
])
    ## https://en.wikipedia.org/wiki/Atkinson_dithering

proc rows*[Rows: static int, Cols: static int](matrix: DiffusionMatrix[Rows, Cols]): int =
    ## The number of rows in this matrix
    return Rows

proc columns*[Rows: static int, Cols: static int](matrix: DiffusionMatrix[Rows, Cols]): int =
    ## The number of columns in this matrix
    return Cols

proc numerator*[Rows: static int, Cols: static int](
    matrix: DiffusionMatrix[Rows, Cols],
    row, column: int
): int =
    ## The inset of to use when considering where the current pixel is located in the matrix
    return matrix.data[row][column]