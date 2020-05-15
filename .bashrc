export LC_ALL=C; unset LANGUAGE

export XDG_CURRENT_DESKTOP=KDE

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# bash history
HISTSIZE=
HISTFILESIZE=
export HISTTIMEFORMAT="[%F %T] "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH=$PATH:~/bin/jetbrains-toolbox
export PATH=$PATH:~/bin
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock # to run docker rootless

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Nord prompt
compile_prompt () {
  local EXIT=$?
  local SPLITBAR=$'-'
  local c_gray='\e[01;30m'
  local c_blue='\e[0;34m'
  local c_cyan='\e[0;36m'
  local c_reset='\e[0m'

  # > Return
  PS1="\n${c_gray}"

  # > Username
  PS1+="[${c_blue}\u${c_gray}]"
  PS1+="$SPLITBAR"

  # > Jobs
  PS1+="[${c_blue}\j${c_gray}]"

  # > Exit Status
  PS1+="[${c_blue}${EXIT}${c_gray}]"
  PS1+="$SPLITBAR"

  # > Time
  PS1+="[${c_blue}\D{%H:%M:%S}${c_gray}]\n"

  # > Working Directory
  PS1+="${c_gray}[${c_blue}\w${c_gray}]"

  # > Git
  PS1+="$(__git_ps1 "-[${c_cyan}%s${c_gray}][${c_cyan}$(git rev-parse --short HEAD 2> /dev/null)${c_gray}]")"

  # > Color reset
  PS1+=" \[\e[0m\]"
}

PROMPT_COMMAND='compile_prompt'
