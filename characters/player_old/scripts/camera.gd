extends Camera2D


export(float) var zoom_increment := 0.1


func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		var increment = Vector2(zoom_increment, zoom_increment)
		
		match event.button_index:
			BUTTON_WHEEL_UP:
				zoom -= increment
			BUTTON_WHEEL_DOWN:
				zoom += increment
