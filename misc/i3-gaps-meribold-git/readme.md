This directory contains a [PKGBUILD][] for my [slightly patched version][1] of
[i3-gaps][].  The PKGBUILD is mostly the result of copy-pasting from these three
PKGBUILDs:

1.  <https://www.archlinux.org/packages/community/x86_64/i3-gaps/>
2.  <https://aur.archlinux.org/packages/i3-gaps-next-git/>
3.  <https://aur.archlinux.org/packages/i3-git/>

## Relevant Links

*   <https://wiki.archlinux.org/title/Arch_Build_System>
*   <https://wiki.archlinux.org/title/Arch_package_guidelines>
*   <https://wiki.archlinux.org/title/VCS_package_guidelines>
*   <https://wiki.archlinux.org/title/Creating_packages>
*   <https://wiki.archlinux.org/title/Makepkg>
*   <https://wiki.archlinux.org/title/PKGBUILD>
*   <https://wiki.archlinux.org/title/Namcap>

Also see [PKGBUILD(5)][] and maybe [makepkg(8)][] and namcap(1).

## TODO

*   The makefile should kick off building and installing the package.

[PKGBUILD]: https://wiki.archlinux.org/title/PKGBUILD
[1]: https://github.com/meribold/i3/tree/meribold
[i3-gaps]: https://github.com/Airblader/i3
[PKGBUILD(5)]: https://archlinux.org/pacman/PKGBUILD.5.html
[makepkg(8)]: https://archlinux.org/pacman/makepkg.8.html
