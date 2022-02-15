status is-interactive || exit

# See <file:///usr/share/doc/fish/faq.html#how-do-i-change-the-greeting-message>.
set -g fish_greeting

# See <https://stackoverflow.com/a/58382277>.
bind \co accept-autosuggestion execute

abbr -ag ... ../..
abbr -ag .... ../../..
abbr -ag ..... ../../../..
abbr -ag ...... ../../../../..

abbr -ag l 'ls'
abbr -ag la 'ls -A'
abbr -ag ll 'ls -lh'
abbr -ag thrl 'ls -thrl'

abbr -ag lsd 'ls -d */'

abbr -ag spinach 'trans >/dev/null -speak en:'

abbr -ag jd 'cd ~/dotfiles'
abbr -ag jp 'cd ~/projects'
abbr -ag jw 'cd ~/wiki'
abbr -ag jr 'cd ~/projects/resume'
abbr -ag jm 'cd ~/projects/meribold.org'

alias df 'df -h'
alias du 'du -h'
alias free 'free -h'

abbr -ag v '$VISUAL'

abbr -ag c 'git commit'
abbr -ag ci 'git commit'
abbr -ag ff 'git merge --ff-only'
abbr -ag ga 'git add'
abbr -ag gd 'git diff'
abbr -ag gg 'git graph'
abbr -ag gl 'git log'
abbr -ag gp 'git push'
abbr -ag gap 'git add -p'
abbr -ag gau 'git add -u'
abbr -ag gds 'git diff --staged'
abbr -ag gcm 'git commit -m'
abbr -ag gin 'git init'
abbr -ag game 'git commit --amend'
abbr -ag gish 'git show'
abbr -ag gist 'git status'

abbr -ag tag 'tig --all'

abbr -ag nx 'git annex'

abbr -ag pg 'pass git'

function archive_command_preexec --on-event fish_preexec
   set rowid (
      printf 'INSERT INTO commands(command, timestamp, wd, fish_pid)
              VALUES(\'%s\', \'%s\', \'%s\', %s);
              SELECT last_insert_rowid()' \
         (string replace --all \' \'\' $argv | string collect) \
         (date -Is) \
         (string replace --all \' \'\' $PWD | string collect) \
         $fish_pid \
         | sqlite3 ~/fish-command-archive.db
   )

   function archive_command_postexec --inherit-variable rowid --on-event fish_postexec
      printf 'UPDATE commands SET status = %s, duration = %s WHERE rowid = %s' \
         $status $CMD_DURATION $rowid | sqlite3 ~/fish-command-archive.db
   end
end
