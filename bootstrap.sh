#!/bin/bash

# DESCRIPTION : This script symlinks all the dotfiles to the home directory. In
# the future more complex bootstrap functionality could be added to install
# packages, set up the environment, etc. This script assumes that the dotfiles
# dotfiles are stored in a directory called .dotfiles in the home directory.
# AUTHOR      : Micah Kepe
# DATE        : 2024-12-26

### Prerequsite checks

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Please install git and try again."
    exit 1
fi

# Check if brew is installed
if ! command -v brew &> /dev/null; then
   echo "Brew is not installed. Please install brew and try again."
   exit 1
fi

### Main script

if [ ! -d ~/.dotfiles ]; then
    echo "Cloning dotfiles..."
    git clone https://github.com/micahkepe/dotfiles
fi

# Set the dotfiles directory
DOTFILES_DIR=~/.dotfiles

# try installing all of the packages int eh Brewfile bundle
echo "Installing packages from Brewfile..."
brew bundle --file=~/.dotfiles/Brewfile

# Symlink helper function
symlink() {
    local src=$1 dst=$2

    # If the file already exists, skip it
    if [ -e "$dst" ]; then
        echo "File $dst already exists. Skipping..."
    else
        echo "Linking $src to $dst"
        ln -s $src $dst
    fi
}

# symlink configs
echo "Linking dotfiles..."
symlink $DOTFILES_DIR/.bashrc ~/.bashrc
symlink $DOTFILES_DIR/.gitconfig ~/.gitconfig
symlink $DOTFILES_DIR/.vimrc ~/.vimrc
symlink $DOTFILES_DIR/.vim ~/.vim
symlink $DOTFILES_DIR/.zshrc ~/.zshrc
symlink $DOTFILES_DIR/.hammerspoon ~/.hammerspoon
symlink $DOTFILES_DIR/nvim ~/.config/nvim
symlink $DOTFILES_DIR/neofetch ~/.config/neofetch
symlink $DOTFILES_DIR/fish ~/.config/fish
symlink $DOTFILES_DIR/tmux/.tmux.conf ~/.tmux.conf
symlink $DOTFILES_DIR/wezterm ~/.config/wezterm
symlink ~/.wezterm.lua $DOTFILES_DIR/wezterm/wezterm.lua
symlink $DOTFILES_DIR/spotify-player ~/.config/spotify-player
symlink $DOTFILES_DIR/ghostty ~/.config/ghostty
# add more here as needed

echo "Dotfiles linked successfully!"
