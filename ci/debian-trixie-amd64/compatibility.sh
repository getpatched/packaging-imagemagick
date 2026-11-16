#!/usr/bin/env bash
set -euo pipefail

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
cd "$work"

cat > source.ppm <<'PPM'
P3
2 1
255
255 0 0 0 255 0
PPM

magick-im7.q16 source.ppm -flop result.png
magick-im7.q16 result.png -depth 8 rgb:actual.rgb
printf '\000\377\000\377\000\000' > expected.rgb
cmp expected.rgb actual.rgb
