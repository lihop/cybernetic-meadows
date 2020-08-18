extends TextureButton
class_name InventorySlotUI
# User interface for the InventorySlot node.


var slot: InventorySlot setget set_slot


func set_slot(new_slot: InventorySlot) -> void:
	if slot != new_slot:
		if slot:
			slot.disconnect("amount_changed", self, "_on_amount_changed")
			slot.disconnect("item_changed", self, "_on_item_changed")
			slot.disconnect("equipped", self, "_on_equipped")
			slot.disconnect("unequipped", self, "_on_unequipped")
		slot = new_slot
		slot.connect("amount_changed", self, "_on_amount_changed")
		slot.connect("item_changed", self, "_on_item_changed")
		slot.connect("equipped", self, "_on_equipped")
		slot.connect("unequipped", self, "_on_unequipped")
		_setup_slot()


func _ready():
	_setup_slot()


func _setup_slot():
	if slot:
		_on_equipped() if slot.equipped else _on_unequipped()
		_on_item_changed(slot.item)
		_on_amount_changed(slot.amount)


func _on_item_changed(new_item: Item) -> void:
	$Icon.texture = new_item.icon if new_item else null


func _on_amount_changed(new_amount):
	$AmountLabel.text = str(new_amount)
	$AmountLabel.visible = new_amount > 0 and not slot.equipped


func _on_equipped():
	$AmountLabel.hide()
	$Icon.texture = load("res://ui/in_game/inventory/assets/hand.png")


func _on_unequipped():
	$AmountLabel.visible = slot.amount > 0
	$Icon.texture = slot.item.icon if slot.item else null
