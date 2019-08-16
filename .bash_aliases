alias sl='ls' #typo preventance 
alias rm='rm -I'
alias cim='vim'
alias cdh='cd ~' #CD Home
alias aliases='vim ~/.bash_aliases'
alias g='git'
alias gc='git commit -S -m'
alias gs='git status | lolcat'
alias gp='git push'
alias upscale='waifu2x-converter-cpp' #it's annoying that they labled this truly amazing piece of software after the concept anime wives
alias imv='feh --recursive -zdF' #can never remember all those tags
alias cfortune='fortune -a | cowsay | lolcat'
alias print='lpr -P home -o sides=two-sided-long-edge'
alias ll_ocamlbuild='ocamlbuild -no-hygiene -pkg llvm -pkg llvm.analysis -pkg llvm.bitwriter -pkg llvm.scalar_opts toy.byte && llclean'
alias llobj='llc -filetype=obj'
alias llclean="ls | grep '\.'ll | xargs -I{} rm {}"
alias clangll="clang -S -emit-llvm"
alias reload_aliases=" . ~/.bash_aliases"
alias vi="vim"
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

#Orsus Cross Compiler (currently just takes in llvm files since the toplevel system) currently only works on one file b/c idk how to do varags in bash
occ(){ #takes in inputfile and then an output file.
   llc -filetype=obj "$1" -o temp1234.o
   gcc -no-pie temp1234.o ~/orsuslib/bin/* -o "$2"
   rm temp1234.o
}

#Orsus Library Compiler
olibc(){
    gcc -c "$1" -o ../bin/"$2" #remember to put file type here
}
