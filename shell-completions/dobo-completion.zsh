#compdef dobo
#
# Zsh completion for dobo
#
# INSTALLATION
#
# First install dobo from
# https://github.com/KeisukeYamashita/dobo
#
# Make sure autocompletion is enabled in your shell, typically
# by adding this to your .zshrc:
#
#     autoload -U compinit && compinit
#
# Then copy this file somewhere (e.g. ~/.zsh/_dobo) and put the
# following in your .zshrc:
#
#     fpath=(~/.zsh $fpath)
#
#
# CONTRIBUTING
#
# See https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org
# for tips on writing and testing zsh completion functions.
#
# CREDITS
# 
# Source codes derived from Simon Whitaker's <sw@netcetera.org> gitignore-boilerplates project
# https://github.com/simonwhitaker/gitignore-boilerplates

_dobo_commands()
{
    _dobo_commands=(
        'dump:Dump one or more boilerplates' \
        'help:Display this help text' \
        'list:List available boilerplates' \
        'root:Show the directory where dobo stores its boilerplates' \
        'search:Search for boilerplates' \
        'update:Update list of available boilerplates' \
        'version:Display current script version'
    )
    _describe 'command' _dobo_commands
}

_dobo_dump_commands()
{
    local local_repo=${DOBO_BOILERPLATES:-"$HOME/.dockerignore-boilerplates"}
    local -a boilerplates
    if [ -e "$local_repo" ]; then
        boilerplates=($local_repo/**/*.dockerignore(:r:t))
    fi

    _arguments "*:boilerplate:($boilerplates)"
}

_dobo()
{
    local ret=1

    _arguments -C \
        '1: :_dobo_commands' \
        '*::arg:->args' \
        && ret=0

    case $state in
        args )
            case $line[1] in
                dump )
                    _arguments \
                        '*: :_dobo_dump_commands' \
                        && ret=0
                    ;;
            esac
    esac
}
