# Stuff used in UltiSnips snippets.

import re
from collections import OrderedDict

import vim

# All options that might be used in modelines should be listed here.
modeline_options = OrderedDict([("tw", "=90"), ("ts", None), ("sts", "=-1"), ("sw", "=3"),
                                ("et", True), ("spell", None)])

def modeline(overrides = {}):
    options = []
    for k, v in modeline_options.items():
        setting = overrides[k] if k in overrides else v
        if setting is None:
            continue
        elif not setting:
            options.append("no" + k)
        elif isinstance(setting, str):
            options.append("{!s}{!s}".format(k, setting))
        else:
            options.append(k)
    options = " ".join(options)
    commentstring = vim.eval("&commentstring")
    if vim.eval("&ft") and commentstring:
        if re.search("%s.*\S", commentstring): # We are using block comments: i.e., there
            # are delimiters indicating the beginning and the end of the comment (like
            # C-style comments).  Only the second modeline form allows this.
            return re.sub(" ?%s ?", " vim: set %s: " % options, commentstring).strip()
        else: # Use the first modeline form.
            return re.sub(" ?%s ?", " vim: %s " % options, commentstring).strip()
    else:
        return "vim: " + options

# Vim checks the last 5 lines of files for modelines (by default) and will confuse some of
# the code above for modelines and throw E518 when starting to edit this file.  Luckily,
# this comment puts those lines out of that range.

# vim: tw=90 sts=-1 sw=4 et
