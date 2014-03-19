# Rouket

Rouket is an S3 bucket router for S3 static site hosting that helps circumvent the 100-bucket limit in s3. Rouket sits between CloudFront and S3 and automatically routes hostname-based traffic into a "subdirectory" in your chosen S3 bucket.

Rouket is designed to be simple and disposable so it can easily be used with autoscaling groups and not require additional configuration at runtime.

## Features

1. Routing via nginx for high performance
2. `http://blah.example.com/en/some/page/` is routed to `s3://my-bucket/blah.example.com/en/some/page/`
3. [Planned] Cache rules enforced by nginx for simpler s3 management and better end-user performance
4. [Planned] Nginx can accomodate custom error pages, indexes, and more complex routing than CloudFront and S3.
5. Basic use requires only one-time configuration
6. Easily customize what you don't like
7. Plug-and-play compatibility with various CDN providers, or push Rouket to the edge

## Setup Instructions

Rouket is built using [packer](http://packer.io/) and [chef-solo](http://docs.opscode.com/chef_solo.html). You will need packer and ruby installed locally in order to run this.

    git clone https://github.com/cbednarski/rouket
    cd rouket
    make init

This will install the dependencies for chef solo, berkshelf, etc.

You'll also need to provide your AWS credentials to packer. You can do this via the to environment variables `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`, or via `packer -var` flags to override them.

When you've got everything setup and you're ready to bootstrap your AMI.

    packer build -var "version=`git describe`" -var "origin_path=MY-S3-BUCKET" rouket-packer.json

Packer will provision an EC2 instance for you and snapshot it. At then end of the script you'll see something like this:

    ==> amazon-ebs: Waiting for AMI to become ready...
    ==> amazon-ebs: Modifying attributes on AMI (ami-########)...
        amazon-ebs: Modifying: description
    ==> amazon-ebs: Adding tags to AMI (ami-########)...
        amazon-ebs: Adding tag: "recipe": "rouket"

Plug that ami id into an autoscaling group or spin up a few instances by hand and you're ready to go!
