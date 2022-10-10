# pure promp optimizations
set pure_show_system_time true

# path
fish_add_path $HOME/.emacs.d/bin
fish_add_path $HOME/.local/bin

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
