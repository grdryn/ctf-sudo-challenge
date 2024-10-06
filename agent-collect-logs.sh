#!/usr/bin/bash

# NOTE: this script should be run with sudo!
# Example:
# sudo agent-fetch-logs.sh > ~/logs.txt

date
echo "DNF ERROR/WARNING/INFO logs:"
grep "ERROR\|WARNING\|INFO" /var/log/dnf.log
echo "=========================================================="

# TODO: collect more logs

exit 0
