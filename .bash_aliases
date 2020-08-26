alias sl='ls'
alias l='ls'
alias scheme='rlwrap scheme'
alias cl='rlwrap sbcl'
alias py='python'
alias rm='rm -I'
alias cvim='vim'
alias v='nvim'
alias vi="nvim"
# alias vim="nvim"
alias vimrc="nvim ~/.config/nvim/init.vim"
alias sudo='sudo '
alias pv='feh -Fdrz --action9 "rm -f %F"'
alias ev='evince'
alias aliases='vim ~/.bash_aliases'
alias g='git'
alias gc='git commit -S -m'
alias gs='git status | lolcat'
alias gp='git push'
alias upscale='waifu2x-converter-cpp' #it's annoying that they labled this truly amazing piece of software after the concept of anime wives
alias cfortune='fortune -a | cowsay | lolcat'
alias print='lpr -P home -o sides=two-sided-long-edge'
alias llobj='llc -filetype=obj'
alias llclean="ls | grep '\.'ll | xargs -I{} rm {}"
alias clangll="clang -S -emit-llvm"
alias todo="task"

gcap(){
    git pull && git add -A && git commit -m "$1" && git push
}
gcp(){
    git commit -m "$1" && git push
}


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
shared() {
    NORMPATH=$(realpath -s "$1")
    PATHNAME=.$(head /dev/urandom -c 20 | base64 | head - -c 20 | tr -d /)-$(basename "$1")
    rsync -avzz "$NORMPATH" cattown:/mnt/.share/"$PATHNAME"
    echo https://keltono.net/.share/$(rawurlencode "$PATHNAME")
    rm -rf "$NORMPATH"
}


#should upgrade this to use the contents of my clipboard instead,
#but then i would need to actually learn how xclip works
sharetxt() {
	PATHNAME=.$(head /dev/urandom -c 20| base64 | head - -c 20 | tr -d /)-$(echo "$1" | { read -a array ; echo ${array[0]} ; } )
	touch ./"$PATHNAME"
	echo "$@" > ./"$PATHNAME"
    rsync -avzz ./"$PATHNAME" cattown:/mnt/.share/"$PATHNAME".txt
	rm "$PATHNAME"
    echo https://keltono.net/.share/$(rawurlencode "$PATHNAME").txt
}

store() {
    rsync -avzz $1 cattown:/mnt/data/$2
}

stored() {
    rsync -avzz $1 cattown:/mnt/data/$2
    rm -rf $1
}

snag() {
    rsync -avzzh cattown:/mnt/data/$1 $2
}

ssnag() { #fragile and bad but i really don't care
  cd ~/spotify_recorder
  perl spotify_snag.pl --uri "$1" --format flac --outdir .
}

sc() {
    maim -s /tmp/temp_screen_cap.png
    PATHNAME=.$(head /dev/urandom -c 20 | base64 | head - -c 20 | tr -d /)
    rsync -avzz /tmp/temp_screen_cap.png cattown:/mnt/.share/screenshots/"$PATHNAME".png
    u="https://keltono.net/.share/screenshots/$(rawurlencode "$PATHNAME").png"
    echo $u
    echo $u | xclip -selection c
    # echo https://keltono.net/.share/screenshots/$(rawurlencode "$PATHNAME").png | xclip -selection c
    rm -f /tmp/temp_screen_cap.png
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


#EVince Quit
evq(){
    evince "$1" &
    disown -h %1 && exit
}


timeto(){
    declare -i hours
    declare -i mins
    hours=10#$(date '+%H')
    mins=10#$(date '+%M')
    hours=$1-$hours
    mins=$2-$mins
    if (( mins < 0 )); then
        mins=$mins+60
        hours=$hours-1
    fi
    echo "time until "$1":"$2" is $hours hours and $mins mins"
}
