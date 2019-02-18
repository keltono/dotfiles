alias aliases='vim ~/.bash_aliases'
alias sshts='ssh -X admin-acct@ssh.keltono.xyz -t "cd /files/; bash -l"'
alias g='git'
alias gc='git commit -S -m'
#used for file transfer from local to server
#stands for SSH Transfer File
sshtf() {
    scp $1 admin-acct@ssh.keltono.xyz:/files/$2
}
#self explanitory. downloads an mp3 from a youtube video. takes the url and then the name of the output file.
youtube-mp3() {
    youtube-dl -x --audio-format mp3 -o $2'.%(ext)s' $1
}
