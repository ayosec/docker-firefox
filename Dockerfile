FROM debian:bullseye

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
      apt-get install              \
        -y                         \
        --no-install-recommends    \
        bzip2                      \
        ca-certificates            \
        curl                       \
        ffmpeg                     \
        fonts-dejavu               \
        fonts-dejavu-core          \
        fonts-dejavu-extra         \
        fonts-hanazono             \
        iproute2                   \
        libarchive-tools           \
        libdbus-glib-1-2           \
        libegl1                    \
        libgtk-3-0                 \
        libpci3                    \
        libx11-xcb1                \
        patch                      \
        pulseaudio                 \
        ratpoison                  \
        tigervnc-standalone-server \
        ttf-unifont                \
        x11vnc                     \
        xclip                      \
        xfonts-unifont             \
        xsel                       \
        xvfb                       \
        zip

ARG UID=1000
ARG VERSION=110.0

RUN curl https://download-installer.cdn.mozilla.net/pub/firefox/releases/$VERSION/linux-x86_64/en-US/firefox-$VERSION.tar.bz2 | \
      tar -C /opt/ -xj

#ADD policies.json /opt/firefox/distribution/policies.json
ADD prefs.js /opt/firefox/browser/defaults/preferences/all-x.js

ADD system /usr/local/bin/browsersystem
ADD run-firefox /usr/local/bin/firefox

ADD patches /opt/firefox-patches
RUN /opt/firefox-patches/apply.sh /opt/firefox

# Use black-and-white emojis
RUN \
  cd /opt/firefox/fonts && \
  rm TwemojiMozilla.ttf && \
  curl 'https://fonts.google.com/download?family=Noto%20Emoji' | bsdtar -xf - --strip-components=1

ADD policies.json /opt/firefox/distribution/policies.json

RUN useradd -u $UID -d /browser browser
USER browser
