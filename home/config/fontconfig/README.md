# [Fontconfig][] Configuration

Fontconfig is a library that many graphical programs use to figure out what font to use.
A program can ask Fontconfig for a font matching a pattern and Fontconfig *will* return a
font which may or may not be "[anything like the requested pattern][`fonts-conf(5)`]".
The important thing is that we can mess with this matching process using configuration
files—for example to set default fonts in a way that will work across many programs.

[Fontconfig]: https://en.wikipedia.org/wiki/Fontconfig "Fontconfig - Wikipedia"
[`fonts-conf(5)`]: https://www.freedesktop.org/software/fontconfig/fontconfig-user.html
    "fonts-conf(5)"
