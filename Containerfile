FROM registry.fedoraproject.org/fedora-toolbox:40

ARG username=agent
ARG user_password=rh_ctf_sud0_ch@ll3ng3

ENV USERNAME=${username}
ENV USER_PASSWORD=${user_password}

RUN dnf install -y sudo

# Create regular user and add to sudoers file
RUN export salted_pass=$(perl -e "print crypt(\"${USER_PASSWORD}\", 'pepper');") && \
    useradd -u 1001 -ms /usr/bin/bash -U -p "${salted_pass}" "${USERNAME}" && \
    echo "${USERNAME}      ALL=(ALL)       ALL" > /etc/sudoers.d/user-${USERNAME}

# Just run sudo once as $username so that the initial warning message
# doesn't come up when the user logs in
USER ${username}
RUN echo "${USER_PASSWORD}" | sudo -S echo "Shh, be quiet!"
USER root

COPY copy-files/ /
# Copy separately to avoid mucking up ownership/permissions in /home
COPY AGENT_README.md /home/${username}
ENTRYPOINT entrypoint.sh
