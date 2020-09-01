extends Item2D
class_name DroppedItem


func _ready():
	$Sprite.texture = resource.icon
	$Sprite.scale = Vector2(0.5, 0.5)


func deconstruct(by):
	# TODO: If by has an inventory, then transfer everything in our inventory to by.
	# Also add ourself to by's inventory.
	if "inventory" in by:
		by.inventory.add_item(resource)
	queue_free()
