extends Node
class_name InventorySlot
# TODO: Needs clean up


# Emitted when the item held by this slot changed.
signal item_changed(new_item)
# Emitted when the amount of the item held by this slot changed.
signal amount_changed(new_amount)
signal equipped()
signal unequipped()


var item: Item = null setget set_item
var amount := 0 setget set_amount
var equipped := false setget set_equipped
# The inventory to which this slot belongs.
var inventory


func _init(inventory):
	self.inventory = inventory


func set_equipped(is_equipped: bool) -> void:
	if equipped != is_equipped:
		equipped = is_equipped
		emit_signal("equipped") if equipped else emit_signal("unequipped")


func set_item(new_item: Item) -> void:
	if item != new_item:
		item = new_item
		emit_signal("item_changed", new_item)


func set_amount(new_amount: int) -> void:
	if amount != new_amount:
		amount = new_amount
		emit_signal("amount_changed", new_amount)
		if amount <= 0:
			self.item = null


func empty():
	return amount <= 0 or item == null
