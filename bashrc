#!/bin/sh

# set app home
if [ -z "$APP_HOME" ]; then
	export APP_HOME="$HOME"
fi

# set language
if [ -z "$NOLANG" ]; then
	if [ `uname` = "AIX" ]; then
		export LANG=EN_US.UTF-8
	else
		export LANG=zh_CN.UTF-8
	fi
fi

# load application enviroment
if [ -f $APP_HOME/etc/bashrc.env ]; then
	. $APP_HOME/etc/bashrc.env
fi

if [ -f $APP_HOME/etc/bashrc.tools ]; then
	. $APP_HOME/etc/bashrc.tools
fi

if [ -f $APP_HOME/etc/bashrc.pyenv ]; then
	. $APP_HOME/etc/bashrc.pyenv
fi

# user
if [ -f $APP_HOME/etc/bashrc.user ]; then
	. $APP_HOME/etc/bashrc.user
fi

# path
PATH="$APP_HOME/bin:$PATH"

# lib
if [ -n "$LD_LIBRARY_PATH" ]; then
	export LD_LIBRARY_PATH=`echo "$LD_LIBRARY_PATH" | sed 's/^://'`
fi

# for other system
if [ -n "$LD_LIBRARY_PATH" ]; then
	case `uname` in
		AIX)
			export LIBPATH="${LIBPATH}:${LD_LIBRARY_PATH}"
			unset LD_LIBRARY_PATH
			;;
		Darwin)
			export DYLD_FALLBACK_LIBRARY_PATH="${DYLD_FALLBACK_LIBRARY_PATH}:${LD_LIBRARY_PATH}"
			export LUA_CPATH=`echo $LD_LIBRARY_PATH | path2lua.awk -v EXT=dylib`
			unset LD_LIBRARY_PATH
			;;
	esac
fi

# change work directory to APP_HOME
if [ -z "$NOCD" ]; then
	cd "$APP_HOME"
fi

# vim: filetype=sh
