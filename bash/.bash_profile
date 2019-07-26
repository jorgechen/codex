# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Go Language
export GOPATH="/Users/george/go"
export PATH="$PATH:$GOPATH/bin"

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile


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
alias glo="git log --decorate --oneline"
alias gb="git branch"
alias gc="git checkout"
alias gp="git pull"
alias gr="git reset"

# cool terminal color scheme
export TERM="xterm-color"
alias ls="ls -G"
PS1="\[\033[01;32m\]\t\[\033[01;36m\] \w \$\[\033[00m\] " #https://askubuntu.com/a/770970/419423

# Prioritize git installed by brew instead of Apple Git
export PATH="/usr/local/bin:$PATH"

# Android SDK
#export PATH=${PATH}:/Users/knav/Library/Android/sdk/platform-tools:/Users/knav/Library/Android/sdk/tools

# GoCo valdiation SSL
#export SSL_CERT_FILE=/usr/local/etc/openssl/cert.pem
#export SSL_CERT_FILE=/usr/local/etc/openssl/cert.pem_old

# SlackBot integration
#export SLACKBOT_TOKEN=tQjoMhsVpbLxiHlwBTf9BbTL
#export HUBOT_SLACK_TOKEN=xoxb-12032015303-Mm74bUH1L4K2XqIw6lJYYibE

# Knocki AWS 
#export AWS_ACCESS_KEY_ID=AKIAINB7BX6VBFY3WLEA
#export AWS_SECRET_ACCESS_KEY=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
#export PATH="/usr/local/opt/postgresql@9.5/bin:$PATH"
#export PATH="/usr/local/opt/node@8/bin:$PATH"
