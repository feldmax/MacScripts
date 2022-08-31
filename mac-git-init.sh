#!/usr/bin/env bash
#
# NOTE:
# To start this script, copy and run the following command in a terminal:
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/feldmax/MacScripts/main/mac-dev-git-init.sh)" | tee mac-dev-git-init.log
#
# To run this script locally, use the next commands:
# sudo chmod +x mac-git-init.sh
# ./mac-git-init.sh | tee mac-dev-git-init.log
#
# trap 'echo "# $BASH_COMMAND";read' DEBUG    # enable debug mode upon demand

echo -e "\n****************************** GIT_INIT ******************************\n"

# Info for user:
echo -e "
⚠️  This script will do the initial Git setup and generate an ssh key pair that
you can use for GitHub, Gerrit, and other SAP services.
"
echo "$ROW_TILDA"

# Git initial configuration for SAP user
if [[ -s ~/.gitconfig ]]
then
    echo -e "Git configuration file is already exists in ~/.gitconfig:\n"
    cat ~/.gitconfig
    echo "$ROW_TILDA"
else
    echo "Git initial configuration for SAP user:"
    sleep .5
    read -r -p "Please enter your full name (like 'John Smith'): " name
    sleep .5
    read -r -p "and your e-mail | corporate e-mail (like 'john.smith@company.com'): " email
    sleep .5
    read -p "Recorded name: \"$name\" email: \"$email\". Is it correct? <Y | N> " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        echo "$ROW_TILDA"
        exit 1
    else
        echo "create ~/.gitconfig"
        git config --global user.name "$name"
        git config --global user.email "$email"
        cat ~/.gitconfig
    fi
    echo "$ROW_TILDA"
fi

# Create default SSH key pair
if [[ -s ~/.ssh/id_rsa.pub ]]
then
    echo -e "SSH key pair is already exists in ~/.ssh . Your SSH public key (id_rsa.pub) is:\n"
    cat ~/.ssh/id_rsa.pub
    echo -e "\n☝️   Copy this SSH public key to your GitHub and Gerrit accounts:
    GitHub > User Icon >  Settings > SSH and GPG keys
    Gerrit > ⚙️  Settings > SSH Keys
    "
    echo
else
    ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y    # use the <<<y option to overwrite the previous key
    echo -e "Your default SSH key pair is created in ~/.ssh . Your SSH public key (id_rsa.pub) is:\n"
    cat ~/.ssh/id_rsa.pub
    echo -e "\n☝️   Copy this SSH public key to your GitHub and Gerrit accounts:
    GitHub > User Icon >  Settings > SSH and GPG keys
    Gerrit > ⚙️  Settings > SSH Keys
    "
    echo
fi

echo "$ROW_HASH"

