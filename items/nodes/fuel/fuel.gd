extends Node
class_name Fuel


signal level_changed()
signal emptied()

var total := 0.0
var level := total setget set_level


func set_level(new_level: float) -> void:
	level = new_level
	emit_signal("level_changed")
	if level <= 0:
		level = 0
		emit_signal("emptied")


func consume_from_slot(slot: InventorySlot):
	if not slot.item or slot.item == null:
		return
	
	if not slot.empty() and "energy" in slot.item:
		slot.amount -= 1
		if not slot.item:
			return
		self.total = slot.item.energy
		self.level = total
