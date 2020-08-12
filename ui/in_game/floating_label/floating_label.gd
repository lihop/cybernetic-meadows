extends Node2D
# Label which floats up and then disappears. Useful for short notifications.


# The distance this Label will float before disappearing.
var floating_distance := 200
# The speed at which the Label moves.
var speed := 1
# The text property of the Label node.
var text := "" setget set_text
var error := false


func set_text(label_text: String) -> void:
	$Label.text = label_text
	text = label_text


func _ready():
	if error:
		$ErrorSound.play()
	
	$Tween.interpolate_property(self, "position", position,
			Vector2(position.x, position.y - floating_distance), speed,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	queue_free()
