# alias python='$(pyenv which python)'
alias py='python'
alias rm='rm -I'
alias cim='nvim'
alias v='nvim'
alias vi="nvim"
alias vim="nvim"
alias sudo='sudo '
alias rv='feh -FdrYz --action9 "rm -f %F"'
alias ev='evince'
alias g='git'
alias gc='git commit -S -m'
alias gs='git status | lolcat'
alias gp='git push'
alias cfortune='fortune -a | cowsay | lolcat'
alias print='lpr -P home -o sides=two-sided-long-edge'
alias llobj='llc -filetype=obj'
alias clangll="clang -S -emit-llvm"
alias todo="vim ~/vimwiki/todos.wiki"
alias sched="vim ~/vimwiki/schedule.wiki"
alias mdkir="mkdir"
alias scheme="rlwrap scheme"
alias pv='sudo feh --action1 "mv %f ./best"  --action9 "rm %f" -zdZFr  .'
alias gchi='ghci'
alias c='clear'
alias cal='cal -m'


catt(){
    cat $1 | uwuify
}
gcap(){
    git pull && git add -A && git commit -m "$1" && git push
}
gcp(){
    git commit -m "$1" && git push
}

cpt(){
    cp /home/kelton/school/Template.tex $1
}

ctv(){
    cp /home/kelton/school/Template.tex $1 ; vim $1
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
    PATHNAME=.$(head /dev/urandom -c 20 | base64 | head - -c 20 | tr -d /)-$(basename "$1")
    rsync -avzz -P $1 cattown:/mnt/.share/"$PATHNAME"
    echo https://keltono.net/.share/$(rawurlencode "$PATHNAME")
}
shared() {
    PATHNAME=.$(head /dev/urandom -c 20 | base64 | head - -c 20 | tr -d /)-$(basename "$1")
    rsync -avzz -P "$NORMPATH" cattown:/mnt/.share/"$PATHNAME"
    echo https://keltono.net/.share/$(rawurlencode "$PATHNAME")
    rm -rf $1
}


sharetxt() {
	PATHNAME=.$(head /dev/urandom -c 20| base64 | head - -c 20 | tr -d /)-$(echo "$1" | { read -a array ; echo ${array[0]} ; } )
	touch ./"$PATHNAME"
	echo "$@" > ./"$PATHNAME"
    rsync -avzz  -P ./"$PATHNAME" cattown:/mnt/.share/"$PATHNAME".txt
	rm "$PATHNAME"
    echo https://keltono.net/.share/$(rawurlencode "$PATHNAME").txt
}

store() {
    rsync -avzz -P $1 cattown:/mnt/data/$2
}


stored() {
    rsync -avzz -P $1 cattown:/mnt/data/$2
    rm -rf $1
}

snag() {
    rsync -avzzh -P cattown:/mnt/data/$1 $2
}

sc() {
    maim -s /tmp/temp_screen_cap.png
    PATHNAME=.$(head /dev/urandom -c 20 | base64 | head - -c 20 | tr -d /)
    rsync -avzz -P /tmp/temp_screen_cap.png cattown:/mnt/.share/screenshots/"$PATHNAME".png
    u="https://keltono.net/.share/screenshots/$(rawurlencode "$PATHNAME").png"
    echo $u
    echo $u | xclip -selection c
    # echo https://keltono.net/.share/screenshots/$(rawurlencode "$PATHNAME").png | xclip -selection c
    rm -f /tmp/temp_screen_cap.png
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

twomonitor(){
    xrandr --output LVDS1 --primary --mode 1366x768 --pos 277x1080 --rotate normal --output DP1 --off --output DP2 --off --output DP3 --off --output HDMI1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI2 --off --output HDMI3 --off --output VGA1 --off --output VIRTUAL1 --off
}

there(){
  cur="$(pwd)"
  nohup alacritty -e bash --rcfile <(echo '. ~/.bashrc; ' cd $cur)  &>/dev/null  &
}

uz(){
    unzip *.zip
    rm *.zip
}
muz(){
    mv "$1" .
    unzip *.zip
    rm *.zip
}
