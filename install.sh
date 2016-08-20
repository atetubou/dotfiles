#!/bin/bash


function install_check () {
    package=$1
    if ! which $package > /dev/null; then
        echo "Please install ${package} before ./install.sh" >& 2
        exit 1
    fi
}

install_check go
install_check curl

set -x
cd $(dirname $0)


if [[ -f ~/.screenrc && ! -f ~/.screenrc.back ]]; then
    mv ~/.screenrc ~/.screenrc.back
fi

cp screenrc ~/.screenrc


curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
echo 'export PATH="~/.cask/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

if [[ ! -L ~/.emacs.d && ! -e ~/.emacs.d.back ]]; then
    mv ~/.emacs.d ~/.emacs.d.back
    ln -s ${PWD}/emacs.d ~/.emacs.d
elif [[ -d ~/.emacs.d ]]; then
    rm -rf ~/.emacs.d
    ln -s ${PWD}/emacs.d ~/.emacs.d
fi

$(
    cd ~/.emacs.d
    cask install
)

# goimports
echo 'export GOPATH="~/.go"' >> ~/.bashrc
echo 'export PATH="$GOPATH/bin:$PATH"' >> ~/.bashrc
go get golang.org/x/tools/cmd/goimports
