#!/bin/bash
set -x
cd $(dirname $0)

function install_check () {
    package=$1
    if ! which $package > /dev/null; then
        echo "Please install ${package} before ./install.sh" >& 2
        exit 1
    fi
}

install_check python
install_check go
install_check curl
install_check git

git config --global alias.st status
git config --global alias.ci commit
git config --global user.name ${USER}
git config --global user.email ${USER}@${HOSTNAME}
git config --global push.default matching



if [[ -f ~/.screenrc && ! -f ~/.screenrc.back ]]; then
    mv ~/.screenrc ~/.screenrc.back
fi

ln -s ${PWD}/screenrc ~/.screenrc


curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
# goimports
go get golang.org/x/tools/cmd/goimports

echo 'export PATH="~/.cask/bin:$PATH"' >> ~/.bashrc
echo 'export GOPATH="~/.go"' >> ~/.bashrc
echo 'export PATH="$GOPATH/bin:$PATH"' >> ~/.bashrc
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
