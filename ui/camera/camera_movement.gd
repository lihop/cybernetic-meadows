extends Camera2D
class_name CameraMovement


export(int) var speed = 500
export(float) var zoom_increment := 0.1


func _process(delta):
	pass
#	var movement_x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
#	var movement_y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
#
#	movement_x *= speed * delta
#	movement_y *= speed * delta
#
#	position.x = clamp(position.x + movement_x, limit_left, limit_right) 
#	position.y = clamp(position.y + movement_y, limit_top, limit_bottom)


func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		var increment = Vector2(zoom_increment, zoom_increment)
		
		match event.button_index:
			BUTTON_WHEEL_UP:
				zoom -= increment
			BUTTON_WHEEL_DOWN:
				zoom += increment
