# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,aliases,exports,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null;
done;

# setup bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
    GIT_PS1_SHOWDIRTYSTATE=true
    export PS1='[\u@mbp \w$(__git_ps1)]\$ '

    # Add git completion to aliases
    __git_complete g __git_main
    __git_complete gc _git_checkout
    __git_complete gr _git_rebase
fi

GPG_TTY=$(tty)
export GPG_TTY
if [ -S "$HOME/.gnupg/S.gpg-agent.ssh" ]; then
    export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
fi


