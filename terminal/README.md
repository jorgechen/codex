# terminal config

My configurations for the terminal in a development environment

## Installation

Copy/merge these files into your home directory:

```
.aliases
.aliases.ohmyzsh
.bash_profile
.bashrc
```

## ZSH

After installing [Oh My ZSH](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH), copy my config:

```shell script
cd terminal
cp .zshrc ~
cp jorge.zsh-theme ~/.oh-my-zsh/custom/themes/jorge.zsh-theme
``` 

## Windows 10

With [Git for Windows](https://gitforwindows.org/) GitBash needs us to manually `cd` to `$HOME`

Go into GitBash Options and change the background to RGB 10,10,10

In *C:\...\Git\etc\profile.d\bash_profile.sh*
 
```shell script
# NOTE: we cannot add this directly to .bashrc because we want JetBrains terminals to `cd` correctly into specific repos
cd $HOME
```

In *C:\...\Git\etc\profile.d\git-prompt.sh*

```shell script
# Comment out the conditional that executes git status, to improve performance
if test -z "$WINELOADERNOEXEC"
  # ...
fi

# Ensure you have a space before $
PS1="$PS1"' $ '
``` 

In *.aliases* comment out `alias l=`

In *C:\...\Git\etc\profile.d\aliases.sh*, comment out the alias commands and replace with:

```shell script
alias l='ls -lah --color=auto --show-control-chars'
alias ls='ls --color=auto --show-control-chars'
```
