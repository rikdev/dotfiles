# dotfiles

This repository contains my personal configuration files,
commonly known as *dotfiles*.

## Installation

Just fetch it to your home directory:

```sh
cd ~
git init
git remote add origin <this repo>
git fetch
git checkout origin/master
git submodule update --init --recursive
```

If you want to hide some settings you can do it with a
[sparse checkout](https://git-scm.com/docs/git-read-tree#_sparse_checkout):

```sh
git config core.sparseCheckout true
echo '/*' >> .git/info/sparse-checkout
echo '!<hidden path>' >> .git/info/sparse-checkout
git read-tree -mu HEAD
```

If you want to hide the *.git* directory from the home directory so that it
doesn't interfere with any other git-repositories around, you can do it using
the *git-dir* and *work-tree* options:

```sh
GIT_DIR="${HOME}/.dotfiles" # you can export GIT_DIR and skip git-dir options
git --git-dir="${GIT_DIR}" init
git --git-dir="${GIT_DIR}" remote add origin <this repo>
git --git-dir="${GIT_DIR}" fetch
git --git-dir="${GIT_DIR}" --work-tree="${HOME}" checkout origin/master
git --git-dir="${GIT_DIR}" --work-tree="${HOME}" submodule update --init --recursive
```

If you choose the last variant, the script `.local/bin/dotfiles` can help you to manage
the repository.

### Dependencies

To install dependencies see the *.pkglist* folder.

## Deletion

In order to delete the repository and all its files from the system,
you can switch to the root commit or the *empty-work-tree* tag then delete
the *.dotfiles* directory and copy original config files from the */etc/skel/*
directory to the home directory.
