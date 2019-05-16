
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# added by George

# aliases
alias cd..="cd .."
alias ll="ls -al"
alias lp="ls -p"
alias lh="ls -a"
alias h=history
alias gs="git status"
alias gd="git diff"
alias ga="git add"
alias gl="git log"
alias glo="git log --decorate --oneline --graph --all"
alias gf="git fetch"
alias gb="git branch"
alias gc="git checkout"
alias gp="git pull"
alias gr="git reset"

# cool terminal color scheme
export TERM="xterm-color"
alias ls="ls -G"
PS1="\[\033[01;32m\]\u@\h\[\033[01;36m\] \w \$\[\033[00m\] "
PS1="\[\033[01;32m\]\t\[\033[01;36m\] \w \$\[\033[00m\] " #https://askubuntu.com/a/770970/419423


# Prioritize git installed by brew instead of Apple Git
export PATH="/usr/local/bin:$PATH"

# Android SDK
export PATH=${PATH}:/Users/knav/Library/Android/sdk/platform-tools:/Users/knav/Library/Android/sdk/tools


