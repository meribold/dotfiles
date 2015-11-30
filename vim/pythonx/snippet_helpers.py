# Stuff used in UltiSnips snippets.

import re
from collections import OrderedDict

import vim

modeline_options = OrderedDict([("tw", "=90"), ("sts", "=-1"), ("sw", "=3"), ("et", "")])

def modeline():
   options = " ".join("{!s}{!s}".format(k, v) for (k, v) in modeline_options.items())
   commentstring = vim.eval("&commentstring")
   if vim.eval("&ft") and commentstring:
      return re.sub(" ?%s ?", " vim: %s " % options, commentstring).strip()
   else:
      return "vim: " + options

# vim: tw=90 sts=-1 sw=4 et
