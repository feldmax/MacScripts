#!/usr/bin/env bash
#
# NOTE:
# This script should be triggered by another wrapper script.
# To run it locally, use the next commands:
# sudo chmod +x package_template.sh
# ./package_template.sh | tee package_template.log
#
# trap 'echo "# $BASH_COMMAND";read' DEBUG    # enable debug mode upon demand

echo -e "\n****************************** PACKAGE_TEMPLATE ******************************\n"

# Record time
time1=$(date +%s)  # start time

# Install something
# TBD--------<add code example here: CLI app>-------------
# TBD--------<add code example here: UI app>-------------
# TBD--------<add code example here: Python app>-------------
echo "$ROW_TILDA"

# Record time
time2=$(date +%s)  # end time

# Calculate install process execution time
secs=$(($time2 - $time1))
printf 'Package installation time: %02dh:%02dm:%02ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60))
echo
