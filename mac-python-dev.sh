#!/usr/bin/env bash
#
# NOTE:
# To run this script locally on your MacBook please make this file executable:
# sudo chmod +x mac-python-dev.sh
# Run script:
# ./mac-python-dev.sh | tee mac-python-dev.log

# trap 'echo "# $BASH_COMMAND";read' DEBUG    # enable debug mode upon demand

# Separation rows | garnish variables
row_tilda=$(printf '~%.0s' {1..80}; printf '\n')
row_hash=$(printf '#%.0s' {1..80}; printf '\n';)

# System info
echo "$row_hash"
sw_vers
echo "$row_tilda"

# Info for user:
echo -e "
⚠️  This script will install typical Python development environment on your computer:
- Apple XCode
- Homebrew Package Manager for macOS
- Git
- Python 3.8
- Python 3.9
- Python 3.10
- Jupyter Lab
- PyCharm CE
Expected execution time around 20 minutes if Apple XCode is already installed.
During the installation process, you will be asked to enter your iUser account
and will be prompted several times to enter your password and accept licenses,
if necessary.\n
🔓  To install programs, you need administrator rights on your Mac. These permissions
are disabled by default. Before starting the process, click on the Privileges icon
in the MacOS Dock to request administrator privileges, and make sure it turns yellow
(open padlock).
"

# Verify iUser
sleep .5
read -r -p "Please type your iUser: " user
[ -z "$user" ] && user="$(whoami)"

shopt -s nocasematch; if [[ "$(whoami)" =~ $user ]]
then
    echo -e "Logged in user: $(whoami) and recorded user: $user. Match - OK \n"
else
    echo "Logged in user: $(whoami) and recorded user: $user. Do NOT match!"
    echo -e "
⛔ You must be logged in as iUser (cUser or dUser)!
Installing and configuring a developer environment with a non-SAP account can
lead to compatibility and network connectivity issues. If your profile name
('whoami' command in terminal) returns your personal name instead of your iUser
- please contact your local IT to set up your laptop account.
After that, run this script again.
    "
    echo "$row_hash"
    exit 1
fi

# Verify padlock
sleep .5
read -p "Is the Privilege icon yellow 🔓 (open padlock) at the moment? <Y | N> " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo -e "\n👉  Please request administrator privileges (click on the green padlock to open it)
    and then re-run this script again.  👈 \n"
    echo "$row_hash"
    exit 1
fi
echo "$row_tilda"

# Install process start time
start_time=$(date +%s)

# Install xcode (required for git and homebrew)
# Note: Installer asks for confirmation and pop-up license agreement at the beginning
if [[ $(xcode-select --install 2>&1) =~ "command line tools are already installed" ]]
then
    echo "XCode is already installed:"
    xcode-select -v
    xcode-select -p
    echo "$row_tilda"
else
    echo "Start installing XCode:"
    echo "Please confirm XCode installation and accept license agreement in the popup window"
    xcode-select --install
    echo "$row_tilda"
    xcode-select -v
    echo "$row_tilda"
fi

# Install Homebrew
# Note: Installer asks for sudo password at the beginning
if ! command -v brew &> /dev/null
then
    echo "Start installing Homebrew:"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.profile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo "$row_tilda"
    brew --version
    echo "$row_tilda"
else
    echo "Homebrew is already installed:"
    brew --version
    echo "$row_tilda"
fi

# ------------- Installing CLI tools and applications without a user interface -------------

# Install Git (on MacOS Monterey the git is already installed)
if ! command -v git &> /dev/null
then
    echo "Start installing Git:"
    brew install git
    echo "$row_tilda"
    git --version
    which git
    echo "$row_tilda"
else
    echo "Git is already installed:"
    git --version
    which git
    echo "$row_tilda"
fi

# Install Python and adding Python aliases if they don't exist
echo -e "Start installing OR updating Python versions 3.8, 3.9, 3.10:\n"
brew install python@3.8
brew install python@3.9
brew install python@3.10
echo "$row_tilda"

echo -e "Adding Python aliases if they don't exist...\n"
grep -q 'alias python3.8' ~/.profile  || echo alias python3.8='/opt/homebrew/opt/python@3.8/bin/python3.8' >> ~/.profile
grep -q 'alias python3.8' ~/.zprofile || echo alias python3.8='/opt/homebrew/opt/python@3.8/bin/python3.8' >> ~/.zprofile

grep -q  'alias python3.9' ~/.profile  || echo alias python3.9='/opt/homebrew/opt/python@3.9/bin/python3.9' >> ~/.profile
grep -q  'alias python3.9' ~/.zprofile || echo alias python3.9='/opt/homebrew/opt/python@3.9/bin/python3.9' >> ~/.zprofile

grep -q  'alias python3.10' ~/.profile  || echo alias python3.10='/opt/homebrew/opt/python@3.10/bin/python3.10' >> ~/.profile
grep -q  'alias python3.10' ~/.zprofile || echo alias python3.10='/opt/homebrew/opt/python@3.10/bin/python3.10' >> ~/.zprofile

grep -q  'alias python=' ~/.profile  || echo alias python='/opt/homebrew/opt/python@3.10/bin/python3.10' >> ~/.profile
grep -q  'alias python=' ~/.zprofile || echo alias python='/opt/homebrew/opt/python@3.10/bin/python3.10' >> ~/.zprofile

grep -q  'alias pip=' ~/.profile  || echo alias pip='/opt/homebrew/opt/python@3.10/bin/pip3' >> ~/.profile
grep -q  'alias pip=' ~/.zprofile || echo alias pip='/opt/homebrew/opt/python@3.10/bin/pip3' >> ~/.zprofile

echo -e "Default pip version is $(pip3 --version)"
echo -e "Default Python version is $(python3 --version), also installed:\n"
/opt/homebrew/opt/python@3.8/bin/python3 --version
/opt/homebrew/opt/python@3.9/bin/python3 --version
/opt/homebrew/opt/python@3.10/bin/python3 --version
echo "$row_tilda"

# Upgrade pip and setuptools
echo "Upgrade pip and setuptools:"
pip3 install --upgrade pip setuptools
pip3 list
echo "$row_tilda"

# Install Jupyter-Lab
if ! command -v jupyter-lab &> /dev/null
then
    echo "Start installing Jupyter-Lab:"
    brew install jupyterlab
    echo alias jplab='/opt/homebrew/bin/jupyter-lab' >> ~/.profile
    echo alias jplab='/opt/homebrew/bin/jupyter-lab' >>  ~/.zprofile
    source ~/.profile
    jupyter --version
    echo "$row_tilda"
else
    echo "Jupyter is already installed:"
    jupyter --version
    echo "$row_tilda"
fi

# -------------------- Install Applications with UI -------------------

# Install JetBrains PyCharm CE
if [[ -x /Applications/PyCharm\ CE.app ]]
then
    echo "PyCharm CE is already installed:"
    echo "/Applications/PyCharm CE.app"
    echo "$row_tilda"
else
    echo "Start installing PyCharm CE:"
    brew install --cask pycharm-ce
    echo "$row_tilda"
fi

# Finally, calculate install process execution time
end_time=$(date +%s)
secs=$(($end_time - $start_time))
echo "Execution time was:"
printf '%02dh:%02dm:%02ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60))
echo -e "\n🔄  Now that the installation is complete, PLEASE DON'T FORGET TO RESTART YOUR COMPUTER 🔄  "
echo -e "\n                                 ¯\_(ツ)_/¯ \n"

echo "$row_hash"
