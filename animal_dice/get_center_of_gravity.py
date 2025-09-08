import json
import os

from stl import mesh

# Directory containing the .stl files
folder = "animals/"
output_file = "animals_center_of_gravity.json"
preset_file = "dice_animal.json"

# Dictionary to store the results
results = []
parameterSet = {
 "fileFormatVersion": "1",
 "parameterSets": {}
}
parts = ""

i = 0
# Iterate over all .stl files in the folder
for file in sorted(os.listdir(folder)):
    if file.endswith(".stl"):
        print(f"Processing {file}...")
        file_path = os.path.join(folder, file)
        your_mesh = mesh.Mesh.from_file(file_path)
        fileWithoutExt = file.replace(".stl", "")

        _, cog, _ = your_mesh.get_mass_properties()
        results.append({
            "filename": file_path,  # filename
            "center_of_gravity": cog.tolist(),  # center of gravity
            "scale": 15,  # scale percent
            "rotation": [0, 0, 0]  # rotation
        })
        parameterSet["parameterSets"][fileWithoutExt] = {
            "animalNumber": str(i),
            "part": "model"
        }
        parameterSet["parameterSets"]["wholeDice_"+fileWithoutExt] = {
            "animalNumber": str(i),
            "part": "whole"
        }
        parts += str(i) + ":" + fileWithoutExt + ", "
        i += 1

# Write the results to a JSON file
with open(output_file, "w") as f:
    json.dump(results, f, indent=2)

parameterSet["parameterSets"]["fixation"] = {
  "part": "fixation"
}
parameterSet["parameterSets"]["all_edges"] = {
  "part": "all_edges"
}

parameterSet["parameterSets"]["edge1_2"] = {
  "part": "edge1_2"
}
parameterSet["parameterSets"]["edge1_3"] = {
  "part": "edge1_3"
}
parameterSet["parameterSets"]["edge1_4"] = {
  "part": "edge1_4"
}
parameterSet["parameterSets"]["edge1_5"] = {
  "part": "edge1_5"
}
parameterSet["parameterSets"]["edge6_2"] = {
  "part": "edge6_2"
}
parameterSet["parameterSets"]["edge6_3"] = {
  "part": "edge6_3"
}
parameterSet["parameterSets"]["edge6_4"] = {
  "part": "edge6_4"
}
parameterSet["parameterSets"]["edge6_5"] = {
  "part": "edge6_5"
}
parameterSet["parameterSets"]["edge2_3"] = {
  "part": "edge2_3"
}
parameterSet["parameterSets"]["edge2_4"] = {
  "part": "edge2_4"
}
parameterSet["parameterSets"]["edge3_5"] = {
  "part": "edge3_5"
}
parameterSet["parameterSets"]["edge4_5"] = {
  "part": "edge4_5"
}

# Write the parameterSet file
with open(preset_file, "w") as f:
    json.dump(parameterSet, f, indent=2)

print("add to your file:")
print("animalNumber = 0; // [" + parts + "]")
