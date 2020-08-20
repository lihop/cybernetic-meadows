extends ItemGrid
# An ItemGrid for displaying and crafiting craftable items.


onready var UI = $"/root/World/UI"

var inventory: Inventory setget set_inventory


func set_inventory(new_inventory: Inventory) -> void:
	inventory = new_inventory
	
	clear_grid()
	
	for i in range(inventory.slots.size()):
		var ui_slot = SlotScene.instance()
		ui_slot.slot = inventory.slots[i]
		grid.add_child(ui_slot)
