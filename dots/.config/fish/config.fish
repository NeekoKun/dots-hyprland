# Commands to run in interactive sessions can go here
if status is-interactive
    # No greeting
    set fish_greeting

    # Use starship
    function starship_transient_prompt_func
        starship module character
    end
    if test "$TERM" != "linux"
        starship init fish | source
        enable_transience
    end
    
    # Colors
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # Aliases
    # kitty doesn't clear properly so we need to do this weird printing
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias celar "printf '\033[2J\033[3J\033[1;1H'"
    alias claer "printf '\033[2J\033[3J\033[1;1H'"
    alias pamcan pacman
    alias q 'qs -c ii'
    if test "$TERM" != "linux"
        alias ls 'eza --icons'
    end
    if test "$TERM" = "xterm-kitty"
        alias ssh 'kitten ssh'
    end
end

set -g _cmd_start_time 0
set -g _notify_threshold 10  # seconds

function _preexec --on-event fish_preexec
    set _cmd_start_time (date +%s)
end

function _precmd --on-event fish_postexec
    set elapsed (math (date +%s) - $_cmd_start_time)
    if test $elapsed -ge $_notify_threshold
        paplay /usr/share/sounds/freedesktop/stereo/complete.oga &>/dev/null &
    end
    set _cmd_start_time 0
end

alias cd=z
alias cdi=zi

alias cpf="rsync --progress --human-readable --perms --times"
alias cpd="rsync --progress --human-readable --perms --times --recursive"

zoxide init fish | source
