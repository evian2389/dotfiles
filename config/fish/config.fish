source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

set PATH ~/.cargo/bin ~/.config/emacs/bin $PATH

# ~/.config/fish/config.fish

function setup_gpg_agent
    # Unset SSH_AGENT_PID to prevent conflicts
    if set -q SSH_AGENT_PID
        unset SSH_AGENT_PID
    end

    # Set SSH_AUTH_SOCK to use the gpg-agent socket
    if test (count $gnupg_SSH_AUTH_SOCK_by) -eq 0 -o $gnupg_SSH_AUTH_SOCK_by != $fish_pid
        set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    end

    # Set GPG_TTY for gpg-agent to connect to the terminal
    set -gx GPG_TTY (tty)

    # Tell gpg-agent about the new tty
    gpg-connect-agent updatestartuptty /bye >/dev/null
end

setup_gpg_agent
