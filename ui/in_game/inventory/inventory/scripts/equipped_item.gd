extends Sprite
class_name EquippedItem


var slot: InventorySlot setget set_slot


func set_slot(p_slot: InventorySlot) -> void:
	if slot == p_slot:
		return
	
	slot = p_slot
	texture = slot.get_node("Icon").texture
	$AmountLabel.text = str(slot.amount)
	slot.equipped = true
	
	slot.connect("amount_changed", self, "_on_slot_amount_changed")


func _process(_delta):
	if Input.is_action_just_pressed("cancel"):
		slot.equipped = false
		queue_free()
	
	if Input.is_action_just_pressed("drop_item"):
		# TODO: Create an instace of the item at mouse position.
		var dropped_item: Item2D = load(slot.item.scene_path).instance()
		$"/root/World".add_child(dropped_item)
		var tile: Vector2 = $"/root/World/Navigation2D/TileMap".world_to_map(
					$"/root/World/Navigation2D/TileMap".get_global_mouse_position())
		var origin: Vector2 = $"/root/World/Navigation2D/TileMap".map_to_world(tile)
		var target := origin
		var space_state := get_world_2d().direct_space_state
		var collisions: Array = space_state.intersect_point(target)
		var i = Vector2.ZERO
		print(collisions)
		while not collisions.empty():
			i += Vector2(32, 32)
			for direction in [Vector2.UP, Vector2.DOWN, Vector2.LEFT,
					Vector2.RIGHT, Vector2.UP + Vector2.LEFT,
					Vector2.UP + Vector2.RIGHT, Vector2.DOWN + Vector2.LEFT,
					Vector2.DOWN + Vector2.RIGHT]:
				target = origin + direction * i
				print(target)
				collisions = space_state.intersect_point(target)
				print(collisions)
				if collisions.empty():
					break
		dropped_item.global_position = target
			
		print(get_global_mouse_position())
		slot.amount -= 1
		if slot.amount == 0:
			slot.equipped = false
			queue_free()
	
	global_position = get_global_mouse_position()


func _on_slot_amount_changed(new_amount: int) -> void:
	$AmountLabel.text = str(new_amount)
