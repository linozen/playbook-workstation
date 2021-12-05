# pure promp optimizations
set pure_show_system_time true

# path
fish_add_path $HOME/.emacs.d/bin
fish_add_path $HOME/.local/bin

# environment variables
set -x DOCKER_HOST "unix:///run/user/1000/docker.sock"
set -x DOCKER_BUILDKIT 1
set -x COMPOSE_DOCKER_CLI_BUILD 1

if status is-interactive
    fish_vi_key_bindings
    # Emulates vim's cursor shape behavior
    # Set the normal and visual mode cursors to a block
    set fish_cursor_default block
    # Set the insert mode cursor to a line
    set fish_cursor_insert line
    # Set the replace mode cursor to an underscore
    set fish_cursor_replace_one underscore
    # The following variable can be used to configure cursor shape in
    # visual mode, but due to fish_cursor_default, is redundant here
    set fish_cursor_visual block
    bind -M insert \cf accept-autosuggestion
    # asdf
    source ~/.asdf/asdf.fish
    asdf direnv hook fish | source
    cat ~/.cache/wal/sequences
end

# dracula theme
set -U fish_color_normal normal
set -U fish_color_command 50fa7b
set -U fish_color_quote f1fa8c
set -U fish_color_redirection 50fa7b
set -U fish_color_end 50fa7b
set -U fish_color_error ff5555
set -U fish_color_param 8be9fd
set -U fish_color_comment 5b6268
set -U fish_color_match --background=brblue
set -U fish_color_selection white --bold --background=brblack
set -U fish_color_search_match bryellow --background=brblack
set -U fish_color_history_current --bold
set -U fish_color_operator bd93f9
set -U fish_color_escape bd93f9
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_valid_path --underline
set -U fish_color_autosuggestion 555 brblack
set -U fish_color_user brgreen
set -U fish_color_host normal
set -U fish_color_cancel -r
set -U fish_pager_color_completion normal
set -U fish_pager_color_description f1fa8c
set -U fish_pager_color_prefix normal --bold --underline
set -U fish_pager_color_progress brwhite --background=cyan

# TODO aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cb='cd -'

alias q=exit
alias clr=clear
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -pv'
alias wget='wget -c'
alias path='echo -e $PATH//:/\\n'
alias ports='netstat -tulanp'
alias nn="nautilus ."

alias d="docker"
alias dc="docker-compose"
alias dsp="docker system prune"
alias dspa="docker system prune -a"

alias et="emacsclient -t"
alias e="emacsclient -n -c"

alias rlde="systemctl --user restart emacs.service && doom sync && systemctl --user restart emacs.service"
alias rldf="source ~/.config/fish/config.fish"

alias mk=make
alias gurl='curl --compressed'

alias shutdown='sudo shutdown'
alias reboot='sudo reboot'

alias y='xclip -selection clipboard -in'
alias p='xclip -selection clipboard -out'

alias jc='journalctl -xe'
alias sc=systemctl
alias ssc='sudo systemctl'

alias exa="exa --group-directories-first --git";
alias l="exa -blF";
alias ll="exa -abghilmu";
alias llm='ll --sort=modified'
alias la="LC_COLLATE=C exa -ablF";
alias tree='exa --tree'

# starship prompt
starship init fish | source
