# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

ENV["VAGRANT_DEFAULT_PROVIDER"] ||= "docker"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "app", primary: true do |app|
    app.vm.provider "docker" do |docker|
      docker.cmd = ["/bin/bash", "-l"]
      docker.create_args = ["-i", "-t"]
      docker.image = "jamesdphillips/cedar:14"
      docker.name = "reddit-dailydigest"
      docker.ports = ["3000:3000", "8808:8808"]

      docker.link "psql:psql"
      docker.link "redis:redis"
    end

    # app.ssh.username = "root"
    app.vm.synced_folder ".", "/root" # , type: "rsync", rsync__exclude: %w(.git/ log/)
  end

  config.vm.define "db" do |db|
    db.vm.provider "docker" do |docker|
      docker.image = "postgres"
      docker.name = "psql"
      docker.ports = ["5432:5432"]
    end
  end

  config.vm.define "redis" do |redis|
    redis.vm.provider "docker" do |docker|
      docker.image  = "dockerfile/redis"
      docker.name = "redis"
      docker.ports = ["6379:6379"]
    end

    redis.vm.synced_folder "tmp/redis", "/data"
  end

  config.ssh.forward_agent = true
  # config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: %w(.git/ log/)
  # %w(.git/).each { |dir| config.vm.synced_folder dir, "/vagrant/#{dir}" }

  # config.vm.provider "virtualbox" do |vb|
  #   vb.customize ["modifyvm", :id, "--memory", ENV.fetch("VIRTUALBOX_MEMORY", "2048")]
  # end
end

