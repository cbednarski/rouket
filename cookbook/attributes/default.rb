#-- Rouket

# Default for Amazon S3. You may need to change this if your bucket is not in
# the default region or if you are not using s3. This becomes the proxy_pass
# value in nginx.
default['rouket']['origin_backend'] = 'https://s3.amazonaws.com:443'

# In s3, this is your bucket name.
default['rouket']['origin_path'] = 'rouket-test'

#-- Nginx

include_attribute "nginx::source"

override['nginx']['install_method'] = 'source'
override['nginx']['version'] = '1.4.7'

# Force nginx to compile the version we want from source. There are numerous
# attributes based off of nginx.version and they are evaluated when the nginx
# recipe is loaded so we have to override all of them here.
override['nginx']['source']['version'] = override['nginx']['version']
override['nginx']['source']['prefix'] = "/opt/nginx-#{node['nginx']['source']['version']}"
override['nginx']['source']['sbin_path'] = "#{node['nginx']['source']['prefix']}/sbin/nginx"
override['nginx']['source']['url'] = "http://nginx.org/download/nginx-#{node['nginx']['source']['version']}.tar.gz"

override['nginx']['source']['default_configure_flags'] = %W(
  --prefix=#{node['nginx']['source']['prefix']}
  --conf-path=#{node['nginx']['dir']}/nginx.conf
  --sbin-path=#{node['nginx']['source']['sbin_path']}
)
