# -*- mode: ruby -*-
# vi: set ft=ruby :

## Cassandra cluster settings
server_count = 3
network = '192.168.2.'
first_ip = 10

servers = []
seeds = []
cassandra_tokens = []
(0..server_count-1).each do |i|
  name = 'node' + (i + 1).to_s
  ip = network + (first_ip + i).to_s
  seeds << ip
  servers << {'name' => name,
              'ip' => ip,
              'initial_token' => 2**127 / server_count * i}
end


# $ruby_install = <<SCRIPT
# curl -L https://get.rvm.io | bash -s stable
# source /etc/profile.d/rvm.sh
# rvm install ruby-1.9.3
# rvm use ruby-1.9.3
# SCRIPT


Vagrant::Config.run do |config|
  servers.each do |server|
    config.vm.define server['name'] do |config2|
      config2.vm.box = "precise"
      config2.vm.box_url = "https://dl.dropbox.com/u/14292474/vagrantboxes/precise64-ruby-1.9.3-p194.box"
      config2.vm.host_name = server['name']
      config2.vm.network :hostonly, server['ip']
      # config2.vm.provision :shell, :inline => $ruby_install
      config2.vm.provision :shell, :inline => "gem install chef --version 11.4.2 --no-rdoc --no-ri --conservative"
      config2.vm.provision :chef_solo do |chef|
        chef.log_level = :debug
        chef.cookbooks_path = ["vagrant/cookbooks", "vagrant/site-cookbooks"]
        chef.add_recipe "updater"
        chef.add_recipe "java"
        chef.add_recipe "cassandra::tarball"
        chef.json = {
          :cassandra => {'cluster_name' => 'My Cluster',
                         'initial_token' => server['initial_token'],
                         'seeds' => seeds.join(","),
                         'listen_address' => server['ip'],
                         'rpc_address' => server['ip']}
        }
      end
    end
  end
end
