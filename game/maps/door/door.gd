extends Portal
class_name Door


const CURSOR_HAND = preload("res://ui/assets/cursor_grey_hand.png")
const CURSOR_ARROW = preload("res://ui/assets/cursor_grey_arrow.png")

export(Vector2) var location: Vector2
export(bool) var locked := false

var _accessible := false

func _unhandled_input(event):
	if event.is_action_pressed("enter_portal") and _accessible:
		if locked:
			$AudioStreamPlayer2D.play()
		else:
			teleport(null)
		
		get_tree().set_input_as_handled()


func _on_Portal_mouse_entered():
	# TODO: Use custom cursor and check _acessible property.
	Input.set_custom_mouse_cursor(CURSOR_HAND)


func _on_Portal_mouse_exited():
	# TODO: Use custom cursor.
	Input.set_custom_mouse_cursor(CURSOR_ARROW)


func _on_Reach_body_entered(body):
	if body is Player:
		_accessible = true


func _on_Reach_body_exited(body):
	if body is Player:
		_accessible = false
