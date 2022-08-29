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

# ========================= GUI APPS =========================

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

# Install Google Drive
if [[ -x /Applications/Google\ Drive.app ]]
then
    echo "Google Drive is already installed:"
    echo "/Applications/Google Drive.app"
    echo "$ROW_TILDA"
else
    echo "Start installing Google Drive:"
    brew install --cask google-drive
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

# ========================= CLI APPS =========================

# Install telnet
if ! command -v telnet &> /dev/null
then
    echo "Start installing telnet:"
    brew install telnet
    telnet --version
    echo "$ROW_TILDA"
else
    echo "telnet is already installed:"
    telnet --version
    echo "$ROW_TILDA"
fi

# Install tree
if ! command -v tree &> /dev/null
then
    echo "Start installing tree:"
    brew install tree
    tree --version
    echo "$ROW_TILDA"
else
    echo "tree is already installed:"
    tree --version
    echo "$ROW_TILDA"
fi

# Install wget
if ! command -v wget &> /dev/null
then
    echo "Start installing wget:"
    brew install wget
    wget --version
    echo "$ROW_TILDA"
else
    echo "wget is already installed:"
    wget --version
    echo "$ROW_TILDA"
fi

# ========================= PYTHON APPS =========================

# Install Openstack Client (Converged Cloud CLI basic modules)
if ! [[ $(pip3 list) =~ "openstack" ]]
then
    echo "Start installing Openstack Client:"
    pip3 install python-openstackclient
    openstack --version
    openstack module list
    echo "$ROW_TILDA"
else
    echo "Openstack is already installed:"
    openstack --version
    openstack module list
    echo "$ROW_TILDA"
fi

# Install mkdocs-material (tools to create static sites with Markdown)
if ! [[ $(pip3 list) =~ "mkdocs" ]]
then
    echo "Start installing mkdocs-material:"
    pip3 install mkdocs-material
    mkdocs --version
    echo "$ROW_TILDA"
else
    echo "mkdocs-material is already installed:"
    mkdocs --version
    echo "$ROW_TILDA"
fi

# ========================= PERSONAL SETTINGS =========================

# Set aliases and default shell
chsh -s /bin/bash	# change default shell to bash for current account

grep -q  'll=' ~/.profile  || echo alias ll='ls -laG' >> ~/.profile
grep -q  'll=' ~/.zprofile || echo alias ll='ls -laG' >>  ~/.zprofile
grep -q  'alias python=' ~/.profile  || echo alias python='/opt/homebrew/bin/python3' >> ~/.profile
grep -q  'alias python=' ~/.zprofile || echo alias python='/opt/homebrew/bin/python3' >> ~/.zprofile
grep -q  'alias pip=' ~/.profile  || echo alias pip='/opt/homebrew/bin/pip3' >> ~/.profile
grep -q  'alias pip=' ~/.zprofile || echo alias pip='/opt/homebrew/bin/pip3' >> ~/.zprofile
grep -q  'jplab=' ~/.profile  || echo alias jplab='/opt/homebrew/bin/jupyter-lab' >> ~/.profile
grep -q  'jplab=' ~/.zprofile || echo alias jplab='/opt/homebrew/bin/jupyter-lab' >>  ~/.zprofile

# Record time
time2=$(date +%s)  # end time

# Calculate the execution time of the package installation process
secs=$(($time2 - $time1))
printf 'Package installation time: %02dh:%02dm:%02ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60))
echo
