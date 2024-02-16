FROM chef/chefworkstation

ENV BUILD_APT_DEPS \
    gpg \
    libvirt-dev

ENV APT_DEPS \
    qemu \
    libvirt-daemon-system \
    ebtables \
    libguestfs-tools \
    ruby-fog-libvirt \
    vagrant \
    terraform \ 
    ansible 

RUN apt update && \
    apt install -y ${BUILD_APT_DEPS}
RUN curl -sL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list

RUN (apt-get purge vagrant-libvirt || true) && \
    (apt-mark hold vagrant-libvirt || true)

RUN apt update && \
    apt install -y --no-install-recommends ${APT_DEPS} && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

ENV GEM_DEPS \
    kitchen-vagrant \ 
    # dry-configurable \
    # dry-container \
    # dry-core \
    # dry-inflector \
    # dry-logic \
    # dry-struct \
    # dry-types \
    # k8s-ruby \
    # jsonpath \
    # train-kubernetes \
    # inspec \
    # inspec-bin \
    # inspec-core \
    # thor \
    # kitchen-inspec \
    faraday-retry \
    kitchen-terraform \
    kitchen-ansible

RUN /opt/chef-workstation/embedded/bin/gem install --no-user-install --install-dir /opt/chef-workstation/embedded/lib/ruby/gems/3.1.0 ${GEM_DEPS}
RUN /opt/chef-workstation/embedded/bin/gem update --no-user-install --install-dir /opt/chef-workstation/embedded/lib/ruby/gems/3.1.0

RUN /opt/chef-workstation/embedded/bin/gem install --no-user-install --install-dir /opt/chef-workstation/embedded/lib/ruby/gems/3.1.0 inspec-bin -v 5.22.40
# RUN /opt/chef-workstation/embedded/bin/gem install --no-user-install --install-dir /opt/chef-workstation/embedded/lib/ruby/gems/3.1.0 hashdiff -v 1.0.1
# RUN /opt/chef-workstation/embedded/bin/gem install --no-user-install --install-dir /opt/chef-workstation/embedded/lib/ruby/gems/3.1.0 faraday_middleware -v 1.0.0
# RUN /opt/chef-workstation/embedded/bin/gem install --no-user-install --install-dir /opt/chef-workstation/embedded/lib/ruby/gems/3.1.0 activesupport -v 7.0.0

# RUN /opt/chef-workstation/embedded/bin/gem uninstall --no-user-install --install-dir /opt/chef-workstation/embedded/lib/ruby/gems/3.1.0 -I faraday-retry -v 1.0.3

# RUN vagrant plugin install vagrant-libvirt vagrant-routeros

COPY target /