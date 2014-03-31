#
# Cookbook Name:: rouket
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'

bash 'apt-upgrade' do
    user 'root'
    code 'apt-get upgrade -y'
end

include_recipe 'nginx'

link "/usr/bin/nginx" do
  to "/opt/#{node['nginx']['version']}/sbin/nginx"
end

template "/etc/nginx/sites-enabled/rouket" do
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables({
      :origin_backend => node['rouket']['origin_backend'],
      :origin_path => node['rouket']['origin_path']
    })
end

service 'nginx' do
  action :reload
end