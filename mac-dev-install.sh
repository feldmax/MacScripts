#!/usr/bin/env bash
#
# NOTE:
# To start this script, copy and run the following command in a terminal:
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/feldmax/MacScripts/main/mac-dev-install.sh)" | tee mac-dev-install.log
#
# To run this script locally, use the next commands:
# sudo chmod +x mac-dev-install.sh
# ./mac-dev-install.sh | tee mac-dev-install.log
#
# trap 'echo "# $BASH_COMMAND";read' DEBUG    # enable debug mode upon demand

# Separation rows & style modifiers
ROW_TILDA=$(printf '~%.0s' {1..80}; printf '\n')
ROW_HASH=$(printf '#%.0s' {1..80}; printf '\n')
RESET='\033[0m'
BOLD='\033[1m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'

# System info
echo "$ROW_HASH"
sw_vers
echo "$ROW_TILDA"

# Info for user:
echo -e "
⚠️  This script will prepare development environment on your computer.
According to your development needs, you can choose which software packages
will be installed.

Common tools:
- package_init      (Apple XCode, Homebrew, Git and Python PIP)
- package_java      (Open JDK, Maven, IntelliJ IDEA CE)
- package_python    (Python, PyCharm CE, Jupyter Lab)
- package_js        (NodeJS, IntelliJ IDEA CE)
- package_ide       (IntelliJ IDEA CE, Visual Studio Code, Eclipse JEE)
- package_browsers  (Chrome, Canary, Chromium, Edge, Firefox, Opera)
- package_messangers        (WhatsUp, Telegram, Viber, Zoom, Slack)
- package_virtualization    (Docker Desktop, Parallels Desktop)
- package_miscellaneous     (Adobe Acrobat, Atom, Brackets, Mac Fan Control, Postman, Snagit, Unarchiver, VLC)
Team specific tools:
- package_devops    (gh, groovy, vault, kubectl, iacbox, cf-cli, telnet, wget)
- package_neo       (Open JDK 8, NodeJS 14)
Personal tools:
- package_personal  (Google Drive, uTorrent, tree, mkdocs-material, aliases)

The expected execution time may vary depending on the number of packages you
wish to install. In most cases it will be 10 to 60 minutes if Apple XCode is
already installed.
During the installation process, you will be asked to enter your iUser account
and will be prompted several times to enter your password and accept licenses,
if necessary.

🔓  $BOLD To install programs, you need administrator rights on your Mac.
On a private MacBook, make sure you're logged in with an administrator account.
On a corporate MacBook, click on the Privileges icon in the MacOS Dock to
request administrator rights, and make sure it turns yellow (open padlock).
$RESET
"

# Verify padlock and admin rights
sleep .5
read -p "Is the Privileges icon yellow 🔓 (open padlock) at the moment? Are you an admin? <Y | N> " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo -e "\n👉  Please request administrator privileges (click on the green padlock to open it)
    or login with an admin account (on a private Mac). Then run this script again.  👈 \n"
    echo "$ROW_HASH"
    exit 1
fi
echo "$ROW_TILDA"

# Verify iUser
sleep .5
read -r -p "Please type your username (iUser|cUser|dUser): " user
[ -z "$user" ] && user="$(whoami)"

shopt -s nocasematch; if [[ "$(whoami)" =~ $user ]]
then
    echo -e "User verification:$GREEN Successful.$RESET Current user:$BOLD $(whoami) $RESET \n"
else
    echo -e "User verification:$RED Failed.$RESET Current user:$BOLD $(whoami) $RESET \n"
    echo -e "
⛔ On the corporate computer you must be logged in as iUser (cUser or dUser)!
Installing and configuring a developer environment with another account can
lead to compatibility and network connectivity issues. If your profile name
('whoami' command in terminal) returns your personal name instead of your iUser
- please contact your local IT department to set up your computer account.
After that, run this script again.
    "
    echo "$ROW_HASH"
    exit 1
fi

# Create the list of packages to be installed
packages=("package_java" "package_js" "package_python")
install_packs=("package_init")  #always install/update initial package

for str in "${packages[@]}"; do
  sleep .5
  echo -e -n "Do you want to install $YELLOW$BOLD $str $RESET ?  <Y | N> "
  read -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
      install_packs+=("$str")
  fi
done
#echo -e  "\nThe following packages will be installed:\n$BOLD ${install_packs[*]} $RESET \n"

echo -e  "\nThe following packages will be installed:\n"
printf '%s\n' "${install_packs[@]}"; echo

sleep .5
read -p "Is it OK? Do you want to continue? <Y | N> " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo -e "\n👉  Run this script again, select the correct packages and press 'Y' to continue. 👈 \n"
    echo "$ROW_HASH"
    exit 1
fi
echo "$ROW_TILDA"

# Record time
start_time=$(date +%s)  #start time

# Install packages
for pack in "${install_packs[@]}"; do
    sleep .5
    source ./$pack.sh || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/feldmax/MacScripts/main/$pack.sh)"
done

# Record time
end_time=$(date +%s)    #end time

# Calculate install process execution time
secs=$(($end_time - $start_time))
printf '\nTotal execution time: %02dh:%02dm:%02ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60))

# Restart remainder
echo -e "\n🔄  Now that the installation is complete, PLEASE DON'T FORGET TO RESTART YOUR COMPUTER 🔄  "
echo -e "\n                                 ¯\_(ツ)_/¯ \n"

echo "$ROW_HASH"
