import sys

from stl import mesh

# Using an existing closed stl file:
your_mesh = mesh.Mesh.from_file(sys.argv[1])

volume, cog, inertia = your_mesh.get_mass_properties()
print("Volume                            = {0}".format(volume))
print("Position of the center of gravity = {0}".format(cog))
