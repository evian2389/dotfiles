# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

plugins=(git ssh-agent)

export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
XDG_CONFIG_HOME=$HOME/.config

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

setopt noEXTENDED_GLOB
export GTAGSLABEL=pygments
export EDITOR=emacs
export VISUAL=emacs

alias vi=nvim
alias vim=nvim
alias cds='cd ~/workspace/hkmc/hkmc5th/src/'
alias cdu='cd ~/workspace/hkmc/hkmc5th/src/AppUpgrade'
alias cdi='cd ~/workspace/hkmc/hkmc5th/img/'
alias cdc='cd ~/workspace/hkmc/hkmc5th/meta-mango2/recipes-app/'
alias cdcc='cd ~/workspace/hkmc/ccIc/'
alias cdcs='cd ~/workspace/hkmc/ccIc/src/'
alias cdcu='cd ~/workspace/hkmc/ccIc/src/updateservice'
alias cdcb='cd ~/workspace/hkmc/ccIc/src/build-coconut'
alias cdci='cd ~/workspace/hkmc/ccIc/img'
alias cdcl='cd ~/workspace/hkmc/ccIc/log'
alias cdcm='cd ~/workspace/hkmc/ccIc/src/meta-ccic'
alias cdm='cd /run/media/jongho3/'

