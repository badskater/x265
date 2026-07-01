# Linux port: changes vs. upstream

This repo (`badskater/x265-new`) is a real GitHub fork of
[jpsdr/x265](https://github.com/jpsdr/x265), so it shares full history and
tags with upstream. Our changes live on top of `x265_mod` (the fork's default
branch). To pull future upstream updates:

```bash
git fetch upstream x265_mod   # or: git fetch origin x265_mod, if using GitHub's fork-sync
```

## What we changed, relative to `upstream/x265_mod`

Real content changes only (mode-bit flips and CRLF/LF noise from the
Windows checkout excluded — see "How to re-check" below):

1. **`source/common/param.cpp`** (8 lines) — replaced MSVC-only
   `strcpy_s`/`strcat_s` with `snprintf`/`strcat`. glibc has no equivalent of
   the Windows "secure CRT" functions; this failed to compile on Linux/GCC
   and Linux/Clang.
2. **`source/dynamicHDR10/json11/json11.cpp`** (1 line) — added
   `#include <cstdint>`. The file uses `uint8_t` but never included a header
   that guarantees it; only compiled on Windows because the type leaked in
   transitively via MSVC/MinGW headers.
3. **`build/linux/Build_{GCC,Clang}*.sh`** (18 new files) — Linux
   equivalents of `build/MSYS_jpsdr/Build_*.sh`, enabling the same mod
   features (avisynth, vapoursynth, HDR10+, SCC, multiview, alpha) but using
   Linux-native conventions: dynamic linking, `-O3` instead of
   `-static`/`-Ofast`/`-ffast-math`. `build/linux/make-Makefiles.bash` and
   `multilib.sh` (pre-existing, generic upstream scripts) were left as-is.
4. **`AGENTS.md`**, **`CLAUDE.md`** — engineering-process docs, unrelated to
   the port itself.

## How to re-check when upstream updates

```bash
git fetch upstream x265_mod

# Real diff, with mode/CRLF noise filtered out:
git diff --stat -w upstream/x265_mod HEAD

# Just our two source fixes, to see if upstream touched the same lines:
git diff -w upstream/x265_mod HEAD -- source/common/param.cpp source/dynamicHDR10/json11/json11.cpp
```

If upstream hasn't touched `param.cpp`'s AQAuto logging block or
`json11.cpp`'s includes, a straight rebase is safe:

```bash
git rebase upstream/x265_mod
```

If those specific lines *have* changed upstream (e.g. they fixed the same
bug themselves, or restructured that code), the rebase will conflict there —
resolve by keeping whichever fix is still needed (upstream may have already
fixed `strcpy_s`/`cstdint` themselves, in which case ours becomes a no-op and
can be dropped).

The `build/linux/*.sh` scripts are new files with no upstream counterpart, so
they won't conflict — they'll just carry forward untouched.
