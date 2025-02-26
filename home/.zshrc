export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE

export VISUAL="nvim --cmd 'let g:flatten_wait=1'"
# zsh automatically changes the keybindings to the vim ones if VISUAL contains
# "vim" or something so change it back to emacs
bindkey -e

# kitty
bindkey '\e[1;3D' backward-word # alt+left
bindkey '\e[1;3C' forward-word # alt+right
bindkey '\e[3~' delete-char # fn+delete (forward delete)

# ^X^E to open VISUAL to edit the command
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE

alias lx='eza --all --oneline --long --group-directories-first'
alias lt='lx --tree'
alias lg='lx --tree -I ".git|node_modules"'
alias yp='yank_path'
alias nv='nvim'
alias icat='kitty +kitten icat'
# Ephemeral playground
alias ep='cd $(mktemp -d)'

alias get_idf='. $HOME/esp/esp-idf/export.sh'

alias gs='git status'
alias ga='git add'
alias gr='git restore'
alias grs='git restore --staged'
alias gd='git diff'
alias gdc='git diff --cached'
alias gch='git checkout'
alias gc='git commit'
alias gcm='git commit -m'
alias gcan='git commit --amend --no-edit'
alias gl='git log'
alias glg='git log --graph --oneline'
alias glga='git log --graph --oneline --all'
alias gsh='git stash'
alias gshp='git stash pop'
alias gf='git fetch'
alias gb='git branch'
alias gba='git branch --all'

function git_current_branch() {
    branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [[ -z $branch ]]
    then
        :
    else
        echo $'\n'"($branch)"
    fi
}
setopt PROMPT_SUBST
export PROMPT='%F{yellow}$(git_current_branch)%f
%F{blue}%~%f
%(0?.%F{green}%#%f.%F{red}%#%f) '

autoload -Uz compinit && compinit

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/code/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/code/atcoder/tools/bin:$PATH"

# The directory contains python3 and pip3 which shouldn't take precedence over
# the normally installed ones
# export PATH="$PATH:$HOME/.platformio/penv/bin"

function atcstart() {
    atcinit "$1" <(pbpaste) || return 1
    cd "$1"
    nvim -c '/input!' -c 'nohl' src/main.rs
    cd -
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# # Haskell
# [ -f "/Users/rjooske/.ghcup/env" ] && source "/Users/rjooske/.ghcup/env" # ghcup-env
#
# # opam configuration
# [[ ! -r /Users/rjooske/.opam/opam-init/init.zsh ]] || source /Users/rjooske/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
