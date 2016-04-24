FROM debian:sid

RUN apt-get update
RUn DEBIAN_FRONTEND=noninteractive \
      apt-get install -y --no-install-recommends \
        firefox   \
        xvfb      \
        ratpoison \
        x11vnc

RUN useradd -u 1000 -d /browser browser

ADD system /browser/system
RUN chmod 755 /browser/system
RUN chown -R browser: /browser

USER browser
