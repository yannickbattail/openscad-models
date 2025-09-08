#!/bin/bash

time ../generate_profile.sh ./test_time_steps.scad
cp ./test_time_steps/gif/logo_animation.gif ./
cp ./test_time_steps/webp/logo_animation.webp ./
cp ./test_time_steps/images/graph.png ./
