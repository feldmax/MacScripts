#!/usr/bin/env bash
#
# NOTE:
# This script should be triggered by another wrapper script.
# To run it locally, use the next commands:
# sudo chmod +x package_js.sh
# ./package_js.sh | tee package_js.log
#
# trap 'echo "# $BASH_COMMAND";read' DEBUG    # enable debug mode upon demand

echo -e "\n****************************** PACKAGE_JS ******************************\n"

# Record time
time1=$(date +%s)  # start time

# Install NodeJS
if ! command -v node &> /dev/null
then
    echo "Start installing NodeJS:"
    brew install node
#    echo 'export PATH="/opt/homebrew/opt/node/bin:$PATH"' >> ~/.profile
#    echo 'export LDFLAGS="-L/opt/homebrew/opt/node/lib"' >> ~/.profile
#    echo 'export CPPFLAGS="-I/opt/homebrew/opt/node/include"' >> ~/.profile
#    echo 'export PATH="/opt/homebrew/opt/node/bin:$PATH"' >> ~/.zprofile
#    echo 'export LDFLAGS="-L/opt/homebrew/opt/node/lib"' >> ~/.zprofile
#    echo 'export CPPFLAGS="-I/opt/homebrew/opt/node/include"' >> ~/.zprofile
#    source ~/.profile
    node --version
    which node
    echo "$ROW_TILDA"
else
    echo "NodeJS is already installed:"
    node --version
    which node
    echo "$ROW_TILDA"
fi

# Install IntelliJ IDEA CE
if [[ -x /Applications/IntelliJ\ IDEA\ CE.app ]]
then
    echo "IntelliJ IDEA CE is already installed:"
    echo "/Applications/IntelliJ IDEA CE.app"
    echo "$ROW_TILDA"
else
    echo "Start installing IntelliJ IDEA CE:"
    brew install --cask intellij-idea-ce
    echo "$ROW_TILDA"
fi

# Record time
time2=$(date +%s)  # end time

# Calculate install process execution time
secs=$(($time2 - $time1))
printf 'Package installation time: %02dh:%02dm:%02ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60))
echo
