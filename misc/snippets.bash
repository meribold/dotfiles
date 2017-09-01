PKGEXT=".pkg.tar" makepkg -sri # build and install an uncompressed package
amixer set Master mute
cat /proc/acpi/ibm/{thermal,fan} | head -n -3 # temperatures
cat /sys/class/power_supply/BAT1/energy_{now,full}
clear && neofetch --uptime_shorthand tiny --ascii && read
cower -u
f=$(mktemp).png bash -c 'maim -s -b 2 -c .843,.373,.373 --nokeyboard "$f" || maim "$f" && imgur.sh "$f"; rm "$f"'
feh --bg-center ~/images/1366x768/the-coming-darkness-noah-bradley.png
firefox-developer --new-tab $(gatewayip) # Try to open a router's web interface
fortune meribold | cowsay -f dynamic-duo | lolcat
git clean -dfx && git checkout -- .
git commit -m 'Update commits recorded by submodules'
git log --oneline --decorate --graph
git pull --recurse-submodules && git submodule update
git push --force-with-lease
git submodule foreach git clean -dfx # remove all untracked files of all submodules
git submodule foreach git pull
git submodule update # doesn't change what commits are recorded in the superproject
git submodule update --remote --merge # merge upstream submodule changes, updates recorded commits
gpg-connect-agent reloadagent /bye # https://wiki.archlinux.org/index.php/GnuPG#Reload_the_agent
i3-msg 'append_layout ~/.config/i3/scratchpad.json; move scratchpad'
ip address show dev wlan0
ip route show dev wlan0
iw dev wlan0 link
journalctl -fu dhcpcd@wlan0 --no-tail -b -o cat
journalctl -fu wpa_supplicant@wlan0 --no-tail -b -o cat
jpm run -b /usr/bin/firefox-developer # test Firefox add-on
latexmk -pdf -shell-escape
mbsync gmail && notmuch new
mount ~/sdb1 # mount known USB drive as normal user
mount ~/sdb1 && { git pull usb; umount ~/sdb1; } # pull from my USB drive
mount ~/sdb1 && { git push usb; umount ~/sdb1; } # push to my USB drive
mount ~/sdb1 && { pass git pull; umount ~/sdb1; } # pull to ~/.password-store
mount ~/sdb1 && { pass git push; umount ~/sdb1; } # push ~/.password-store
mpc clear && mpc ls | mpc add
mpc toggleoutput 2 # toggle whether MPD produces output for cli-visualizer
pacman -Qeq --foreign > ~/packages-foreign.txt
pacman -Qeq --native > ~/packages-native.txt
pacman -Qtdq # list (real) orphan packages
reflector -a 1 -f 10 -n 5 -p http --sort score | sudo tee /etc/pacman.d/mirrorlist # generate new mirror list for pacman
rofi -modi drun,run -matching fuzzy -show
rsync -r -h --info=progress2 SRC DEST
sudo dhcpcd -B wlan0
sudo ip link set wlan0 up
sudo iw dev wlan0 scan | less
sudo mount /dev/sdb1 ~/sdb1
sudo pacman -Syu
sudo systemctl poweroff
sudo systemctl suspend
sudo umount ~/sdb1
sudo wpa_supplicant -i wlan0 -c ~/.wpa_supplicant.conf
umount ~/sdb1
watch -n 1 cat /proc/acpi/ibm/{thermal,fan} /sys/class/power_supply/BAT1/energy_{now,full}
xprop
xrandr --output VGA-0 --auto --output HDMI-0 --auto # enable connected and disable disconnected external monitors
xrandr --output VGA-0 --off --output HDMI-0 --off # disable external monitors
xwininfo
youtube-dl -o - 'XAAp_luluo0' | mplayer -cache 8192 -
{ checkupdates & cower -u; } | less -FX # check for updates to native and foreign (AUR) packages
