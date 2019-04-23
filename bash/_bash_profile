#.bash_profile
_BASH_PROFILE_=":"
. ${HOME}/.bashutils

. ~/.bashenv

: "Extra PATH" && {
	[ -d /opt/bin ] && pathmerge /opt/bin
	[ -d /opt/local/bin ] && pathmerge /opt/local/bin
	[ -d ${HOME}/local/bin ] && pathmerge ${HOME}/local/bin
	[ -d ${HOME}/.local/bin ] && pathmerge ${HOME}/.local/bin
	[ -d /usr/local/mysql ] && pathmerge /usr/local/mysql/bin
	[ -n "${HEROKU_HOME}" ] && export HEROKU_HOME && pathmerge ${HEROKU_HOME}/bin
	if [ -n "${ANDROID_SDK}" ]; then
		pathmerge ${ANDROID_SDK}/tools
		pathmerge ${ANDROID_SDK}/platform-tools
	fi
}

: "Programming Language Settings" && {
	: "JVM" && {
		: "Java" && {
			[ -n "${JAVA_HOME}" ] && export JAVA_HOME && pathmerge ${JAVA_HOME}/bin
			[ -n "${_JAVA_OPTIONS}" ] && export _JAVA_OPTIONS
		}
		: "Scala" && {
			[ -n "${SCALA_HOME}" ] && export SCALA_HOME && pathmerge ${SCALA_HOME}/bin
			[ -n "${SBT_HOME}" ] && export SBT_HOME && pathmerge ${SBT_HOME}/bin
		}
	}
	: "Go" && {
		[ -n "${GOROOT}" ] && export GOROOT && pathmerge ${GOROOT}/bin
		[ -n "${GOPATH}" ] && export GOPATH && pathmerge ${GOPATH}/bin
	}
	: "Node.js" && {
		[ -n "${NVM_DIR}" ] && export NVM_DIR && source ${NVM_DIR}/nvm.sh
	}
}

# Programming Language
[ -n "${GRAILS_HOME}" ] && export GRAILS_HOME && pathmerge ${GRAILS_HOME}/bin

# Tex
if [ -n "${TEXLIVE_HOME}" ]; then
	pathmerge ${TEXLIVE_HOME}/${TEXLIVE_VERSION}/bin/${TEX_BIN}
	xpathmerge MAN ${TEXLIVE_HOME}/${TEXLIVE_VERSION}/texmf/doc/man
fi


xpathmerge LIB /usr/local/lib

export PATH
export MANPATH
export LD_LIBRARY_PATH

# Get the aliases and functions
[ -r ${HOME}/.bashrc ] && . ${HOME}/.bashrc

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "${HOME}/.gvm/bin/gvm-init.sh" ]] && source "${HOME}/.gvm/bin/gvm-init.sh"

