# dotfiles

## Prerequire:
 - curl
 - emacs
 - git
 - go
 - python

```
sudo apt -y install curl emacs git golang python
```

## tmux

Follow https://github.com/tmux-plugins/tpm/blob/master/README.md#installation and then run

```
wget https://raw.githubusercontent.com/atetubou/dotfiles/master/tmux.conf -O ~/.tmux.conf
```

## Install:
```
git clone https://github.com/atetubou/dotfiles.git && \
  ./dotfiles/install.sh && \
  source ~/.bashrc
```
