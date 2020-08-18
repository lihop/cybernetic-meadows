extends Node
class_name ElectricityConsumer
# Consumes electricity.


export(bool) var on := false
export(NodePath) var battery

onready var _battery: Battery = get_node_or_null(battery)


func _process(delta):
	# TODO: Consume electricity.
	pass
