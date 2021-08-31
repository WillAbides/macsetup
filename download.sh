#!/bin/sh

# download.sh will install homebrew if needed then clone https://github.com/WillAbides/macsetup.git
# to $HOME/repos/WillAbides/macsetup

set -e

TARGET="${TARGET:-"$HOME/repos/WillAbides/macsetup"}"

git_url="https://github.com/WillAbides/macsetup.git"
git_push_url="git@github.com:WillAbides/macsetup.git"

if ! type brew; then
  UNATTENDED=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ -e "$TARGET" ]; then
  1>&2 echo "$TARGET already exists"
  exit 1
fi

git clone "$git_url" "$TARGET"
cd "$TARGET"
git remote set-url --push origin "$git_push_url"
