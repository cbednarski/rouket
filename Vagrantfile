Vagrant.configure('2') do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.hostname = "rouket-berkshelf"
  config.vm.box = "ubuntu-1204-vbox"
  # config.vm.box = "ubuntu-1204-vmware"

  # config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :private_network, ip: "172.16.40.10"
  # config.vm.network :public_network
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = 'cookbook/Berksfile'

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      'nginx' => {
        'source' => {
          'version' => '1.4.4'
        },
        'version' => '1.4.4'
      }
    }

    chef.run_list = [
        "recipe[rouket::default]"
    ]
  end
end
