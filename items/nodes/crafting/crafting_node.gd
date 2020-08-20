extends Node
class_name CraftingNode
# A crafting node converts an input to an output.


signal started()
signal stopped()


export(bool) var crafting := false setget set_crafting
export(NodePath) var fuel_node

onready var fuel = get_node(fuel_node)


func set_crafting(is_crafting: bool) -> void:
	if crafting != is_crafting:
		crafting = is_crafting
		if crafting:
			set_process(true)
			emit_signal("started")
		else:
			set_process(false)
			emit_signal("stopped")


func _process(delta: float) -> void:
	if fuel.level <= 0:
		self.crafting = false
	else:
		fuel.level -= delta
