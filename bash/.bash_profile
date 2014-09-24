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
		;;
esac

# Get the aliases and functions
[ -r ${HOME}/.bashrc ] && . ${HOME}/.bashrc
