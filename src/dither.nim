import dither/[ordered, types, palette, diffusion, quantizer, matrix]
export ordered, types, palette, diffusion, quantizer, matrix

proc dither*(input: InputImage, output: var OutputImage, algorithm: DitherModes, palette: Palette) =
    ## Applies the a dithering algorithm to `input` and writes it to `output`
    case algorithm
    of DitherModes.Bayer2x2: input.orderedDither(output, palette, Bayer2x2)
    of DitherModes.Bayer4x4: input.orderedDither(output, palette, Bayer4x4)
    of DitherModes.Bayer8x8: input.orderedDither(output, palette, Bayer8x8)
    of DitherModes.FloydSteinberg: input.errorDiffusionDither(output, palette, ColorQuantizer, FloydSteinberg)
    of DitherModes.JarvisJudiceNinke: input.errorDiffusionDither(output, palette, ColorQuantizer, JarvisJudiceNinke)
    of DitherModes.Stucki: input.errorDiffusionDither(output, palette, ColorQuantizer, Stucki)
    of DitherModes.Atkinson: input.errorDiffusionDither(output, palette, ColorQuantizer, Atkinson)
    of DitherModes.Burkes: input.errorDiffusionDither(output, palette, ColorQuantizer, Burkes)