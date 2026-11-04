# GetPatched ImageMagick recipe

This public repository is a development candidate for Debian 13 Trixie amd64. It pins the exact ImageMagick source from Debian's 2026-10-30 snapshot and carries the upstream fix for CVE-2026-119124.

## Candidate scope

| Target | Exact source | CVE | Status |
|---|---|---|---|
| Debian Trixie amd64 | `8:7.1.1.43+dfsg1-1+deb13u12` | CVE-2026-119124 | Unverified development candidate; paired package build, regression and scan pending |

The Debian Security tracker marks Trixie's `u12` source vulnerable and Bookworm unaffected; no other distro, release, or architecture is claimed. The target descriptor records the immutable snapshot URLs, exact archive hashes, and the checksums listed in the source descriptor. The `.dsc` uploader signature has not been separately verified.

## Patch and regression

The candidate applies upstream commit [`270f70f609f659a01aaa2a8ed7bd887f79722d45`](https://github.com/ImageMagick/ImageMagick/commit/270f70f609f659a01aaa2a8ed7bd887f79722d45) to `MagickCore/visual-effects.c`. It corrects pixel-channel iteration and access in `MorphImages()` when the input frames have different channel layouts.

The small PNG pair in `tests/fixtures/` exercises a GrayscaleAlpha first frame followed by an sRGB second frame. The command succeeds on an installed upstream-fixed ImageMagick 7.1.2 host build. The platform verification workflow runs the exact Debian source build and package tests, then executes the same fixture against baseline and patched installed images and compares scans using its pinned vulnerability database. Those hosted checks and independent review are still pending. Do not treat this candidate as a verified fix or installable release.

## Licensing

GetPatched-authored recipe metadata and documentation are MIT licensed. ImageMagick source, the upstream-derived patch, Debian packaging, and their notices retain their upstream and Debian license terms. No source tarballs or package binaries are published in this repository.
