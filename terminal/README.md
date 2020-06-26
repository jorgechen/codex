# terminal config

My configurations for the terminal in a development environment

## Installation

Copy these files into your home directory:

```
.alias
.alias.ohmyzsh
.bash_profile
.bashrc
```

## Windows 10

With [Git for Windows](https://gitforwindows.org/) GitBash needs us to manually `cd` to `$HOME`

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
