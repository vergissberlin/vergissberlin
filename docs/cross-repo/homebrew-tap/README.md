# Homebrew Tap of [vergissberlin](https://github.com/vergissberlin)

This is a [Homebrew tap](https://docs.brew.sh/Taps) for open source projects of vergissberlin.

## Usage

To install a formula from this tap, run:

```sh
brew tap vergissberlin/tap
brew install <formula>
```

Example — install the `vergissberlin` CLI:

```sh
brew tap vergissberlin/tap
brew install vergissberlin
# or:
brew install vergissberlin/tap/vergissberlin
```

Or, to install the latest development version of a formula, run:

```sh
brew install --HEAD vergissberlin/tap/<formula>
```

### Formulae

| Formula | Description |
| ------- | ----------- |
| [thinkport](Formula/thinkport.rb) | Informations about Thinkport GmbH |
| [vergissberlin](Formula/vergissberlin.rb) | Useless CLI gem (`vergissberlin`) |

## Contributing

To add a new formula to this tap, run:

```sh
brew create <url>
```

Then, edit the generated formula file to add a description, update the homepage, and add a test.

### Create sha

```sh
wget <file>
shasum -a 256 <file>
```

## License

[MIT](LICENSE)
