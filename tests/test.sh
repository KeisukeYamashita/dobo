#!/bin/bash

DOBO_BOILERPLATES=$(dirname "$0")/mock-boilerplates
export DOBO_BOILERPLATES
dobo=$(dirname "$0")/../dobo

fail() {
    echo "$1"
    exit 1
}

# Create a dummy .git directory inside $DOBO_BOILERPLATES to placate dobo's
# clone function.
(cd "${DOBO_BOILERPLATES}" && mkdir -p .git)

# Calling dobo without subcommand exits with non-zero exit status
if $dobo >/dev/null 2>&1; then
    fail "Got successful (zero) exit status when run without subcommand"
fi

# It fails when the boilerplate file doesn't exist
if $dobo dump UnknownBoilerplate >/dev/null 2>&1; then
    fail "Got successful (zero) exit status for unknown boilerplate"
fi

# It succeeds when the boilerplate file exists
if ! $dobo dump Foo >/dev/null; then
    fail "Got unsuccessful (non-zero) exit status for known boilerplate"
fi

# `dobo dump Foo` outputs 7 lines
expected=7
lines=$($dobo dump Foo | wc -l)
if [[ $lines -ne $expected ]]; then
    fail "Expected $expected lines in output of 'dobo dump Foo', got $lines"
fi

# `dobo dump Foo Bar` outputs 14 lines
expected=14
lines=$($dobo dump Foo Bar | wc -l)
if [[ $lines -ne $expected ]]; then
    fail "Expected $expected lines in output of 'dobo dump Foo Bar', got $lines"
fi
