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
    check(BlackAndWhiteIntPalette.nearestColor(128) == 0)
    check(BlackAndWhiteIntPalette.nearestColor(200) == 255)

  test "Can estimate the max distance between colors":
    check(BlackAndWhiteIntPalette.approxMaxColorDistance == 128)
