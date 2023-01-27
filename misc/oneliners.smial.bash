ds compton -o 1 -i 0.85 --no-fading-openclose --unredir-if-possible
feh --bg-center ~/images/1366x768/the-coming-darkness-noah-bradley.png
fortune 50% meribold all | cowsay -W 72 -f dynamic-duo | lolcat
git push esgaroth snapshots-meribold-smial
i3-msg 'append_layout ~/.config/i3/scratchpad.json' && xterm -e 'stty -ixon && exec screen -S scratchpad -x -p 0' & sleep .3; i3-msg 'move scratchpad'
nx describe here Smial
nx init Smial
sudo rsync -hazzHAXx -M--fake-super --delete --exclude={'/dev/*','/proc/*','/sys/*','/tmp/*','/run/*','/mnt/*','/media/*','/lost+found','/var/cache/pacman/pkg/*','/home/meribold/.local/share/Steam/*','/home/meribold/.local/share/lutris/*','/home/meribold/vms/*'} --info=progress2 / esgaroth:smial/; systemctl suspend
while :; do clear; fortune meribold | cowsay -W 72 -f dynamic-duo | lolcat; read -n 1; done
cp {~/.mozilla,~/dotfiles/home/mozilla}/firefox/ctontcrf.default/prefs.js
cp {~/.config,~/dotfiles/home/config}/htop/htoprc
