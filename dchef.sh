#!/bin/bash

mkdir -p ~/.chef
mkdir -p ~/.kitchen
mkdir -p ~/.vagrant.d
mkdir -p ~/.ansible
test -f ~/.gitconfig || touch ~/.gitconfig

DOCKER_RUN_CMD="docker run \
    --rm \
    --user $UID:"$(id -g)" \
    --workdir="/home/${USER}/project" \
    --network host \
    -it \
    -v .:"/home/${USER}/project" \
    -v /etc/group:/etc/group:ro \
    -v /etc/passwd:/etc/passwd:ro \
    -v ~/.gitconfig:"/home/${USER}/.gitconfig:ro"\
    -v ~/.chef:"/home/${USER}/.chef" \
    -v ~/.kitchen:"/home/${USER}/.kitchen" \
    -v ~/.vagrant.d:"/home/${USER}/.vagrant.d" \
    -v ~/.ansible:"/home/${USER}/.ansible" \
    -v /var/run/libvirt/libvirt-sock:/var/run/libvirt/libvirt-sock \
    ktogias/dchef"


if vagrant plugin list | grep -q 'vagrant-libvirt'; then
  echo "vagrant-libvirt plugin is installed."
else
  echo "vagrant-libvirt plugin is NOT installed."
  eval "${DOCKER_RUN_CMD} vagrant plugin install vagrant-libvirt"
fi

if vagrant plugin list | grep -q 'vagrant-routeros'; then
  echo "vagrant-routeros plugin is installed."
else
  echo "vagrant-routeros plugin is NOT installed."
  eval "${DOCKER_RUN_CMD} vagrant plugin install vagrant-routeros"
fi


eval "${DOCKER_RUN_CMD} $@"