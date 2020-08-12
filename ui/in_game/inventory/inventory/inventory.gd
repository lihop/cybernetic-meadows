extends VBoxContainer


const InventorySlot: PackedScene = preload("./inventory_slot.tscn")

var inventory := Inventory.new() setget _set_inventory


func _set_inventory(new_inventory: Inventory):
	inventory = new_inventory
	inventory.connect("inventory_updated", self, "_refresh")
	inventory.connect("slot_updated", self, "_update_slot")


# Refresh the entire inventory by deleting and re-adding every slot. Useful
# after a major change to the inventory.
func _refresh():
	for slot in $GridContainer.get_children():
		slot.queue_free()
	
	for slot in inventory.slots:
		$GridContainer.add_child(InventorySlot.instance())
	
	for i in range(inventory.slots.size()):
		var ui_slot = $GridContainer.get_child(i)
		ui_slot.amount = inventory.slots[i].amount


func _update_slot(slot_number: int):
	var ui_slot = $GridContainer.get_child(slot_number)
	var slot = inventory.slots[slot_number]
	
	ui_slot.amount = slot.amount
	ui_slot.icon = slot.icon
