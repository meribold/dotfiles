# [Fontconfig][] 🤷

<!-- TODO
*   Add a footnote saying that this started as a comment explaining my `fonts.conf`...
*   A better way to test the configuration is `fc-match -s`:
        $ fc-match -s serif | head -3
        NotoSerifCJK-Regular.ttc: "Noto Serif CJK TC" "Regular"
        NotoColorEmoji.ttf: "Noto Color Emoji" "Regular"
        NotoSerif-Regular.ttf: "Noto Serif" "Regular"
*   Write that [`fc-match(1)`][] appears to reflect changes to configuration files
    immediately.  That is, it seems running `fc-cache` is usually unnecessary.
-->

Fontconfig is a library that many graphical programs use to figure out what font to use.
A program can ask Fontconfig for a font matching a pattern and Fontconfig *will* return a
font which may or may not be "[anything like the requested pattern][`fonts-conf(5)`]".
The important thing is that we can mess with this matching process using configuration
files—for example to set default fonts in a way that will work across many programs.

The [`fc-match(1)`][] utility that ships with Fontconfig can be used to test what fonts
are returned for a given pattern:

    $ fc-match
    Ubuntu-R.ttf: "Ubuntu" "Regular"
    $ fc-match serif
    NotoSerifCJK-Regular.ttc: "Noto Serif CJK TC" "Regular"

Since `fc-match` uses "[the normal fontconfig matching rules][`fc-match(1)`]", the above
output implies that (with my configuration) a program that (reasonably) wants to use the
most default font possible will use [Ubuntu][], and a program that wants the default serif
font will use [Noto Serif CJK TC][].

## Configuration

I want to use members of the [Ubuntu][] family as the default sans-serif and monospace
typefaces.  That is, I want `fc-match` to print those when the argument is `sans-serif` or
`monospace`.  Google's [Noto][] font family should be used as the fallback for missing
characters <!-- Is character the correct term here?  What about symbol, glyph, grapheme,
sign, ideograph, ... --> and when a serif typeface is requested.

There are some nuances to this this that make it more tricky than it sounds.

### Major tangent: [Han unification][]

If your system is configured well and has the necessary fonts installed, you will see two
similar but non-identical [Han characters][] here:

<!-- We can't use <span>.  Use a list as a workaround.  See
<https://github.com/github/markup/issues/245#issuecomment-245460087>. -->
<ul>
<li lang="zh">練</li>
<li lang="ja">練</li>
</ul>

*Unicode does not.*  It assigns the same [code point][] (number) to both characters.  The
only reason they (hopefully) look distinct is that I added [`lang`][] attributes to the
list items.  Those two characters can only coexist when additional metadata is
provided—possible on a webpage, but try copying both characters into your browser's
[address bar][], a text editor, or a terminal: I bet they'll look the same.

Relying on additional metadata for correct rendering of text seems like a weird choice in
hindsight, but the consequence that's relevant here is this: choosing a fallback font also
determines which variant of [some Han characters][] will appear in contexts that lack
language metadata.  Plainly using [Noto Sans][], [Noto Serif][], etc. apparently means
that the Japanese [*kanji*][] forms are used.  I want [traditional Chinese characters][]
instead.  Noto includes [Noto Sans CJK TC][] etc. for this purpose.

<!--
I think my best bet for setting up Fontconfig is to specify "Noto San CJK TC" as the first
and "Noto Sans" as an additional fallback font for requests of a sans-serif typeface, and
to do something equivalent for serif and monospace.
-->

### Back to topic (sort of)

It's important to know the order in which Fontconfig loads configuration files.  There
usually are lots in `/etc/fonts/conf.d/` and they interfere with user-specific
configuration.  The only explanation I've found is in the [*Tuning Fontconfig*][] section
of [*Beyond Linux From Scratch*][]: files in `/etc/fonts/conf.d/` have names starting with
a two-digit number followed by a hyphen and smaller numbers are loaded first.

