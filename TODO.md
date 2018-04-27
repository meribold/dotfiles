## Installation

*   Extend `makefile` to set up symlinks for all files that should have them.
*   Add a phony target for each program for which configuration is included.

## [Firefox][]

*   **Custom keybinds** (why is this so damn difficult?)
    *   Keybind that sends the current tab to OneTab.
    *   Use [KeySnail](https://github.com/mooz/keysnail)?  It probably will
        [never][keysnail-issue-220] [work][keysnail-issue-222] in Firefox 57 and later.
*   Use [`userChrome.css`][], [`userContent.css`][], and [`user.js`][] more extensively.
*   Add all my custom CSS (both chrome and content) to the repository.

[Firefox]: /home/mozilla/firefox/ctontcrf.default/
[KeySnail]: https://github.com/mooz/keysnail
[keysnail-issue-220]: https://github.com/mooz/keysnail/issues/220
[keysnail-issue-222]: https://github.com/mooz/keysnail/issues/222
[`userChrome.css`]: /home/mozilla/firefox/ctontcrf.default/chrome/userChrome.css
[`userContent.css`]: /home/mozilla/firefox/ctontcrf.default/chrome/userContent.css
[`user.js`]: /home/mozilla/firefox/ctontcrf.default/user.js

### [Sigaldry][]

*   Convert [Sigaldry][] to use WebExtensions APIs.
*   Use it to keep the set of search engines synchronised between machines and profiles.

[Sigaldry]: /misc/sigaldry

## [Mutt][]

*   Desktop notifications?

[Mutt]: /home/mutt/

## Uncategorized

*   Remove the configuration files for Notion?

<!-- vim: set tw=90 sts=-1 sw=4 et spell: -->
