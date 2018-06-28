# ZSHRC
# Author: Martijn van der Veen (turiphro)

# the Where
export DOTFILES=$(dirname $(realpath ${(%):-%N})) # actual dir .zshrc lives in
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.oh-my-zsh-custom" # outside .oh-my-fish so submodules in dotfiles work

function zsh_add_plugin () {
    echo "git submodule add -f \"$1\" .oh-my-zsh-custom/plugins/(basename $)"
    _BASE=${$(basename $1)%.*}
    cd $DOTFILES && git submodule add -f "$1" .oh-my-zsh-custom/plugins/$_BASE && cd -
}

## the Visual
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"  # robbyrussell, bira, fishy

DEFAULT_USER='martijn' # hide user from prompt when logged in locally

# Time stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"


## the Plugins
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  autojump                  # jump to often-visited dirs (j SUBSTR; show with j -s)
  common-aliases            # H/T/G/L/NUL, ls aliases, interactive rm/cp/mv, py autocomplete
  dircycle                  # CTRL+SHIFT+ < > moving through dir history
  #django
  #docker                   # docker autocomplete (already working?)
  git
  git-flow
  history
  history-substring-search  # type, then UP/DOWN (ported from Fish)
  #pip                      # (very slow)
  python
  zsh-syntax-highlighting   # highlight while typing (similar to Fish)
  zsh-autosuggestions       # auto suggestions based on history (ported from Fish)
)

source $ZSH/oh-my-zsh.sh

## the Plugin user configuration
unalias rm cp mv  # undo from common-aliases
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'


## the Variables
export PATH=$PATH:~/stack/doc/com/settings/bin/
export EDITOR='vim'


## the Aliases
alias t="tree"
alias t1="tree -L 1"
alias t2="tree -L 2"
alias t3="tree -L 3"
alias o=xdg-open
alias py2=ipython
alias py=ipython3
alias jqc='jq -C'        # colour-aware
alias par='parallel'
alias git-graph="git log --graph --all --oneline --decorate"

eval $(thefuck --alias --enable-experimental-instant-mode)


## the Custom Functions

function mkcd() {
    mkdir -p "$@" && cd "$@"
}

function cdl() {
    cd "$@" && ls -al
}

function cdls() {
    cd "$@" && ls
}

# highlight
function hl() {
    grep "$@|" --color=always -E
}

# Data science
function termplot() {
    WIDTH=$(tput cols)
    HEIGHT=$(expr (tput lines) - 3)
    if not contains -- "--stream" $@; then
        set extra --exit
    fi
    feedgnuplot --terminal "dumb $WIDTH,$HEIGHT" $@ $extra
}

function termhist() {
    termplot --histogram 0 $@
}

function termscat() {
    termplot --domain --points $@
}


function pdfbooklet() {
    if test (echo $@ | grep "^http.*\.pdf"); then
        echo "downloading url"
        wget $@ -O pdf-original.pdf
        LOCALFILE=pdf-original.pdf
    else
        LOCALFILE=$@
    fi
    pdfbook2 --paper=a4paper --short-edge --outer-margin=50 --inner-margin=10 --top-margin=10 --bottom-margin=10 $LOCALFILE
    evince (echo $LOCALFILE | sed "s/.pdf/-book.pdf/")
    echo "Please print landscape, short-edge, double-sided"
}


# Allow for a local zshrc file, *not* checked into git
if [[ -a ~/.zshrc_local ]]; then
    #source ~/.zshrc_local # TODO
fi


## the Unused
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"
# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

