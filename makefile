# I don't really know how to write portable shell scripts.  Just use Bash.
SHELL := /bin/bash

# Disable all built-in rules.  See <http://stackoverflow.com/q/4122831> and
# <http://gnu.org/software/make/manual/html_node/Catalogue-of-Rules.html>.
MAKEFLAGS += --no-builtin-rules

# Clear the suffix list; no suffix rules in this makefile.  See section 7.2.1 of the GNU
# Coding Standards [1].  This might be redundant.
.SUFFIXES:
# [1]: https://www.gnu.org/prep/standards/standards.html#Makefile-Basics

# The manual recommends variable names contain only "letters, numbers, and underscores".
# (https://www.gnu.org/software/make/manual/make.html#Using-Variables).
GIT_CRYPT ?= git-crypt

.PHONY: all vim nvim

# Set the default goal.
all: vim nvim

# Explicitly initialize as simple variables as recursive ones are the default.  Some
# directories are added to $(links) instead of $(dirs) when just linking to a directory
# has advantages compared to creating a directory with lots of links to files.  E.g.,
# `~/.vim/UltiSnips` is added to $(links), so that new snippet files created by
# `:UltiSnipsEdit` are inside the Git repository.
dirs  :=
links :=

# Define a variable containing all link targets used when building the `vim` goal.
# Generally, the directory structure is mirrored and only files are linked, but these
# directories are linked directly: `vim/after`, `vim/ftplugin`, `vim/UltiSnips`.
vim_link_targets := $(shell find home/vim -regex \
                                 'home/vim/after\|home/vim/ftplugin\|home/vim/UltiSnips' \
                                 -prune -o -type f -o -type l)
# Transform the list of link targets to paths of links that should be created when
# building the `vim` goal.
vim_links := $(patsubst home/%,$(HOME)/.%,$(vim_link_targets))

links += $(vim_links)

# Check if $(GIT_CRYPT) exists.  See <http://stackoverflow.com/a/677212>.  `command -v`
# prints something iff the command is available.  Thus, if the output is empty,
# `git-crypt` is not available.
ifeq ($(shell command -v $(GIT_CRYPT) 2>/dev/null),)
   $(info Note: $(GIT_CRYPT) is not available.)
