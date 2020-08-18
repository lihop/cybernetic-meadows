extends NaturalResource
# Tress reduce pollution by absorbing carbon dioxide from the atmosphere.
# They also contribute beauty to the environment. The can be chopped down
# to extract wood.


func _on_depleted():
	# TODO: Change the sprite to show a tree stump.
	# TODO: Change the footprint to removeable, meaning that if anything is
	# placed on top of this node's tile, it will be deleted.
	queue_free()


func _on_Extractable_depleted():
	queue_free()
