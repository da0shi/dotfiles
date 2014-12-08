#.bash_profile
export _BASH_PROFILE_=":"
. ${HOME}/.bash_utils

OS=$(uname)
case ${OS} in
	Darwin )
		. ~/.bash_profile.macosx ;;
	* )
		# java
		JDK_VERSION=jdk1.7.0_51
		JAVA_HOME=/opt/local/java/${JDK_VERSION}
		# scala
		SCALA_HOME=/opt/local/scala-2.11.2
		# android
		ANDROID_SDK=/usr/local/android-sdk
		ANDROID_NDK=/usr/local/android-ndk
		GOPATH=${HOME}/.local/gopath
		pathmerge ${ANDROID_SDK}/tools
		pathmerge ${ANDROID_SDK}/platform-tools

		pathmerge /opt/local/bin
		pathmerge ${HOME}/local/bin
		pathmerge ${HOME}/.local/bin
		pathmerge ${GOPATH}/bin
		[ -n ${JAVA_HOME} ] && pathmerge ${JAVA_HOME}/bin
		[ -n ${SCALA_HOME} ] && pathmerge ${SCALA_HOME}/bin
		if [ -n ${ANDROID_SDK} ]; then
			pathmerge ${ANDROID_SDK}/tools
			pathmerge ${ANDROID_SDK}/platform-tools
		fi
		[ -d /usr/local/mysql ] && pathmerge /usr/local/mysql/bin
		xpathmerge LIB /usr/local/lib
		export PATH
		export MANPATH
		export LD_LIBRARY_PATH
		export JAVA_HOME
		export SCALA_HOME
		export GOPATH
		;;
esac

# Get the aliases and functions
[ -r ${HOME}/.bashrc ] && . ${HOME}/.bashrc
