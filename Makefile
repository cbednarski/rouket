packer: init
	packer build -var "version=`git describe`" rouket-packer.json
debug:
	packer build -debug -var "version=`git describe`" rouket-packer.json
vagrant: init
	vagrant up
	vagrant provision
init:
	bundle install
	bundle exec berks install --path vendor/cookbooks