# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
XDG_CONFIG_HOME=$HOME/.config

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export GTAGSLABEL=pygments
export EDITOR=emacs
export VISUAL=emacs
export QT_QPA_PLATFORMTHEME="qt5ct"

export HU_IP=10.159.156.39

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

alias cdus="cd /home/jongho3/mnt/ccIcBuildServer/workspace/ccIc/src/updateservice"
alias cdcs="cd /home/jongho3/mnt/ccIcBuildServer/workspace/ccIc/src/"

#GHC_PATH=`stack path | grep compiler-bin | sed -e 's/compiler-bin: //'`
#export PATH="$PATH:$GHC_PATH"

#ibus-daemon -drx
#xkbcomp -I$HOME/.xkb $HOME/.keymap.xkb $DISPLAY

#source ~/workspace/config/pc_config.sh
export HOSTALIASES=~/.hosts

alias vi=nvim
