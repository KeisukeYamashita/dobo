# Fish completion for dobo
#
# INSTALLATION
#
# First install dobo from
# https://github.com/KeisukeYamashita/dobo
#
# Then copy this file to somewhere in $fish_complete_path,
# e.g. ~/.config/fish/completions
#
# CREDITS
#
# Initial version written by Sebastian Schulz <https://github.com/yilazius>

function __dobo_wants_subcommand
    set cmd (commandline -opc)
    if test (count $cmd) -eq 1
        return 0
    end
    return 1
end

function __dobo_using_subcommand
    set cmd (commandline -opc)
    set subcommand $argv[1]
    if test (count $cmd) -ge 2
        and test $cmd[2] = $subcommand
        return 0
    end
    return 1
end

function __dobo_completion_list
    set dobo_home "$HOME/.dockerignore-boilerplates"
    if set -q DOBO_BOILERPLATES
        set dobo_home $DOBO_BOILERPLATES
    end
    find "$dobo_home" -name "*.dockerignore" -exec basename \{\} .dockerignore \;
end

complete -c dobo -n "__dobo_wants_subcommand" -f -a "dump" -d 'Dump one or more boilerplates to STDOUT'
complete -c dobo -n "__dobo_wants_subcommand" -f -a "search" -d 'Search for boilerplates'
complete -c dobo -n "__dobo_wants_subcommand" -f -a "root" -d 'Show the directory where dobo stores its boilerplates'
complete -c dobo -n "__dobo_wants_subcommand" -f -a "help" -d 'Show help information'
complete -c dobo -n "__dobo_wants_subcommand" -f -a "list" -d 'Show the list of available boilerplates'
complete -c dobo -n "__dobo_wants_subcommand" -f -a "update" -d 'Update the list of available boilerplates'
complete -c dobo -n "__dobo_wants_subcommand" -f -a "version" -d 'Show the current version of dobo installed'
complete -c dobo -n "__dobo_using_subcommand dump" -f -a '(__dobo_completion_list)'
