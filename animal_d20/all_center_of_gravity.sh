#!/bin/bash

python3 -m venv venv
. ./venv/bin/activate
pip install numpy-stl

for file in animals/*.stl; do
  echo "File $file"
  python get_center_of_gravity.py $file
done
