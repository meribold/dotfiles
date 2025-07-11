git remote | xargs -L1 -P0 git push
pass git remote | xargs -L1 -P0 pass git push
git push --force-with-lease
cd $(mktemp -d)
pacman -Qtdq # list (real) orphan packages
sudo pacman -Rns $(pacman -Qtdq) # recursively remove (real) orphan packages
nx sync --no-content --no-resolvemerge --no-commit
nx sync --no-content --no-resolvemerge --no-commit --no-pull
nx sync --no-content --no-resolvemerge --no-commit --no-push
nx copy --fast --all --to esgaroth
nx copy --fast --all --to s3
nx copy --fast --all --to s5g
nx copy --fast --all -J4 --to esgaroth
{ reflector --protocol https --completion-percent 100 --age 1 --delay 1 --sort rate --number 10 --connection-timeout 1 --download-timeout 1 || cat /etc/pacman.d/mirrorlist; } | sudo sponge /etc/pacman.d/mirrorlist # generate new mirror list for pacman
git check-attr --all
gds --color-words
gds --word-diff
git pull --ff-only
git mergetool --tool=kdiff3
git mergetool --tool=meld
git mergetool --tool=p4merge
nx info
nx info .
nx info here
nx status
nx version
paccache -rk1 # remove all but the most recent cached versions of ALL packages
paccache -ruk0 # remove ALL cached versions of uninstalled packages
$FIREFOX --safe-mode
PKGEXT=".pkg.tar" makepkg -sri # build and install an uncompressed package
bundle install
cat /sys/devices/virtual/thermal/thermal_zone{0,1}/temp /proc/acpi/ibm/fan | head -5 # temperatures
checkupdates | grep "$(pacman -Qqe | awk '{ print "^"$1" " }')" | grep -v ' \(.\+\)-\(.\+\) -> \1-.\+$' | less -FX
chmod -R a=r,a+X,u+w
clear && neofetch --uptime_shorthand tiny --ascii && read
coredumpctl list
f() { [[ $1 ]] && ssh esgaroth "git init --bare $1" && git remote add esgaroth esgaroth:"$1"; }; f
f=$(mktemp).png bash -c 'maim -s -b 2 -c .843,.373,.373 --nokeyboard "$f" || maim "$f" && imgur.sh "$f"; rm "$f"'
f=~/screenshots/$(date +%Y%m%dT%H%M%S).png bash -c 'maim -s -b 2 -c .843,.373,.373 --nokeyboard "$f" || maim "$f"'
find / -name '*.desktop' 2>/dev/null | less
git commit --amend --date=now
git commit -m 'Fix typo'
git commit -m 'Initial commit'
git commit -m 'Update commits recorded by submodules'
git config --list
git fetch . WIP:master
git pull --recurse-submodules && git submodule update
git submodule foreach git pull
git submodule update # doesn't change what commits are recorded in the superproject
git submodule update --remote --merge # merge upstream submodule changes, updates recorded commits
git-crypt status
gpg --edit-key D14CCBFF836E57327C252FDE7066AC79C4592C12
gpg --encrypt --armor --recipient D14CCBFF836E57327C252FDE7066AC79C4592C12
gpg --export --armor D14CCBFF836E57327C252FDE7066AC79C4592C12
i3-msg -- resize set 1370 381, move position -2 -2 # move and resize to scratchpad position and size
journalctl --dmesg --follow
journalctl --no-tail -b -o cat -fu dhcpcd@eth0
journalctl --no-tail -b -o cat -fu dhcpcd@wlan0
journalctl --no-tail -b -o cat -fu wpa_supplicant@wlan0
journalctl -u "sshd@*"
journalctl /usr/bin/sshd
journalctl _COMM=sshd
latexmk -pdf -shell-escape
mbsync gmail && notmuch new
mkcd $(date -I)
mkdir -p delete-me && feh --action 'mv %N delete-me' .
mount ~/s5g
mount ~/v8x # mount my USB drive (this only works because of an entry in my fstab(5))
mount ~/v8x && { git pull usb; umount ~/v8x; } # pull from my USB drive
mount ~/v8x && { git push usb; umount ~/v8x; } # push to my USB drive
mount ~/v8x && { pass git pull; umount ~/v8x; } # pull to ~/.password-store
mount ~/v8x && { pass git push; umount ~/v8x; } # push ~/.password-store
mpc toggleoutput 2 # toggle whether MPD produces output for cli-visualizer
mpv av://v4l2:/dev/video0
nohup xdg-open file &>/dev/null <&1 &
nx describe esgaroth Esgaroth
nx describe s3 'Amazon S3'
nx describe s5g 'Samsung T7 Shield'
nx initremote esgaroth type=rsync rsyncurl=esgaroth:DIR encryption=none
nx initremote foo type=rsync --whatelse
nx initremote foo type=S3 --whatelse
nx move --unused --to esgaroth
nx vicfg
nx whereis --unused
nx whereis --all
nx fsck --all
pacman -F FILENAME
pacman -Qe | grep -v "$(pacman -Qqeg base-devel base)" # print explicitly installed packages not in base or base-devel
pacman -Qii | awk '/^MODIFIED/ {print $2}' # list changed backup files
pip list --local --outdated # list outdated Python packages; use `pip install --user -U` to upgrade them
pip list --user --outdated # list outdated Python packages; use `pip install -U` to upgrade them
python -c 'import cv2; print(cv2.getBuildInformation())' | less
rclone mount dropbox: ~/dropbox
rclone mount googledrive: ~/googledrive
rm -rf _serve && bundle exec jekyll serve --drafts --unpublished --future --destination _serve
rsync -rh --info=progress2 SRC DEST
sco() { git checkout --detach && git reset "$1" && git checkout "$1"; }; sco
set -o
sleep 1 && i3-msg border pixel 1
slop -b 2 -c .843,.373,.373 -t 9999 --nokeyboard >/dev/null && i3-msg border none # remove any border from a container
slop -b 2 -c .843,.373,.373 -t 9999 --nokeyboard >/dev/null && i3-msg border pixel 1 # add a border to a container
sshfs esgaroth: ~/esgaroth
sudo dhcpcd -B wlan0
sudo etckeeper commit
sudo iw dev wlan0 connect SSID # join the open WiFi network with the given SSID
sudo iw dev wlan0 scan | less
sudo pacman -D --asdeps PACKAGE
sudo pacman -Syu
sudo sysctl kernel.sysrq=1
telnet mapscii.me
trans :zh-TW -b - | s
vim -u NONE
watch -n 1 cat /proc/acpi/ibm/{thermal,fan} /sys/class/power_supply/BAT0/energy_{now,full}
wgetpaste
xdg-open file &>/dev/null <&1 & disown
xsel --clipboard | vipe | xsel --clipboard
xsel --clipboard | wgetpaste --tee -C
youtube-dl -x --audio-format mp3 --audio-quality 0 'GmtTDvNcXcU'
{ checkupdates & auracle outdated; } | less -FX # check for updates to native and foreign (AUR) packages
python -m http.server
ping -bc6 192.168.1.255
vim .git/info/exclude
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
# git clean -dfx && git checkout -- .
# git submodule foreach git clean -dfx # remove all untracked files of all submodules
# nx forget --force
# nx sync --cleanup
