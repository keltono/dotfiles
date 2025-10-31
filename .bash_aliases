alias w='emacs ~/work/france/cubical/Cubical/Cohomology/GroupCohomology.agda &'
alias py='python'
alias rm='rm -I'
alias cim='nvim'
alias vi="nvim"
alias vim="nvim"
alias sudo='sudo '
alias s='sioyek'
alias g='git'
alias gc='git commit -S -m'
alias gs='git status | lolcat'
alias gp='git push'
alias cfortune='fortune -a | cowsay | lolcat'
alias clangll="clang -S -emit-llvm"
alias mdkir="mkdir"
alias scheme="rlwrap scheme"
alias gchi='ghci'
alias c='clear'
alias deu='setxkbmap -layout de'
alias cube='cd ~/work/france/cubical/Cubical'
alias ami='setxkbmap -layout us'
alias cfg='sudo nvim /etc/nixos/configuration.nix'
alias work='cd ~/1lab ; nix-shell  --command "cd src/1Lab/Reflection/ && emacs Paper.agda &"'
alias lightmode="sed -i 's/^#//' ~/.config/foot/foot.ini &&  sed -i 's/^\"set background/set background/' ~/.config/nvim/init.vim"
alias darkmode="sed -i 's/^/#/' ~/.config/foot/foot.ini && sed -i 's/^set background/\"set background/' ~/.config/nvim/init.vim"
alias deskmonitor="sed -i 's/^output DP-2 scale 1.5/#output DP-2 scale 1.5/' ~/.sway/config && sed -E -i 's/^#(output DP-2 pos 1504 0 transform 270 scale 1.5)/\1/' ~/.sway/config"
alias classmonitor="sed -E -i 's/^#(output DP-2 scale 1.5)/\1/' ~/.sway/config && sed -E -i 's/^(output DP-2 pos 1504 0 transform 270 scale 1.5)/#\1/' ~/.sway/config"
alias present="wl-present mirror eDP-1 --fullscreen-output DP-4"
alias mirror="wl-present mirror eDP-1 --fullscreen-output DP-2 --fullscreen"
alias class="lightmode && classmonitor && mirror"
alias unclass="darkmode && deskmonitor"

commd(){
  cp ~/work/cubical/Cubical/HITs/Join/Dist.agda ~/work/groupCohomology/Join

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
    rsync -avzz -P $1 keltono.net:/mnt/.share/"$PATHNAME"
    echo https://keltono.net/.share/$(rawurlencode "$PATHNAME")
}
shared() {
    PATHNAME=.$(head /dev/urandom -c 20 | base64 | head - -c 20 | tr -d /)-$(basename "$1")
    rsync -avzz -P "$NORMPATH" cattown:/mnt/.share/"$PATHNAME" && rm -rf $1
    echo https://keltono.net/.share/$(rawurlencode "$PATHNAME")
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
    rsync -avzz -P $1 keltono.net:/mnt/data/$2
}


stored() {
    rsync -avzz -P $1 keltono.net:/mnt/data/$2
    rm -rf $1
}

snag() {
    rsync -avzzh -P keltono.net:/mnt/data/$1 $2
}

scc() {
    maim -s /tmp/temp_screen_cap.png
    PATHNAME=.$(head /dev/urandom -c 20 | base64 | head - -c 20 | tr -d /)
    rsync -avzz -P /tmp/temp_screen_cap.png keltono.net:/mnt/.share/screenshots/"$PATHNAME".png
    u="https://keltono.net/.share/screenshots/$(rawurlencode "$PATHNAME").png"
    echo $u
    echo $u | xclip -selection c
    rm -f /tmp/temp_screen_cap.png
}

sc() {
    maim -s /tmp/temp_screen_cap.png
    xclip -sel clip -t image/png < /tmp/temp_screen_cap.png 
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

uz(){
    unzip *.zip
    rm *.zip
}

cdir(){
    mkdir $1
    cd $1
}
