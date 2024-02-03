type
    DiffusionMatrix*[Rows: static int, Cols: static int] = object
        ## Uses numerators in a matrix to determine the distribution of errors surrounding a pixel
        data: array[Rows, array[Cols, int]]
        inset*: int
        denominator*: int

    ThresholdMatrix*[N: static int] = array[N, array[N, int]]
        ## Uses a matrix of integers as a threshold map for ordered dithering

proc matrix[Rows: static int, Cols: static int](inset, denom: int; data: array[Rows, array[Cols, int]]): auto =
    return DiffusionMatrix[Rows, Cols](data: data, inset: inset, denominator: denom)

const Bayer2x2*: ThresholdMatrix[2]  = [
    [ 0, 2 ],
    [ 3, 1 ]
]
    ## Bayer 2x2 dithering

const Bayer4x4*: ThresholdMatrix[4]  = [
    [ 1,  9,  3,  11 ],
    [ 13, 5,  15, 7  ],
    [ 4,  12, 2,  10 ],
    [ 16, 8,  14, 6  ]
]
    ## Bayer 4x4 dithering

const Bayer8x8*: ThresholdMatrix[8] = [
    [ 0, 32,  8, 40,  2, 34, 10, 42],
    [48, 16, 56, 24, 50, 18, 58, 26],
    [12, 44,  4, 36, 14, 46,  6, 38],
    [60, 28, 52, 20, 62, 30, 54, 22],
    [ 3, 35, 11, 43,  1, 33,  9, 41],
    [51, 19, 59, 27, 49, 17, 57, 25],
    [15, 47,  7, 39, 13, 45,  5, 37],
    [63, 31, 55, 23, 61, 29, 53, 21]
]
    ## Bayer 8x8 dithering

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

const Burkes* = matrix[2, 5](2, 32, [
    [ 0, 0, 0, 8, 4 ],
    [ 2, 4, 8, 4, 2 ],
])
    ## Burkes dithering

proc maxThreshold*[N: static int](thresholds: ThresholdMatrix[N]): int = N * N

proc threshold*[N: static int](thresholds: ThresholdMatrix[N], x, y: int): int = thresholds[y mod N][x mod N]

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