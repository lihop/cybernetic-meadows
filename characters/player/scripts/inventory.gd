extends Node
class_name Inventory


# Emitted when an inventory slot is updated. For example, the amount changed
# or a new item was added.
signal slot_updated(slot_number)
# Emitted when the inventory itself was updated. For example after a resort.
signal inventory_updated()

export(int) var num_slots := 80

var slots := []


func _ready():
	slots.resize(num_slots)
	for i in range(num_slots):
		slots[i] = InventorySlot.new()
		slots[i].number = i
	emit_signal("inventory_updated")


func add(type: String, amount: int):
	print('adding %d of %s' % [amount, type])
	
	# Find the either the next slot containing type that hasn't reached the 
	# types stack limit or the next empty slot.
	for slot in slots:
		if slot.type == type:
			slot.amount += amount
			emit_signal("slot_updated", slot.number)
			return
	
	for slot in slots:
		if slot.amount == 0:
			slot.type = type
			slot.amount = amount
			emit_signal("slot_updated", slot.number)
			return


class InventorySlot:
	extends Node
	
	var number: int
	var type: String
	var amount := 0
	var icon = null
