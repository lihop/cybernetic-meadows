extends VBoxContainer
class_name Inventory


const InventorySlot: PackedScene = preload("./inventory_slot.tscn")

# Emitted when an inventory slot is updated. For example, the amount changed
# or a new item was added.
signal slot_updated(slot_number)
# Emitted when the inventory itself was updated. For example after a resort.
signal inventory_updated()

export(int) var num_slots := 80


func _ready():
	for i in range(num_slots):
		var slot = InventorySlot.instance()
		$GridContainer.add_child(InventorySlot.instance())
		$GridContainer.get_child(i).number = i
	connect("inventory_updated", self, "_refresh")
	connect("slot_updated", self, "_update_slot")
	emit_signal("inventory_updated")


func add_item(item: Item, amount: int = 1):
	for slot in $GridContainer.get_children():
		if slot.item and slot.item.get_class() == item.get_class():
			slot.amount += amount
			emit_signal("slot_updated", slot.number)
			return
	
	for slot in $GridContainer.get_children():
		if slot.amount == 0:
			slot.item = item
			slot.amount = amount
			emit_signal("slot_updated", slot.number)
			return
