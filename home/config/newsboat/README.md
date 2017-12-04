# [Newsboat](https://newsboat.org) Configuration

Newsboat is a fork of Newsbeuter, [the Mutt of feed readers][1].  "[The only difference
is that Newsboat is actively maintained while Newsbeuter isn't.][Newsboat]"  I set
Newsboat up to mostly use the same colors I configured for Mutt as well as similar
keybindings.  Newsboat doesn't really have the flexibility to faithfully reproduce *all*
my Mutt key bindings, but it does get close enough: I only get irritated once in a while
because of muscle memory.

My [`urls`](urls) file is encrypted with [git-crypt][].

## Highlights

*   <kbd>o</kbd> opens the URL associated with the current article using `$BROWSER`.  I
    have `$BROWSER` set to `firefox-developer`, so articles are opened in Firefox instead
    of a text-based browser.
*   <kbd>,</kbd> <kbd>o</kbd> passes the URL associated with the current article to
    [mpv][] using the [`mpv.sh`](mpv.sh) script in this directory.  A new `screen(1)`
    split is created for mpv and is killed again when mpv exits.  I use this keybinding
    for YouTube subscriptions.
*   All my YouTube subscriptions are aggregated into a single feed.  The relevant section
    of my `urls` file looks like this:

        https://www.youtube.com/feeds/videos.xml?channel_id=UCYO_jab_esuFRV4b17AJtAw "~3Blue1Brown" !YouTube YouTube
        https://www.youtube.com/feeds/videos.xml?channel_id=UC8BtBl8PNgd3vWKtm2yJ7aA "~Bartosz Milewski" !YouTube YouTube
        ...
        "query:YouTube:tags # \"YouTube\""

    See [section 4.7 of the manual][2] for the documentation of query feeds and [issue #33
    of Newsboat][3] for the reason the YouTube feeds are tagged as both `!YouTube`
    ([hidden tag][4]) and `YouTube`.

## TODO

*   Add a screenshot to this readme file?
*   [`mpv.sh`](mpv.sh) could probably be made more robust if I would switch to [tmux][].

[1]: https://zedshaw.com/archive/i-want-the-mutt-of-feed-readers/
[git-crypt]: https://github.com/AGWA/git-crypt
[mpv]: https://github.com/mpv-player/mpv
[2]: file:///usr/share/doc/newsboat/newsboat.html#_query_feeds
[3]: https://github.com/newsboat/newsboat/issues/33
[4]: file:///usr/share/doc/newsboat/newsboat.html#_tagging
[Newsboat]: https://github.com/newsboat/newsboat
[tmux]: https://github.com/tmux/tmux

<!-- vim: set tw=90 sts=-1 sw=4 et spell: -->
