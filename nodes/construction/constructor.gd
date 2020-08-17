extends Node2D
class_name ItemConstructor
# A Constructor node is capable of constructing and deconstructing its parent.


signal deconstructed(by)

var constructed := true

onready var item: Item2D = get_parent()


func _ready():
	if not constructed:
		_set_unconstructed()


func _set_unconstructed():
	item.get_node("Sprite").modulate = Color(0, 1, 0, 0.5)


func construct():
	constructed = true


func deconstruct(by):
	constructed = false
	if item.resource and "inventory" in by:
		by.inventory.add_item(item.resource)
	item.queue_free()
	emit_signal("deconstructed", by)
