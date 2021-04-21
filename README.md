# Docker image for building buildroot and buildroot-layer.

The purpose of this docker image is to be able to build buildroot inside a container running this image.

This includes running the scripts defined by buildroot-layer: `source-prepare.rb` and `build.rb`.

The image is based on Ubuntu 20.04 LTS.

In order to use the `dr` (docker-run) script in dotconfig you must create a file called .docker.env in the root of your checkout.

This repository contains a .docker.env file you can copy.

Using the `dr` script enables you to automatically download the docker image from Microchip Artifactory:
https://artifacts.microchip.com/ui/repos/tree/Properties/docker%2Fmicrochip%2Fung%2Fbsp%2Fbsp-buildenv

## Helper scripts

There are several helper scripts to build, pull, push and run this image.

The scrip names should be self-explanatory.

The name and tag used enables you to 

## TODO

* Reduce the size of the image for faster download
* Test with standard buildroot
* Test with Jenkins
* Find a better way to use `sudo` inside the container when running as an ordinary user
* Maybe use `bundler` instead of `gem install`

