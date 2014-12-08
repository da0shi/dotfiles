#.bash_profile
export _BASH_PROFILE_=":"
. ${HOME}/.bashutils

OS=$(uname)
case ${OS} in
	Darwin )
		. ~/.bash_profile.macosx ;;
	* )
		# java
		JDK_VERSION=jdk1.7.0_51
		JAVA_HOME=/usr/local/java/${JDK_VERSION}
		[ -d ${JAVA_HOME} ] || JAVA_HOME=
		# scala
		SCALA_HOME=/usr/local/scala-2.11.2
		[ -d ${SCALA_HOME} ] || SCALA_HOME=
		# android
		ANDROID_SDK=/usr/local/android-sdk
		[ -d ${ANDROID_SDK} ] || ANDROID_SDK=
		ANDROID_NDK=/usr/local/android-ndk
		[ -d ${ANDROID_NDK} ] || ANDROID_NDK=
		# golang
		GOPATH=${HOME}/.gopath
		[ -d ${GOPATH} ] || GOPATH=

		# optional bin directory made by user
		[ -d /opt/local/bin ] && pathmerge /opt/local/bin
		[ -d ${HOME}/local/bin ] && pathmerge ${HOME}/local/bin
		[ -d ${HOME}/.local/bin ] && pathmerge ${HOME}/.local/bin

		[ -n "${JAVA_HOME}" ] && export JAVA_HOME && pathmerge ${JAVA_HOME}/bin
		[ -n "${SCALA_HOME}" ] && export SCALA_HOME && pathmerge ${SCALA_HOME}/bin
		[ -n "${GOPATH}" ] && export GOPATH && pathmerge ${GOPATH}/bin
		if [ -n "${ANDROID_SDK}" ]; then
			pathmerge ${ANDROID_SDK}/tools
			pathmerge ${ANDROID_SDK}/platform-tools
		fi
		[ -d /usr/local/mysql ] && pathmerge /usr/local/mysql/bin
		xpathmerge LIB /usr/local/lib

		export PATH
		export MANPATH
		export LD_LIBRARY_PATH
		;;
esac

# Get the aliases and functions
[ -r ${HOME}/.bashrc ] && . ${HOME}/.bashrc
