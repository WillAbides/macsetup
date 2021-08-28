#!/bin/sh

set -e

CDPATH="" cd -- "$(dirname -- "$0")"

# hold sudo until the script is done
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

if ! hash brew 2>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew update

caffeinate -is brew bundle install

if ! grep -q '/usr/local/bin/bash' /etc/shells; then
  hold_sudo
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
fi

if [ "$SHELL" != '/usr/local/bin/bash' ]; then
  hold_sudo
  sudo chsh -s '/usr/local/bin/bash' "$(id -un)"
fi

./config.sh
