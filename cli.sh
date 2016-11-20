#!/usr/bin/env bash

# Ask for the administrator password upfront
#sudo -v

# Keep-alive: update existing `sudo` time stamp until `osx.sh` has finished
#while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Git                                                                         #
###############################################################################
if [ ! -d ~/git ]; then
  echo "Creating ~/git directory..."
  mkdir ~/git 
fi

# Clone dotfiles
if [ ! -d ~/git/dotfiles ]; then
  echo "Cloning joeynguyen/dotfiles repo..."
  git clone https://github.com/joeynguyen/dotfiles.git ~/git/dotfiles
fi

###############################################################################
# Zsh                                                                         #
###############################################################################

# Install oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# Create symlink for .zshrc from dotfiles repo
if [ ! -L ~/.zshrc ]; then
  echo "Create symlink for .zshrc..."
  if [ -f ~/.zshrc  ]; then
    mv ~/.zshrc ~/.zshrc.bak
  fi
  ln -s ~/git/dotfiles/zshrc ~/.zshrc
fi

# Create symlink for .warpc from dotfiles repo
if [ ! -L ~/.warprc ]; then
  if [ -f ~/.warprc ]; then
    mv ~/.warprc ~/.warprc.bak
  fi
  echo "Create symlink for .warpc..."
  ln -s ~/git/dotfiles/warprc ~/.warprc
fi

###############################################################################
# Neovim                                                                      #
###############################################################################

# Create symlink for neovim config file from dotfiles repo
if [ ! -L ~/.config/nvim/init.vim ]; then
  echo "Create symlink for neovim config file..."
  if [ ! -d ~/.config/nvim ]; then
    mkdir -p ~/.config/nvim
  fi
  if [ -f ~/.config/nvim/init.vim  ]; then
    mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.bak
  fi
  ln -s ~/git/dotfiles/nvimrc ~/.config/nvim/init.vim
fi
