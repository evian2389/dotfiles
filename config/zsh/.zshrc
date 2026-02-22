  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.
  #
  ##############GUIX##########
  
  GUIX_PROFILE="/home/orka/guix-system/env/profile"
  source "$GUIX_PROFILE/etc/profile"
  #unset GUIX_PROFILE
  
  # 추가 프로필 (예: 개인용 도구)
  export GUIX_PROFILE_EXTRA=$HOME/.guix-profiles/orka-extra
  if [ -f "$GUIX_PROFILE_EXTRA/etc/profile" ]; then
    source "$GUIX_PROFILE_EXTRA/etc/profile"
  fi
  
  
  #export GTK_IM_MODULE=fcitx
  #export QT_IM_MODULE=fcitx
  export XMODIFIERS=@im=fcitx
  export GLFW_IM_MODULE=fcitx
  
  export BROWSER=google-chrome
  
  export XDG_DATA_DIRS="$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$HOME/.local/share:$XDG_DATA_DIRS"
  
  
  export PATH=$PATH:$HOME/.npm-global/bin:$HOME/.local/bin:~/.cargo/bin:~/.npm-packages/bin:~/.config/emacs/bin/:~/.nix-profile/bin
  #################
  # nix
  if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
  . ~/.nix-profile/etc/profile.d/nix.sh
  fi
  #
  # ################
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
  
 # source $HOME/dotfiles/config/zsh/cachyos-config.zsh
  
  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
  
  
  # BEGIN opam configuration
  # This is useful if you're using opam as it adds:
  #   - the correct directories to the PATH
  #   - auto-completion for the opam binary
  # This section can be safely removed at any time if needed.
  [[ ! -r '/home/orka/.opam/opam-init/init.zsh' ]] || source '/home/orka/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
  # END opam configuration
  
  #export HELIX_RUNTIME=~/workspace/helix/runtime
  export EDITOR=helix
  export VISUAL=helix
  
  
  source /home/orka/.config/broot/launcher/bash/br
  
  unset SSH_AGENT_PID
  if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  fi
  export GPG_TTY=$(tty)
  gpg-connect-agent updatestartuptty /bye >/dev/null
  
  alias em="emacs -nw"
  alias ls="eza -al"
  alias tree="eza --tree -a"
  
  #export ZELLIJ=zellij
  #export ZELLIJ_SESSION_NAME=main
  
  if [[ -z "$ZELLIJ" ]]; then
      if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
          zellij attach -c
      else
          zellij
      fi
  
      if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
          exit
      fi
  fi

source /home/orka/.config/broot/launcher/bash/br

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

