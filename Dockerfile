#FROM containerssh/agent AS agent
FROM quay.io/rh_ctf_2023/rh_ctf:containerssh_agent as agent
#---
# FROM registry.fedoraproject.org/fedora-toolbox:40
FROM quay.io/rh_ctf_2023/rh_ctf:fedora-toolbox-40
COPY --from=agent /usr/bin/containerssh-agent /usr/bin/containerssh-agent

ARG username=agent
ARG user_password=rh_ctf_sud0_ch@ll3ng3
RUN dnf install -y sudo

# Create regular user and add to sudoers file
RUN export salted_pass=$(perl -e "print crypt(\"${user_password}\", 'pepper');") && \
    useradd -u 1001 -ms /usr/bin/bash -U -p "${salted_pass}" "${username}" && \
    echo "${username}      ALL=(ALL)       ALL" > /etc/sudoers.d/user-${username}

# Just run sudo once as $username so that the initial warning message
# doesn't come up when the user logs in
USER ${username}
RUN echo "${user_password}" | sudo -S echo "Shh, be quiet!"
USER root

COPY agent-collect-logs.sh /usr/local/bin
COPY AGENT_README.md /home/${username}
COPY flag.txt entrypoint.sh /
RUN echo "${user_password}" > entrypoint_credentials

RUN chmod 600 /flag.txt /entrypoint_credentials && \
    chmod 744 /entrypoint.sh

ENTRYPOINT /entrypoint.sh
