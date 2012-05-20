#
# For GNU Global
# http://www.gnu.org/software/global/
#

funcs()
{
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=(`global -c $cur`)
}
complete -F funcs global

