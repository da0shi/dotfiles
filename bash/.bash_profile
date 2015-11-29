# .bash_profile
_BASH_PROFILE_=":"
[ $(type -t brew) ] && export BREW_PREFIX=$(brew --prefix)
[ -n "${BREW_PREFIX}" ] && BREW_CELLAR=${BREW_PREFIX}/Cellar

. ${HOME}/.bashutils

# Exports for command option
export TITANIUM_VERTION=2.1.4GA
export LSCOLORS=GxDxcxdxCxegedabagacbg;
export SSH_AUTH_SOCK=""

# Completion sources
# Git
_GIT_CONTRIB_DIR=${HOME}/.local/git-contrib
# Bash
_BCOMPLETION_DIR="${BREW_PREFIX}/etc"

# optional bin directory made by user
[ -d /opt/local/bin ] && pathmerge /opt/local/bin
[ -d ${HOME}/local/bin ] && pathmerge ${HOME}/local/bin
[ -d ${HOME}/.local/bin ] && pathmerge ${HOME}/.local/bin

# Programming Language
# "java"
export JAVA_HOME=$(/usr/libexec/java_home)
[ -d ${JAVA_HOME} ] && pathmerge ${JAVA_HOME}/bin
export _JAVA_OPTIONS="-Dfile.encoding=UTF-8"

# Scala
export SCALA_HOME=${BREW_CELLAR}/scala/2.11.7
[ -d ${SCALA_HOME} ] && pathmerge ${SCALA_HOME}/bin

# Groovy
export GRAILS_HOME=${BREW_CELLAR}/groovy/2.3.3
[ -d ${GRAILS_HOME} ] && pathmerge ${GRAILS_HOME}/bin

# golang
export GOPATH=${HOME}/go
[ -d ${GOPATH} ] && pathmerge ${GOPATH}/bin

# nvm
export NVM_DIR=~/.nvm
[ -d ${NVM_DIR} ] && source $(brew --prefix nvm)/nvm.sh

# Android
export ANDROID_SDK=/opt/local/android-sdk-macosx
[ -d ${ANDROID_SDK} ] && pathmerge ${ANDROID_SDK}/tools && pathmerge ${ANDROID_SDK}/platform-tools
export ANDROID_NDK=/opt/local/android-ndk-macosx

[ -d /usr/local/mysql ] && pathmerge /usr/local/mysql/bin

# Tex
# TeX
TEXLIVE_HOME=/usr/local/texlive
TEXLIVE_VERSION=2014
TEX_BIN=x86_64-darwin
[ -d ${TEXLIVE_HOME}/${TEXLIVE_VERSION} ] && \
	pathmerge ${TEXLIVE_HOME}/${TEXLIVE_VERSION}/bin/${TEX_BIN} && \
	xpathmerge MAN ${TEXLIVE_HOME}/${TEXLIVE_VERSION}/texmf/doc/man

# Heroku
export HEROKU_HOME=/usr/local/heroku
[ -d ${HEROKU_HOME} ] && pathmerge ${HEROKU_HOME}/bin

xpathmerge LIB /usr/local/lib

export PATH
export MANPATH
export LD_LIBRARY_PATH

# Get the aliases and functions
[ -r ${HOME}/.bashrc ] && . ${HOME}/.bashrc

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "${HOME}/.gvm/bin/gvm-init.sh" ]] && source "${HOME}/.gvm/bin/gvm-init.sh"
