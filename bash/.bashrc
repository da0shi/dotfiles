[ ! ${_BASH_PROFILE_} ] && . ${HOME}/.bash_profile
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# history
HISTCONTROL=ignoreboth;
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

case ${OS} in
	Darwin )
		export LSCOLORS=GxDxcxdxCxegedabagacbg;
		export SSH_AUTH_SOCK=""
		GIT_CONTRIB_DIR=${HOME}/.local/git-contrib
		BCOMPLETION_DIR="$(brew --prefix)/etc"
		;;
	* )
		GIT_CONTRIB_DIR=/usr/local/etc/git-contrib
		BCOMPLETION_DIR= "/etc"
		;;
esac

gitps1=":"
if [ -r ${GIT_CONTRIB_DIR}/completion/git-prompt.sh ]; then
	. ${GIT_CONTRIB_DIR}/completion/git-prompt.sh
fi
if [ -r ${GIT_CONTRIB_DIR}/completion/git-completion.bash ]; then
	. ${GIT_CONTRIB_DIR}/completion/git-completion.bash
fi
[ $(type -t __git_ps1) ] && gitps1="__git_ps1"

if [ -f ${BCOMPLETION_DIR}/bash_completion ] && ! shopt -oq posix; then
	. ${BCOMPLETION_DIR}/bash_completion
fi

# prompt
case ${TERM} in
	eterm-color | dumb )
		export PS1='\u@\h [\w]$(${gitps1})\$ '
		;;
	linux )
		export LANG=C
		export PS1='\[\e[32m\]\u@\h \[\e[33m\][\w]$(${gitps1})\[\e[0m\]\$ '
		;;
	* )
		export PS1='\[\e]0;\w\a\]\[\e[32m\]\u@\h \[\e[33m\][\w]$(${gitps1})\[\e[0m\]\$ '
		;;
esac

[ -r ${HOME}/.bash_alias ] && . ${HOME}/.bash_alias

[ $(type -t direnv) ] && eval "$(direnv hook $0)"

# editor
export EDITOR=vim
#pager
export PAGER='less -gMj10'
