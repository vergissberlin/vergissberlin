# Apply cross-repo changes (vergissberlin CLI + Homebrew tap)

This cloud agent only has write access to `vergissberlin/vergissberlin`.
Grant the Cursor GitHub App access to the target repos (or apply manually).

## 1. RubyGems ownership (manual — unblocks `gem install` → 0.1.5)

Current RubyGems owner: **ProgrammerQ**. CI push failed with permission denied.

```bash
gem owner vergissberlin --add <rubygems-handle-or-email-for-RUBYGEMS_API_KEY>
```

Then re-run the failed **Release Please** workflow on `vergissberlin-cli` for `v0.1.5`.

Tracking: https://github.com/vergissberlin/vergissberlin-cli/issues/16

## 2. vergissberlin-cli

```bash
git clone https://github.com/vergissberlin/vergissberlin-cli.git
cd vergissberlin-cli
git checkout -b cursor/gem-homebrew-install-86cb
git am /path/to/vergissberlin/docs/cross-repo/vergissberlin-cli/0001-*.patch
git push -u origin HEAD
gh pr create --base main \
  --title "fix(release): Packages resilience + Homebrew install docs" \
  --body "See https://github.com/vergissberlin/vergissberlin-cli/issues/16"
```

Patch covers:

- `.github/workflows/release.yml` — publish to GitHub Packages even if RubyGems fails
- `README.md` — Homebrew install via `vergissberlin/tap`
- `CONTRIBUTING.md` — gem ownership troubleshooting

## 3. homebrew-tap

```bash
git clone https://github.com/vergissberlin/homebrew-tap.git
cd homebrew-tap
git checkout -b cursor/gem-homebrew-install-86cb
git am /path/to/vergissberlin/docs/cross-repo/homebrew-tap/0001-*.patch
# or copy Formula/vergissberlin.rb from this folder
git push -u origin HEAD
gh pr create --base main \
  --title "feat: add vergissberlin formula" \
  --body "See https://github.com/vergissberlin/homebrew-tap/issues/4"
```

SHA256 (`v0.1.5` tarball): `1875aa112154889ec836fd7c3bd3373eed9d2ac79d3e6acde050eabc23cb6c59`

## Install (after tap formula lands)

```bash
brew tap vergissberlin/tap
brew install vergissberlin
# or:
brew install vergissberlin/tap/vergissberlin
```
