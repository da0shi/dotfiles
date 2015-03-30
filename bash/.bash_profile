#.bash_profile
_BASH_PROFILE_=":"
if [ ! $(type -t dlog) ]; then
	dlog () {
		[ -w ${HOME}/.bashdebug.log ] && echo "`date '+%Y%m%d-%H%M%S-%N'`: $*" >>${HOME}/.bashdebug.log
	}
fi
dlog ".bash_profile load start"
. ${HOME}/.bashutils

. ~/.bashenv

# optional bin directory made by user
[ -d /opt/local/bin ] && pathmerge /opt/local/bin
[ -d ${HOME}/local/bin ] && pathmerge ${HOME}/local/bin
[ -d ${HOME}/.local/bin ] && pathmerge ${HOME}/.local/bin

# Programming Language
[ -n "${JAVA_HOME}" ] && export JAVA_HOME && pathmerge ${JAVA_HOME}/bin
[ -n "${_JAVA_OPTIONS}" ] && export _JAVA_OPTIONS
[ -n "${SCALA_HOME}" ] && export SCALA_HOME && pathmerge ${SCALA_HOME}/bin
[ -n "${GRAILS_HOME}" ] && export GRAILS_HOME && pathmerge ${GRAILS_HOME}/bin
[ -n "${GOPATH}" ] && export GOPATH && pathmerge ${GOPATH}/bin
if [ -n "${ANDROID_SDK}" ]; then
	pathmerge ${ANDROID_SDK}/tools
	pathmerge ${ANDROID_SDK}/platform-tools
fi
[ -d /usr/local/mysql ] && pathmerge /usr/local/mysql/bin

# Tex
if [ -n "${TEXLIVE_HOME}" ]; then
	pathmerge ${TEXLIVE_HOME}/${TEXLIVE_VERSION}/bin/${TEX_BIN}
	xpathmerge MAN ${TEXLIVE_HOME}/${TEXLIVE_VERSION}/texmf/doc/man
fi

# Heroku
[ -n "${HEROKU_HOME}" ] && export HEROKU_HOME && pathmerge ${HEROKU_HOME}/bin

xpathmerge LIB /usr/local/lib

export PATH
export MANPATH
export LD_LIBRARY_PATH

# Get the aliases and functions
[ -r ${HOME}/.bashrc ] && . ${HOME}/.bashrc

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "${HOME}/.gvm/bin/gvm-init.sh" ]] && source "${HOME}/.gvm/bin/gvm-init.sh"

dlog ".bash_profile load complete"
