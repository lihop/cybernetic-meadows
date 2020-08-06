extends Camera2D
class_name CameraMovement


export(int) var speed = 500


func _process(delta):
	var movement_x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	var movement_y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	position.x += movement_x * speed * delta
	position.y += movement_y * speed * delta
