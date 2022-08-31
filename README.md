#  MacScripts
A set of scripts for automatic installation and configuration of MacBook

- [Package installer for Mac](https://github.com/feldmax/MacScripts#package-installer-for-mac)
- [Package list](https://github.com/feldmax/MacScripts#package-list)
- [How to create and run custom package](https://github.com/feldmax/MacScripts#how-to-create-and-run-custom-package)
- [Known Issues](https://github.com/feldmax/MacScripts#known-issues)

## Package installer for Mac
This folder contains the package installer for Mac and several packages with typical sets of software 
used by developers.

**mac-dev-install.sh** -
This is the first script you need to run. This script will install typical sets of software, called packages, 
on your computer. Each package contains software for specific development needs. You can choose between 
regular packages, team-specific packages, or prepare and install your own set of software with a *custom* package. 
In addition, you can run a special *upgrade* package to refresh your environment and update all programs 
previously installed with other packages.

☝️ You can install packages one by one or run multiple packages at the same time. If a program is already installed, 
the installer will simply skip it. The expected execution time may vary depending on the number of packages you 
want to install. In most cases, it will take about 10-20 minutes, if Apple XCode is already installed.
During the installation process, you will be asked to enter your account name and will be prompted to enter
your password and accept licenses, if necessary. Please note that the *package_init*, which contains the 
prerequisites for all other packages, will always run first, no matter which packages you choose.

🔓  To install programs, you need administrator rights on your Mac. On corporate computers, these permissions
disabled by default. Before starting the process, click on the Privileges icon in the MacOS Dock to request
administrator privileges, and make sure it turns yellow (open padlock).

To run the script, just copy and paste this command into the terminal on your Mac:

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/feldmax/MacScripts/main/mac-dev-install.sh)" | tee mac-dev-install.log


**mac-git-init.sh** -
This is the second script you may need to run. This script will do the initial Git setup and generate 
an SSH key pair that you can use for GitHub, Gerrit, and other services. You can run this script several times, -
if the SSH key pair already exists it will not be overwritten and the public key will  be shown on the screen.

To run the script, just copy and paste this command into the terminal on your Mac:

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/feldmax/MacScripts/main/mac-dev-git-init.sh)" | tee mac-dev-git-init.log


## Package list

**Common packages:**
- package_init      (Apple XCode, Homebrew, Git and Python PIP)      ~10 min
- package_java      (Open JDK, Maven, Tomcat, IntelliJ IDEA CE)       ~3 min
- package_js        (NodeJS, IntelliJ IDEA CE)                        ~4 min
- package_python    (Python, Jupyter Lab, PyCharm CE)                 ~8 min
- package_ide       (IntelliJ, VSCode, Eclipse, Atom, Brackets)       ~8 min
- package_browsers  (Chrome, Canary, Chromium, Edge, Firefox, Opera)  ~6 min
- package_messengers        (WhatsApp, Telegram, Viber, Zoom)         ~2 min
- package_qa                (Open JDK, Postman, JMerer, Selenium)     ~2 min

**Team specific packages:**
- package_devops    (gh, groovy, docker, kubectl, cf-cli, vault)      ~2 min
- package_neo       (Open JDK 8, Maven, NodeJS 14, Eclipse, IntelliJ,
  VSCode, Postman)                                ~10 min

**Custom package:**
- package_custom            (This is just template for custom package creation)
- package_custom_example    (An example of my personal a custom package)

**Upgrade package:**
- package_upgrade   (upgrade all installed programs to the latest versions)


## How to create and run custom package

If you need to add some additional software, create aliases, or want to build your own unique set of tools, 
you can edit and run a custom package.

- Open the *package_custom.sh* script file in GitHub and click Raw view
- Right Click > Save As > and save it as a TXT file
- Edit this file and add the necessary programs to the if-else blocks.
- See *package_custom_example.sh* for examples
- In the terminal, change directory to the location of the file and run the installer
- The installer will run the code from your local *package_custom.sh* file

☝️ You can use the same procedure to customize any other package. The installer always tries to execute 
the local files first, and if the file is not found, it will run the code from GitHub.


## *Known Issues*

UX is not perfect yet. You will need to answer "Yes" or "No" to install each package.
Some programs ask for a sudo password and require you to accept a license during the installation process.
Therefore, the installation process requires your attention to the output in the terminal, from time to time ...








