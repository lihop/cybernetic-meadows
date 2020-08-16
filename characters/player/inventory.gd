extends Node


# Emitted when an inventory slot is updated. For example, the amount changed
# or a new item was added.
signal slot_updated(slot_number)
# Emitted when the inventory itself was updated. For example after a resort.
signal inventory_updated()
signal changed()

export(int) var num_slots := 80

var slots := []


func _ready():
	slots.resize(num_slots)
	for i in range(num_slots):
		slots[i] = load("res://ui/in_game/inventory/inventory/inventory_slot.tscn").instance()
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
	
	print('emitting signal changed!')
	emit_signal("changed")


func add_item(item: Item, amount: int = 1):
	for slot in slots:
		if slot.item and slot.item.get_class() == item.get_class():
			slot.amount += amount
			emit_signal("slot_updated", slot.number)
			return
	
	for slot in slots:
		if slot.amount == 0:
			slot.item = item
			slot.amount = amount
			emit_signal("slot_updated", slot.number)
			return
