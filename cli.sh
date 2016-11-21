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

# Create symlink for .gitignore_global from dotfiles repo
if [ ! -L ~/.gitignore_global ]; then
  if [ -f ~/.gitignore_global ]; then
    mv ~/.gitignore_global ~/.gitignore_global.bak
  fi
  echo "Creating symlink for .globalgitignore..."
  ln -s ~/git/dotfiles/gitignore_global ~/.gitignore_global
  echo "Setting global gitignore file..."
  git config --global core.excludesfile '~/.gitignore_global'
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
  echo "Creating symlink for .zshrc..."
  if [ -f ~/.zshrc  ]; then
    mv ~/.zshrc ~/.zshrc.bak
  fi
  ln -s ~/git/dotfiles/zshrc ~/.zshrc
fi

# Create symlink for .profile from dotfiles repo
if [ ! -L ~/.profile ]; then
  if [ -f ~/.profile ]; then
    mv ~/.profile ~/.profile.bak
  fi
  echo "Creating symlink for .profile..."
  ln -s ~/git/dotfiles/profile ~/.profile
fi

###############################################################################
# Tools                                                                       #
###############################################################################

# Create symlink for .warpc from dotfiles repo
if [ ! -L ~/.warprc ]; then
  if [ -f ~/.warprc ]; then
    mv ~/.warprc ~/.warprc.bak
  fi
  echo "Creating symlink for .warpc..."
  ln -s ~/git/dotfiles/warprc ~/.warprc
fi

# Create symlink for .ackrc from dotfiles repo
if [ ! -L ~/.ackrc ]; then
  if [ -f ~/.ackrc ]; then
    mv ~/.ackrc ~/.ackrc.bak
  fi
  echo "Creating symlink for .ackrc..."
  ln -s ~/git/dotfiles/ackrc ~/.ackrc
fi
