# terminal config

My configurations for the terminal in a development environment

## Installation

Copy/merge these files into your home directory:

```shell script
.aliases
.aliases.ohmyzsh
.bash_profile
.bashrc
```

For  over-write:

```shell script
curl https://raw.githubusercontent.com/jorgechen/codex/master/terminal/.aliases -o ~/.aliases
curl https://raw.githubusercontent.com/jorgechen/codex/master/terminal/.aliases.ohmyzsh -o ~/.aliases.ohmyzsh
curl https://raw.githubusercontent.com/jorgechen/codex/master/terminal/.bashrc -o ~/.bashrc
curl https://raw.githubusercontent.com/jorgechen/codex/master/terminal/.bash_profile -o ~/.bash_profile
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

In _C:\...\Git\etc\profile.d\bash_profile.sh_
 
```shell script
# NOTE: we cannot add this directly to .bashrc because we want JetBrains terminals to `cd` correctly into specific repos
cd $HOME
```

In _C:\...\Git\etc\profile.d\git-prompt.sh_

```shell script
# Comment out the conditional that executes git status, to improve performance
if test -z "$WINELOADERNOEXEC"
  # ...
fi

# Ensure you have a space before $
PS1="$PS1"' $ '
``` 

In _.aliases.ohmyzsh_, comment out `alias ls=` otherwise these will override the GitBash aliases

In _C:\...\Git\etc\profile.d\aliases.sh_, comment out the `alias` commands, then replace with:

```shell script
# GitBash requires `--color=auto` in order to properly show colors in Windows
alias ls='ls --color=auto --show-control-chars'
```

