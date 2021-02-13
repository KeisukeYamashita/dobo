# dobo: fast access to dockerignore boilerplates

![CI](https://github.com/KeiskeYamashita/dobo/workflows/CI/badge.svg)

**dobo** (short for dockerignore boilerplates) is a shell script to help you easily access dockerignore boilerplates from [github.com/github/gitignore](https://github.com/github/gitignore).

## Typical usage

```console
dobo dump Swift Xcode >> .dockerignore
```

For additional usage instructions, run `dobo help`.

## Installation

### Installation on OS X using [Homebrew](http://mxcl.github.com/homebrew/)

```console
$ brew install KeisukeYamashita/tap/dobo
```

### Installation on Fedora Linux

`dobo` is avaiable as a [COPR repository](https://copr.fedorainfracloud.org/). It provides packages for main script and bash / zsh completions:

```console
$ dnf copr enable saschpe/dobo
$ dnf install dobo dobo-bash-completion dobo-zsh-completion
```

### Installation on other (*nix) platforms

Just download `dobo` and put it somewhere on your $PATH. Then:

```console
$ chmod +x /path/to/dobo   # Make dobo executable
$ dobo update              # Initialise dobo
```

You can automate this with the following one-liner (assuming ~/bin is on your $PATH).

```console
$ curl -L https://raw.github.com/KeiskeYamashita/dobo/master/dobo \
        -so ~/bin/dobo && chmod +x ~/bin/dobo && dobo update
```

### Installation on Windows

#### Using scoop

The easiest way to install `dobo` on Windows is to use [scoop](https://github.com/lukesampson/scoop), a PowerShell-based package-manager of sorts for Windows:

```console
$ scoop update
$ scoop install dobo
```

A great benefit to using scoop, is that it provides an easy way to update its packages, including dobo:

```console
$ scoop update
$ scoop update dobo
```

#### git installation

You can download the whole `dobo` repo directly from GitHub:

```console
$ git clone https://github.com/KeiskeYamashita/dobo.git dobo
```

Then add the full dobo directory (`C:\Users\<Your User>\bin\dobo`) to your system's PATH environment variable.

#### Manual installation

To manually install only the `dobo.bat` file, download it to your computer and save it to any directory that is in your PATH.

Right-click [this link](https://raw.githubusercontent.com/KeiskeYamashita/dobo/master/dobo.bat) and select 'Save target as...' (or 'Save link as...' depending on your browser) to save it to your computer.

A good directory to put the file is `C:\Users\<Your User>\bin` and add that directory to your system's PATH environment variable. Where ever you put it, make sure the batch file is accessible via `where dobo`.

### Installation on Docker

Just type the following command.

```console
$ docker run --rm KeiskeYamashita/dobo
```

## Tab completion in bash, zsh and fish

bash, zsh and fish users can enjoy the deluxe dobo experience by enabling tab completion of available boilerplate names.

Sorry, there is no tab completion support in Windows.

### bash instructions

Copy `dobo-completion.bash` into a `bash_completion.d` folder:

* `/etc/bash_completion.d`
* `/usr/local/etc/bash_completion.d`
* `~/bash_completion.d`

or copy it somewhere (e.g. ~/.dobo-completion.bash) and put the following in your .bashrc:

```console
source ~/.dobo-completion.bash
```

### zsh instructions

Copy `dobo-completion.zsh` somewhere in your `$fpath`. The convention for autoloaded functions used in completion is that they start with an underscore, so I suggest you rename it to `_dobo`.

Alternatively, you can use `dobo-completion.zsh` as an [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) plugin by following [these instructions](https://github.com/KeiskeYamashita/gitignore-boilerplates/wiki/Using-dobo-as-an-ohmyzsh-plugin).

### fish instructions

Copy `dobo.fish` to somewhere in your `$fish_complete_path`.

## Use dobo to generate .hgignore files

The `glob` .hgignore syntax for Mercurial is compatible with dockerignore syntax. This means that you can use dobo to generate .hgignore files, as long as the .hgignore files use the `glob` syntax:

```console
$ echo 'syntax: glob' > .hgignore
$ dobo dump Python TextMate >> .hgignore
```

## Credits

This repository was forked from [simonwhitaker/gibo](https://github.com/simonwhitaker/gibo) and derived almost all the source codes. Thank you [@simonwhitaker](https://github.com/simonwhitaker) for working on this amazing product.
