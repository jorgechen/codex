# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Go Language
export GOPATH="/Users/george/go"
export PATH="$PATH:$GOPATH/bin"

### aliases ###
source .alias.ohmyzsh
source .alias

### terminal color scheme ###
export TERM="xterm-color"
alias ls="ls -G"
# PS1="\[\033[01;32m\]\u@\h\[\033[01;36m\] \w \$\[\033[00m\] "
PS1="\[\033[01;32m\]\t\[\033[01;36m\] \w \$\[\033[00m\] " #https://askubuntu.com/a/770970/419423

# Prioritize git installed by brew instead of Apple Git
export PATH="/usr/local/bin:$PATH"

# Android SDK
#export PATH=${PATH}:/Users/knav/Library/Android/sdk/platform-tools:/Users/knav/Library/Android/sdk/tools

# Ruby on Rails valdiation SSL
#export SSL_CERT_FILE=/usr/local/etc/openssl/cert.pem
#export SSL_CERT_FILE=/usr/local/etc/openssl/cert.pem_old

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
