# -*- mode: shell-script -*-

function glast {
    LATEST=`git log --oneline -n 1`
    echo -n $LATEST | ack '^([a-zA-Z0-9]*) {1}' --output='$1' | pbcopy
    echo $LATEST
}

function bysearch {
    ldapsearch -u -x -h ldap-us.corp.yahoo.com -b 'ou=people,dc=corp,dc=yahoo,dc=com' "uid=$1"
}

function line {
    awk "NR == $1"
}

# -----------------------
#   System info
# -----------------------

function arch-os {
    echo $(uname -m)-$(uname -s)
}

# -----------------------
#   Reload bash config files
# -----------------------

function rc {
    source ~/.bashrc
}

# -----------------------
#   String functions
# -----------------------

function bash_join {
    local IFS="$1" # separator
    shift
    echo "$*"
}

function subst {
    sed -e "s$1$2g"
}

# -----------------------
#   Path functions
# -----------------------

function path {
    echo $PATH | tr ":" "\n"
}

function path_append {
    export PATH=$(bash_join ':' $PATH $@)
    if [ ! -z "$PS1" ]; then path; fi
}

function path_prepend {
    export PATH=$(bash_join ':' $@ $PATH)
    if [ ! -z "$PS1" ]; then path; fi
}

# -----------------------
#   Program functions
# -----------------------

function program_present {
    which $1 > /dev/null 2>&1
}

# Note that this function will return false if the program is running as a different user
# so that we can't signal it.
function program_running_as_user {
    if ! killall -0 $1 2> /dev/null; then
        return -1 # FALSE
    else
        return 0 # TRUE
    fi
}

function first_available_program {
    for prog in $*; do
        if program_present $prog; then 
            echo $prog 
            return
        fi
    done
}

function available_programs {
    for prog in $*; do
        if program_present $prog; then echo $prog; fi
    done
}

function select_program {
    local _ret
    select _ret in $*; do
        echo $_ret
        return
    done;
}

function select_editor {
    EDITOR=$(select_program $editors)
}

function editor {
    if [ $# -eq 1 ]; then EDITOR=$1; fi
    echo $EDITOR
}

function pager {
    if [ $# -eq 1 ]; then PAGER=$1; fi
    echo $PAGER
}

function exec_with_extra_ld_library_path {
    local _dir=$1
    shift
    LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$_dir "$@"
}

# -----------------------
#   GNU Screen
# -----------------------

function rename_screen_tab () { echo -ne "\x1bk$@\x1b\\"; return 0; }

