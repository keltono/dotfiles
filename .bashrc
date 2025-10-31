[[ $- != *i* ]] && return
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias more=less

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize
shopt -s expand_aliases

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#configure jdtls
export JAR=/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.100.v20201223-0822.jar
export JAVA_HOME=/usr/lib/jvm/default
export JDTLS_CONFIG=/usr/share/java/jdtls/config_linux
export WORKSPACE=$HOME/.workspace
#note to self: i also needed to reset the permisions for the /usr/share/java/jdtls folder

export XDG_CONFIG_HOME=$HOME/.config
export NIXPKGS_ALLOW_UNFREE=1
