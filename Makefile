packer: init
	packer build -var "version=`git describe`" rouket-packer.json
debug:
	packer build -debug -var "version=`git describe`" rouket-packer.json
vagrant: init
	vagrant up
	vagrant provision
init:
	cd cookbook && bundle install
	cd cookbook && bundle exec berks install --path ../vendor/cookbooks
