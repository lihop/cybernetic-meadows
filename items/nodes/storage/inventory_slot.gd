extends Node
class_name InventorySlot
# TODO: Needs clean up


# Emitted when the item held by this slot changed.
signal item_changed(new_item)
# Emitted when the amount of the item held by this slot changed.
signal amount_changed(new_amount)
signal equipped()
signal unequipped()
# Emitted when the amount of item in the slot reaches 0.
signal emptied()


var item: Item = null setget set_item
var amount := 0 setget set_amount
var equipped := false setget set_equipped
# The inventory to which this slot belongs.
var inventory
var index: int


func _init(inventory, index: int):
	self.inventory = inventory
	self.index = index


func set_equipped(is_equipped: bool) -> void:
	if equipped != is_equipped:
		equipped = is_equipped
		emit_signal("equipped") if equipped else emit_signal("unequipped")


func set_item(new_item: Item) -> void:
	if item != new_item:
		item = new_item
		emit_signal("item_changed", new_item)
		inventory.emit_signal("slot_updated", index)

func set_amount(new_amount: int) -> void:
	if amount != new_amount:
		amount = new_amount
		emit_signal("amount_changed", new_amount)
		inventory.emit_signal("slot_updated", index)
		if amount <= 0:
			self.item = null
			emit_signal("emptied")


func empty():
	return amount <= 0 or item == null
