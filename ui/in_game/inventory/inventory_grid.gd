extends ItemGrid
# An ItemGrid for displaying and crafiting craftable items.


onready var UI = $"/root/World/UI"

var inventory: Inventory setget set_inventory


func set_inventory(new_inventory: Inventory) -> void:
	inventory = new_inventory
	
	clear_grid()
	
	for i in range(inventory.get_child_count()):
		var ui_slot = SlotScene.instance()
		ui_slot.slot = inventory.get_child(i)
		grid.add_child(ui_slot)