Loading files from the configuration paths specified by [`fonts-conf(5)`][] isn't
intrinsic behavior of Fontconfig.  Instead, the master `/etc/fonts/fonts.conf` file
contains `<include>` directives.  On my
system,<sup>[\[1\]](#user-content-footnote-1)</sup> it only includes files in
`/etc/fonts/conf.d/`, but in there is `50-user.conf` which includes (among other things)
[`~/.config/fontconfig/fonts.conf`][`fonts.conf`].  The takeaway is that the user-specific
configuration here is loaded sort of after one half and before one half of the system-wide
configuration files.

My configuration file started off based on the one in [this section][fonts-aw-ffo] of the
[*Fonts*][Fonts - ArchWiki] ArchWiki article.  The important parts are `<alias>` elements
such as:

```xml
<alias>
   <family>sans-serif</family>
   <prefer>
      <family>Ubuntu</family>
      <family>Noto Sans CJK TC</family>
      <family>Noto Color Emoji</family>
      <family>Noto Sans</family>
   </prefer>
</alias>
```

The element says: prepend those 4 font families to the list of best-matching fonts in that
order when "sans-serif" is requested.

<!--
Configuration files with numbers that are lower than 50 and that also prepend fonts to
`serif`, `sans-serif`, or `monospace` win.  The fonts they prepend are above the ones I
prepend in the output of `fc-match`.  The file that messes stuff up is
`/etc/fonts/conf.d/30-infinality-aliases.conf`.  I think it does stuff that should really
be done in files with numbers 60 to 69 (see [*Tuning Fontconfig*]; search for "generic
aliases, map generic to family").
-->

This would typically work.  I think.  It didn't quite do it for me, though.  Something
else was also prepending "Noto Sans" with the effect that it ended up at the very top of
the font list.  I identified [`30-infinality-aliases.conf`][], which I got from the
[`fonts-meta-extended-lt`][] package, as the culprit.  It does this:

```xml
<alias>
   <family>sans-serif</family>
   <prefer><family>Noto Sans</family></prefer>
</alias>
```

But wait!  How can <code><b>30</b>-infinality-aliases.conf</code> override an alias that
is ultimately included from <code><b>50</b>-user.conf</code>?  Well, there are two ways in
which one may prepend fonts with Fontconfig and `<prefer>`ing is syntactic sugar for
inserting before the matching `<family>` but not actually at the top.
`30-infinality-aliases.conf` does this before my own configuration and consequently it
wins.<sup>[\[2\]](#user-content-footnote-2)</sup>

We can get around this by using `<prepend_first>`, but have to do without the `<alias>`
shorthand:

```xml
<match target="pattern">
   <test name="family">
      <string>sans-serif</string>
   </test>
   <edit name="family" mode="prepend_first">
      <string>Ubuntu</string>
      <string>Noto Sans CJK TC</string>
      <string>Noto Color Emoji</string>
      <string>Noto Sans</string>
   </edit>
</match>
```

My [`fonts.conf`][] consists of such `<match>` elements for "serif", "sans-serif", and
"monospace".<sup>[\[3\]](#user-content-footnote-3)</sup> We can test the results with the
`-s` flag of `fc-match`:

```bash
$ fc-match -s serif | head -3
NotoSerifCJK-Regular.ttc: "Noto Serif CJK TC" "Regular"
NotoColorEmoji.ttf: "Noto Color Emoji" "Regular"
NotoSerif-Regular.ttf: "Noto Serif" "Regular"
```

```bash
$ fc-match -s sans-serif | head -4
Ubuntu-R.ttf: "Ubuntu" "Regular"
NotoSansCJK-Regular.ttc: "Noto Sans CJK TC" "Regular"
NotoColorEmoji.ttf: "Noto Color Emoji" "Regular"
NotoSans-Regular.ttf: "Noto Sans" "Regular"
```

```bash
$ fc-match -s monospace | head -3
UbuntuMono-R.ttf: "Ubuntu Mono" "Regular"
NotoSansCJK-Regular.ttc: "Noto Sans Mono CJK TC" "Regular"
NotoSansMono-Regular.ttf: "Noto Sans Mono" "Regular"
```

🙂

## Sources

Here are most of the articles and other resources that I referenced, as well some more
that are relevant and interesting:

*   [*I stared into the fontconfig, and the fontconfig stared back at me*][] by Eevee
*   [*The Secret Life of Unicode*][] by Suzanne Topping
*   Joel Spolsky's [blog post about Unicode with a very long title][The 15 Excuses]
*   [*Unicode Revisited*][] by Steven J. Searle
*   [*Around the* 🌎 *with Unicode*][nora-sandler-unicode] by Nora Sandler
*   Jonathan New's [article][poo] about the JavaScript `length` of emoji
*   [`fonts-conf(5)`][] (this seems to be the primary documentation of Fontconfig)
*   [`fc-match(1)`][]
*   The *[Han unification][]*, *[Variant Chinese character][]*, *[Noto fonts][]*,
    *[Fontconfig][]*, and *[Unicode][]* Wikipedia articles
*   The [*Fonts*][Fonts - ArchWiki], [*Font configuration*][Font configuration -
    ArchWiki], and [*Font configuration/Examples*][Font configuration/Examples - ArchWiki]
    ArchWiki articles
*   The [*Tuning Fontconfig*][] section from [*Beyond Linux From Scratch*][]
*   The [*Unicode HOWTO*][] at `docs.python.org`
*   Lastly, you can probably find many examples of Fontconfig configuration files in
    `/etc/fonts/conf.d/`

## Footnotes

<ol>
<li id="footnote-1"><a href="https://redd.it/32o299">Did I tell you I use Arch Linux?</a></li>
<li id="footnote-2">
I think <code>30-infinality-aliases.conf</code> disregards the <a
href="http://linuxfromscratch.org/blfs/view/stable/x/tuning-fontconfig.html">conventional
naming scheme</a> in doing so: "generic aliases" should appear in files with numbers 60 to
69 (see the <i>various files</i> section).
</li>
<li id="footnote-3">
The semantics of Fontconfig's XML schema are documented in <a
href="https://www.freedesktop.org/software/fontconfig/fontconfig-user.html"
title="fonts-conf(5)"><code>fonts-conf(5)</code></a>.
</li>
</ol>

[Fontconfig]: https://en.wikipedia.org/wiki/Fontconfig "Fontconfig - Wikipedia"
[`fonts-conf(5)`]: https://www.freedesktop.org/software/fontconfig/fontconfig-user.html
    "fonts-conf(5)"
[`fc-match(1)`]: https://linux.die.net/man/1/fc-match "fc-match(1)"
[Ubuntu]: https://en.wikipedia.org/wiki/Ubuntu_(typeface) "Ubuntu (typeface) - Wikipedia"
[Noto Serif CJK TC]: https://www.google.com/get/noto/#serif-hant "Google Noto Fonts"
[Noto]: https://en.wikipedia.org/wiki/Noto_fonts "Noto fonts - Wikipedia"
[Han unification]: https://en.wikipedia.org/wiki/Han_unification
    "Han unification - Wikipedia"
[Han characters]: https://en.wikipedia.org/wiki/Han_characters
    "Han characters - Wikipedia"
[code point]: https://en.wikipedia.org/wiki/Code_point "Code point - Wikipedia"
[`lang`]: https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/lang
    "lang - HTML | MDN"
[address bar]: https://en.wikipedia.org/wiki/Address_bar "Address bar - Wikipedia"
[some Han characters]: https://en.wikipedia.org/wiki/Variant_Chinese_character#Usage_in_computing
    "Variant Chinese character - Wikipedia"
[*kanji*]: https://en.wikipedia.org/wiki/Kanji
    "Kanji - Wikipedia"
[traditional Chinese characters]: https://en.wikipedia.org/wiki/Traditional_Chinese_characters
    "Traditional Chinese characters - Wikipedia"
[Noto Sans CJK TC]: https://www.google.com/get/noto/#sans-hant "Google Noto Fonts"
[Noto Sans]: https://www.google.com/get/noto/#sans-lgc "Google Noto Fonts"
[Noto Serif]: https://www.google.com/get/noto/#serif-lgc "Google Noto Fonts"
[*Tuning Fontconfig*]: http://linuxfromscratch.org/blfs/view/stable/x/tuning-fontconfig.html
    "Tuning Fontconfig"
[*Beyond Linux From Scratch*]: http://linuxfromscratch.org/blfs/view/stable/index.html
[`fonts.conf`]: fonts.conf
[fonts-aw-ffo]: https://wiki.archlinux.org/index.php/Fonts#Fallback_font_order_with_X11
    "\"Fallback font order with X11\" (Fonts - ArchWiki)"
[Fonts - ArchWiki]: https://wiki.archlinux.org/index.php/Fonts "Fonts - ArchWiki"
[`30-infinality-aliases.conf`]: https://gist.githubusercontent.com/cryzed/4f64bb79e80d619866ee0b18ba2d32fc/raw/bd073b52365393f9f0718425271825fc27b218f7/local.conf
[`fonts-meta-extended-lt`]: https://aur.archlinux.org/packages/fonts-meta-extended-lt
    "AUR (en) - fonts-meta-extended-lt"
[*I stared into the fontconfig, and the fontconfig stared back at me*]: https://eev.ee/blog/2015/05/20/i-stared-into-the-fontconfig-and-the-fontconfig-stared-back-at-me/
[*The Secret Life of Unicode*]: http://www.btetrud.com/Lima/The%20Secret%20Life%20of%20Unicode.pdf
[The 15 Excuses]: https://www.joelonsoftware.com/2003/10/08/the-absolute-minimum-every-software-developer-absolutely-positively-must-know-about-unicode-and-character-sets-no-excuses/
    "The Absolute Minimum Every Software Developer Absolutely, Positively Must Know About Unicode and Character Sets (No Excuses!)"
[*Unicode Revisited*]: http://tronweb.super-nova.co.jp/unicoderevisited.html
[nora-sandler-unicode]: https://norasandler.com/2017/11/02/Around-the-with-Unicode.html
    "Around the 🌎 with Unicode"
[poo]: https://blog.jonnew.com/posts/poo-dot-length-equals-two
    "Jonathan New | \"💩\".length === 2"
[Variant Chinese character]: https://en.wikipedia.org/wiki/Variant_Chinese_character
    "Variant Chinese character - Wikipedia"
[Noto fonts]: https://en.wikipedia.org/wiki/Noto_fonts
    "Noto fonts - Wikipedia"
[Unicode]: https://en.wikipedia.org/wiki/Unicode "Unicode - Wikipedia"
[Font configuration - ArchWiki]: https://wiki.archlinux.org/index.php/Font_configuration
    "Font configuration - ArchWiki"
[Font configuration/Examples - ArchWiki]: https://wiki.archlinux.org/index.php/Font_configuration/Examples
    "Font configuration/Examples - ArchWiki"
[*Unicode HOWTO*]: https://docs.python.org/3/howto/unicode.html
    "Unicode HOWTO — Python 3 documentation"
