import json
import os

from stl import mesh

# Directory containing the .stl files
folder = "animals/"
output_file = "animals_center_of_gravity.json"

# Dictionary to store the results
results = []

# Iterate over all .stl files in the folder
for file in sorted(os.listdir(folder)):
    if file.endswith(".stl"):
        print(f"Processing {file}...")
        file_path = os.path.join(folder, file)
        your_mesh = mesh.Mesh.from_file(file_path)

        _, cog, _ = your_mesh.get_mass_properties()
        results.append({
            "filename": file_path,  # filename
            "center_of_gravity": cog.tolist(),  # center of gravity
            "scale": 15,  # scale percent
            "rotation": [0, 0, 0]  # rotation
        })

# Write the results to a JSON file
with open(output_file, "w") as f:
    json.dump(results, f, indent=2)
