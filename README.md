# chef-workstation-dockerized
Run chef workstation and kitchen with vagrant libvirt provider from a docker container

Build: `docker build -t dchef .`

Init:
```./dchef.sh vagrant plugin install vagrant-libvirt```

Generate cookbook:
```./dchef.sh chef generate cookbook git_cookbook --chef-license=accept```

See https://kitchen.ci/docs/getting-started/creating-cookbook/ for Test Kitchen documentation.

Prepend all chef and kitchen commands with ./dchef.sh