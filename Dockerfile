FROM ubuntu:20.04

# Suppress time zone questions during build
ENV TZ=Europe/Copenhagen

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  && echo $TZ > /etc/timezone \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
# Packages sorted alphabetically
    asciidoc \
    bc \
    build-essential \
    cmake \
    cpio \
    dblatex \
    file \
    gettext-base \
    git \
    graphviz \
    help2man \
    iproute2 \
    iputils-ping \
    libacl1-dev \
    libglade2-0 \
    libgtk2.0-0 \
    libncurses5 \
    libncurses5-dev \
    python3 \
    python3-pip \
    qt5-default \
    rsync \
    ruby-full \
    sudo \
    texinfo \
    tree \
    w3m \
    wget \
# Cleanup
  && rm -rf /var/lib/apt/lists/* \
# git needs a user
  && git config --system user.email "br@example.com" && git config --system user.name "Build Root" \
# TBD Use bundler instead?
  && gem install nokogiri asciidoctor \
# Enable use of python command
  && update-alternatives --install /usr/bin/python python /usr/bin/python3 100 \
# Install python-matplotlib
  && python -m pip install matplotlib

# buildroot-layer needs this for installing missing toolchains
COPY ./mscc-install-pkg /usr/local/bin

# A common entrypoint for setting up things before running the user command(s)
COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
