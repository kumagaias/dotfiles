if [[ -f ~/.bashrc ]]; then
  source ~/.bashrc
fi

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
  alias stup='~/Workcopy/tool/up-git-branch-files-to-staging/main.sh'
  source /usr/local/etc/bash_completion.d/git-completion.bash
  source /usr/local/etc/bash_completion.d/git-prompt.sh
  # crontab -e で編集できるように
  export EDITOR=vim

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
fi

# Windows, Msys2
if [[ ${os} = 'Windows' ]]; then
  alias docker='winpty docker'
  alias heroku='winpty heroku'
  alias node='winpty node'
  alias ll='ls -la --color=auto'
fi

# Shell only exists after the 10th consecutive Ctrl-d
IGNOREEOF=10

# shortcut
alias vi='vim'
alias here='find `pwd -P` -maxdepth 1'

export LESS='-i -M -R'

# git
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\h\[\033[00m\]:\W\[\033[31m\]$(__git_ps1 [%s])\[\033[00m\]\$ '
alias g='git'
alias gn='git --no-pager'

# aws cli
complete -C aws_completer aws

# svn
export SVN_EDITOR=vim

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

# phpunit
alias phpunit='~/Workcopy/tool/phpunit-local/phpunit.sh'

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

# pip
export PATH=~/.local/bin:$PATH

