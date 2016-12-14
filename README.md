## Usage:
Run all:

    $ ./setup all

Run a single script, for example: neovim.sh:

    $ ./setup neovim

Run `osxprep.sh`, `brew.sh`, `osx.sh`, and `cli.sh`:

    $ ./setup osxprep brew osx cli

Note, some scripts depend on others to have been run first to get the necessary tools unless those tools have been installed through other means. Specifically `osxprep.sh` and `brew.sh` should be ran before `cli.sh` and `neovim.sh`.


Inspired by https://github.com/donnemartin/dev-setup.
