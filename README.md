# Sudo Hijacking

We have some sort of a background process that will come and re-evaluate
`.bashrc` before using sudo. We can't sudo straight away since we don't have
the password for the user we are running as. Thus we have to overload `sudo`
with a function or alias to have it leak us the flag (in a file we don't have
the permissions to read).

https://blog.grdryn.me/blog/fedora/prank-alias-sudo-in-bash.html
https://book.hacktricks.xyz/linux-hardening/privilege-escalation#sudo-hijacking

## Flag

Change it in `flag.txt`:

    RH_CTF{b3_c4r3ful_w1th_sud0}

## Author

    Gerard Ryan gryan@redhat.com

## Build & Deploy

    podman build -t quay.io/rh_ctf_2023/rh_ctf:sudo_gerard .
    podman push quay.io/rh_ctf_2023/rh_ctf:sudo_gerard

Deployment is going to be a bit awkward:

1. We need to have containerssh installed and configured for port 2222/tcp (see [installing containerssh](https://gitlab.cee.redhat.com/warhw-ctf-2023-orga-team/warhw-ctf-2024/-/blob/main/infrastructure/k3s/README.md?ref_type=heads#optional-install-containerssh)
2. Configure containerssh instance to have the entrypoint running:
   `oc apply -f ./deploy.yaml`
3. Kill the containerssh pod in ns/containerssh, otherwise the configuration
   won't be reloaded.

Once it's all done, connect to containerssh to spawn the pod, use any password:

    ssh agent@agent.ctf.raiders-of-the-lost-flag.quest -p 2222

## Solution

See `example-solve.txt`
