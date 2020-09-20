### aliases ###
source ~/.aliases.ohmyzsh
source ~/.aliases

### terminal color scheme ###
export TERM="xterm-color"
PS1="${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\t \[\033[01;32m\]\u@\h\[\033[90m\]:\[\033[01;33m\]\w \[\033[37m\]\$\[\033[00m\] "

### Android
#export ANDROID_HOME=$HOME/Library/Android/sdk
#export PATH=$PATH:$ANDROID_HOME/emulator
#export PATH=$PATH:$ANDROID_HOME/tools
#export PATH=$PATH:$ANDROID_HOME/tools/bin
#export PATH=$PATH:$ANDROID_HOME/platform-tools

### Go Language
#export GOPATH="/Users/george/go"
#export PATH="$PATH:$GOPATH/bin"

### Android SDK
#export PATH=${PATH}:/Users/knav/Library/Android/sdk/platform-tools:/Users/knav/Library/Android/sdk/tools

### set Ruby validation SSL ###
#export SSL_CERT_FILE=/usr/local/etc/openssl/cert.pem
#export SSL_CERT_FILE=/usr/local/etc/openssl/cert.pem_old

### installed by NVM ###
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### installed by Homebrew, prioritizes git installed by brew instead of Apple Git
#export PATH="/usr/local/bin:$PATH"
