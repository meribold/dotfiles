# [Newsboat](https://newsboat.org) Configuration

Newsboat is a [fork][1] of [Newsbeuter][], the "[Mutt of feed readers][2]", and is
"[actively maintained while Newsbeuter isn't][Newsboat]."  Effectively, Newsboat is the
continuation of Newsbeuter and [not a separate project][3].

I set Newsboat up to mostly use the same colors I configured for Mutt as well as similar
keybindings.  Newsboat doesn't really have the flexibility to faithfully reproduce *all*
my Mutt key bindings, but it does get close enough: I only get irritated once in a while
because of muscle memory.

My [`urls`](urls) file is encrypted with [git-crypt][].

## Highlights

*   <kbd>o</kbd> opens the URL associated with the current article using `$BROWSER`.  I
    have `$BROWSER` set to `firefox-esr`, so articles are opened in Firefox instead of a
    text-based browser.
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

    See [section 4.7 of the manual][4] for the documentation of query feeds and [issue #33
    of Newsboat][5] for the reason the YouTube feeds are tagged as both `!YouTube`
    ([hidden tag][6]) and `YouTube`.

## TODO

*   Add a screenshot to this readme file?
*   [`mpv.sh`](mpv.sh) could probably be made more robust if I would switch to [tmux][].

[1]: https://groups.google.com/forum/#!topic/newsbeuter/RPtlWX8CPGU
[Newsbeuter]: https://github.com/akrennmair/newsbeuter
[2]: https://zedshaw.com/archive/i-want-the-mutt-of-feed-readers/
     "I Want The Mutt Of Feed Readers – Zed A. Shaw"
[git-crypt]: https://github.com/AGWA/git-crypt
[mpv]: https://github.com/mpv-player/mpv
[3]: https://github.com/newsboat/newsboat/blob/master/CHANGELOG.md#210---2017-09-20
     "newsboat/CHANGELOG.md"
[4]: file:///usr/share/doc/newsboat/newsboat.html#_query_feeds
[5]: https://github.com/newsboat/newsboat/issues/33
[6]: file:///usr/share/doc/newsboat/newsboat.html#_tagging
[Newsboat]: https://github.com/newsboat/newsboat
[tmux]: https://github.com/tmux/tmux
