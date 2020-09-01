extends Camera2D
class_name PlayerCamera


export(NodePath) var target: NodePath
export(float) var speed := 3.5

onready var _target: Node2D = get_node(target)


func _ready():
	global_position = _target.global_position


func _process(delta):
	global_position = (lerp(global_position, _target.global_position,
			delta * speed))
