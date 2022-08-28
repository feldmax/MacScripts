#!/usr/bin/env bash
#
# NOTE:
# This script should be triggered by another wrapper script.
# To run it locally, use the next commands:
# sudo chmod +x package_upgrade.sh
# ./package_upgrade.sh | tee package_upgrade.log
#
# trap 'echo "# $BASH_COMMAND";read' DEBUG    # enable debug mode upon demand

echo -e "\n****************************** PACKAGE_UPGRADE ******************************\n"

# Record time
time1=$(date +%s)  # start time

# Upgrade Git (instead of default v. 2.32.1 (Apple Git-133))
echo "Checking for Git updates..."
brew install git
git --version
which git
echo "$ROW_TILDA"

# Update Homebrew and upgrade all brew packages (formulas)
# Note: Installer may ask for sudo password for brew upgrade (?)
echo "Checking for Homebrew updates..."
brew update
brew upgrade
brew --version
echo "Brew packages:"
brew list --versions
echo "$ROW_TILDA"

# Upgrade PIP and all python packages
echo "Checking for Python packages updates..."
pip3 install --upgrade $(pip3 list --outdated | awk 'NR>2 { print $1 }') &>/dev/null
pip3 list
echo "$ROW_TILDA"

# Record time
time2=$(date +%s)  # end time

# Calculate install process execution time
secs=$(($time2 - $time1))
printf 'Package installation time: %02dh:%02dm:%02ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60))
echo
