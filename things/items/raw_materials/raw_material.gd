extends Item
class_name RawMaterial


export(String) var type


func _ready():
	add_to_group("raw_materials")
	$Sprite.texture = icon


func get_class() -> String:
	return type
