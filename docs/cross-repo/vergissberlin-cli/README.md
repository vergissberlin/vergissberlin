# Vergissberlin

Some hot useless stuff! Trust me, there is no functionality.

[![CI](https://github.com/vergissberlin/vergissberlin-cli/actions/workflows/ci.yml/badge.svg)](https://github.com/vergissberlin/vergissberlin-cli/actions/workflows/ci.yml)
[![Gem Version](https://badge.fury.io/rb/vergissberlin.svg)](https://badge.fury.io/rb/vergissberlin)
[![Coverage Status](https://coveralls.io/repos/github/vergissberlin/vergissberlin-cli/badge.svg?branch=main)](https://coveralls.io/github/vergissberlin/vergissberlin-cli?branch=main)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE.txt)

## Installation

### For End Users

**RubyGems.org** (default Ruby path):

```ruby
gem "vergissberlin"
```

```bash
bundle install
# or
gem install vergissberlin
```

**Homebrew** ([vergissberlin/homebrew-tap](https://github.com/vergissberlin/homebrew-tap)):

```bash
brew tap vergissberlin/tap
brew install vergissberlin
# or one-liner:
brew install vergissberlin/tap/vergissberlin
```

**GitHub Packages** ([packages](https://github.com/vergissberlin/vergissberlin-cli/packages)):

```ruby
source "https://rubygems.pkg.github.com/vergissberlin" do
  gem "vergissberlin"
end
```

Authenticate Bundler (classic PAT with `read:packages`):

```bash
bundle config https://rubygems.pkg.github.com/vergissberlin USERNAME:TOKEN
```

### For Developers

```bash
git clone https://github.com/vergissberlin/vergissberlin-cli.git
cd vergissberlin-cli
bundle install
bundle exec rake test
bundle exec vergissberlin --help
```

Ruby 3.2+ is required.

## Usage

```bash
vergissberlin          # print the rainbow "THATS COOL" banner
vergissberlin --version  # print installed version (also -v)
vergissberlin --help
```

The default banner uses a diagonal rainbow (ANSI truecolor) when stdout is a
TTY. Set `NO_COLOR=1` to disable colors, or `FORCE_COLOR=1` to force them
(overrides `NO_COLOR`). Use `FORCE_COLOR=0` to disable colors explicitly.

## Development

```bash
bundle install
bundle exec rake test
```

Coverage reports are written to `coverage/` (HTML + LCOV). CI uploads LCOV to Coveralls.

## Release

Releases are automated with [Release Please](https://github.com/googleapis/release-please).

1. Merge conventional commits into `main`
2. Release Please opens (or updates) a release PR with changelog + version bump
3. Merging that PR creates a GitHub release/tag
4. The release workflow publishes the gem to **RubyGems.org** and **GitHub Packages**

All Conventional Commit types (`feat`, `fix`, `docs`, `refactor`, `chore`, …) appear in the changelog and can open a release PR. Version bumps still follow SemVer (`feat` / `fix` / `perf` / breaking).

See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## Contributing

Bug reports and pull requests are welcome. Please read [CONTRIBUTING.md](CONTRIBUTING.md) and use [Conventional Commits](https://www.conventionalcommits.org/).

## License

The gem is available as open source under the terms of the [MIT License](LICENSE.txt).
