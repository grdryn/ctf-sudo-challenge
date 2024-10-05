#!/usr/bin/bash

entrypoint() {
    local username=agent
    local userpass=rh_ctf_sud0_ch@ll3ng3

    while :
    do
        echo ${userpass} | sudo --login -u ${username} bash -l -c "sudo --login -S -p \"\" agent-collect-logs.sh > ~/logs.txt"
        sleep 30
    done
}

entrypoint &

exec su -l agent
