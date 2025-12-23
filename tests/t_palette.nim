import unittest, dither, chroma

let black = rgbx(0, 0, 0, 255)
let gray = rgbx(128, 128, 128, 255)
let white = rgbx(255, 255, 255, 255)

let palette = palette(black, white, gray)

suite "Fixed palette":
  test "Can return the nearest color":
    check(palette.nearestColor(rgbx(200, 200, 200, 200)) == white)
    check(palette.nearestColor(rgbx(10, 10, 10, 200)) == black)
    check(palette.nearestColor(rgbx(100, 100, 100, 200)) == gray)

  test "Can estimate the max distance between colors":
    check(palette.approxMaxColorDistance == 128)

suite "Black and white int pallete":
  test "Can return the nearest color":
    check(BlackAndWhiteIntPalette.nearestColor(10) == 0)
    check(BlackAndWhiteIntPalette.nearestColor(128) == 255)
    check(BlackAndWhiteIntPalette.nearestColor(200) == 255)

  test "Can estimate the max distance between colors":
    check(BlackAndWhiteIntPalette.approxMaxColorDistance == 128)

suite "Grey scale int pallete":
  test "Can return the nearest color":
    # For 8 shades (0, 36, 72, 109, 145, 182, 218, 255)
    check(newGreyScalePalette(8).nearestColor(5) == 0)
    check(newGreyScalePalette(8).nearestColor(36) == 36)
    check(newGreyScalePalette(8).nearestColor(40) == 36)
    check(newGreyScalePalette(8).nearestColor(60) == 72)
    check(newGreyScalePalette(8).nearestColor(127) == 144)
    check(newGreyScalePalette(8).nearestColor(150) == 144)
    check(newGreyScalePalette(8).nearestColor(200) == 216)
    check(newGreyScalePalette(8).nearestColor(240) == 252)

    # For 4 shades (0, 85, 170, 255)
    check(newGreyScalePalette(4).nearestColor(10) == 0)
    check(newGreyScalePalette(4).nearestColor(64) == 85)
    check(newGreyScalePalette(4).nearestColor(128) == 170)
    check(newGreyScalePalette(4).nearestColor(200) == 170)
    check(newGreyScalePalette(4).nearestColor(240) == 255)

    # For 2 shades (0, 255)
    check(newGreyScalePalette(2).nearestColor(0) == 0)
    check(newGreyScalePalette(2).nearestColor(127) == 0)
    check(newGreyScalePalette(2).nearestColor(128) == 255)
    check(newGreyScalePalette(2).nearestColor(255) == 255)

  test "Can estimate the max distance between colors":
    check(newGreyScalePalette(8).approxMaxColorDistance == 32)
    check(newGreyScalePalette(16).approxMaxColorDistance == 16)
    check(newGreyScalePalette(4).approxMaxColorDistance == 64)
    check(newGreyScalePalette(2).approxMaxColorDistance == 128)
