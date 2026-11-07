# GetPatched ImageMagick recipe

This public repository contains target-specific ImageMagick backport recipes for Debian 13 Trixie amd64. It pins the exact ImageMagick source from Debian's 2026-10-30 security snapshot and does not publish binaries.

## Candidate scope

| Target | Baseline / candidate version | CVE | Status |
|---|---|---|---|
| Debian Trixie amd64 | baseline `8:7.1.1.43+dfsg1-1+deb13u13`, verified candidate `8:7.1.1.43+dfsg1-1+deb13u13+getpatched2` | CVE-2026-119124 | Hosted development verification passed; no production release |
| Debian Trixie amd64 | baseline `8:7.1.1.43+dfsg1-1+deb13u13`, verified candidate `8:7.1.1.43+dfsg1-1+deb13u13+getpatched2` | CVE-2026-116159 | Hosted development verification passed; no production release |

The Debian Security tracker marks Trixie's security `u13` source vulnerable and Bookworm unaffected; no other distro, release, or architecture is claimed. The target descriptor records the immutable snapshot URLs, exact archive hashes, and the checksums listed in the source descriptor. The signed Debian Security index authenticates the `.dsc` hash; its uploader signature has not been separately verified.

## Patch and regression

The verified candidate combines two upstream fixes:

- [CVE-2026-119124, upstream commit `270f70f609f659a01aaa2a8ed7bd887f79722d45`](https://github.com/ImageMagick/ImageMagick/commit/270f70f609f659a01aaa2a8ed7bd887f79722d45) corrects pixel-channel iteration and access in `MorphImages()` when input frames have different channel layouts. The small PNG pair in `tests/fixtures/` uses a GrayscaleAlpha first frame followed by an sRGB second frame.
- [CVE-2026-116159, upstream commit `68168e6e5617e4cc478452777586e408f542362b`](https://github.com/ImageMagick/ImageMagick/commit/68168e6e5617e4cc478452777586e408f542362b) frees the `-cdl` file buffer in both the modern CLI and legacy `mogrify` code paths. The PPM/XML fixture pair exercises `magick -cdl` and `mogrify -cdl`.

Hosted [verification run 42369255337](https://github.com/getpatched/platform/actions/runs/42369255337) built the exact Debian source and candidate packages without publishing binaries. On the exact installed baseline, Valgrind reports the 4,464-byte definite `-cdl` leak through `CLIOption` for `magick` and `MogrifyImage` for `mogrify`, and the MorphImages regression reports an invalid write (exit 97). The installed patched packages pass both `-cdl` checks with zero definite lost bytes or Memcheck errors; the MorphImages control passes with three output frames. Debian's Q16 and Q16-HDRI package suites each pass 87/87 with no skips, failures, or errors.

The candidate-aware scan found both target CVEs on the baseline and neither on the candidate; unrelated findings remain. Raw Trivy 0.70.0 does not report these CVEs in either image, so its absence is not treated as remediation evidence or a clean-scan claim. The isolated temporary signed APT repository check verified Release signatures/by-hash metadata, installed the exact candidate version, and fetched its source package; its temporary repository/key were discarded. The run reports `candidateVerified=true`, `verificationChecksPassed=true`, and `releaseEligible=false` because production publication is disabled. No production repository, index, or binary release was published.

The Debian Security `InRelease` signature authenticates the source index containing the `.dsc` and archive hashes. The `.dsc` uploader signature was not separately verified. Verification covers only Debian Trixie amd64; Bookworm, Ubuntu, other architectures, and other ImageMagick versions are outside this result.

## Licensing

GetPatched-authored recipe metadata and documentation are MIT licensed. ImageMagick source, the upstream-derived patch, Debian packaging, and their notices retain their upstream and Debian license terms. No source tarballs or package binaries are published in this repository.
