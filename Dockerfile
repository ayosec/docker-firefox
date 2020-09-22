FROM debian:buster

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
        libdbus-glib-1-2           \
        libgtk-3-0                 \
        libx11-xcb1                \
        pulseaudio                 \
        ratpoison                  \
        tigervnc-standalone-server \
        x11vnc                     \
        xvfb                       \
        xclip                      \
        xsel                       \
        wl-clipboard

ARG UID=1000
ARG VERSION=81.0

RUN curl https://download-installer.cdn.mozilla.net/pub/firefox/releases/$VERSION/linux-x86_64/en-US/firefox-$VERSION.tar.bz2 | \
      tar -C /opt/ -xj

ADD policies.json /opt/firefox/distribution/policies.json
ADD system /usr/local/bin/browsersystem

RUN useradd -u $UID -d /browser browser

ADD prefs.js /opt/firefox/browser/defaults/preferences/all-x.js

ADD run-firefox /usr/local/bin/firefox

USER browser
