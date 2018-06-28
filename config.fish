set -gx SHELL (which fish)

set PATH $PATH ~/stack/doc/com/settings/bin/
set CDPATH $CDPATH . ~ $HOME $HOME/workdir/

# Path to your oh-my-fish.
#set fish_path $HOME/.oh-my-fish

# Theme
#set fish_theme bobthefish

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

function fish_prompt
    # a bit slow, need to fix that
    python3 ~/stack/doc/com/settings/powerline-shell.py $status --shell bare ^/dev/null
end

function fish_greeting
    if test -z "$TMUX"
        fortune | cowsay
        #figlet (whoami) @ (hostname)
    end
end

abbr . source # deprecated?
abbr tree "tree -c"
abbr t "tree"
abbr t1 "tree -L 1"
abbr t2 "tree -L 2"
abbr t3 "tree -L 3"
abbr o xdg-open
abbr py2 ipython
abbr py ipython3
abbr json "python3 -m json.tool"
abbr ... "cd ../.."
abbr .... "cd ../../../"
abbr ..... "cd ../../../../"
abbr grep 'grep --color=auto'
abbr ls 'ls --color=auto'
abbr lessc 'less -r'    # colour-aware
abbr jqc 'jq -C'        # colour-aware
abbr par 'parallel'

#eval (thefuck --alias | source) # seriously slow

# Change to first directory matching the query
function cdgrep
    cd (tree -f -L 5 | grep $argv | head -n 1 | cut -d"." -f2 | cut -c 2-)
end

function mkcd
    mkdir -p "$argv"; cd "$argv"
end

function cdl
    cd "$argv"; ls -al
end

function cdls
    cd "$argv"; ls
end

# highlight
function hl
    grep "$argv|" --color=always -E
end

# Data science
function termplot
    set -lx WIDTH (tput cols)
    set -lx HEIGHT (expr (tput lines) - 3)
    if not contains -- "--stream" $argv
        set extra --exit
    end
    feedgnuplot --terminal "dumb $WIDTH,$HEIGHT" $argv $extra
end

function termhist
    termplot --histogram 0 $argv
end

function termscat --description "GNUPlot terminal Scatter plot"
    termplot --domain --points $argv
end

# Run matlab with bash
function matlab
    set -lx SHELL /bin/bash
    command matlab $argv
end

# Git shortcuts
# also see ~/gitconfig
function git-graph
    git log --graph --all --oneline --decorate
end

function gg
    git-graph
end

function gst
    git status
end

function ga
    git add .
end

function gcm
    git commit -m $argv
end

function gca
    git commit --amend
end

function pdfbooklet
    if test (echo $argv | grep "^http.*\.pdf")
        echo "downloading url"
        wget $argv -O pdf-original.pdf
        set -x localfile pdf-original.pdf
    else
        set -x localfile $argv
    end
    pdfbook2 --paper=a4paper --short-edge --outer-margin=50 --inner-margin=10 --top-margin=10 --bottom-margin=10 $localfile
    evince (echo $localfile | sed "s/.pdf/-book.pdf/")
    echo "Please print landscape, short-edge, double-sided"
end
