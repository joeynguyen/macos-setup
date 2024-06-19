#!/usr/bin/env bash

###############################################################################
# Neovim                                                                      #
###############################################################################

# TODO: Add npm install -g eslint babel-eslint eslint-plugin-react
# Check to see if those libraries exists first

# Create symlink for neovim config file from dotfiles repo
if [ ! -L ~/.config/nvim ]; then
  if [ ! -d ~/git/kickstart.nvim ]; then
    echo "Cloning joeynguyen/dotfiles repo..."
    git clone git@github.com:joeynguyen/kickstart.nvim.git ~/git/kickstart.nvim

  fi
  echo "Creating symlink for neovim config file..."
  ln -s ~/git/kickstart.nvim ~/.config/nvim
fi

