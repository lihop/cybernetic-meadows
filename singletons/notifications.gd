extends Node2D

const FloatingLabel = preload("res://ui/in_game/floating_label/floating_label.tscn")

enum Levels {
	INFO
	ERROR
}

const LEVEL_INFO = Levels.INFO
const LEVEL_ERROR = Levels.ERROR

# Creates a notification at the mouse position.
func send_mouse(message: String, level: int = LEVEL_INFO) -> void:
				# TODO: Notification singleton.
				var floating_label = FloatingLabel.instance()
				floating_label.text = message
				floating_label.global_position = get_global_mouse_position()
				if level == LEVEL_ERROR:
					floating_label.error = true
				$"/root/World".add_child(floating_label)
