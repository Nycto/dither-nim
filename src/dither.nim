import dither/[ordered, types, palette, diffusion, quantizer, algorithms]
export ordered, types, palette, diffusion, quantizer, algorithms

proc dither*[Color, Error](
  input: InputImage[Color],
  output: var OutputImage[Color],
  algorithm: DitherModes,
  palette: Palette[Color],
  quantizer: Quantizer[Color, Error]
) =
  ## Applies the a dithering algorithm to `input` and writes it to `output`
  case algorithm
  of DitherModes.Bayer2x2:
    input.orderedDither(output, palette, Bayer2x2)
  of DitherModes.Bayer4x4:
    input.orderedDither(output, palette, Bayer4x4)
  of DitherModes.Bayer8x8:
    input.orderedDither(output, palette, Bayer8x8)
  of DitherModes.FloydSteinberg:
    input.errorDiffusionDither(output, palette, quantizer, FloydSteinberg)
  of DitherModes.JarvisJudiceNinke:
    input.errorDiffusionDither(output, palette, quantizer, JarvisJudiceNinke)
  of DitherModes.Stucki:
    input.errorDiffusionDither(output, palette, quantizer, Stucki)
  of DitherModes.Atkinson:
    input.errorDiffusionDither(output, palette, quantizer, Atkinson)
  of DitherModes.Burkes:
    input.errorDiffusionDither(output, palette, quantizer, Burkes)

proc dither*[Color](
    input: InputImage[Color], output: var OutputImage[Color], algorithm: DitherModes, palette: Palette[Color]
) =
  ## Applies the a dithering algorithm to `input` and writes it to `output`
  dither(input, output, algorithm, ColorQuantizer, palette)
