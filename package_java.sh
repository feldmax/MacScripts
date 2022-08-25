#!/usr/bin/env bash
#
# NOTE:
# This script should be run by another wrapper script. To run it separately:
# sudo chmod +x package_java.sh
# ./package_java.sh | tee package_java.log

# trap 'echo "# $BASH_COMMAND";read' DEBUG    # enable debug mode upon demand

# Separation rows & garnish variables defined in wrapper script
# ROW_TILDA=$(printf '~%.0s' {1..80}; printf '\n')

# Record time
time1=$(date +%s)  # start time

# STUB
echo -e "-------------------This is empty TEST package remote call--------------------------"


# Record time
time2=$(date +%s)  # end time

# Calculate install process execution time
secs=$(($time2 - $time1))
printf 'Package installation time: %02dh:%02dm:%02ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60))
echo "$ROW_TILDA"
