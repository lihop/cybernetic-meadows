extends Camera2D
class_name PlayerCamera


export(float) var speed = 5
export(float) var zoom_increment := 0.1
export(float) var max_zoom
export(float) var min_zoom
export(NodePath) var target_node

onready var target: Node2D = get_node(target_node)


func _process(delta):
	global_position = lerp(global_position, target.global_position,
			delta * speed)


func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		var increment = Vector2(zoom_increment, zoom_increment)
		
		match event.button_index:
			BUTTON_WHEEL_UP:
				zoom -= increment
			BUTTON_WHEEL_DOWN:
				zoom += increment
