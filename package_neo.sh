#!/usr/bin/env bash
#
# NOTE:
# This script should be triggered by another wrapper script.
# To run it locally, use the next commands:
# sudo chmod +x package_neo.sh
# ./package_neo.sh | tee package_neo.log
#
# trap 'echo "# $BASH_COMMAND";read' DEBUG    # enable debug mode upon demand

echo -e "\n****************************** PACKAGE_NEO ******************************\n"

# Record time
time1=$(date +%s)  # start time

# install JDK 8 if this specific version is not installed
# overwrite JAVA_HOME with jdk8 path (add new line)


# Install Java 8 (Open JDK 8)
# Note: The installer asks for Password and acceptance of Java access to the Documents folder, at the end
if [[ $(java -version 2>&1) =~ "Unable to locate a Java Runtime" ]]
then
    echo "Start installing OpenJDK 8:"
    brew tap adoptopenjdk/openjdk
    brew install --cask adoptopenjdk8
    echo "$ROW_TILDA"
    java -version
    echo "export JAVA_HOME=$(/usr/libexec/java_home)" >> ~/.profile
    echo "export JAVA_HOME=$(/usr/libexec/java_home)" >> ~/.zprofile
    source ~/.profile
    echo "JAVA_HOME is:"
    echo "$JAVA_HOME"
    echo "$ROW_TILDA"
elif ! [[ $(java -version 2>&1) =~ "build 1.8.0_" ]]
then
    echo "Need to install OpenJDK 8"
else
    echo "Java is already installed:"
    java -version
    source ~/.profile
    echo "JAVA_HOME is:"
    echo "$JAVA_HOME"
    echo "$ROW_TILDA"
fi

# install NodeJS 14 if this specific version is not installed
# add PATH with node@14 path if not exist
# add flags if not exist

# Install NodeJS 14
#if ! command -v node &> /dev/null
#then
#    echo "Start installing NodeJS 14:"
#    brew install node@14
#    echo 'export PATH="/opt/homebrew/opt/node@14/bin:$PATH"' >> ~/.profile
#    echo 'export LDFLAGS="-L/opt/homebrew/opt/node@14/lib"' >> ~/.profile
#    echo 'export CPPFLAGS="-I/opt/homebrew/opt/node@14/include"' >> ~/.profile
#    echo 'export PATH="/opt/homebrew/opt/node@14/bin:$PATH"' >> ~/.zprofile
#    echo 'export LDFLAGS="-L/opt/homebrew/opt/node@14/lib"' >> ~/.zprofile
#    echo 'export CPPFLAGS="-I/opt/homebrew/opt/node@14/include"' >> ~/.zprofile
#    source ~/.profile
#    node --version
#    which node
#    echo "$ROW_TILDA"
#else
#    echo "NodeJS is already installed:"
#    node --version
#    which node
#    echo "$ROW_TILDA"
#fi


# Record time
time2=$(date +%s)  # end time

# Calculate the execution time of the package installation process
secs=$(($time2 - $time1))
printf 'Package installation time: %02dh:%02dm:%02ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60))
echo