else
   # Find (encrypted) prerequisite ".add" spell files (e.g. `en.utf-8.add`) and transform
   # the list of file paths to obtain the respective targets (".add.spl" files).  See
   # `:h spell` in Vim.
   add_spl_files := $(patsubst home/%,$(HOME)/.%.spl,$(wildcard home/vim/spell/*.add))
endif

# See <https://github.com/junegunn/vim-plug#installation>.
$(HOME)/.vim/autoload/plug.vim: | $(HOME)/.vim/autoload/
	curl -fLso '$@' \
	   'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# TODO: split plugin declarations into a separate file?
vim: $(vim_links) $(add_spl_files) $(HOME)/.vim/autoload/plug.vim \
   $(addprefix $(HOME)/.vim/spell/de.utf-8.,spl sug)
	@# Install plugins with vim-plug.  See
	@# <https://github.com/junegunn/dotfiles/blob/master/install-vim>.
	vim -u home/vim/vimrc +PlugInstall +qa

nvim: vim $(HOME)/.config/nvim \
   $(foreach ll,en de,$(addprefix $(HOME)/.config/nvim/spell/$(ll).utf-8.,spl sug))

# This is not a normal link into `dotfiles/`, so we need a special rule (instead of just
# adding the target to $(links)).  One alternative might be to have a link
# `dotfiles/config/nvim` to `~/.vim`.
$(HOME)/.config/nvim: %nvim: | %
	@# Assert that $@ doesn't exist.
	@[[ ! -e '$@' ]]
	ln -s '$(HOME)/.vim' '$@'

# Vim only bundles English spell files (though Arch has [vim-spell-de]).  I want German
# ones too.  Start Vim and prompt it to prompt us if it should download spell files.  They
# should be saved to `~/.vim/spell/`.
#
# [vim-spell-de]: https://www.archlinux.org/packages/extra/any/vim-spell-de/
#
# The command to invoke Vim is unfortunately quite complex.  Firstly because vimrc files
# may cause the prompt to not appear: in particular, the download functionality requires
# the netrw plugin, which I disabled from `common.vim` with `let loaded_netrwPlugin = 1`.
# It also depends on other bundled ".vim" files like `spellfile.vim`.
#
# The `-u NORC` option disables loading of any vimrc files (see `:h -noplugin`).  Setting
# 'rtp' ('runtimepath') to just `$VIMRUNTIME` (the directory containing runtime files
# distributed with Vim) prevents loading plugin scripts from $HOME.  They aren't needed
# and may cause warnings (stuff in my dotfile's `vim/after/` directory depends on things
# in my vimrc files).  See `:h load-plugins` and `:h initialization`.
#
# The next parameter triggers the prompt by setting 'spelllang' and enabling 'spell'.
# There must be a (writable) directory in 'rtp' for the prompt to appear, so `~/.vim` is
# readded.  See `:h spell-load` and `:h spellfile.vim`.
#
# `-N` sets 'nocompatible', which is also required.  See
# <https://github.com/vim/vim/blob/master/runtime/plugin/spellfile.vim>.
#
# FIXME: downloading `de.utf-8.sug` consistently fails.
#
# Also, "[p]attern rules may have more than one target.  Unlike normal rules, this does
# not act as many different rules with the same prerequisites and recipe.  If a pattern
# rule has multiple targets, `make` knows that the rule's recipe is responsible for making
# all of the targets.  The recipe is executed only once to make all the targets."
#    -- <https://www.gnu.org/software/make/manual/make.html#Pattern-Intro>
$(HOME)/.vim/spell/%.utf-8.spl $(HOME)/.vim/spell/%.utf-8.sug:
	@# Remove the ".spl" file if the associated ".sug" file doesn't exist.  Else, the
	@# download prompt won't appear.
	@[[ -e '$(@:.sug=.spl)' && ! -e '$(@:.spl=.sug)' ]] && \
	   { PS4=; set -x; rm '$(@:.sug=.spl)'; } || :
	vim -u NORC -N --cmd 'set rtp=$$VIMRUNTIME' \
	    +'set rtp+=~/.vim spelllang=$* spell' +q

# Neovim doesn't bundle any spell files [1] but improved the auto-download feature [2][3].
#
# The command to get spell files with Neovim is slightly different from Vim's.  For
# example, Neovim doesn't complain if stdin isn't a terminal and automatically confirming
# the downloads with `<<< y` works as expected.  We also don't need `-N`.
#
# When no spell directory is found, Neovim creates one inside `$XDG_DATA_HOME/nvim/site`
# (`~/.local/share/nvim/site`) and saves spell files there [4].  Readding `~/.config/nvim`
# to `rtp` prevents this.
#
# [1]: https://github.com/neovim/neovim/issues/1551
# [2]: https://github.com/neovim/neovim/pull/3027
# [3]: https://github.com/neovim/neovim/pull/4555
# [4]: https://github.com/neovim/neovim/blob/master/runtime/autoload/spellfile.vim
$(HOME)/.config/nvim/spell/%.utf-8.spl $(HOME)/.config/nvim/spell/%.utf-8.sug:
	@[[ -e '$(@:.sug=.spl)' && ! -e '$(@:.spl=.sug)' ]] && \
	   { PS4=; set -x; rm '$(@:.sug=.spl)'; } || :
	nvim -u NORC --cmd 'set rtp=$$VIMRUNTIME' \
	     +'set rtp+=~/.config/nvim spelllang=$* spell' +q <<< y

# FIXME: DRY.  This is too manual.  Write a function or something.  It could take the
# program name and a list of link names or link targets as arguments.
git_links := $(addprefix $(HOME)/,.gitconfig .gitignore)
links += $(git_links)
.PHONY: git
git: $(git_links)
all: git

bash_link_targets := $(addprefix home/,bash_logout bash_profile bashrc profile) \
                     $(wildcard home/bin/*)
bash_links := $(patsubst home/%,$(HOME)/.%,$(bash_link_targets))
links += $(bash_links)
.PHONY: bash
bash: $(bash_links)
all: bash

screen_links := $(HOME)/.screenrc
links += $(screen_links)
.PHONY: screen
screen: $(screen_links)
all: screen

mutt_link_targets := $(wildcard home/mutt/*) home/urlview
mutt_links := $(patsubst home/%,$(HOME)/.%,$(mutt_link_targets))
links += $(mutt_links)
.PHONY: mutt
mutt: $(mutt_links)
all: mutt

conky_links := $(HOME)/.config/conky
links += $(conky_links)
.PHONY: conky
conky: $(conky_links)
all: conky

dirs += $(sort $(dir $(links))) # `sort` removes duplicates.

# Create directories.
$(dirs):
	mkdir -p '$@'

# Enable the second expansion of prerequisites.
.SECONDEXPANSION:

# Link files.  Each target has the directory it should be created in as an order-only
# prerequisite.  If a conflicting file exists and it's a symbolic link, remove it.
$(links): | $$(dir $$@)
	@[[ -L '$@' ]] && { PS4=; set -x; rm '$@'; } || :
	ln -sT '$(patsubst $(HOME)/.%,$(CURDIR)/home/%,$@)' '$@'

# Create ".add.spl" files from corresponding ".add" prerequisites.  These are regular
# prerequisites (not order-only): if the ".add" file is newer than the target, the target
# must be rebuilt.
# A ".add" file is a word list.  Vim updates these when using the `zg` and `zw` mappings
# etc. but doesn't read them directly.  Instead, the associated binary ".add.spl" files
# are used.
$(add_spl_files): $$(patsubst %.spl,%,$$@)
	@# See `:h s-ex`.
	vim -u NONE -es '+mkspell! $<' +q

# vim: tw=90 ts=8 sts=-1 sw=3 noet
