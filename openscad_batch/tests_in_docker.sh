#!/bin/bash

docker run -it -v ./:/work openscad-tools bash -c "./tests/tests.sh"
