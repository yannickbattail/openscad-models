#!/bin/bash

## for debugging
DEBUG=" --progress=plain "
#DEBUG=" --progress=plain --no-cache "

docker build \
  --build-arg "F3D_URL=https://github.com/f3d-app/f3d/releases/download/v3.0.0/F3D-3.0.0-Linux-x86_64.deb" \
  --build-arg "SCADFORMAT_URL=https://github.com/hugheaves/scadformat/releases/download/v0.7/linux.zip" \
  $DEBUG -t openscad-nightly-tools .
