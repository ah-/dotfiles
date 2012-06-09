#!/bin/sh

# install oh-my-zsh: 
# $ wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

# if screen-256color is not available on a system:
# infocmp screen-256color > /tmp/screen-256color.terminfo (already done)
# tic screen-256color.terminfo

cd $(dirname $0)
for dotfile in .?*
do
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ] && [ $dotfile != '.oh-my-zsh' ]
    then
        echo "ln -Fis $PWD/$dotfile $HOME"
        ln -Fis "$PWD/$dotfile" $HOME
    fi
done

echo "ln -Fis \"$PWD/.oh-my-zsh/themes/ah.zsh-theme\" $HOME/.oh-my-zsh/themes"
ln -Fis "$PWD/.oh-my-zsh/themes/ah.zsh-theme" $HOME/.oh-my-zsh/themes
