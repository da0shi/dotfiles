#.bash_profile
export _BASH_PROFILE_=":"
. ${HOME}/.bash_utils

OS=$(uname)

## Version Info
JDK_VERSION=jdk1.7.0_51
TITANIUM_VERTION=2.1.4GA

case ${OS} in
	Darwin )
		# java
		JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home
		# android
		ANDROID_SDK=/opt/local/android-sdk-macosx
		ANDROID_NDK=/opt/local/android-ndk-macosx
		;;
	* )
		# java
		JAVA_HOME=/opt/local/java/${JDK_VERSION}
		# scala
		SCALA_HOME=/opt/local/scala-2.11.2
		# android
		ANDROID_SDK=/usr/local/android-sdk
		ANDROID_NDK=/usr/local/android-ndk
		;;
esac


# TeX
TEXLIVE_ROOT=/usr/local/texlive

# path
pathmerge ${JAVA_HOME}/bin
pathmerge ${SCALA_HOME}/bin
pathmerge ${ANDROID_SDK}/tools
pathmerge ${ANDROID_SDK}/platform-tools
pathmerge /opt/local/bin
pathmerge ${HOME}/local/bin
pathmerge ${HOME}/.local/bin

# "mysql"
[ -d /usr/local/mysql ] && pathmerge /usr/local/mysql/bin
# "TeX"
case ${OS} in
	Darwin )
		TEX_BIN=x86_64-darwin
		;;
	* )
		TEX_BIN=x86_64-linux
		;;
esac
pathmerge ${TEXLIVE_ROOT}/2012/bin/${TEX_BIN}
pathmerge MAN${TEXLIVE_ROOT}/2012/texmf/doc/man

pathmerge LIB/usr/local/lib

# export variables
export PATH
export MANPATH
export LD_LIBRARY_PATH

export JAVA_HOME

[ "${TERM}" != "linux" ] && export TERM=xterm-256color

# Get the aliases and functions
[ -r ${HOME}/.bashrc ] && . ${HOME}/.bashrc
