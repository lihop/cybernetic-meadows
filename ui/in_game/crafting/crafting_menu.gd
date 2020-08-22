extends ItemGrid
# An item grid for displaying and crafiting craftable items.


# Inventory in to which crafted items will be placed.
var inventory: Inventory setget set_inventory


func set_inventory(new_inventory: Inventory):
	inventory = new_inventory
	inventory.connect("inventory_updated", self, "_update")
	_update()


func clear_grid():
	# We need to override the parent clear_grid() function otherwise we get
	# an error about trying to free() a locked Object.
	# TODO: Fix this properly by changing the way the CraftingGrid is updated.
	for child in grid.get_children():
		child.queue_free()


func _update():
	clear_grid()
	
	# Ensure the grid is always full width even if we have fewer craftables than
	# would fill an entire row.
#	for i in range(max(grid.columns, Crafting.craftables.size())):
#		var craftable = Crafting.craftables[i] if i < Crafting.craftables.size() else null
#		var slot = SlotScene.instance()
#
#		if craftable and craftable.recipe.enabled:
#			slot.slot = craftable
#			slot.get_node("Icon").texture = craftable.icon
#			slot.disabled = not Crafting.can_craft(craftable, inventory)
#			slot.connect("pressed", self, "_on_slot_pressed", [craftable])
#		else:
#			slot.get_node("Icon").texture = null
#			slot.disabled = true
#			slot.texture_normal = null
		
#		grid.add_child(slot)


func _on_slot_pressed(item: Item):
	Crafting.craft(item, inventory)
