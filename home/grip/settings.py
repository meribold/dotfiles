# [Grip](https://github.com/joeyespo/grip) configuration file.
#
# Currently this file's only purpose is to give Grip my GitHub credentials since GitHub
# imposes a rate limit of 60 requests per hour when using their API without
# authentication.  See <https://github.com/joeyespo/grip#access>.

import subprocess as sp

USERNAME = 'meribold'

# Call `pass(1)` to get my GitHub password.  Heavily simplified from [this Gist][2] linked
# [here][1].  Also see [3].
# [1]: https://github.com/joeyespo/grip#configuration
# [2]: https://gist.github.com/klmr/3840aa3c12f947e4064c
# [3]: https://docs.python.org/3/library/subprocess.html
PASSWORD = sp.run(['pass', 'show', 'github/meribold'], stdout = sp.PIPE).stdout.strip()

# vim: tw=90 sts=-1 sw=4 et
