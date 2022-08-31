#!/usr/bin/env bash
#
# NOTE:
# This script should be triggered by another wrapper script.
# To run it locally, use the next commands:
# sudo chmod +x package_custom.sh
# ./package_custom.sh | tee package_custom.log
#
# trap 'echo "# $BASH_COMMAND";read' DEBUG    # enable debug mode upon demand

echo -e "\n****************************** PACKAGE_CUSTOM ******************************\n"

# Record time
time1=$(date +%s)  # start time

echo -e "
👉 This is a template file for creating a custom package.
You can create a fully customized package with all the software and configurations
you need. The installer will process this package directly from your computer, so
you don't need to upload it to GitHub or anywhere else. You can also use this
package to overwrite any program installed with shared packages or change the
default configuration if you need to.
Follow the instructions here: https://github.com/feldmax/MacScripts#how-to-create-and-run-custom-package
and simply change the commented code examples below. 👈

"

# Find homebrew formulas in: https://formulae.brew.sh/
# Find Python packages in: https://pypi.org/
# In the examples below, change XXXXX to the actual app name.
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
## Install Python application example
#if ! [[ $(pip3 list) =~ "XXXXX" ]]
#then
#    echo "Start installing XXXXX:"
#    pip3 install XXXXX
#    XXXXX --version
#    echo "$ROW_TILDA"
#else
#    echo "XXXXX is already installed:"
#    XXXXX --version
#    echo "$ROW_TILDA"
#fi
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
## Set alias example
#grep -q  'll=' ~/.profile  || echo alias ll='ls -laG' >> ~/.profile
#grep -q  'll=' ~/.zprofile || echo alias ll='ls -laG' >>  ~/.zprofile
#

# Record time
time2=$(date +%s)  # end time

# Calculate the execution time of the package installation process
secs=$(($time2 - $time1))
printf 'Package installation time: %02dh:%02dm:%02ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60))
echo
