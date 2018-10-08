#!/bin/sh
DOTFILES=(.config/nvim/dein.toml .config/nvim/dein_lazy.toml .config/nvim/init.vim .screenrc)

for file in ${DOTFILES[@]}
do
  if [ ! -L $HOME/$file ]; then
    ln -fnsv $HOME/dotfiles/$file $HOME/$file
  fi
done
