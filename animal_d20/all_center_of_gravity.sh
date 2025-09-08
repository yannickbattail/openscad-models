#!/bin/bash

python3 -m venv venv
. ./venv/bin/activate
pip install numpy-stl

python3 get_center_of_gravity.py
