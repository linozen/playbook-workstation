# python
set -x WORKON_HOME "$HOME/.virtualenvs"
set -x PROJECT_HOME "$HOME/Projects"
set -g VIRTUALFISH_HOME $WORKON_HOME
set -g VIRTUALFISH_COMPAT_ALIASES "True"
set -g VIRTUALFISH_DEFAULT_PYTHON "$HOME/.asdf/installs/python/3.9.0/bin/python"
source ~/.asdf/asdf.fish

# go
set -Ux GOPATH $HOME/.go

# emacs is king
set -Ux EDITOR emacsclient -t
set -Ux VISUAL emacsclient -t
alias vi 'emacsclient -t'
alias vim 'emacsclient -t'
alias emacs 'emacsclient -t'
alias e 'emacsclient -t'

# img-optimize
alias img-opt '$HOME/Projects/img-optimize/optimize.sh'

# shell
alias c 'clear'
alias ex 'exit'

# exa
alias ls='exa'
alias ll='exa -l'
alias lll='exa -l | less'
alias lla='exa -la'
alias llg='exa -bghHliS --git'
alias llt='exa -T'

# doom
alias ds 'doom sync'
alias du 'doom upgrade'

# ydl
alias ydla 'youtube-dl -f bestaudio --extract-audio --audio-format mp3 --audio-quality 5'
alias ydlv 'youtube-dl'

# history across fishes
function save_history --on-event fish_preexec
    history --save
end
alias hr 'history --merge' # read and merge history from disk

# pure options
set pure_show_system_time true
set pure_symbol_prompt λ

# pure colors
set pure_color_mute 5B6268

# fish colours
set -Ux fish_color_normal 51afef
set -Ux fish_color_command bbc2cf
set -Ux fish_color_quote 98be65
set -Ux fish_color_redirection 51afef
set -Ux fish_color_end 98be65
set -Ux fish_color_error ff6c6b
set -Ux fish_color_param a9a1e1
set -Ux fish_color_selection bbc2cf --bold --background=brblack
set -Ux fish_color_search_match ecbe7b --background=brblack
set -Ux fish_color_history_current --bold
set -Ux fish_color_operator 00a6b2
set -Ux fish_color_escape 00a6b2
set -Ux fish_color_cwd 98be65
set -Ux fish_color_cwd_root ff6c6b
set -Ux fish_color_valid_path --underline
set -Ux fish_color_autosuggestion 5b6268
set -Ux fish_color_user 51afef
set -Ux fish_color_host 51afef
set -Ux fish_color_cancel -r
set -Ux fish_pager_color_completion normal
set -Ux fish_pager_color_description ecbe7b
set -Ux fish_pager_color_prefix bbc2cf --bold --underline
set -Ux fish_pager_color_progress bbc2cf --background=cyan
set -Ux fish_color_comment c678dd
set -Ux fish_color_match --background=brblue

# qt theming
set -Ux QT_QPA_PLATFORMTHEME qt5ct
