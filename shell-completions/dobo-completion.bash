# Bash completion for dobo
#
# INSTALLATION
#
# First install dobo from
# https://github.com/KeisukeYamashita/dobo
#
# Then copy this file into a bash_completion.d folder:
#
#     /etc/bash_completion.d
#     /usr/local/etc/bash_completion.d
#     ~/bash_completion.d
#
# or copy it somewhere (e.g. ~/.dobo-completion.bash) and put the
# following in your .bashrc:
#
#     source ~/.dobo-completion.bash
#
# CREDITS
#
# Source codes derived from Simon Whitaker's <sw@netcetera.org> gitignore-boilerplates project
# https://github.com/simonwhitaker/gitignore-boilerplates

_dobo()
{
    local cur prev opts
    cur="${COMP_WORDS[COMP_CWORD]}"

    case $COMP_CWORD in
        1)
            COMPREPLY=($(compgen -W "dump help list root search update version" -- ${cur}))
            ;;
        *)
            subcommand="${COMP_WORDS[1]}"
            case $subcommand in
                dump)
                    opts=$( find ${DOBO_BOILERPLATES:-"$HOME/.dockerignore-boilerplates"} -name "*.dockerignore" -exec basename \{\} .dockerignore \; )
                    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            ;;
    esac
}

complete -F _dobo dobo
