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
		ui_slot.connect("pressed", self, "_on_slot_pressed", [i])
		grid.add_child(ui_slot)


func _on_slot_pressed(slot_index: int) -> void:
	if not UI.equipped_item:
		inventory.equip_slot(slot_index)
	elif UI.equipped_item.slot == inventory.slots[slot_index]:
		inventory.unequip_slot()
	elif UI.equipped_item.slot.inventory == inventory:
		inventory.unequip_slot()
		# TODO: Swap slots.
	elif UI.equipped_item.slot.inventory != inventory:
		var equipped_slot = UI.equipped_item.slot
		var other_slot = inventory.slots[slot_index]
		
		if other_slot.empty():
			other_slot.item = equipped_slot.item
			other_slot.amount = equipped_slot.amount
			equipped_slot.amount = 0
			equipped_slot.inventory.unequip_slot()
