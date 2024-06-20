#!/usr/bin/env bash

# Ask for the administrator password upfront
#sudo -v

# Keep-alive: update existing `sudo` time stamp until `osx.sh` has finished
#while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Dotfiles                                                                         #
###############################################################################

if [ ! -d ~/git/dotfiles ]; then
  echo "Cloning joeynguyen/dotfiles repo..."
  git clone git@github.com:joeynguyen/dotfiles.git ~/git/dotfiles
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
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# install Spaceship prompt
if [ ! -d $ZSH_CUSTOM/themes/spaceship-prompt ]; then
  git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
fi
if [ ! -L $ZSH_CUSTOM/themes/spaceship.zsh-theme ]; then
  ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
fi

if [ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
fi

# Create symlink for .zshrc from dotfiles repo
if [ ! -L ~/.zshrc ]; then
  echo "Creating symlink for .zshrc..."
  if [ -f ~/.zshrc  ]; then
    mv ~/.zshrc ~/.zshrc.bak
  fi

  ln -s ~/git/dotfiles/zshrc-mac ~/.zshrc

else
  echo "Symlink for ~/.zshrc already exists."
fi

if [[ ! -L ~/.zprofile && ! -f ~/.zprofile ]]; then
  echo "Creating symlink for .zprofile..."

  ln -s ~/git/dotfiles/zprofile-mac ~/.zprofile
else
  echo "~/.zprofile already exists."
fi

# Create symlink for .profile from dotfiles repo
if [ ! -L ~/.profile ]; then
  if [ -f ~/.profile  ]; then
    mv ~/.profile ~/.profile.bak
  fi

  echo "Creating symlink for .profile..."
  read -p "Is this a work computer? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    ln -s ~/git/dotfiles/profile-mac-work ~/.profile
  else
    ln -s ~/git/dotfiles/profile-mac-personal ~/.profile
  fi;
else
  echo "Symlink for ~/.profile already exists."
fi

###############################################################################
# Tools                                                                       #
###############################################################################

if [ ! -d ~/.config ]; then
  echo "Creating ~/.config directory..."
  mkdir ~/.config
fi

## Tmux
if [ ! -d ~/.config/tmux/ ]; then
  mkdir ~/.config/tmux/
fi

if [ ! -d ~/git/oh-my-tmux ]; then
  echo "Cloning oh-my-tmux dotfiles repo..."
  git clone https://github.com/gpakosz/.tmux.git ~/git/oh-my-tmux/
fi

if [ ! -L ~/.config/tmux/tmux.conf ]; then
    ln -s ~/git/oh-my-tmux/.tmux.conf ~/.config/tmux/tmux.conf
fi

if test $(which stow) && test -L ~/git/dotfiles/; then
  read -p "Run stow? (y/n) " -n 1;
  echo "";

  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Running stow..."
    # need to `cd` into the directory first because the `stow` command doesn't accept having
    # slashes in the last argument, e.g., ~/git/dotfiles/dotconfig
    cd ~/git/dotfiles
    stow -t ~/.config dotconfig
  fi;
fi

