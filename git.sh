#!/usr/bin/env bash

# This step needs to be done before cli.sh

###############################################################################
# Git                                                                         #
###############################################################################

if [ ! -d ~/git ]; then
  echo "Creating ~/git directory..."
  mkdir ~/git
fi

if [ ! -d ~/.ssh ]; then
  echo "Creating ~/.ssh directory..."
  mkdir ~/.ssh
fi

if [ ! -f ~/.ssh/id_ed25519.pub ]; then
  echo "Creating SSH keys..."
  read -p "Enter your Github email [username@email.com]: " email
  ssh-keygen -t ed25519 -C $email
  echo "Follow these instructions to complete adding your SSH key to the ssh-agent:"
  echo "https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent"
fi

