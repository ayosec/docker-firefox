FROM debian:sid

RUN apt-get update
RUn DEBIAN_FRONTEND=noninteractive \
      apt-get install -y --no-install-recommends \
        firefox    \
        xvfb       \
        ratpoison  \
        x11vnc     \
        ffmpeg     \
        pulseaudio \
        xsel

RUN useradd -u 1000 -d /browser browser

ADD system /browser/system
RUN chmod 755 /browser/system
RUN chown -R browser: /browser

ADD local-run.sh /tmp/
RUN sh /tmp/local-run.sh

RUN apt-get install -y fonts-dejavu fonts-dejavu-core fonts-dejavu-extra

ADD prefs.js /etc/firefox-esr/sane.js
ADD prefs.js /etc/firefox/sane.js

USER browser
