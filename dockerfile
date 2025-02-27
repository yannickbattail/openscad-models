FROM openscad/openscad:dev

ARG F3D_URL="https://github.com/f3d-app/f3d/releases/download/v2.5.0/F3D-2.5.0-Linux-x86_64-headless.deb"
ARG SCADFORMAT_URL="https://github.com/hugheaves/scadformat/releases/download/v0.6/linux.zip"

RUN echo F3D_URL="${F3D_URL}" SCADFORMAT_URL="${SCADFORMAT_URL}"
# install tools
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        ca-certificates \
        jq \
        imagemagick \
        webp \
        xvfb \
        zip \
        unzip

# install f3d last releases
RUN curl -L -o /tmp/f3d.deb "${F3D_URL}" \
    && apt-get install -y --no-install-recommends /tmp/f3d.deb \
    && f3d --version \
    && rm -rf /var/lib/apt/lists/* /tmp/f3d.deb

# install f3d last releases
RUN curl -L -o /tmp/scadformat.zip "${SCADFORMAT_URL}" \
    && cd /tmp/ \
    && unzip scadformat.zip \
    && mv scadformat /bin/

# install generate_profile.sh
COPY --chmod=755 ./openscad_batch/generate_profile.sh ./openscad_batch/one_file.sh ./openscad_batch/generate_for_thingiverse.sh /bin/

RUN groupadd -g 1000 openscad \
    && useradd -m -u 1000 -g 1000 -d /home/openscad -s /bin/bash openscad \
    && mkdir /home/openscad/.config/ \
    && chown -R 1000:1000 /home/openscad/.config/ /openscad
COPY --chmod=755 --chown=1000:1000 ./openscad_batch/generate_profile.for_docker.conf /home/openscad/.config/generate_profile.conf
COPY --chmod=755 --chown=1000:1000 ./openscad_batch/generate_profile.for_docker.conf /home/ubuntu/.config/generate_profile.conf
COPY --chmod=755 ./openscad_batch/generate_profile.for_docker.conf /.config/generate_profile.conf

USER 1000:1000
WORKDIR /openscad
VOLUME /openscad
