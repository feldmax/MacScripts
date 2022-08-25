#!/usr/bin/env bash
#
# NOTE:
# To run this script locally on your MacBook please make this file executable:
# sudo chmod +x mac-dev-install.sh
# Run script:
# ./mac-dev-install.sh | tee mac-dev-install.log

# trap 'echo "# $BASH_COMMAND";read' DEBUG    # enable debug mode upon demand

# Separation rows & garnish variables
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
- package_init (Apple XCode, Homebrew, Git and Python PIP)
- package_java (Open JDK, Maven, IntelliJ IDEA CE)
- package_python (Python, PyCharm CE, Jupyter Lab)
- package_js (NodeJS, IntelliJ IDEA CE)
- package_ide (IntelliJ IDEA CE, Visual Studio Code, Eclipse JEE)
- package_browsers (Chrome, Canary, Chromium, Edge, Firefox, Opera)
- package_messangers (WhatsUp, Telegram, Viber, Zoom, Slack)
- package_virtualization (Docker Desktop, Parallels Desktop)
- package_miscellaneous (Adobe Acrobat, Atom, Brackets, Mac Fan Control, Postman, Snagit, Unarchiver, VLC)
Team specific tools:
- package_devops (gh, groovy, vault, kubectl, iacbox, cf-cli, telnet, wget)
- package_neo (Open JDK 8, NodeJS 14)
Personal tools:
- package_personal (Google Drive, uTorrent, tree, mkdocs-material, aliases)

The expected execution time may vary depending on the number of packages you
wish to install. In most cases it will be 10 to 60 minutes if Apple XCode is
already installed.
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
    echo "$ROW_HASH"
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
    echo "$ROW_HASH"
    exit 1
fi
echo "$ROW_TILDA"

# Create the list of packages to be installed
packages=("package_java" "package_js" "package_python")
install_packs=("package_init")  #always install/update initial package

for str in "${packages[@]}"; do
  sleep .5
  echo -e -n "Do you want to install ${YELLOW}${BOLD} $str ${RESET} ?  <Y | N> "
  read -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
      install_packs+=("$str")
  fi
done
echo -e  "The following packages will be installed:\n${GREEN} ${install_packs[*]} ${RESET} \n"
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
    source ./$pack.sh
#    ./$pack.sh &
#    source ./$pack.sh || curl https://github.wdf.sap.corp/raw/i058126/ShellScripts/master/Mac%20scripts/$pack.sh?token=AAAIWG2LR6OKYCATV2N4TI3DB4YHI | source
#    source ./$pack.sh | grep --color -E "$pack.sh: No such file or directory|$"
done

# Record time
end_time=$(date +%s)    #end time

# Calculate install process execution time
secs=$(($end_time - $start_time))
printf 'Total execution time: %02dh:%02dm:%02ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60))

# Restart remainder
echo -e "\n🔄  Now that the installation is complete, PLEASE DON'T FORGET TO RESTART YOUR COMPUTER 🔄  "
echo -e "\n                                 ¯\_(ツ)_/¯ \n"

echo "$ROW_HASH"
