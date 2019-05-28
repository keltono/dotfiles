cd ~/.i3/
modkey=`awk 'NR==5' config`
if [ "$modkey" = 'set $mod Mod4' ]; then
    echo "setting to mod1"
    sed -i '5s/.*/set $mod Mod1/' config
elif [ "$modkey" = 'set $mod Mod1' ]; then
    echo "setting to mod4"
    sed -i '5s/.*/set $mod Mod4/' config
fi
