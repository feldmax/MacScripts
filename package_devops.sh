#!/usr/bin/env bash
#
# NOTE:
# This script should be triggered by another wrapper script.
# To run it locally, use the next commands:
# sudo chmod +x package_devops.sh
# ./package_devops.sh | tee package_devops.log
#
# trap 'echo "# $BASH_COMMAND";read' DEBUG    # enable debug mode upon demand

echo -e "\n****************************** PACKAGE_DEVOPS ******************************\n"

# Record time
time1=$(date +%s)  # start time

# Install GitHub CLI
if ! command -v gh &> /dev/null
then
    echo "Start installing GitHub CLI (gh):"
    brew install gh
    gh --version
    echo "$ROW_TILDA"
else
    echo "GitHub CLI (gh) is already installed:"
    gh --version
    echo "$ROW_TILDA"
fi

# Install Groovy
if ! command -v groovy &> /dev/null
then
    echo "Start installing Groovy:"
    brew install groovy
    grep -q  'GROOVY_HOME' ~/.profile  || echo "export GROOVY_HOME=$(brew --prefix)/opt/groovy/libexec" >> ~/.profile
    grep -q  'GROOVY_HOME' ~/.zprofile || echo "export GROOVY_HOME=$(brew --prefix)/opt/groovy/libexec" >> ~/.zprofile
    source ~/.profile
    groovy --version
    echo "GROOVY_HOME is:"
    echo "$GROOVY_HOME"
    echo "$ROW_TILDA"
else
    echo "Groovy is already installed:"
    groovy --version
    echo "GROOVY_HOME is:"
    echo "$GROOVY_HOME"
    echo "$ROW_TILDA"
fi

# Install Docker CLI
if ! command -v docker &> /dev/null
then
    echo "Start installing Docker:"
    brew install docker
    docker --version
    echo "$ROW_TILDA"
else
    echo "Docker is already installed:"
    docker --version
    echo "$ROW_TILDA"
fi

# Install Kubernetes CLI (kubectl)
if ! command -v kubectl &> /dev/null
then
    echo "Start installing Kubernetes CLI (kubectl):"
    brew install kubernetes-cli
    kubectl version
    echo "$ROW_TILDA"
else
    echo "Kubernetes CLI (kubectl) is already installed:"
    kubectl version
    echo "$ROW_TILDA"
fi

# Install Cloud Foundry CLI (cf)
if ! command -v cf &> /dev/null
then
    echo "Start installing Cloud Foundry CLI (cf):"
#    brew tap cloudfoundry/tap
    brew install cloudfoundry/tap/cf-cli@8
    cf --version
    echo "$ROW_TILDA"
else
    echo "Cloud Foundry CLI (cf) is already installed:"
    cf --version
    echo "$ROW_TILDA"
fi

# Install Vault
if ! command -v vault &> /dev/null
then
    echo "Start installing Vault:"
    brew install vault
    vault --version
    echo "$ROW_TILDA"
else
    echo "Vault is already installed:"
    vault --version
    echo "$ROW_TILDA"
fi

# Record time
time2=$(date +%s)  # end time

# Calculate the execution time of the package installation process
secs=$(($time2 - $time1))
printf 'Package installation time: %02dh:%02dm:%02ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60))
echo
