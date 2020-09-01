extends Item2D
class_name RawMaterial


func _ready():
	add_to_group("raw_materials")
	$Sprite.texture = icon
	$Extractable.resource = resource
	$Extractable.units = 1
	$Extractable.units_per_yield = 1
	$Extractable.extraction_effort = 0


func get_class() -> String:
	return "RawMaterial"


func _on_Extractable_depleted():
	queue_free()
