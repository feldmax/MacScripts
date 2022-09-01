#!/usr/bin/env bash
#
# NOTE:
# This script should be triggered by another wrapper script.
# To run it locally, use the next commands:
# sudo chmod +x package_messengers.sh
# ./package_messengers.sh | tee package_messengers.log
#
# trap 'echo "# $BASH_COMMAND";read' DEBUG    # enable debug mode upon demand

echo -e "\n****************************** PACKAGE_MESSENGERS ******************************\n"

# Record time
time1=$(date +%s)  # start time

# Install WhatsApp
if [[ -x /Applications/WhatsApp.app ]]
then
    echo "WhatsApp is already installed:"
    echo "/Applications/WhatsApp.app"
    echo "$ROW_TILDA"
else
    echo "Start installing WhatsApp:"
    brew install --cask whatsapp
    echo "$ROW_TILDA"
fi

# Install Telegram
if [[ -x /Applications/Telegram.app ]]
then
    echo "Telegram is already installed:"
    echo "/Applications/Telegram.app"
    echo "$ROW_TILDA"
else
    echo "Start installing Telegram:"
    brew install --cask telegram
    echo "$ROW_TILDA"
fi

# Install Viber
if [[ -x /Applications/Viber.app ]]
then
    echo "Telegram is already installed:"
    echo "/Applications/Viber.app"
    echo "$ROW_TILDA"
else
    echo "Start installing Viber:"
    brew install --cask viber
    echo "$ROW_TILDA"
fi

# Install Zoom
# Note: Installer asks for sudo password...
if [[ -x /Applications/zoom.us.app ]]
then
    echo "Zoom is already installed:"
    echo "/Applications/zoom.us.app"
    echo "$ROW_TILDA"
else
    echo "Start installing Zoom:"
    brew install --cask zoom
    echo "$ROW_TILDA"
fi

# Record time
time2=$(date +%s)  # end time

# Calculate the execution time of the package installation process
secs=$(($time2 - $time1))
printf 'Package installation time: %02dh:%02dm:%02ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60))
echo

