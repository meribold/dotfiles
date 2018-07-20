# [Fontconfig][] 🤷

<!-- TODO
*   Add a footnote saying that this started as a comment explaining my `fonts.conf`...
-->

<!-- ## Concerning Fontconfig -->

Fontconfig<!-- (or is it fontconfig?<sup>[\[1\]](#user-content-footnote-1)</sup>) --> is a
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
