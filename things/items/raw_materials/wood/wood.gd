extends RawMaterial
class_name Wood


func _on_Extractable_depleted():
	queue_free()
