extends Node


const DATA_PATH = "res://"

var items := []
var recipe := RecipeData.new()
var natural_resources := []


func _ready():
	_load_data(DATA_PATH)


func _load_data(path: String) -> void:
	var dir := Directory.new()
	
	if dir.open(path) == OK:
		dir.list_dir_begin()
	
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir() and file_name != "." and file_name != "..":
				var subdir_path = "%s/%s" % [dir.get_current_dir(), file_name]
				_load_data(subdir_path)
			if file_name.ends_with("recipe.res") or file_name.ends_with("recipe.tres"):
				var data = load("%s/%s" % [dir.get_current_dir(), file_name])
				if data is Recipe:
					# Remove unused ingredient and output slots.
					for i in range(data.ingredients.size() - 1, 0):
						if data.ingredients[i] == null:
							data.ingredients.remove(i)
						if data.outputs[i] == null:
							data.outputs.remove(i)
					recipe.recipes.append(data)
				elif data is NaturalResource:
					natural_resources.append(data)
			file_name = dir.get_next()
		
		dir.list_dir_end()
