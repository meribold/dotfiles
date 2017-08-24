# [X resources](https://en.wikipedia.org/wiki/X_resources)

X resources are key-value pairs used for program configuration mediated by the X Window
System.  They are manipulated by [`xrdb(1)`][xrdb(1)] (used in my [`xinitrc`][xinitrc]).
Newer programs usually don't use this configuration mechanism.

[xrdb(1)]: https://linux.die.net/man/1/xrdb
[xinitrc]: ../xinitrc

Values are assigned to keys such as `XTerm.termName` (**capitalization matters:** `XTerm`
and `xterm` will work, but not `Xterm`).  Generally, the keys consist of a bunch of
alphanumeric strings separated by dots (`.`) where the first string is a *class* or
*instance* name of an application:

>   The first element in a resource specification is either a "class" or an "instance".  A
>   class consists of ALL the invocations of a particular program.  An instance is a
>   process which is given a particular name.  
>   —["How do I use X Resources?" at kb.mit.edu][1]

[1]: https://kb.mit.edu/confluence/pages/viewpage.action?pageId=3907291

A fully specified resource may look like this:

    application.widget.widget.attribute: value

Everything to the left of the colon is the key.  The space between the colon and the
value seems to be optional.

Class names typically start with a capital letter.  For example, `XTerm` is the default
resource class for xterms.  The default instance name for xterms is `xterm`<!-- (is this
based on the name of the executable?) -->.  While  xterm allows overriding both the class
name and the instance name (with the `-class` and `-name` command-line options), I don't
think this is at all commonly done (for xterm or any program).

Whether a class name or instance name is used does not seem to matter much.  X resource
snippets on the web mostly use one or the other randomly without providing any reasoning.
Class names may be intended to be more general and (mainly for consistency) I am always
using them here.

The last string of a key is the *resource name* or *attribute*.  In between can be any
number of strings referred to as *components* or *widgets*, whose names and relations
are (probably) defined by the program to be configured.  For example, two widget names
used by xterm are `vt100` and `tek4014` (class names: `VT100` and `Tek4014`).

Lastly, the keys are actually patterns (sometimes called resource patterns) as two
wildcard characters can appear anywhere but at the end:

`*` matches any number of components, including the class or instance name, so this
is valid: `*background: black`.  
`?` matches a single component.  The dots still have to be specified.  It seems to be
less commonly used than `*`.

Other informative links:

*   [X resources ArchWiki page][2]
*   [Inessential X Resources for Techno-Dweebs][3]

[2]: https://wiki.archlinux.org/index.php/X_resources
[3]: https://stuff.mit.edu/afs/sipb/project/doc/ixresources/xres.html

<!-- vim: set tw=90 sts=-1 sw=4 et spell: -->
