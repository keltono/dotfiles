alias sl='ls' #typo preventance 
alias py='python'
alias rm='rm -I'
alias cim='vim'
alias sudo='sudo '
alias v='vim'
alias pv='feh -Fdrz --action9 "rm -f %F"'
alias ev='evince'
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
alias cdc="cd ~/school"
alias vi="vim"
#used for file transfer from local to server
#stands for SSH Transfer File

rawurlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"    # You can either set a return variable (FASTER)
#  REPLY="${encoded}"   #+or echo the result (EASIER)... or both... :p
}

share() {
    NORMPATH=$(realpath -s "$1")
    PATHNAME=.$(head /dev/urandom -c 20 | base64 | head - -c 20 | tr -d /)-$(basename "$1")
    rsync -avzz "$NORMPATH" cattown:/mnt/.share/"$PATHNAME"
    echo https://keltono.net/.share/$(rawurlencode "$PATHNAME")
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


acmtf(){ #ACM TransFer
    scp $1 keltont@argo.acm.umn.edu:/home/kelton/$2
}

acmssh(){
    ssh kelton@argo.acm.umn.edu
}

#Orsus Cross Compiler (currently just takes in llvm files since the toplevel system) currently only works on one file b/c idk how to do varags in bash
occ(){ #takes in inputfile and then an output file.
   llc -filetype=obj "$1" -o temp1234.o
   gcc -no-pie temp1234.o ~/orsuslib/bin/* -o "$2"
   rm temp1234.o
}

#Orsus Library Compiler

#EVince Quit
evq(){
    evince "$1" &
    disown -h %1 && exit
}

