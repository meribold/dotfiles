ds compton -o 1 -i 0.85 --no-fading-openclose --unredir-if-possible
fortune 50% meribold all | cowsay -W 72 -f dynamic-duo | lolcat
git push esgaroth snapshots-meribold-smial
i3-msg 'append_layout ~/.config/i3/scratchpad.json' && xterm -e 'stty -ixon && exec screen -S scratchpad -x -p 0' & sleep .3; i3-msg 'move scratchpad'
nx describe here Smial
nx init Smial
date; sudo backup; date; systemctl suspend
while :; do clear; fortune meribold | cowsay -W 72 -f dynamic-duo | lolcat; read -n 1; done
cp {~/.mozilla,~/dotfiles/home/mozilla}/firefox/ctontcrf.default/prefs.js
cp {~/.config,~/dotfiles/home/config}/htop/htoprc
