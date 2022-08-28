#!/usr/bin/env bash
#
# NOTE:
# This script should be triggered by another wrapper script.
# To run it locally, use the next commands:
# sudo chmod +x package_browsers.sh
# ./package_browsers.sh | tee package_browsers.log
#
# trap 'echo "# $BASH_COMMAND";read' DEBUG    # enable debug mode upon demand

echo -e "\n****************************** PACKAGE_BROWSERS ******************************\n"

# Record time
time1=$(date +%s)  # start time

# Install Chromium
if [[ -x /Applications/Chromium.app ]]
then
    echo "Chromium is already installed:"
    echo "/Applications/Chromium.app"
    echo "$ROW_TILDA"
else
    echo "Start installing Chromium:"
    brew install --cask chromium
    echo "$ROW_TILDA"
fi

# Install Google Chrome
if [[ -x /Applications/Google\ Chrome.app ]]
then
    echo "Google Chrome is already installed:"
    echo "/Applications/Google Chrome.app"
    echo "$ROW_TILDA"
else
    echo "Start installing Google Chrome:"
    brew install --cask google-chrome
    echo "$ROW_TILDA"
fi

# Install Google Chrome Canary
if [[ -x /Applications/Google\ Chrome\ Canary.app ]]
then
    echo "Google Chrome Canary is already installed:"
    echo "/Applications/Google Chrome Canary.app"
    echo "$ROW_TILDA"
else
    echo "Start installing Google Chrome Canary:"
    brew tap homebrew/cask-versions && brew install --cask google-chrome-canary
    echo "$ROW_TILDA"
fi

# Install Microsoft Edge
if [[ -x /Applications/Microsoft\ Edge.app ]]
then
    echo "Microsoft Edge is already installed:"
    echo "/Applications/Microsoft Edge.app"
    echo "$ROW_TILDA"
else
    echo "Start installing Microsoft Edge:"
    brew install --cask microsoft-edge
    echo "$ROW_TILDA"
fi

# Install Firefox
if [[ -x /Applications/Firefox.app ]]
then
    echo "Firefox is already installed:"
    echo "/Applications/Firefox.app"
    echo "$ROW_TILDA"
else
    echo "Start installing Firefox:"
    brew install --cask firefox
    echo "$ROW_TILDA"
fi

# Install Opera
if [[ -x /Applications/Opera.app ]]
then
    echo "Opera is already installed:"
    echo "/Applications/Opera.app"
    echo "$ROW_TILDA"
else
    echo "Start installing Opera:"
    brew install --cask opera
    echo "$ROW_TILDA"
fi

# Record time
time2=$(date +%s)  # end time

# Calculate the execution time of the package installation process
secs=$(($time2 - $time1))
printf 'Package installation time: %02dh:%02dm:%02ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60))
echo
