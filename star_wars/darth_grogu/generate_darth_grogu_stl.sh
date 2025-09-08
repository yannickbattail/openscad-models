#!/bin/bash

stl_dir=darth_grogu_stl

mkdir -p $stl_dir


echo generating darth_grogu.stl ...
openscad -q -o ./$stl_dir/darth_grogu.stl ./darth_grogu.scad

echo generating darth_grogu.png ...
openscad -q -o ./$stl_dir/darth_grogu.png ./darth_grogu.scad
