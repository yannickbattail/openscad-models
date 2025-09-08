#!/bin/bash

DEBUG=" --progress=plain "
#DEBUG=" --progress=plain --no-cache "
## for debugging
docker build $DEBUG --build-arg "F3D_URL=https://github.com/f3d-app/f3d/releases/download/v2.4.0/F3D-2.4.0-Linux-x86_64-headless.deb" -t openscad-tools  .
