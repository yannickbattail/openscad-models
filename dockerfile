FROM ubuntu:24.04

ARG F3D_URL
ARG SCADFORMAT_URL

# install tools
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates jq imagemagick webp xvfb zip unzip

# install openscad-nightly
RUN curl -L -o /etc/apt/trusted.gpg.d/obs-openscad-nightly.asc https://files.openscad.org/OBS-Repository-Key.pub \
    && echo 'deb https://download.opensuse.org/repositories/home:/t-paul/xUbuntu_24.04/ ./' >  /etc/apt/sources.list.d/openscad.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends openscad-nightly openscad-mcad \
    && openscad-nightly --version

# install f3d last releases
RUN curl -L -o /tmp/f3d.deb $F3D_URL \
    && apt-get install -y --no-install-recommends /tmp/f3d.deb \
    && f3d --version \
    && rm -rf /var/lib/apt/lists/* /tmp/f3d.deb

# install f3d last releases
RUN curl -L -o /tmp/scadformat.zip $SCADFORMAT_URL \
    && cd /tmp/ \
    && unzip scadformat.zip \
    && mv scadformat /bin/

# install generate_profile.sh
COPY --chmod=755 ./openscad_batch/generate_profile.sh ./openscad_batch/one_file.sh /openscad_batch/generate_for_thingiverse.sh /bin/

RUN mkdir /home/ubuntu/.config/ /work && chown -R 1000:1000 /home/ubuntu/.config/ /work
COPY --chmod=755 --chown=1000:1000 ./openscad_batch/generate_profile.for_docker.conf /home/ubuntu/.config/generate_profile.conf

USER 1000:1000
WORKDIR /work
VOLUME /work
