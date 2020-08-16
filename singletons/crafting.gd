extends Node


onready var craftables := _gather_craftable_resources("res://")


func _ready():
	# Loop through the custom resources in things and find every resource
	# that has a recipe. A thing is craftable if it has a recipe. A thing is
	# craftable by the player if they have unlocked the technology to craft it
	# and they have the materials to craft it.
	for craftable in craftables:
		var recipe: Recipe = craftable.recipe
		# For now, unlock all crafting recipes.
		recipe.enabled = true


func _gather_craftable_resources(path: String) -> Array:
	var result := []
	var dir := Directory.new()
	
	if dir.open(path) == OK:
		dir.list_dir_begin()
	
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir() and file_name != "." and file_name != "..":
				var subdir_path = "%s/%s" % [dir.get_current_dir(), file_name]
				result += _gather_craftable_resources(subdir_path)
			if file_name.ends_with(".res") or file_name.ends_with(".tres"):
				var resource = load("%s/%s" % [dir.get_current_dir(), file_name])
				if "recipe" in resource and resource.recipe is Recipe:
					result.append(resource)
			file_name = dir.get_next()
		
		dir.list_dir_end()
	return result


# Given a craftable item and an inventory, returns if there is any possible way
# to craft craftable including crafting it's dependencies.
func can_craft(craftable: Item, inventory: Inventory) -> bool:
	for ingredient in craftable.recipe.ingredients:
		if not inventory.has_item(ingredient.item, ingredient.quantity):
			return false
	return true


# Craft craftable using components in inventory and add it to inventory.
func craft(craftable: Item, inventory: Inventory) -> void:
	if not can_craft(craftable, inventory):
		return
	
	for ingredient in craftable.recipe.ingredients:
		inventory.remove_item(ingredient.item, ingredient.quantity)
		yield(get_tree().create_timer(craftable.recipe.energy_required), "timeout")
		inventory.add_item(craftable)
