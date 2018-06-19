#!/usr/bin/bash

SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

function usage()
{
  echo "Mode:"
  echo "  -e Deploy"
  echo "  -n Dryrun"
}

CMD=""
EXEC_MODE=""

if [ "${1}" = "--help" -o "${1}" = "-h" ]; then
  usage
  exit
else
  EXEC_MODE=${1}
fi

# OS 検出
os='undetected'
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
esac

echo "running ${os}"

case "${EXEC_MODE}" in
  "-e") CMD="ln -s";;
  "-n") CMD="echo ln -s";;
  *) usage && exit;;
esac

echo "start..."

# make symbolic link
for f in `find . -name '.*' -maxdepth 1 | cut -c3-`
do
  [ "${f}" = ".git" ] && continue
  ${CMD} ${SCRIPT_DIR}/${f} ${HOME}/${f}
done

if [ "${EXEC_MODE}" = "-e" ]; then
  # vim settings
  mkdir -p ~/.vim/dein/repos/github.com/Shougo/dein.vim
  git clone https://github.com/Shougo/dein.vim.git ~/.vim/dein/repos/github.com/Shougo/dein.vim
  # git
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > /usr/local/etc/bash_completion.d/git-prompt.sh
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > /usr/local/etc/bash_completion.d/git-completion.bash
  # anyenv
  git clone https://github.com/riywo/anyenv ~/.anyenv
  # Mac (BSD 系)
  if [[ ${os} = 'Mac' ]]; then
    brew install reattach-to-user-namespace
    brew install fzy

    brew tap phinze/cask
    brew install brew-cask
    brew cask install skype
    brew cask install skitch
  fi
fi

echo "Please type: ln -s ${SCRIPT_DIR}/.gitconfig.local ${HOME}/.gitconfig.local"
echo "done"
