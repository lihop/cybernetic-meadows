extends Node2D


func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	if event.button_index != BUTTON_LEFT or not event.pressed:
		return
	
	var new_path = $Navigation2D.get_simple_path($Character.global_position,
			get_global_mouse_position())
	$Character.path = new_path
