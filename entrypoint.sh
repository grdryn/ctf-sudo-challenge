#!/usr/bin/bash

entrypoint() {
    local username=agent

    while :
    do
        cat /entrypoint_credentials | sudo --login -u ${username} bash -l -c "sudo --login -S -p \"\" agent-collect-logs.sh > ~/logs.txt"
        sleep 30
    done
}

entrypoint &

exec su -l agent
