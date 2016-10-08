#!/bin/bash
set -x
cd $(dirname $0)

function install_check () {
    package="$1"
    if ! which "$package" > /dev/null; then
        echo "Please install ${package} before ./install.sh" >& 2
        exit 1
    fi
}

function add_path () {
    path="$1"
    if ! fgrep "$path" ~/.bashrc ; then
        echo "$path" >> ~/.bashrc
    fi
}

install_check python
install_check go
install_check curl
install_check git
install_check emacs

git config --global alias.st status
git config --global alias.ci commit
git config --global user.name "${USER}"
git config --global user.email "${USER}@${HOSTNAME}"
git config --global push.default matching

rm -rf ~/.screenrc
ln -s ${PWD}/screenrc ~/.screenrc

if ! [[ -d ~/.cask ]]; then
    curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
fi

add_path 'export PATH="${HOME}/.cask/bin:$PATH"'
export PATH="${HOME}/.cask/bin:$PATH"
add_path 'export GOPATH="${HOME}/.go"'
export GOPATH="${HOME}/.go"
add_path 'export PATH="$GOPATH/bin:$PATH"'
export PATH="$GOPATH/bin:$PATH"

# goimports
go get golang.org/x/tools/cmd/goimports

rm -rf ~/.emacs.d
ln -s ${PWD}/emacs.d ~/.emacs.d

cd ~/.emacs.d
cask install
