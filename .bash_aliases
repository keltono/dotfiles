alias aliases='vim ~/.bash_aliases'
alias sshts='ssh -X -p 844 admin-acct@ssh.keltono.xyz -t "cd /files/; bash -l"'
alias sshtpi='ssh -X -p 8744 pi@ssh.keltono.xyz'
alias g='git'
alias gc='git commit -S -m'
alias gs='git status | lolcat'
alias gpu='git pull'
alias cfortune='fortune -a | cowsay | lolcat'
alias t='tmux'
#used for file transfer from local to server
#stands for SSH Transfer File
sshtf() {
    scp $1 admin-acct@ssh.keltono.xyz:/files/$2
}
#self explanitory. downloads an mp3 from a youtube video. takes the url and then the name of the output file.
youtube-mp3() {
    youtube-dl -x --audio-format mp3 -o $2'.%(ext)s' $1
}
cloc-git(){
    git clone --depth 1 "$1" temp-linecount-repo &&
        printf "('temp-linecount-repo' will be deleted automatically)\n\n\n" &&
        cloc temp-linecount-repo &&
        rm -rf temp-linecount-repo
}
mvc(){
    cur="$(pwd)"
    cd ..
    mv $cur $1
    cd $1
}

cowr(){
    exec echo "$@" | cowsay | lolcat
}
