#!/usr/bin/env bash

DOTFILES=$(dirname $(realpath $BASH_SOURCE))

# TODO function that checks if it exists (backup or ask)

# update all submodules
git submodule update --init --recursive
git submodule update --recursive --remote


# add symlinks to dotfiles in this repo
for FILE in .zshrc .vimrc .tmux.conf .gitconfig; do
    ln -s $DOTFILES/$FILE $HOME/$FILE
done

for DIR in .oh-my-zsh/ .vim/; do
    ln -s $DOTFILES/$DIR $HOME/
done

mkdir -p $HOME/.config/fish/
ln -s $DOTFILES/config.fish $HOME/.config/fish/config.fish
