# Rouket

Rouket is an S3 bucket router for S3 static site hosting that helps circumvent the 100-bucket limit in s3. Rouket sits between CloudFront and S3 and automatically routes hostname-based traffic into a "subdirectory" in your chosen S3 bucket.

Rouket is designed to be simple and disposable so it can easily be used with autoscaling groups and not require additional configuration at runtime.

## Features

1. Routing via nginx for high performance
2. `http://blah.example.com/en/some/page/` is routed to `s3://my-bucket/blah.example.com/en/some/page/`
3. Cache rules enforced by nginx for simpler s3 management and better end-user performance
4. Nginx can accomodate custom error pages, indexes, and more complex routing than CloudFront and S3.
5. Basic use requires only one-time configuration
6. Easily customize what you don't like
7. Plug-and-play compatibility with various CDN providers, or push Rouket to the edge

## Tech

Rouket is built with nginx and chef-solo.

    git clone https://github.com/cbednarski/rouket
    cd rouket
    make