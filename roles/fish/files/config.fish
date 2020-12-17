# python
set -x WORKON_HOME "$HOME/.virtualenvs"
set -x PROJECT_HOME "$HOME/projects"
set -g VIRTUALFISH_HOME $WORKON_HOME
set -g VIRTUALFISH_COMPAT_ALIASES "True"
set -g VIRTUALFISH_DEFAULT_PYTHON "$HOME/.asdf/installs/python/3.9.0/bin/python"
source ~/.asdf/asdf.fish

# go
set -Ux GOPATH $HOME/.go

# paths
contains $GOPATH/bin $fish_user_paths
or set -Ua fish_user_paths $GOPATH/bin
contains $HOME/.local/bin/calibre $fish_user_paths
set -Ua fish_user_paths ~/.local/bin/calibre

# emacs is king
contains $HOME/.emacs.d/bin $fish_user_paths
or set -Ua fish_user_paths $HOME/.emacs.d/bin
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

# pure
set pure_color_mute 5B6268
