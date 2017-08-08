# Sigaldry

Personal add-on for Firefox customizations that aren't possible with just `about:config`,
`userChrome.css`, etc. and that I couldn't find a nice existing add-on for.
*   Changes the new tab page to [startpage/index.html](/startpage/index.html).
*   Makes Firefox keep the address bar empty for that page.

### Installation

To install the add-on, press <kbd>Ctrl</kbd>+<kbd>O</kbd> in Firefox (or select "Open" or
something from its file menu) and select the
[XPI](https://en.wikipedia.org/wiki/XPInstall) file inside this directory (drag and drop
should work too).  The `about:config` entry `xpinstall.signatures.required` has to be set
to `false`.  Otherwise, unsigned extensions can't be installed.

<!-- vim: set tw=90 sts=-1 sw=4 et spell: -->
