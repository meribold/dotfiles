export VISUAL=nvim
export EDITOR=nvim
export BROWSER=firefox

export GPG_TTY=$(tty)
# The GNU Privacy Guard Manual suggest setting and exporting GPG_TTY like this.
# https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html
# https://www.gnupg.org/documentation/manuals/gnupg/Common-Problems.html

# Makes wiki-search-html from the arch-wiki-light package work.
export wiki_browser=$BROWSER

# Make RubyGems available (http://guides.rubygems.org/faqs/#user-install).
if which ruby >/dev/null && which gem >/dev/null; then
   PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

# Set PATH to include ~/bin if it exists.
if [ -d "$HOME/bin" ]; then
   PATH="$HOME/bin:$PATH"
fi

# vim: tw=90 sts=-1 sw=3 et ft=sh
