#
# Cookbook Name:: rouket
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'semitas::nginx'

link "/usr/bin/nginx" do
  to "/opt/nginx-1.4.4/sbin/nginx"
end


remote_file "#{Chef::Config[:file_cache_path]}/slick-error-pages.tar.gz" do
  owner 'root'
  group 'root'
  mode 00644
  source 'https://github.com/cbednarski/slick-error-pages/archive/master.tar.gz'
end

directory '/opt/slick-error-pages' do
  owner 'root'
  group 'root'
  mode 00755
  action :create
end

bash 'install_error_pages' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar -xzf slick-error-pages.tar.gz
    cp slick-error-pages-master/*.html /opt/slick-error-pages/
  EOH
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
