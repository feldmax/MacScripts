#!/usr/bin/env bash
#
# NOTE:
# This script should be triggered by another wrapper script.
# To run it locally, use the next commands:
# sudo chmod +x package_java.sh
# ./package_java.sh | tee package_java.log
#
# trap 'echo "# $BASH_COMMAND";read' DEBUG    # enable debug mode upon demand

echo -e "\n****************************** PACKAGE_JAVA ******************************\n"

# Record time
time1=$(date +%s)  # start time

# Install Java (Open JDK)
# Note: The installer asks for Password and acceptance of Java access to the Documents folder, at the end
if [[ $(java -version 2>&1) =~ "Unable to locate a Java Runtime" ]]
then
    echo "Start installing OpenJDK:"
    brew install openjdk
    grep -q  'openjdk/bin' ~/.profile  || echo 'export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"' >> ~/.profile
    grep -q  'openjdk/bin' ~/.zprofile || echo 'export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"' >> ~/.zprofile
    grep -q  'JAVA_HOME' ~/.profile  || echo "export JAVA_HOME=/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home" >> ~/.profile
    grep -q  'JAVA_HOME' ~/.zprofile || echo "export JAVA_HOME=/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home" >> ~/.zprofile
    source ~/.profile
    java -version
    echo "JAVA_HOME is:"
    echo "$JAVA_HOME"
    echo "$ROW_TILDA"
else
    echo "Java is already installed:"
    java -version
    source ~/.profile
    echo "JAVA_HOME is:"
    echo "$JAVA_HOME"
    echo "$ROW_TILDA"
fi

# Install Maven
if ! command -v mvn &> /dev/null
then
    echo "Start installing Maven:"
    brew install maven
    echo
    mvn --version
    grep -q  'M2_HOME' ~/.profile  || echo "export M2_HOME=/opt/homebrew/opt/maven/libexec" >> ~/.profile
    grep -q  'M2_HOME' ~/.zprofile || echo "export M2_HOME=/opt/homebrew/opt/maven/libexec" >> ~/.zprofile
    source ~/.profile
    echo "M2_HOME is:"
    echo "$M2_HOME"
    echo "$ROW_TILDA"
else
    echo "Maven is already installed:"
    mvn --version
    source ~/.profile
    echo "M2_HOME is:"
    echo "$M2_HOME"
    echo "$ROW_TILDA"
fi

# Install Tomcat
# TBD

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
