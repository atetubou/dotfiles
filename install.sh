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
    if ! fgrep "$path" ~/.bashrc > /dev/null ; then
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

add_path 'export PATH="$(go env GOPATH)/bin:$PATH"'
export PATH="$(go env GOPATH)/bin:$PATH"

# goimports
go get golang.org/x/tools/cmd/goimports

# gocode
go get -u github.com/mdempsky/gocode

rm -rf ~/.emacs.d
ln -s ${PWD}/emacs.d ~/.emacs.d
