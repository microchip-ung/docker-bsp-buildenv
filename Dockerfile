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
    autoconf \
    bc \
    bison \
    build-essential \
    ccache \
    cmake \
    cmake-curses-gui \
    cpio \
    dblatex \
    default-jre \
    doxygen \
    file \
    flex \
    gdisk \
    genext2fs \
    gettext-base \
    git \
    graphviz \
    gzip \
    help2man \
    iproute2 \
    iputils-ping \
    libacl1-dev \
    libelf-dev \
    libglade2-0 \
    libgtk2.0-0 \
    libmpc-dev \
    libncurses5 \
    libncurses5-dev \
    libncursesw5-dev \
    libssl-dev \
    libtool \
    locales \
    m4 \
    mtd-utils \
    parted \
    patchelf \
    python3 \
    python3-pip \
    qt5-default \
    rsync \
    ruby-full \
    ruby-parslet \
    squashfs-tools \
    sudo \
    texinfo \
    tree \
    u-boot-tools \
    udev \
    util-linux \
    vim \
    w3m \
    wget \
    xz-utils \
# Cleanup
  && rm -rf /var/lib/apt/lists/* \
# Generate en_US.UTF-8 locale
  && locale-gen en_US.UTF-8 \
# Update locate to en_US.UTF-8
  && update-locale LANG=en_US.UTF-8 LANGUAGE=en \
# git needs a user
  && git config --system user.email "br@example.com" && git config --system user.name "Build Root" \
# TBD Use bundler instead?
  && gem install nokogiri asciidoctor slop minitar optimist \
# Enable use of python command
  && update-alternatives --install /usr/bin/python python /usr/bin/python3 100 \
# Install python-matplotlib
  && python -m pip install matplotlib \
# Support Microsemi version
  && ln -s /usr/local/bin/mchp-install-pkg /usr/local/bin/mscc-install-pkg

# Set locale
ENV LANG='en_US.UTF-8' LC_ALL='en_US.UTF-8'

# buildroot-layer needs this for installing missing toolchains
COPY ./mchp-install-pkg /usr/local/bin

# Add simple grid client as this is needed to dispatch sub-jobs in the internal
# mchp building environment
COPY ./SimpleGridClient /usr/local/bin

RUN git clone https://github.com/matthiasmiller/javascriptlint.git /tmp/jsl
RUN cd /tmp/jsl; git checkout 5a245b453d68228878d6c283e12ef35327c45279; cd ./src; make -f Makefile.ref; cp ./Linux_All_DBG.OBJ/jsl /usr/local/bin/

# A common entrypoint for setting up things before running the user command(s)
COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
