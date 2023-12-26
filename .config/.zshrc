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
export EDITOR=code
export VISUAL=helix

alias hx=helix
alias vi=nvim
alias vim=nvim

alias cdic='cd ~/workspace/hkmc/ccIc/'
alias cdis='cd ~/workspace/hkmc/ccIc/src/'
alias cdiu='cd ~/workspace/hkmc/ccIc/src/updateservice'
alias cdib='cd ~/workspace/hkmc/ccIc/src/build-coconut'
alias cdii='cd ~/workspace/hkmc/ccIc/img'
alias cdil='cd ~/workspace/hkmc/ccIc/log'
alias cdim='cd ~/workspace/hkmc/ccIc/src/meta-ccic'

alias cdrc='cd ~/workspace/hkmc/ccRC/'
alias cdrs='cd ~/workspace/hkmc/ccRC/src/'
alias cdru='cd ~/workspace/hkmc/ccRC/src/updateservice'
alias cdrb='cd ~/workspace/hkmc/ccRC/src/build-coconut'
alias cdri='cd ~/workspace/hkmc/ccRC/img'
alias cdrl='cd ~/workspace/hkmc/ccRC/log'
alias cdrm='cd ~/workspace/hkmc/ccRC/src/meta-ccic'
alias cdm='cd /run/media/jongho3/'
