#!/bin/bash

#mkdir -p ~/.xkb/symbols/

#cp mykeys ~/.xkb/symbols/mykeys

ln -sf ~/dotfiles/.xkb ~/.xkb
ln -sf ~/dotfiles/.xkb/.keymap.xkb ~/.keymap.xkb

##test
##xkbcomp -I$HOME/.xkb $HOME/.keymap.xkb $DISPLAY
