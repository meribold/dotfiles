cat /proc/acpi/ibm/{thermal,fan} | head -n -3
cat /sys/class/power_supply/BAT1/energy_{now,full}
cower -u
f=$(mktemp).png bash -c 'maim -s -b 2 -c .843,.373,.373 --nokeyboard "$f" || maim "$f" && imgurbash "$f"'
feh --bg-center ~/images/1366x768/the-coming-darkness-noah-bradley.png
fortune ~/dotfiles/cookies | cowsay -f ~/dotfiles/dynamic_duo.cow | lolcat
git clean -dfx && git checkout -- .
git log --oneline --decorate --graph
git pull --recurse-submodules && git submodule update
git submodule foreach git clean -dfx # remove all untracked files of all submodules
git submodule foreach git pull
gpg-connect-agent reloadagent /bye # https://wiki.archlinux.org/index.php/GnuPG#Reload_the_agent
i3-msg 'append_layout ~/.config/i3/scratchpad.json; move scratchpad'
makepkg -sri
mpc clear && mpc ls | mpc add
rsync -r -h --info=progress2 SRC DEST
strfile ~/dotfiles/cookies
sudo dhcpcd -B wlan0
sudo mount /dev/sdb1 ~/sdb1
sudo wpa_supplicant -i wlan0 -c ~/.wpa_supplicant.conf
