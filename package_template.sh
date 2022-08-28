#!/usr/bin/env bash
#
# NOTE:
# This script should be triggered by another wrapper script.
# To run it locally, use the next commands:
# sudo chmod +x package_template.sh
# ./package_template.sh | tee package_template.log
#
# trap 'echo "# $BASH_COMMAND";read' DEBUG    # enable debug mode upon demand

echo -e "\n****************************** PACKAGE_TEMPLATE ******************************\n"

# Record time
time1=$(date +%s)  # start time

# Find homebrew formulas in: https://formulae.brew.sh/
# Find Python packages in: https://pypi.org/
# In the examples below, change XXXXX to the actual app name.
#
## Install CLI application example
#if ! command -v XXXXX &> /dev/null
#then
#    echo "Start installing XXXXX:"
#    brew install XXXXX
#    XXXXX --version
#    echo "$ROW_TILDA"
#else
#    echo "XXXXX is already installed:"
#    XXXXX --version
#    echo "$ROW_TILDA"
#fi
#
## Install GUI application example
#if [[ -x /Applications/XXXXX.app ]]
#then
#    echo "XXXXX is already installed:"
#    echo "/Applications/XXXXX.app"
#    echo "$ROW_TILDA"
#else
#    echo "Start installing XXXXX:"
#    brew install --cask XXXXX
#    echo "$ROW_TILDA"
#fi
#
## Install Python application example
#echo "Start installing XXXXX:"
#pip3 install XXXXX
#echo "$ROW_TILDA"
#
## Uninstall Homebrew app example (if the app is no longer needed)
#echo "Removing XXXXX:"
#brew uninstall XXXXX
#echo "$ROW_TILDA"
#
## Uninstall Python app example (if the app is no longer needed)
#echo "Removing XXXXX:"
#pip3 uninstall XXXXX
#echo "$ROW_TILDA"
#

# Record time
time2=$(date +%s)  # end time

# Calculate the execution time of the package installation process
secs=$(($time2 - $time1))
printf 'Package installation time: %02dh:%02dm:%02ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60))
echo
