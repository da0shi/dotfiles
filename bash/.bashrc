# If not running interactively, don't do anything
[ -z "$PS1" ] && return

[ ! ${_BASH_PROFILE_} ] && . ${HOME}/.bash_profile

# history
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
. ~/.bashrcenv

[ -z "${gitps1}" ] && gitps1=":"
if [ -r ${_GIT_CONTRIB_DIR}/completion/git-prompt.sh ]; then
	[ "${gitps1}" == ":" ] && . ${_GIT_CONTRIB_DIR}/completion/git-prompt.sh
fi
if [ -r ${_GIT_CONTRIB_DIR}/completion/git-completion.bash ]; then
	[ "${gitps1}" == ":" ] && . ${_GIT_CONTRIB_DIR}/completion/git-completion.bash
fi
[ $(type -t __git_ps1) ] && gitps1="__git_ps1"

if [ -f ${_BCOMPLETION_DIR}/bash_completion ] && ! shopt -oq posix; then
	[ -z "${BASH_COMPLETION_COMPAT_DIR}" ] && . ${_BCOMPLETION_DIR}/bash_completion
fi

# prompt
# assume we have color support
PS1='\[\e]0;\w\a\]\[\e[32m\]\u@\h \[\e[33m\][\w]$(${gitps1})\[\e[0m\]\$ '
case ${TERM} in
	eterm-color | dumb )
		PS1='\u@\h [\w]$(${gitps1})\$ '
		;;
	linux )
		export LANG=C
		PS1='\[\e[32m\]\u@\h \[\e[33m\][\w]$(${gitps1})\[\e[0m\]\$ '
		;;
	xterm )
		export TERM=xterm-256color
		;;
	* ) ;;
esac
export PS1

# editor
export EDITOR=vim
#pager
export PAGER='less -gMj2r'

# Alias definitions.
[ -z "${_BASH_ALIAS_}" ] && [ -r ${HOME}/.bash_alias ] && . ${HOME}/.bash_alias

[ $(type -t direnv) ] && eval "$(direnv hook $0)"

