# Arch Linux package lists
This directory contains lists of packages for Arch Linux.

## Installation
To install packages from a previously saved list of packages, run:
```sh
# pacman -S --needed $(cat pacman-*.txt)
```
See the [ArchWiki](https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#Install_packages_from_a_list) for details.
If you don't want to install i3wm you can only install the *pacman-base.txt* packages list.
