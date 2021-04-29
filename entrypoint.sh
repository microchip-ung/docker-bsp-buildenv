#!/usr/bin/env bash
#
# The docker image executes as root by default, but we want the generated files
# to be owned by the caller of the docker image.
#
# The .docker.env file must add user and uid in the environment like this:
# MCHP_DOCKER_PARAMS="... -e BLD_USER=$(id -un) -e BLD_UID=$(id -u) ..."
#
# The docker image is configured to always call this file at startup.
#
# Here we create a user that is equal to the caller of the docker image and also
# enabled this user to run sudo without a password.
#
# Finally we execute the command supplied by the user as the user.
#

if [[ "$#" -eq "0" ]]; then
    echo "ERROR: Missing command!" 1>&2
    exit 1
fi

if [[ -z $BLD_USER ]]; then
    echo "ERROR: BLD_USER variable not set!" 1>&2
    exit 1
fi
   
if [[ -z $BLD_UID ]]; then
    echo "ERROR: BLD_UID variable not set!" 1>&2
    exit 1
fi

# Add user as specified in environment
adduser --no-create-home --disabled-password --home / --uid $BLD_UID --gecos "Bob the Builder" $BLD_USER > /dev/null

# Allow user to sudo without password
echo "$BLD_USER ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/$BLD_USER
chmod 0440 /etc/sudoers.d/$BLD_USER

# Run command as user
runuser -u $BLD_USER -- "$@"
