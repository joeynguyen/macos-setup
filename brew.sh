#!/usr/bin/env bash

# Install Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

BREWFILE_LOCATION='~/git/dotfiles/Brewfile'

if [ -f "$BREWFILE_LOCATION" ]; then
  read -p "Install apps in Brewfile? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    brew -f $BREWFILE_LOCATION install
  fi;
else
  echo "$BREWFILE_LOCATION does not exist."
fi

