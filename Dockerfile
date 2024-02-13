FROM chef/chefworkstation

ENV APT_DEPS \
    qemu \
    libvirt-daemon-system \
    ebtables \
    libguestfs-tools \
    ruby-fog-libvirt \
    vagrant

ENV GEM_DEPS \
    kitchen-vagrant

RUN (apt-get purge vagrant-libvirt || true) && \
    (apt-mark hold vagrant-libvirt || true)

RUN apt update && \
    apt install -y --no-install-recommends ${APT_DEPS} && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN vagrant plugin install vagrant-libvirt

RUN gem install ${GEM_DEPS}