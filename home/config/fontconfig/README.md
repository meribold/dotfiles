# [Fontconfig][] 🤷

<!-- TODO
*   Add a footnote saying that this started as a comment explaining my `fonts.conf`...
-->

Fontconfig is a
library that many graphical programs use to figure out what font to use.  A program can
ask Fontconfig for a font matching a pattern and Fontconfig *will* return a font which may
or may not be "[anything like the requested pattern][`fonts-conf(5)`]".  The important
thing is that we can mess with this matching process using configuration files—for example
to set default fonts in a way that will work across many programs.

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

## My configuration

First, I want [Ubuntu][] to be the default sans-serif typeface for the Latin alphabet.
That is, I want `fc-match sans-serif` to print it.

<!-- Is character the correct term here?  What about symbol, glyph, grapheme, sign,
ideograph, ...-->
Second, Google's [Noto][] font family should be used as the fallback for every character
missing in Ubuntu.  This is complicated by [Han unification][].

### Major tangent: Han unification

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
hindsight, but the consequence that's relevant here is this:
choosing a fallback font also determines which variant of [some Han
characters][] will be used in contexts that lack language metadata.  Simply asking for
"[Noto Sans][]" apparently means that the Japanese [kanji][] forms will be used.  I
want [traditional Chinese
characters][] instead; Noto includes [Noto Sans CJK TC][] for this
purpose.

My best bet is probably to specify "Noto San CJK TC" as the first and "Noto Sans" as an
additional fallback font.

## Footnotes

<ol>
<li id="footnote-1"><b>TODO</b></li>
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
[kanji]: https://en.wikipedia.org/wiki/Kanji
    "Kanji - Wikipedia"
[traditional Chinese characters]: https://en.wikipedia.org/wiki/Traditional_Chinese_characters
    "Traditional Chinese characters - Wikipedia"
[Noto Sans CJK TC]: https://www.google.com/get/noto/#sans-hant "Google Noto Fonts"
[Noto Sans]: https://www.google.com/get/noto/#sans-lgc "Google Noto Fonts"
