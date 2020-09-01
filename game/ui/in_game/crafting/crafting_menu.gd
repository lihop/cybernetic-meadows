extends ItemGrid
# An item grid for displaying and crafiting craftable items.


# Inventory in to which crafted items will be placed.
var inventory: Inventory setget set_inventory


func set_inventory(new_inventory: Inventory):
	inventory = new_inventory
	inventory.connect("inventory_updated", self, "_update")
	$Crafting.input_inventory = new_inventory
	$Crafting.output_inventory = new_inventory
	_update()


func clear_grid():
	# We need to override the parent clear_grid() function otherwise we get
	# an error about trying to free() a locked Object.
	# TODO: Fix this properly by changing the way the CraftingGrid is updated.
	for child in grid.get_children():
		child.queue_free()


func _update():
	clear_grid()
	
	# The player can only make crafting recipes. Other recipes will probably
	# require some machine like a furnace for smelting or assembling machine
	# for complex components.
	var recipes := Data.recipe.find({"method": Recipe.METHOD_CRAFTING}).recipes
	
	# Ensure the grid is always full width even if we have fewer craftables than
	# would fill an entire row.
	for i in range(max(grid.columns, recipes.size())):
		var recipe = recipes[i] if i < recipes.size() else null
		var slot = SlotScene.instance()

		if recipe is Recipe and recipe.enabled:
			slot.slot = recipe
			# By default we use the icon of the first product for the recipe's icon.
			slot.get_node("Icon").texture = recipe.icon
			slot.disabled = not $Crafting.can_craft(recipe)
			slot.connect("pressed", self, "_on_slot_pressed", [recipe])
		else:
			slot.get_node("Icon").texture = null
			slot.disabled = true
			slot.texture_normal = null
		
		grid.add_child(slot)


func _on_slot_pressed(recipe: Recipe):
	if $Crafting.can_craft(recipe):
		$Crafting.recipe = recipe
		$Crafting.on = true


func _on_Crafting_output_transferred():
	$Crafting.recipe = null
	$Crafting.on = false
