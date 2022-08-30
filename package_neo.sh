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

# Install Java 8 (Open JDK 8)
# Note: The installer asks for Password and acceptance of Java access to the Documents folder, at the end
if ! [[ $(java -version 2>&1) =~ "build 1.8.0_" ]] && ! [[ $($JAVA_HOME/bin/java -version 2>&1) =~ "build 1.8.0_" ]]
then
    echo "Start installing | updating OpenJDK 8:"
    brew tap adoptopenjdk/openjdk
    brew install --cask homebrew/cask-versions/adoptopenjdk8
    echo "$ROW_TILDA"
    echo "export JAVA_HOME=$(/usr/libexec/java_home)" >> ~/.profile
    echo "export JAVA_HOME=$(/usr/libexec/java_home)" >> ~/.zprofile
    source ~/.profile
    echo "JAVA_HOME is:"
    echo "$JAVA_HOME"
    echo "Java 8 version:"
    $JAVA_HOME/bin/java -version
    echo "Java 8 location is:"
    echo "$JAVA_HOME/bin/java"
    echo "Default Java on this machine:"
    java -version
    echo "Default Java location is:"
    command -v java
    echo "$ROW_TILDA"
else
    echo "Java is already installed:"
    source ~/.profile
    echo "JAVA_HOME is:"
    echo "$JAVA_HOME"
    echo "Java 8 version:"
    $JAVA_HOME/bin/java -version
    echo "Java 8 location is:"
    echo "$JAVA_HOME/bin/java"
    echo "Default Java on this machine:"
    java -version
    echo "Default Java location is:"
    command -v java
    echo "$ROW_TILDA"
fi

# Install Maven
if ! command -v mvn &> /dev/null
then
    echo "Start installing Maven:"
    brew install maven
    grep -q  'M2_HOME' ~/.profile  || echo "export M2_HOME=/opt/homebrew/opt/maven/libexec" >> ~/.profile
    grep -q  'M2_HOME' ~/.zprofile || echo "export M2_HOME=/opt/homebrew/opt/maven/libexec" >> ~/.zprofile
    source ~/.profile
    mvn --version
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

# Install NodeJS 14
if ! [[ $(node --version) =~ "v14." ]] || ! command -v node &> /dev/null
then
    echo "Start installing NodeJS 14:"
    brew install node@14
    echo 'export PATH="/opt/homebrew/opt/node@14/bin:$PATH"' >> ~/.profile
    echo 'export PATH="/opt/homebrew/opt/node@14/bin:$PATH"' >> ~/.zprofile
    echo 'export LDFLAGS="-L/opt/homebrew/opt/node@14/lib"' >> ~/.profile
    echo 'export LDFLAGS="-L/opt/homebrew/opt/node@14/lib"' >> ~/.zprofile
    echo 'export CPPFLAGS="-I/opt/homebrew/opt/node@14/include"' >> ~/.profile
    echo 'export CPPFLAGS="-I/opt/homebrew/opt/node@14/include"' >> ~/.zprofile
    source ~/.profile
    node --version
    which node
    echo "$ROW_TILDA"
else
    echo "NodeJS 14 is already installed:"
    node --version
    which node
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

# Record time
time2=$(date +%s)  # end time

# Calculate the execution time of the package installation process
secs=$(($time2 - $time1))
printf 'Package installation time: %02dh:%02dm:%02ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60))
echo
