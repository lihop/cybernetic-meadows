extends Reference
class_name RecipeData


var recipes := []


func find(query: Dictionary) -> RecipeData:
	var result: RecipeData = get_script().new()
	result.recipes = recipes.duplicate()
	if query.has("method"):
		result.recipes = filter(result.recipes, "method", query.method)
	return result


func filter(array: Array, key: String, value) -> Array:
	var filtered := []
	for element in array:
		if element[key] == value:
			filtered.append(element)
	return filtered
