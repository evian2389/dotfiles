XDG_CONFIG_HOME=$HOME/.config

export LANG=en_US.UTF-8

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found


# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region


eval "$(starship init zsh)"
eval "$(zoxide init zsh)"


# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='exa'
alias cd='z'
alias vim='nvim'
alias c='clear'
alias vi=nvim
alias vim=nvim
alias ine='hx $(fzf -m --preview="bat --color=always {}")'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

plugins=(git ssh-agent)

export ZELLIJ_AUTO_ATTACH="true"
#export ZELLIJ_AUTO_EXIT=false
export ASDF_CONFIG_FILE=~/.asdf
export ASDF_DATA_DIR=~/.asdf
export ASDF_DIR=~/.asdf

# Golang environment variables
#export GOROOT=$HOME/.go
#export GOPATH=$XDG_CONFIG_HOME/go
# Update PATH to include GOPATH and GOROOT binaries
export PATH=$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin/:$HOME/bin/:$PATH


export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
source <(fzf --zsh)


setopt noEXTENDED_GLOB
export EDITOR=emacs
export VISUAL=hx


#eval "$(zellij setup --generate-auto-start zsh)"

 if [[ -z "$ZELLIJ" ]]; then
     if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
         zellij attach -c w
     else
         zellij
     fi

     if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
         exit
     fi
 fi

. $HOME/.asdf/asdf.sh

export HELIX_RUNTIME=~/src/helix/runtime
export PATH=~/elixir-ls:~/src/helix/runtime:/home/orka/.asdf/bin:$PATH


source ~/.aider_api_key
source /home/orka/.config/broot/launcher/bash/br
