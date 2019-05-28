alias sl='ls'
alias aliases='vim ~/.bash_aliases'
alias sshtpi='ssh -X -p 8744 pi@ssh.keltono.xyz'
alias g='git'
alias gc='git commit -S -m'
alias gs='git status | lolcat'
alias gpu='git pull'
alias upscale='waifu2x-converter-cpp'
alias pv='feh --recursive -zdF'
alias cfortune='fortune -a | cowsay | lolcat'
alias print='lpr -P home -o sides=two-sided-long-edge'
#used for file transfer from local to server
#stands for SSH Transfer File

sshtc() { 
    if [ $(iwconfig wlp3s0 | grep 'ESSID' | awk '{print $4}') = 'ESSID:"OBRIEN"' ] 
    then
        ssh -X -p 844 admin-acct@10.0.0.45 -t "cd /files/; bash -l"
    else
        ssh -X -p 844 admin-acct@ssh.keltono.xyz -t "cd /files/; bash -l"
    fi
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

sshtf(){
    scp -P 844 $1 admin-acct@ssh.keltono.xyz:/files/$2
}
