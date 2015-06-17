FROM debian:jessie
MAINTAINER Andrew Dunham <andrew@du.nham.ca>

# Install build tools
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -yy && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yy \
        automake            \
        build-essential     \
        curl                \
        file                \
        git                 \
        pkg-config          \
        python              \
        texinfo             \
        wget

# Install musl-cross
ENV MUSL_VERSION 1.1.10
RUN mkdir /build &&                                                 \
    cd /build &&                                                    \
    git clone https://github.com/GregorR/musl-cross.git &&          \
    cd musl-cross &&                                                \
    echo 'GCC_BUILTIN_PREREQS=yes' >> config.sh &&                  \
    sed -i -e "s/^MUSL_VERSION=.*\$/MUSL_VERSION=$MUSL_VERSION/" defs.sh &&  \
    ./build.sh

CMD /bin/bash
