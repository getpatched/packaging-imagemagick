#!/usr/bin/env bash
set -euo pipefail
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
cd "$work"
magick-im7.q16 -size 2x3 xc:red sample.png
test "$(magick-im7.q16 identify -format '%wx%h' sample.png)" = 2x3
