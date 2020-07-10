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

Go into GitBash Options and change the background to RGB 10,10,10 with low transparency

Create _~/.config/git/git-prompt.sh_ with:

```shell script
# This file ~/.config/git/git-prompt.sh prevents GitBash window running the expensive PS1=
# NOTE: this does not run in JetBrains terminal or SSH (.bashrc will be used in those cases)

# Prompt for GitBash terminal
PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]' # set window title
PS1="$PS1"'\[\033[36m\]'       # change to purple # Jorge: cyan
PS1="$PS1"'\t '          # show MSYSTEM
PS1="$PS1"'\[\033[32m\]'       # change to green
PS1="$PS1"'\u@\h '             # user@host<space>
PS1="$PS1"'\[\033[33m\]'       # change to brownish yellow
PS1="$PS1"'\w'                 # current working directory
PS1="$PS1"'\[\033[0m\]'        # change color
PS1="$PS1"' $ '                 # prompt: always $

# GitBash requires `--color=auto` in order to properly show colors in Windows
# We put it here because it's run by both the GitBash window and JetBrains terminals/etc.
alias ls='ls --color=auto --show-control-chars'
```

In _.aliases.ohmyzsh_, comment out `alias ls=` otherwise these will override the GitBash `--color=auto` alias

In _C:\...\Git\etc\profile.d\aliases.sh_, comment out the `alias` commands, then add:

```shell script
# Optional: If you pin GitBash to Windows taskbar, the --cd-to-home cannot be specified for taskbar shortcuts. However, beware that this will affect the opening if GitBash from a Win context menu
cd $HOME
```
