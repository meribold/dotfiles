# Stuff used in UltiSnips snippets.

import re
from collections import OrderedDict

import vim

# All options that might be used in modelines should be listed here.
modeline_options = OrderedDict([("tw", "=90"), ("ts", None), ("sts", "=-1"), ("sw", "=3"),
                                ("et", True)])

def modeline(overrides = {}):
    options = []
    for k, v in modeline_options.items():
        setting = overrides[k] if k in overrides else  v
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
        return re.sub(" ?%s ?", " vim: %s " % options, commentstring).strip()
    else:
        return "vim: " + options

# vim: tw=90 sts=-1 sw=4 et
