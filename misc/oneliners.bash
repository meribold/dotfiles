# git clean -dfx && git checkout -- .
# git submodule foreach git clean -dfx # remove all untracked files of all submodules
# nx forget --force
# nx sync --cleanup
$FIREFOX --ProfileManager
$FIREFOX --safe-mode
>/dev/null trans -speak en: spinach
PKGEXT=".pkg.tar" makepkg -sri # build and install an uncompressed package
amixer set Master mute
bundle exec jekyll serve --drafts
bundle install --path vendor/bundle
cat /proc/cmdline # check what kernel parameters we booted with
cat /proc/sys/kernel/sysrq
cat /sys/devices/virtual/thermal/thermal_zone{0,1}/temp /proc/acpi/ibm/fan | head -5 # temperatures
cat /sys/module/usbcore/parameters/autosuspend
cd $(mktemp -d)
checkupdates | grep "$(pacman -Qqe | awk '{ print "^"$1" " }')" | grep -v ' \(.\+\)-\(.\+\) -> \1-.\+$' | less -FX
chmod -R a=r,a+X,u+w
clear && neofetch --uptime_shorthand tiny --ascii && read
coredumpctl list
curl ipinfo.io
ds compton -o 1 -i 0.85 --no-fading-openclose --unredir-if-possible
ds fcitx && sleep 0.5 && xmodmap ~/dotfiles/misc/xmodmaprc
f() { [[ $1 ]] && ssh esgaroth "git init --bare $1" && git remote add esgaroth esgaroth:"$1"; }; f
f() { mpc search any "$1" | mpc insert; }; f
f=$(mktemp).png bash -c 'maim -s -b 2 -c .843,.373,.373 --nokeyboard "$f" || maim "$f" && imgur.sh "$f"; rm "$f"'
f=~/screenshots/$(date "+%Y%m%dT%H%M%S").png bash -c 'maim -s -b 2 -c .843,.373,.373 --nokeyboard "$f" || maim "$f"'
feh --bg-center ~/images/1366x768/the-coming-darkness-noah-bradley.png
feh --sort mtime ~/.config/signal/attachments # view photos from Signal
feh --sort mtime ~/screenshots
find / -name '*.desktop' 2>/dev/null | less
fortune 50% meribold all | cowsay -W 72 -f dynamic-duo | lolcat
gds --color-words
getent hosts athrad snapscore.meribold.xyz snapscore.meribold.org meribold.xyz meribold.org
git check-attr --all
git commit -m 'Fix typo'
git commit -m 'Initial commit'
git commit -m 'Update commits recorded by submodules'
git fetch . WIP:master
git pull --ff-only
git pull --recurse-submodules && git submodule update
git push --force-with-lease
git remote | xargs -L1 -P0 git push
git stash push -u && rm -rf _site && bundle exec jekyll build && git stash pop
git submodule foreach git pull
git submodule update # doesn't change what commits are recorded in the superproject
git submodule update --remote --merge # merge upstream submodule changes, updates recorded commits
git-crypt status
gpg --armor --export D14CCBFF836E57327C252FDE7066AC79C4592C12
gpg --encrypt --armor --recipient D14CCBFF836E57327C252FDE7066AC79C4592C12
gpg-connect-agent reloadagent /bye # https://wiki.archlinux.org/index.php/GnuPG#Reload_the_agent
i3-msg 'append_layout ~/.config/i3/scratchpad.json' && xterm -e 'stty -ixon && exec screen -S scratchpad -x -p 0' & sleep .3; i3-msg 'move scratchpad'
i3-msg -- resize set 1370 381, move position -2 -2 # move and resize to scratchpad position and size
i3-msg -t get_workspaces | jq
journalctl --no-tail -b -o cat -fu dhcpcd@eth0
journalctl --no-tail -b -o cat -fu dhcpcd@wlan0
journalctl --no-tail -b -o cat -fu wpa_supplicant@wlan0
journalctl --user -n 100 -fu signal-cli.bash.service
journalctl -u "sshd@*"
journalctl /usr/bin/sshd
journalctl _COMM=sshd
kill -l
killall -SIGUSR1 dunst # pause Dunst
killall -SIGUSR2 dunst # resume Dunst
latexmk -pdf -shell-escape
mbsync gmail && notmuch new
mirrorlist=$(reflector --age 1 --latest 200 --sort rate -n 10) && sudo tee /etc/pacman.d/mirrorlist <<< "$mirrorlist" # generate new mirror list for pacman
mount ~/usb-hdd
mount ~/v8x # mount my USB drive (this only works because of an entry in my fstab(5))
mount ~/v8x && { git pull usb; umount ~/v8x; } # pull from my USB drive
mount ~/v8x && { git push usb; umount ~/v8x; } # push to my USB drive
mount ~/v8x && { pass git pull; umount ~/v8x; } # pull to ~/.password-store
mount ~/v8x && { pass git push; umount ~/v8x; } # push ~/.password-store
mpc clear && mpc add / && mpc shuffle # make MPD queue all songs in random order
mpc clear && mpc load favorites
mpc toggleoutput 2 # toggle whether MPD produces output for cli-visualizer
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://3p8jLMz0lu8' # Taverns of Azeroth (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://7cy_RK04TUA' # Vanilla Winterspring (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://BV-v9bdMQp0' # Teldrassil (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://C0nAcUxPFqs' # Ironforge (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://Gl6g9CZTZL0' # Gothic (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://Gli5allDOa8' # Stranglethorn Vale (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://ID1KR37bqnQ' # Vanilla Darkshore (music & rain ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://JUoH8CzIkDo' # Avatar mix 1
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://MW4fASDkQXA' # Elwynn (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://PGOjUZpYu-U' # Vanilla Feralas (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://QHV_FTIm6zY' # Vanilla Ironforge (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://RhYuUV4wSC8' # Vanilla Blackfathom Deeps (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://UrJTZZibdHk' # LOTR (calm music mix)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://WwcGGkvEIHE' # The Night Elves of Vanilla (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://XDKPs_CMd0E' # Vanilla Moonglade (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://YDOp-IlsO6I' # Winterspring (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://YONdeDeSgrQ' # Barrens (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://YTnLxsYOj8w' # Vanilla Tanaris (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://Y__NCf9lYPk' # Shire, LOTRO (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://_SBQvd6vY9s' # LOTR soundtrack
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://b-gMnQIV5tU' # Avatar mix 2
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://f-Ic9feSwcg' # Zangarmarsh (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://ix2CRYd2FT8' # The Tauren of Vanilla (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://j7GK9KPvabk' # Ashenvale (ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://ku4Z8GrHjIo' # Isle of Thunder (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://q8PqlJBeuT0' # Mulgore (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://rbM0eGQepgc' # Moonglade (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://u3qIZG11mSg' # Stormwind (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://wLY-5S-6xuY' # Darnassus (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio 'ytdl://xTPn_Nk_KrM' # Ashenvale (music & ambience)
mpv --input-file=/tmp/mpvfifo --ytdl-format bestaudio --shuffle 'ytdl://PLBCLqOzi7nCR7cfDldMpVICZ5BSdmQCT0'
mpv av://v4l2:/dev/video0
mutt_pid=$(pgrep neomutt) && sudo strace -p "$mutt_pid"
neomutt -s 'Hi.' 'meribold@gmail.com' <<< ''
nohup xdg-open file &>/dev/null <&1 &
nx copy --fast --all --to t5a # copy all available versions of all files
nx copy --fast --to esgaroth
nx copy --fast --to s3
nx describe esgaroth Esgaroth
nx describe here Smial
nx describe s3 'Amazon S3'
nx describe t5a 'Toshiba USB HDD'
nx info
nx info .
nx init 'ThinkPad X220'
nx initremote esgaroth type=rsync rsyncurl=esgaroth:DIR encryption=none
nx initremote foo type=S3 --whatelse
nx move --unused --to esgaroth
nx status
nx sync --no-resolvemerge --no-commit
nx version
nx vicfg
paccache -rk1 # remove all but the most recent cached versions of ALL packages
paccache -ruk0 # remove ALL cached versions of uninstalled packages
pacman -F FILENAME
pacman -Qe | grep -v "$(pacman -Qqeg base-devel base)" # print explicitly installed packages not in base or base-devel
pacman -Qeq --foreign > ~/dotfiles/misc/foreign-packages.txt
pacman -Qeq --native > ~/dotfiles/misc/native-packages.txt
pacman -Qii | awk '/^MODIFIED/ {print $2}' # list changed backup files
pacman -Qtdq # list (real) orphan packages
pass git remote | xargs -L1 -P0 pass git push
pip list --local --outdated # list outdated Python packages; use `pip install --user -U` to upgrade them
pip list --user --outdated # list outdated Python packages; use `pip install -U` to upgrade them
pydoc str
python -c 'import cv2; print(cv2.getBuildInformation())' | less
rclone mount dropbox: ~/dropbox
rclone mount googledrive: ~/googledrive
rofi -combi-modi window,drun -modi combi -show
rofi -modi drun,run -matching fuzzy -show
route -n # get the IP address of the default gateway (router)
rsync -rh --info=progress2 SRC DEST
sco() { git checkout --detach && git reset "$1" && git checkout "$1"; }; sco
scp -i athrad:SRC DEST
sensors
sleep 1 && i3-msg border pixel 1
slop -b 2 -c .843,.373,.373 -t 9999 --nokeyboard >/dev/null && i3-msg border none # remove any border from a container
slop -b 2 -c .843,.373,.373 -t 9999 --nokeyboard >/dev/null && i3-msg border pixel 1 # add a border to a container
ssh -t athrad screen -Ux
ssh esgaroth ls .zfs/snapshot
ssh esgaroth quota
sshfs esgaroth: ~/esgaroth
sudo dhcpcd -B wlan0
sudo etckeeper commit
sudo ip link set wlan0 up
sudo iw dev wlan0 connect SSID # join the open WiFi network with the given SSID
sudo iw dev wlan0 scan | less
sudo pacman -D --asdeps PACKAGE
sudo pacman -Rns $(pacman -Qtdq) # recursively remove (real) orphan packages
sudo pacman -Syu
sudo rsync -hazzHAXx -M--fake-super --delete --exclude={'/dev/*','/proc/*','/sys/*','/tmp/*','/run/*','/mnt/*','/media/*','/lost+found','/var/cache/pacman/pkg/*'} --info=progress2 / esgaroth:smial/; systemctl suspend
sudo sysctl kernel.sysrq=1
sudo systemctl restart dhcpcd@wlan0
sudo systemctl restart wpa_supplicant@wlan0
sudo systemctl start dhcpcd@eth0
sudo systemctl stop wpa_supplicant@wlan0
sudo wpa_supplicant -i wlan0 -c ~/.wpa_supplicant.conf
sysctl kernel.sysrq
systemctl --user restart signal-cli.bash.service
systemctl --user start signal-cli.bash.service
systemctl --user stop signal-cli.bash.service
telnet mapscii.me
time cat
trans :zh-TW -b - | s
umount ~/usb-hdd
umount ~/v8x
vim -u NONE
watch -n 1 cat /proc/acpi/ibm/{thermal,fan} /sys/class/power_supply/BAT0/energy_{now,full}
wgetpaste
while :; do clear; fortune meribold | cowsay -W 72 -f dynamic-duo | lolcat; read -n 1; done
xbindkeys -k
xdg-open file &>/dev/null <&1 & disown
xdotool key Caps_Lock
xev # interactively enter keys and get keysyms
xprop
xrandr --output HDMI-0 --auto --right-of LVDS # FIXME: untested
xrandr --output VGA-0 --auto --output HDMI-0 --auto # enable connected and disable disconnected external monitors
xrandr --output VGA-0 --off --output HDMI-0 --off # disable external monitors
xsel --clipboard | vipe | xsel --clipboard
xsel --clipboard | wgetpaste --tee -C
xwininfo
youtube-dl -x --audio-format mp3 --audio-quality 0 'GmtTDvNcXcU'
{ checkupdates & auracle outdated; } | less -FX # check for updates to native and foreign (AUR) packages
