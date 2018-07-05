PKGEXT=".pkg.tar" makepkg -sri # build and install an uncompressed package
amixer set Master mute
cat /sys/devices/virtual/thermal/thermal_zone{0,1}/temp /proc/acpi/ibm/fan | head -5 # temperatures
cat /sys/class/power_supply/BAT1/energy_{now,full}
clear && neofetch --uptime_shorthand tiny --ascii && read
cower -u
f=$(mktemp).png bash -c 'maim -s -b 2 -c .843,.373,.373 --nokeyboard "$f" || maim "$f" && imgur.sh "$f"; rm "$f"'
feh --bg-center ~/images/1366x768/the-coming-darkness-noah-bradley.png
firefox-developer --new-tab $(gatewayip) # Try to open a router's web interface
fortune 50% meribold all | cowsay -W 72 -f dynamic-duo | lolcat
git clean -dfx && git checkout -- .
git commit -m 'Update commits recorded by submodules'
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
jpm run -b /usr/bin/firefox-developer-edition # test Firefox add-on
killall -SIGUSR1 dunst # pause Dunst
killall -SIGUSR2 dunst # resume Dunst
latexmk -pdf -shell-escape
mbsync gmail && notmuch new
mount ~/v8x # mount my USB drive (this only works because of an entry in my fstab(5))
mount ~/v8x && { git pull usb; umount ~/v8x; } # pull from my USB drive
mount ~/v8x && { git push usb; umount ~/v8x; } # push to my USB drive
mount ~/v8x && { pass git pull; umount ~/v8x; } # pull to ~/.password-store
mount ~/v8x && { pass git push; umount ~/v8x; } # push ~/.password-store
mpc clear && mpc add / && mpc shuffle
mpc toggleoutput 2 # toggle whether MPD produces output for cli-visualizer
pacman -Qeq --foreign > ~/packages-foreign.txt
pacman -Qeq --native > ~/packages-native.txt
pacman -Qtdq # list (real) orphan packages
pip list --local --outdated # list outdated Python packages; use `pip install --user -U` to upgrade them
pip list --user --outdated # list outdated Python packages; use `pip install -U` to upgrade them
reflector -a 1 -f 10 -n 5 -p http --sort score | sudo tee /etc/pacman.d/mirrorlist # generate new mirror list for pacman
rofi -modi drun,run -matching fuzzy -show
rsync -r -h --info=progress2 SRC DEST
sudo dhcpcd -B wlan0
sudo ip link set wlan0 up
sudo iw dev wlan0 scan | less
sudo mount /dev/sdb1 ~/sdb1
sudo pacman -Syu
sudo systemctl poweroff
sudo systemctl restart wpa_supplicant@wlan0
sudo systemctl suspend
sudo umount ~/sdb1
sudo wpa_supplicant -i wlan0 -c ~/.wpa_supplicant.conf
umount ~/v8x
watch -n 1 cat /proc/acpi/ibm/{thermal,fan} /sys/class/power_supply/BAT1/energy_{now,full}
while :; do clear; fortune meribold | cowsay -W 72 -f dynamic-duo | lolcat; read -n 1; done
xprop
xrandr --output VGA-0 --auto --output HDMI-0 --auto # enable connected and disable disconnected external monitors
xrandr --output VGA-0 --off --output HDMI-0 --off # disable external monitors
xwininfo
youtube-dl -o - 'XAAp_luluo0' | mplayer -cache 8192 -
{ checkupdates & cower -u; } | less -FX # check for updates to native and foreign (AUR) packages
