This directory contains a [PKGBUILD][] for my [slightly patched version][1] of
[i3-gaps][].  The PKGBUILD is mostly the result of copy-pasting from these three
PKGBUILDs:

1.  <https://www.archlinux.org/packages/community/x86_64/i3-gaps/>
2.  <https://aur.archlinux.org/packages/i3-gaps-next-git/>
3.  <https://aur.archlinux.org/packages/i3-git/>

## Relevant Links

*   <https://wiki.archlinux.org/index.php/Arch_Build_System>
*   <https://wiki.archlinux.org/index.php/Arch_package_guidelines>
*   <https://wiki.archlinux.org/index.php/VCS_package_guidelines>
*   <https://wiki.archlinux.org/index.php/Creating_packages>
*   <https://wiki.archlinux.org/index.php/Makepkg>
*   <https://wiki.archlinux.org/index.php/PKGBUILD>
*   <https://wiki.archlinux.org/index.php/Namcap>

Also see [PKGBUILD(5)][] and maybe [makepkg(8)][] and namcap(1).

## TODO

*   I get this warning when running `makepgk`:

        ==> WARNING: Package contains reference to $srcdir

    See [this][2].
*   The makefile should kick off building and installing the package.

[PKGBUILD]: https://wiki.archlinux.org/index.php/PKGBUILD
[1]: https://github.com/meribold/i3/tree/meribold
[i3-gaps]: https://github.com/Airblader/i3
[PKGBUILD(5)]: https://archlinux.org/pacman/PKGBUILD.5.html
[makepkg(8)]: https://archlinux.org/pacman/makepkg.8.html
[2]: https://wiki.archlinux.org/index.php/Makepkg#WARNING:_Package_contains_reference_to_$srcdir
