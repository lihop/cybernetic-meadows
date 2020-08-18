extends ItemGrid
# An ItemGrid for displaying and crafiting craftable items.


var inventory: Inventory setget set_inventory


func set_inventory(new_inventory: Inventory) -> void:
	inventory = new_inventory
	
	clear_grid()
	
	for i in range(inventory.slots.size()):
		var ui_slot = SlotScene.instance()
		ui_slot.slot = inventory.slots[i]
		ui_slot.connect("pressed", self, "_on_slot_pressed", [i])
		grid.add_child(ui_slot)


func _on_slot_pressed(slot_index: int) -> void:
	if not inventory.equipped_item:
		inventory.equip_slot(slot_index)
	elif inventory.equipped_item.slot == inventory.slots[slot_index]:
		inventory.unequip_slot()
	else:
		inventory.unequip_slot()
		# TODO: Swap slots.
