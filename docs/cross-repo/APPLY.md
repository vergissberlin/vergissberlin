# Apply cross-repo changes (vergissberlin CLI + Homebrew tap)

This agent only has write access to `vergissberlin/vergissberlin`. The changes
below are ready to apply to the target repositories. Grant the Cursor GitHub App
access to those repos and re-run, or apply manually:

## 1. RubyGems ownership (manual)

`gem install vergissberlin` still installs **0.0.16** because publish of **0.1.5**
failed: the CI `RUBYGEMS_API_KEY` is not an owner of the gem. Current owner:
**ProgrammerQ**.

While logged in as ProgrammerQ:

```bash
gem owner vergissberlin --add <handle-or-email-for-RUBYGEMS_API_KEY>
```

Confirm the secret `RUBYGEMS_API_KEY` on `vergissberlin/vergissberlin-cli`, then
re-run the failed Release Please workflow for `v0.1.5` (or `gem push` once).

## 2. vergissberlin-cli

```bash
git clone https://github.com/vergissberlin/vergissberlin-cli.git
cd vergissberlin-cli
git checkout -b cursor/gem-homebrew-install-86cb
git am path/to/docs/cross-repo/vergissberlin-cli/0001-*.patch
# or copy files:
# cp release.yml .github/workflows/release.yml
# cp README.md CONTRIBUTING.md .
git push -u origin HEAD
gh pr create --base main --title "fix(release): Homebrew docs + Packages publish resilience" --body "See docs/cross-repo/APPLY.md"
```

## 3. homebrew-tap

```bash
git clone https://github.com/vergissberlin/homebrew-tap.git
cd homebrew-tap
git checkout -b cursor/gem-homebrew-install-86cb
git am path/to/docs/cross-repo/homebrew-tap/0001-*.patch
# or:
# cp Formula/vergissberlin.rb Formula/
# cp README.md .
git push -u origin HEAD
gh pr create --base main --title "feat: add vergissberlin formula" --body "Install via brew tap vergissberlin/tap && brew install vergissberlin"
```

## Install (after tap lands)

```bash
brew tap vergissberlin/tap
brew install vergissberlin
```
