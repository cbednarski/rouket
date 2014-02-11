
# Default for Amazon S3. You may need to change this if your bucket is not in
# the default region. Becomes the proxy_pass value in nginx.
default['rouket']['origin_backend'] = 'https://s3.amazonaws.com:443'

# In s3, this is your bucket name.
default['rouket']['origin_path'] = 'rouket-test'
