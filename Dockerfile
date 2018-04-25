FROM archlinux/base

# Setup a build user and installs initial dependencies
RUN pacman -Sy --needed --noconfirm \
    binutils \
    clang \
    fakeroot \
    file \
    git \
    grep \
    make \
    pkg-config \
    sudo \
    wget \
    && \
    useradd -m -s /bin/bash -d /build builder && \
    echo 'builder ALL=NOPASSWD: ALL' >> /etc/sudoers

# Switch user
USER builder
WORKDIR /build

# Install nlohmann-json JSON library - auracle dependency
RUN mkdir nlohmann-json && \
    cd nlohmann-json && \
    wget 'https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=nlohmann-json' \
         -O PKGBUILD && \
    makepkg -sic --noconfirm

# Install auracle
RUN mkdir auracle && \
    cd auracle && \
    wget 'https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=auracle-git' \
         -O PKGBUILD && \
    makepkg -sic --noconfirm

# Setup a build user
RUN sudo pacman -S --needed --noconfirm \
    gawk \
    patch \
    && echo

# Install nodenv-node-build
RUN auracle download nodenv-node-build && \
    cd nodenv-node-build && \
    makepkg -sic --noconfirm

# Install nodenv and various versions of Node.js
RUN auracle download nodenv && \
    cd nodenv && \
    makepkg -sic --noconfirm && \
    nodenv install 4.0.0 && \
    nodenv install 4.1.2 && \
    nodenv install 4.2.6 && \
    nodenv install 4.3.2 && \
    nodenv install 4.4.7 && \
    nodenv install 4.5.0 && \
    nodenv install 4.6.2 && \
    nodenv install 4.7.3 && \
    nodenv install 4.8.7 && \
    nodenv install 5.0.0 && \
    nodenv install 5.1.1 && \
    nodenv install 5.2.0 && \
    nodenv install 5.3.0 && \
    nodenv install 5.4.1 && \
    nodenv install 5.5.0 && \
    nodenv install 5.6.0 && \
    nodenv install 5.7.1 && \
    nodenv install 5.8.0 && \
    nodenv install 5.9.1 && \
    nodenv install 5.10.1 && \
    nodenv install 5.11.1 && \
    nodenv install 5.12.0 && \
    nodenv install 6.0.0 && \
    nodenv install 6.1.0 && \
    nodenv install 6.2.2 && \
    nodenv install 6.3.1 && \
    nodenv install 6.4.0 && \
    nodenv install 6.5.0 && \
    nodenv install 6.6.0 && \
    nodenv install 6.7.0 && \
    nodenv install 6.8.1 && \
    nodenv install 6.9.5 && \
    nodenv install 6.10.3 && \
    nodenv install 6.11.5 && \
    nodenv install 6.12.3 && \
    nodenv install 7.0.0 && \
    nodenv install 7.1.0 && \
    nodenv install 7.2.1 && \
    nodenv install 7.3.0 && \
    nodenv install 7.4.0 && \
    nodenv install 7.5.0 && \
    nodenv install 7.6.0 && \
    nodenv install 7.7.4 && \
    nodenv install 7.8.0 && \
    nodenv install 7.9.0 && \
    nodenv install 7.10.1 && \
    nodenv install 8.0.0 && \
    nodenv install 8.1.4 && \
    nodenv install 8.2.1 && \
    nodenv install 8.3.0 && \
    nodenv install 8.4.0 && \
    nodenv install 8.5.0 && \
    nodenv install 8.6.0 && \
    nodenv install 8.7.0 && \
    nodenv install 8.8.1 && \
    nodenv install 8.9.4 && \
    nodenv install 9.0.0 && \
    nodenv install 9.1.0 && \
    nodenv install 9.2.1 && \
    nodenv install 9.3.0 && \
    nodenv install 9.4.0

# Setup a build user
RUN sudo pacman -S --needed --noconfirm \
    openssl-1.0 \
    diffutils \
    && echo

ENV OPENSSL_1_0_INCLUDE -I/usr/include/openssl-1.0
ENV OPENSSL_1_0_LIB -L/usr/lib64/openssl-1.0

# Install pyenv
RUN auracle download pyenv && \
    cd pyenv && \
    makepkg -sic --noconfirm && \
    # These depend on an outdated readline library
    # pyenv install 2.1.3 && \
    # pyenv install 2.2.3 && \
    # pyenv install 2.3.7 && \
    BASECFLAGS=$OPENSSL_1_0_INCLUDE LDFLAGS=$OPENSSL_1_0_LIB pyenv install 2.4.6 && \
    BASECFLAGS=$OPENSSL_1_0_INCLUDE LDFLAGS=$OPENSSL_1_0_LIB pyenv install 2.5.6 && \
    BASECFLAGS=$OPENSSL_1_0_INCLUDE LDFLAGS=$OPENSSL_1_0_LIB pyenv install 2.6.9 && \
    BASECFLAGS=$OPENSSL_1_0_INCLUDE LDFLAGS=$OPENSSL_1_0_LIB pyenv install 2.7.14 && \
    BASECFLAGS=$OPENSSL_1_0_INCLUDE LDFLAGS=$OPENSSL_1_0_LIB pyenv install 3.0.1 && \
    BASECFLAGS=$OPENSSL_1_0_INCLUDE LDFLAGS=$OPENSSL_1_0_LIB pyenv install 3.1.5 && \
    BASECFLAGS=$OPENSSL_1_0_INCLUDE LDFLAGS=$OPENSSL_1_0_LIB pyenv install 3.2.6 && \
    # Fails due to reference of `ctx = SSL_CTX_new(SSLv3_method());'
    # It should be patched to `ctx = SSL_CTX_new(SSLv23_method());'
    # Check out https://gist.github.com/Lh4cKg/fc6f1b6d6e6d285f51d6
    # BASECFLAGS=$OPENSSL_1_0_INCLUDE LDFLAGS=$OPENSSL_1_0_LIB pyenv install 3.3.7 && \
    BASECFLAGS=$OPENSSL_1_0_INCLUDE LDFLAGS=$OPENSSL_1_0_LIB pyenv install 3.4.8 && \
    pyenv install 3.5.5 && \
    pyenv install 3.6.4


# Install lua-build
RUN git clone https://github.com/martinjlowm/lua-build.git && \
    rm -fr lua-build/.git && \
    sudo mkdir -p /opt/luaenv/plugins/ && \
    sudo mv lua-build /opt/luaenv/plugins/ && \
    sudo ln -s /opt/luaenv/plugins/lua-build/bin/lua-build /bin/lua-build && \
    sudo ln -s /opt/luaenv/plugins/lua-build/bin/luaenv-install /bin/luaenv-install && \
    sudo ln -s /opt/luaenv/plugins/lua-build/bin/luaenv-uninstall /bin/luaenv-uninstall

# Install luaenv
RUN git clone https://github.com/cehoffman/luaenv.git && \
    rm -fr luaenv/.git && \
    sudo mv luaenv/* /opt/luaenv/ && \
    sudo ln -s /opt/luaenv/libexec/luaenv /bin/luaenv && \
    luaenv install 5.0.3 && \
    luaenv install 5.1.5 && \
    luaenv install 5.2.4 && \
    luaenv install 5.3.3

ARG CACHE_DATE=2002-01-01
COPY docker-entrypoint.sh /usr/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD []
