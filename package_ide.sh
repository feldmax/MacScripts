#!/usr/bin/env bash
#
# NOTE:
# This script should be triggered by another wrapper script.
# To run it locally, use the next commands:
# sudo chmod +x package_ide.sh
# ./package_ide.sh | tee package_ide.log
#
# trap 'echo "# $BASH_COMMAND";read' DEBUG    # enable debug mode upon demand

echo -e "\n****************************** PACKAGE_JAVA ******************************\n"

# Record time
time1=$(date +%s)  # start time

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

# Install Visual Studio Code
if [[ -x /Applications/Visual\ Studio\ Code.app ]]
then
    echo "Visual Studio Code is already installed:"
    echo "/Applications/Visual Studio Code.app"
    echo "$ROW_TILDA"
else
    echo "Start installing VSCode:"
    brew install --cask visual-studio-code
    echo "$ROW_TILDA"
fi

# Install Eclipse
if [[ -x /Applications/Eclipse\ JEE.app ]]
then
    echo "Eclipse is already installed:"
    echo "/Applications/Eclipse JEE.app"
    echo "$ROW_TILDA"
else
    echo "Start installing Eclipse:"
    brew install --cask eclipse-jee
    echo "$ROW_TILDA"
fi

# Install Atom
if [[ -x /Applications/Atom.app ]]
then
    echo "Atom is already installed:"
    echo "/Applications/Atom.app"
    echo "$ROW_TILDA"
else
    echo "Start installing Atom:"
    brew install --cask atom
    echo "$ROW_TILDA"
fi

# Install Brackets
if [[ -x /Applications/Brackets.app ]]
then
    echo "Brackets is already installed:"
    echo "/Applications/Brackets.app"
    echo "$ROW_TILDA"
else
    echo "Start installing Brackets:"
    brew install --cask brackets
    echo "$ROW_TILDA"
fi

# Record time
time2=$(date +%s)  # end time

# Calculate install process execution time
secs=$(($time2 - $time1))
printf 'Package installation time: %02dh:%02dm:%02ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60))
echo

