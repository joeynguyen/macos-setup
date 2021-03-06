#!/usr/bin/env bash

###############################################################################
# Neovim                                                                      #
###############################################################################

# TODO: Add npm install -g eslint babel-eslint eslint-plugin-react
# Check to see if those libraries exists first

# Create symlink for neovim config file from dotfiles repo
if [ ! -L ~/.config/nvim/init.vim ]; then
  echo "Creating symlink for neovim config file..."
  if [ ! -d ~/.config/nvim ]; then
    mkdir -p ~/.config/nvim
  fi
  if [ -f ~/.config/nvim/init.vim  ]; then
    mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.bak
  fi
  ln -s ~/git/dotfiles/nvimrc ~/.config/nvim/init.vim
fi

# Fix for Neovim issue with Ctrl-h not being able to be remapped.
if [ ! -f ~/$TERM.ti  ]; then
  echo "Fix Neovim issue with Ctrl-h not being able to be remapped"
  infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > ~/$TERM.ti && tic ~/$TERM.ti
fi

# Check for Python 2,
# Install if we don't have it
if test ! $(which python); then
  echo "Installing Python 2..."
  brew install python
fi

# Check for Python 3,
# Install if we don't have it
if test ! $(which python3); then
  echo "Installing Python 3..."
  brew install python3
fi

if test $(which pip2); then
  if [ ! -d ~/Library/Python/2.7/lib/python/site-packages/neovim ]; then
    echo "Installing Python 2 support for Neovim..."
    pip2 install --user neovim
  fi
fi

if test $(which pip3); then
  if [ ! -d ~/Library/Python/3.5/lib/python/site-packages/neovim ]; then
    echo "Installing Python 3 support for Neovim..."
    pip3 install --user neovim
  fi
fi

# Install Vim Plug
if [ ! -f ~/.config/nvim/autoload/plug.vim ]; then
  echo "Installing Vim Plug..."
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
