FROM ubuntu:20.04

# Suppress time zone questions during build
ENV TZ=Europe/Copenhagen

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  && echo $TZ > /etc/timezone \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
# Packages sorted alphabetically
    bc \
    build-essential \
    cmake \
    cpio \
    file \
    gettext-base \
    git \
    help2man \
    iproute2 \
    iputils-ping \
    libacl1-dev \
    libncurses5 \
    libncurses5-dev \
    python3 \
    rsync \
    ruby-full \
    sudo \
    texinfo \
    wget \
  && rm -rf /var/lib/apt/lists/* \
# git needs a user
  && git config --system user.email "br@example.com" && git config --system user.name "Build Root" \
# TBD Use bundler instead?
  && gem install nokogiri asciidoctor

COPY ./mscc-install-pkg /usr/local/bin

COPY ./make-users /tmp
RUN /tmp/make-users
