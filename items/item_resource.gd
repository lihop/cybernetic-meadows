extends Resource
class_name Item


export(String) var display_name
export(String) var name
export(Texture) var icon
export(Resource) var recipe
export(String, FILE) var scene_path
export(bool) var placeable := true

# Amount of energy contained in the item in MJ.
export(float) var energy := 0.0
