# Package

version       = "0.1.0"
author        = "Nycto"
description   = "A CLI tool for dithering an image"
license       = "Apache-2.0"
srcDir        = "src"
bin           = @["dither_img"]


# Dependencies

requires "nim >= 1.6.14", "dither", "pixie >= 5"
