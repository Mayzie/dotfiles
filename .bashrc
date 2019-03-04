#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias open=xdg-open
alias cp='cp -i'
shopt -s nocaseglob
PS1='[\u@\h \W]\$ '

export ANDROID_HOME=/opt/android-sdk/

# Add ADB to the path.
export PATH=$ANDROID_HOME/platform-tools/:$PATH
# Add Python2 application check to the path.
export PATH=${HOME}/QEMU/bin/:/opt/cocos2d-x/tools/cocos2d-console/bin:/opt/cocos2d-x/tools/cocos2d-console/plugins/plugin_package/:/usr/local/bin/:$PATH

export NDK_ROOT=/opt/android-sdk/ndk-bundle
export ANDROID_SDK_ROOT=/opt/android-sdk
export ANT_ROOT=/usr/bin

# Add environment variable COCOS_X_ROOT for cocos2d-x
export COCOS_X_ROOT=/opt
export PATH=$COCOS_X_ROOT:$PATH
export http_proxy=''
export https_proxy=''
export ftp_proxy=''
export socks_proxy=''
export EDITOR=vim
export VISUAL=vim
export SUDO_EDITOR=vim


aria2dl() {
	if [ "$#" -gt 1 ]; then
		aria2c -x8 -j8 -s8 --file-allocation=none --header="Authorization: $2" "$1"
	elif [ "$#" -eq 1 ]; then
		aria2c -x8 -j8 -s8 "$1"
	fi
}

apt-get() {
	>&2 echo "Error: apt-get or apt is an Ubuntu specific command and is not applicable to Arch Linux. Use pacman to install software instead."
}

alias apt=apt-get

# Unlimited bash history
HISTSIZE=
HISTFILESIZE=
