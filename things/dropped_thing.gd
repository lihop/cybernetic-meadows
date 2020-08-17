extends Item2D
class_name DroppedThing


func _ready():
	$Sprite.texture = resource.icon
	$Sprite.scale = Vector2(0.5, 0.5)
