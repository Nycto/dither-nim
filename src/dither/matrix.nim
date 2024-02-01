type
    DiffusionMatrix*[Rows: static int, Cols: static int, Inset: static int] = array[Rows, array[Cols, int]]
        ## Uses numerators in a matrix to determine the distribution of errors surrounding a pixel

const FloydSteinberg*: DiffusionMatrix[2, 3, 1] = [
    [ 0, 0, 7 ],
    [ 3, 5, 1 ]
]
    ## Floyd Steinberg dithering

const JarvisJudiceNinke*: DiffusionMatrix[3, 5, 2] = [
    [ 0, 0, 0, 7, 5 ],
    [ 3, 5, 7, 5, 3 ],
    [ 1, 3, 5, 3, 1 ]
]
    ## Jarvis, Judice, and Ninkey dithering

const Stucki*: DiffusionMatrix[3, 5, 2] = [
    [ 0, 0, 0, 8, 4 ],
    [ 2, 4, 8, 4, 2 ],
    [ 1, 2, 4, 2, 1 ]
]
    ## Stucki dithering

proc rows*[Rows: static int, Cols: static int, Inset: static int](matrix: DiffusionMatrix[Rows, Cols, Inset]): int =
    ## The number of rows in this matrix
    return Rows

proc columns*[Rows: static int, Cols: static int, Inset: static int](matrix: DiffusionMatrix[Rows, Cols, Inset]): int =
    ## The number of columns in this matrix
    return Cols

proc inset*[Rows: static int, Cols: static int, Inset: static int](matrix: DiffusionMatrix[Rows, Cols, Inset]): int =
    ## The inset of to use when considering where the current pixel is located in the matrix
    return Inset

proc numerator*[Rows: static int, Cols: static int, Inset: static int](
    matrix: DiffusionMatrix[Rows, Cols, Inset],
    row, column: int
): int =
    ## The inset of to use when considering where the current pixel is located in the matrix
    return matrix[row][column]