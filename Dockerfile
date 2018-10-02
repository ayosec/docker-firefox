FROM debian:sid

ARG UID=1000
ARG VERSION=62.0.3

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
      apt-get install -y --no-install-recommends \
        bzip2              \
        ca-certificates    \
        curl               \
        ffmpeg             \
        fonts-dejavu       \
        fonts-dejavu-core  \
        fonts-dejavu-extra \
        libdbus-glib-1-2   \
        libgtk-3-0         \
        libx11-xcb1        \
        pulseaudio         \
        ratpoison          \
        x11vnc             \
        xvfb               \
        xsel


RUN curl https://download-installer.cdn.mozilla.net/pub/firefox/releases/$VERSION/linux-x86_64/en-US/firefox-$VERSION.tar.bz2 | \
      tar -C /opt/ -xj

RUN useradd -u $UID -d /browser browser

ADD system /browser/system
RUN chmod 755 /browser/system
RUN chown -R browser: /browser

ADD local-run.sh /tmp/
RUN sh /tmp/local-run.sh

# ADD prefs.js /etc/firefox-esr/sane.js
ADD prefs.js /etc/firefox/sane.js

USER browser
