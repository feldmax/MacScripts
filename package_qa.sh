#!/usr/bin/env bash
#
# NOTE:
# This script should be triggered by another wrapper script.
# To run it locally, use the next commands:
# sudo chmod +x package_qa.sh
# ./package_qa.sh | tee package_qa.log
#
# trap 'echo "# $BASH_COMMAND";read' DEBUG    # enable debug mode upon demand

echo -e "\n****************************** PACKAGE_QA ******************************\n"

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

# Install Postman
if [[ -x /Applications/Postman.app ]]
then
    echo "Postman is already installed:"
    echo "/Applications/Postman.app"
    echo "$ROW_TILDA"
else
    echo "Start installing Postman:"
    brew install --cask postman
    echo "$ROW_TILDA"
fi

# Install Apache JMeter (need Java)
if ! command -v jmeter &> /dev/null
then
    echo "Start installing JMeter:"
    brew install jmeter
    which jmeter
    echo "$ROW_TILDA"
else
    echo "JMeter is already installed:"
    which jmeter
    echo "$ROW_TILDA"
fi

# Install Apache Selenium (need Java)
if ! command -v jmeter &> /dev/null
then
    echo "Start installing Selenium Server:"
    brew install selenium-server
    which jmeter
    echo "$ROW_TILDA"
else
    echo "JSelenium Server is already installed:"
    which selenium-server
    echo "$ROW_TILDA"
fi

# Record time
time2=$(date +%s)  # end time

# Calculate the execution time of the package installation process
secs=$(($time2 - $time1))
printf 'Package installation time: %02dh:%02dm:%02ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60))
echo
