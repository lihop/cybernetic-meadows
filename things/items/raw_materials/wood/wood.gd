extends RawMaterial
class_name Wood


func _ready():
	pass

func _on_Extractable_depleted():
	queue_free()
