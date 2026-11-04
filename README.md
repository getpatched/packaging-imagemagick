# GetPatched ImageMagick recipe

This public repository is a development candidate for Debian 13 Trixie amd64. It pins the exact ImageMagick source from Debian's 2026-10-30 security snapshot and carries the upstream fix for CVE-2026-119124.

## Candidate scope

| Target | Exact source | CVE | Status |
|---|---|---|---|
| Debian Trixie amd64 | `8:7.1.1.43+dfsg1-1+deb13u13` | CVE-2026-119124 | Hosted development verification passed; no production release |

The Debian Security tracker marks Trixie's security `u13` source vulnerable and Bookworm unaffected; no other distro, release, or architecture is claimed. The target descriptor records the immutable snapshot URLs, exact archive hashes, and the checksums listed in the source descriptor. The signed Debian Security index authenticates the `.dsc` hash; its uploader signature has not been separately verified.

## Patch and regression

The candidate applies upstream commit [`270f70f609f659a01aaa2a8ed7bd887f79722d45`](https://github.com/ImageMagick/ImageMagick/commit/270f70f609f659a01aaa2a8ed7bd887f79722d45) to `MagickCore/visual-effects.c`. It corrects pixel-channel iteration and access in `MorphImages()` when the input frames have different channel layouts.

The small PNG pair in `tests/fixtures/` exercises a GrayscaleAlpha first frame followed by an sRGB second frame. The hosted [verification run](https://github.com/getpatched/platform/actions/runs/41793654256) built the exact Debian source and candidate packages, reproduced the invalid write on the installed baseline under Valgrind (exit 97), and passed the same regression on the patched packages (exit 0, three output frames). The candidate-aware advisory comparison found CVE-2026-119124 before the fix and not after it, while retaining unrelated findings. Raw Trivy output did not detect this CVE in either image, so Trivy absence is not presented as remediation evidence. The signed temporary APT repository check fetched and installed the exact packages and verified repository signatures; its temporary signing key was discarded. This is development verification only: no production repository or binary release was published.

The Debian Security `InRelease` signature authenticates the source index containing the `.dsc` and archive hashes. The `.dsc` uploader signature was not separately verified. Verification covers only Debian Trixie amd64; Bookworm, Ubuntu, other architectures, and other ImageMagick versions are outside this result.

## Licensing

GetPatched-authored recipe metadata and documentation are MIT licensed. ImageMagick source, the upstream-derived patch, Debian packaging, and their notices retain their upstream and Debian license terms. No source tarballs or package binaries are published in this repository.
