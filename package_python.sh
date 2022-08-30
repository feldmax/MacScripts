#!/usr/bin/env bash
#
# NOTE:
# This script should be triggered by another wrapper script.
# To run it locally, use the next commands:
# sudo chmod +x package_python.sh
# ./package_python.sh | tee package_python.log
#
# trap 'echo "# $BASH_COMMAND";read' DEBUG    # enable debug mode upon demand

echo -e "\n****************************** PACKAGE_PYTHON ******************************\n"

# Record time
time1=$(date +%s)  # start time

# Install Python and adding Python aliases if they don't exist
echo -e "Try to install or upgrade Python:\n"
brew install python
#grep -q  'alias python=' ~/.profile  || echo alias python='/opt/homebrew/bin/python3' >> ~/.profile
#grep -q  'alias python=' ~/.zprofile || echo alias python='/opt/homebrew/bin/python3' >> ~/.zprofile
#grep -q  'alias pip=' ~/.profile  || echo alias pip='/opt/homebrew/bin/pip3' >> ~/.profile
#grep -q  'alias pip=' ~/.zprofile || echo alias pip='/opt/homebrew/bin/pip3' >> ~/.zprofile
source ~/.profile
python3 --version
which python3
echo "$ROW_TILDA"

# Install Jupyter-Lab
if ! command -v jupyter-lab &> /dev/null
then
    echo "Start installing Jupyter-Lab:"
    brew install jupyterlab
#    grep -q  'jplab=' ~/.profile  || echo alias jplab='/opt/homebrew/bin/jupyter-lab' >> ~/.profile
#    grep -q  'jplab=' ~/.zprofile || echo alias jplab='/opt/homebrew/bin/jupyter-lab' >>  ~/.zprofile
    source ~/.profile
    jupyter --version
    echo "$ROW_TILDA"
else
    echo "Jupyter is already installed:"
    jupyter --version
    echo "$ROW_TILDA"
fi

# Install JetBrains PyCharm CE
if [[ -x /Applications/PyCharm\ CE.app ]]
then
    echo "PyCharm CE is already installed:"
    echo "/Applications/PyCharm CE.app"
    echo "$ROW_TILDA"
else
    echo "Start installing PyCharm CE:"
    brew install --cask pycharm-ce
    echo "$ROW_TILDA"
fi

# Upgrade pip and setuptools
echo "Checking for updates for Python pip and setuptools..."
pip3 install --upgrade pip setuptools
pip3 list
echo "$ROW_TILDA"

# Record time
time2=$(date +%s)  # end time

# Calculate install process execution time
secs=$(($time2 - $time1))
printf 'Package installation time: %02dh:%02dm:%02ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60))
echo
