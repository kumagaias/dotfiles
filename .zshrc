# check running OS
case "$(uname -s)" in
   Darwin)
     os='Mac'
     ;;
   Linux)
     os='Linux'
     ;;
   CYGWIN*|MINGW*|MSYS*)
     os='Windows'
     ;;
   *)
     os='other'
     ;;
esac

# Mac (BSD 系)
if [[ ${os} = 'Mac' ]]; then
  alias ll='ls -laG'
  alias mongod='mongod --config /usr/local/etc/mongod.conf'

  # Mac App
  function numbers() {
    command open -a Numbers $1
  }
  function guiflow() {
    command open /usr/local/lib/guiflow-darwin-x64/guiflow.app $1
  }

  # open xls
  alias serverx='numbers ~/Shortcut/serverx'
  alias passwdx='numbers ~/Shortcut/passwdx'
  alias mailx='numbers ~/Shortcut/mailx'
  alias servermailx='numbers ~/Shortcut/servermailx'
fi

# Linux
if [[ ${os} = 'Linux' ]]; then
  alias ll='ls -la --color=auto'

  # VS Code
  export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  # Vagrant
  export PATH="$PATH:/mnt/c/Program Files/Oracle/VirtualBox"
  export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
fi

# Windows, Msys2
if [[ ${os} = 'Windows' ]]; then
  alias docker='winpty docker'
  alias heroku='winpty heroku'
  alias node='winpty node'
  alias ll='ls -la --color=auto'
fi

export LC_ALL=en_US.UTF-8

# Shell only exists after the 10th consecutive Ctrl-d
IGNOREEOF=10

# shortcut
alias vi='nvim'
alias vim='nvim'
alias here='find `pwd -P` -maxdepth 1'
alias k='kubectl'
alias vimdiff='nvim -d '
alias mk='minikube'
alias k='kubectl'
alias p='python'
alias gc='gcloud'
alias dc='docker-compose'
alias vr="git for-each-ref --sort=committerdate refs/heads/ --format='%(authordate:short) %(color:red)%(objectname:short) %(color:yellow)%(refname:short)%(color:reset) (%(color:green)%(committerdate:relative)%(color:reset))'"

export LESS='-i -M -R'

# git
alias g='git'
alias gn='git --no-pager'
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

PROMPT='[%B%F{black}%n@%m%f%b:%F{green}%~%f]%F{cyan}$vcs_info_msg_0_%f %F{yellow}$%f '

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt share_history
setopt hist_ignore_all_dups
bindkey -e
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward


# aws cli
# complete -C aws_completer aws

# svn
export SVN_EDITOR=nvim

# require fzy
if type "fzy" > /dev/null 2>&1; then
  # Svn check for modifications
  function svndiff () {
  # status と path を変数に格納する
    eval $(svn status | fzy | awk '{status=$1;path=$2} {printf("status=%s; path=%s", status, path)}')
    case "${status}" in
      'M' ) svn diff ${path} ;;
      'A' | '?' ) vi ${path} ;;
      '*' ) echo 'Cant not open: ' ${status} ${path} ;;
    esac
  }
  # git difftool wrapper
  function gdiff () {
    path=`git status | fzy | awk -F':' '{print $2}'`
    git difftool ${path}
  }

  # hisotry list
  alias hl='eval $(history | fzy | awk '\''{for(i=2;i<NF;i++){printf("%s ",$i)}print $NF}'\'')'

  # Svn log
  function svnlog () {
    # default log numbers
    limit=20
    if [[ -n "$1" ]];then
      limit=$1
    fi
    # revision を変数に格納する
    eval $(svn log -l ${limit} | fzy | awk '{rev=$1} {printf("rev=%s", rev)}')
    # 数字だけにする
    rev=`echo ${rev} | sed -e 's/[^0-9]//g'`
    if [[ -n "${rev}" ]];then
      eval $(svn log -v -r ${rev} | fzy | awk '{status=$1;path=$2} {printf("status=%s; path=%s", status, path)}')
      previous_rev=`expr ${rev} - 1`
      case "${status}" in
        'M' ) svn diff -r ${rev}:${previous_rev} ./${path} ;;
        '*' ) echo 'Cant not open: ' ${status} ${path} ;;
      esac
    fi
  }
fi

# nodejs
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# nodejs library path
export NODE_PATH='/usr/local/lib/node_modules'
export PATH="$PATH:./node_modules/.bin"

# go
export PATH="$PATH:~/go/bin"

# anyenv
if [[ -e ~/.anyenv ]]; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
    # for tmux
    for D in `ls $HOME/.anyenv/envs`
    do
        export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
    done
fi

# go
export GOPATH=~/go

# VS Code
export DISPLAY=:0.0

# pip
export PATH=~/.local/bin:$PATH
export PATH="/usr/local/opt/helm@2/bin:$PATH"

alias tf="terraform"

# postgres
export PGDATA="~/.pg/data"

# direnv
export EDITOR=nvim
eval "$(direnv hook zsh)"
# eval "$(direnv hook bash)"
