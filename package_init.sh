#!/usr/bin/env bash
#
# NOTE:
# This script should be triggered by another wrapper script.
# To run it locally, use the next commands:
# sudo chmod +x package_init.sh
# ./package_init.sh | tee package_init.log
#
# trap 'echo "# $BASH_COMMAND";read' DEBUG    # enable debug mode upon demand

echo -e "\n****************************** PACKAGE_INIT ******************************\n"

# Record time
time1=$(date +%s)  # start time

# Install xcode (required for git and homebrew)
# Note: Installer asks for confirmation and pop-up license agreement at the beginning
# Note: Installer asks for sudo password after download
if [[ $(xcode-select --install 2>&1) =~ "command line tools are already installed" ]]
then
#    echo "$(xcode-select -v) is already installed in $(xcode-select -p)"
    echo "XCode is already installed:"
    xcode-select -v
    xcode-select -p
    echo "$ROW_TILDA"
else
    echo "Start installing XCode:"
    echo "Please confirm XCode installation and accept license agreement in the popup window"
    xcode-select --install
    xcode-select -v
    echo "$ROW_TILDA"
fi

# Install or update Homebrew and upgrade outdated formulas
# Note: Installer asks for sudo password at the beginning
if ! command -v brew &> /dev/null
then
    echo "Start installing Homebrew:"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.profile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    brew --version
    echo "$ROW_TILDA"
else
    echo "Homebrew is already installed. Checking for an update..."
    brew --version
    echo "$ROW_TILDA"
fi

# Install Git (on MacOS Monterey the git is already installed: v. 2.32.1 (Apple Git-133))
if ! command -v git &> /dev/null
then
    echo "Start installing Git:"
    brew install git
    git --version
    which git
    echo "$ROW_TILDA"
else
    echo "Git is already installed:"
    git --version
    which git
    echo "$ROW_TILDA"
fi

# Upgrade pip and setuptools (added with XCode library > Python3 framework)
echo "Upgrade pip and setuptools:"
pip3 install --upgrade pip setuptools
pip3 --version
which pip3
echo "$ROW_TILDA"

# Record time
time2=$(date +%s)  # end time

# Calculate install process execution time
secs=$(($time2 - $time1))
printf 'Package installation time: %02dh:%02dm:%02ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60))
echo
