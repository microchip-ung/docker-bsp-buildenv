FROM ubuntu:18.04


RUN apt-get update && apt-get install -y build-essential git ruby ruby-nokogiri gettext file wget cpio bc libncurses5-dev libncursesw5-dev genext2fs mtd-utils squashfs-tools u-boot-tools util-linux patchelf bison cmake flex gettext m4 xz-utils vim rsync python3 libssl-dev
RUN git config --global user.email "you@example.com" && git config --global user.name "Your Name"
RUN  mkdir -p /opt/mscc/ && mkdir -p /usr/local/bin
COPY ./mscc-install-pkg /usr/local/bin/
RUN /usr/local/bin/mscc-install-pkg -t toolchains/2020.02.3-083-toolchain mscc-toolchain-bin-2020.02.3-083
RUN /usr/local/bin/mscc-install-pkg -t toolchains/2020.02.3-085-toolchain mscc-toolchain-bin-2020.02.3-085

WORKDIR /src
ENV FORCE_UNSAFE_CONFIGURE=1

#FROM alpine:3.13
#
#RUN apk update && apk add --virtual build-dependencies build-base gcc wget git ruby ruby-json vim gettext bash perl rsync cpio tar findutils linux-headers
#RUN git config --global user.email "you@example.com" && git config --global user.name "Your Name"
