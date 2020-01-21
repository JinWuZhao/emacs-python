#!/bin/sh

pacman -Syu --noconfirm

pacman -S --noconfirm python-setuptools
pacman -S --noconfirm python-pip

pacman -Scc --noconfirm

pip install python-language-server[all]

curl -o /root/.emacs.d/custom/awesome-tab.el https://raw.githubusercontent.com/manateelazycat/awesome-tab/master/awesome-tab.el

emacs --daemon
emacsclient -e '(kill-emacs)'
