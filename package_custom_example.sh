#!/usr/bin/env bash
#
# NOTE:
# This script should be triggered by another wrapper script.
# To run it locally, use the next commands:
# sudo chmod +x package_custom_example.sh
# ./package_custom_example.sh | tee package_custom_example.log
#
# trap 'echo "# $BASH_COMMAND";read' DEBUG    # enable debug mode upon demand

echo -e "\n****************************** PACKAGE_CUSTOM_EXAMPLE ******************************\n"

# Record time
time1=$(date +%s)  # start time

# Install Adobe Acrobat Reader
# Note: Installer asks for sudo password...
if [[ -x /Applications/Adobe\ Acrobat\ Reader\ DC.app ]]
then
    echo "Adobe Acrobat Reader is already installed:"
    echo "/Applications/Adobe Acrobat Reader DC.app"
    echo "$ROW_TILDA"
else
    echo "Start installing Adobe Acrobat Reader:"
    brew install --cask adobe-acrobat-reader
    echo "$ROW_TILDA"
fi

# Install Macs Fan Control
if [[ -x /Applications/Macs\ Fan\ Control.app ]]
then
    echo "Macs Fan Control is already installed:"
    echo "/Applications/Macs Fan Control.app"
    echo "$ROW_TILDA"
else
    echo "Start installing Macs Fan Control:"
    brew install --cask macs-fan-control
    echo "$ROW_TILDA"
fi

# Install The Unarchiver
if [[ -x /Applications/The\ Unarchiver.app ]]
then
    echo "The Unarchiver is already installed:"
    echo "/Applications/The Unarchiver.app"
    echo "$ROW_TILDA"
else
    echo "Start installing The Unarchiver:"
    brew install --cask the-unarchiver
    echo "$ROW_TILDA"
fi

# Install VLC
if [[ -x /Applications/VLC.app ]]
then
    echo "VLC is already installed:"
    echo "/Applications/VLC.app"
    echo "$ROW_TILDA"
else
    echo "Start installing VLC:"
    brew install --cask vlc
    echo "$ROW_TILDA"
fi

# Record time
time2=$(date +%s)  # end time

# Calculate the execution time of the package installation process
secs=$(($time2 - $time1))
printf 'Package installation time: %02dh:%02dm:%02ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60))
echo
