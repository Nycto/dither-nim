# dither-nim

[![Build](https://github.com/Nycto/dither-nim/actions/workflows/build.yml/badge.svg)](https://github.com/Nycto/dither-nim/actions/workflows/build.yml)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/Nycto/dither-nim/blob/main/LICENSE.md)

Dithering algorithms implemented in Nim

## API

[API Documentation](https://nycto.github.io/dither-nim/)

## Algorithms

This library supports two primary classifications of algorithms:

* __[Ordered Dithering](https://en.wikipedia.org/wiki/Ordered_dithering)__: This is a fast dithering algorithm that uses
  a matrix of predefined values to vary what color is selected.
* __[Error Diffusion](https://en.wikipedia.org/wiki/Error_diffusion)__: A slightly slower dithering algorithm that
  tracks the error incurred when a color is clamped to the palette, then distributes that error to surrounding pixels.

A more detailed list of supported algorithms can be found here:

https://nycto.github.io/dither-nim/dither/types.html#DitherModes

## Example

A working example that uses [pixie](https://github.com/treeform/pixie) for images and
[chroma](https://github.com/treeform/chroma) for colors can be seen here:

https://github.com/Nycto/dither-nim/blob/main/example/src/dither_img.nim

## A note on concepts

This library uses Nim [concepts](https://nim-lang.org/docs/manual_experimental.html#concepts) to control the inputs
to its algorithms. This allows it to integrate with arbitrary image, color, and palette libraries -- as long as they
implement the interface described by the concepts.
