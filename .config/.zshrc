# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
# if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
#   source /usr/share/zsh/manjaro-zsh-prompt
# fi

eval "$(starship init zsh)"


plugins=(git ssh-agent)

export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export ZELLIJ_AUTO_ATTACH=true
#export ZELLIJ_AUTO_EXIT=false




XDG_CONFIG_HOME=$HOME/.config

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

setopt noEXTENDED_GLOB
export GTAGSLABEL=pygments
export EDITOR=helix
export VISUAL=neovide-lunarvim

alias vi=nvim
alias vim=nvim
#alias nvim=neovide-lunarvim

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

#eval "$(zellij setup --generate-auto-start zsh)"

# if [[ -z "$ZELLIJ" ]]; then
#     if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
#         zellij attach -c d
#     else
#         zellij
#     fi

#     if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
#         exit
#     fi
# fi

. /opt/asdf-vm/asdf.sh

export HELIX_RUNTIME=~/src/helix/runtime

export PATH=~/elixir-ls:~/src/helix/runtime:$PATH
