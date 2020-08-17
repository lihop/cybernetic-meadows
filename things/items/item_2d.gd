extends Thing
class_name Item2D
# An audio-visual representation of an Item resource in 2D space.


# Icon of the thing for display in the inventory.
# Should be around 32x32px.
export(Texture) var icon


func _on_deconstructed(by):
	# TODO: If by has an inventory, then transfer everything in our inventory to by.
	# Also add ourself to by's inventory.
	if "inventory" in by:
		by.inventory.add_item(resource)
	queue_free()
