extends Node
class_name Smelting


signal started()
signal stopped()


var on := false setget set_on


onready var fuel_slot = $FuelInventory.slots[0]
onready var input_slot = $FuelInventory.slots[0]
onready var output_slot = $FuelInventory.slots[0]


func set_on(is_on: bool) -> void:
	on = is_on
	emit_signal("started") if on else emit_signal("stopped")
