FROM ubuntu
MAINTAINER liuzheng712@gmail.com

ENV DEBIAN_FRONTEND=noninteractive

RUN set -xe \
    && apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl \
    xvfb x11vnc xterm \
    sudo \
    supervisor \
    awesome \
    openjdk-8-jre-headless ca-certificates-java libnss3 libnspr4 java-common liblcms2-2 libcups2 libpcsclite1 libxi6 libswt-gtk-4-java\
    gnupg && \
    curl -o  dbeaver.deb  https://dbeaver.io/files/6.1.3/dbeaver-ce_6.1.3_amd64.deb && \
    dpkg -i dbeaver.deb && \
    rm -fr dbeaver.deb && \
    rm -rf /var/lib/apt/lists/*

RUN set -xe \
    && useradd -u 1000 -g 100 -G sudo --shell /bin/bash --no-create-home --home-dir /tmp user \
    && echo 'ALL ALL = (ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

COPY supervisord.conf /etc/
COPY entry.sh /

User user
WORKDIR /tmp

CMD ["/entry.sh"]
