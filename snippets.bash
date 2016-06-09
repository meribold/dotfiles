cat /proc/acpi/ibm/{thermal,fan} | head -n -3 # temperatures
cat /sys/class/power_supply/BAT1/energy_{now,full}
cower -u
f=$(mktemp).png bash -c 'maim -s -b 2 -c .843,.373,.373 --nokeyboard "$f" || maim "$f" && imgur.sh "$f"; rm "$f"'
feh --bg-center ~/images/1366x768/the-coming-darkness-noah-bradley.png
fortune ~/dotfiles/cookies | cowsay -f ~/dotfiles/dynamic_duo.cow | lolcat
git clean -dfx && git checkout -- .
git log --oneline --decorate --graph
git pull --recurse-submodules && git submodule update
git submodule foreach git clean -dfx # remove all untracked files of all submodules
git submodule foreach git pull
git submodule update # doesn't change what commits are recorded in the superproject
git submodule update --remote --merge # merge upstream submodule changes
gpg-connect-agent reloadagent /bye # https://wiki.archlinux.org/index.php/GnuPG#Reload_the_agent
i3-msg 'append_layout ~/.config/i3/scratchpad.json; move scratchpad'
iw dev wlan0 link
makepkg -sri
mpc clear && mpc ls | mpc add
pacman -Qeq --foreign > ~/packages-foreign.txt
pacman -Qeq --native > ~/packages-native.txt
rsync -r -h --info=progress2 SRC DEST
strfile ~/dotfiles/cookies
sudo dhcpcd -B wlan0
sudo iw dev wlan0 scan | less
sudo mount /dev/sdb1 ~/sdb1
sudo systemctl poweroff
sudo systemctl suspend
sudo umount ~/sdb1
sudo wpa_supplicant -i wlan0 -c ~/.wpa_supplicant.conf
watch -n 1 cat /proc/acpi/ibm/{thermal,fan} /sys/class/power_supply/BAT1/energy_{now,full}
xrandr --output LVDS --auto
youtube-dl -o - 'XAAp_luluo0' | mplayer -cache 8192 -
