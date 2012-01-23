#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#

autoload -U compinit
compinit

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

export EDITOR="lemacs -nw"
export SVN_EDITOR="lemacs -nw"

## keep background processes at full speed
#setopt NOBGNICE
## restart running processes on exit
#setopt HUP

## history
#setopt APPEND_HISTORY
## for sharing history between zsh processes
setopt INC_APPEND_HISTORY
#setopt SHARE_HISTORY

setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS

export HISTSIZE=1000
export HISTFILE=~/.zsh_history
export SAVEHIST=1000


## never ever beep ever
#setopt NO_BEEP

## automatically decide when to page a list of completions
#LISTMAX=0

## disable mail checking
#MAILCHECK=0

autoload -U colors
colors

[ `hostname` = 'prowl.itinerary.com' ] && export WINEPREFIX=/home/pgreg/.wine-new

alias ls='ls --color=always'
alias grep="grep --colour=always -n"
alias ditaa="java -jar ~/bin/ditaa0_6b.jar"
alias less='less -R'
alias hg='hgintercept'
