#!/bin/bash

mkdir -p ~/.chef
mkdir -p ~/.kitchen
mkdir -p ~/.vagrant.d
test -f ~/.gitconfig || touch ~/.gitconfig

docker run \
    --rm \
    --user $UID:`id -g` \
    --workdir="/home" \
    --network host \
    -it \
    -v .:/home \
    -v /etc/group:/etc/group:ro \
    -v /etc/passwd:/etc/passwd:ro \
    -v /etc/shadow:/etc/shadow:ro \
    -v ~/.gitconfig:/home/.gitconfig:ro \
    -v ~/.chef:/.chef \
    -v ~/.kitchen:/.kitchen \
    -v ~/.vagrant.d:/.vagrant.d \
    -v /var/run/libvirt/libvirt-sock:/var/run/libvirt/libvirt-sock \
    dchef $@