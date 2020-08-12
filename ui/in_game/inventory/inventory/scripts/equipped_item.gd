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
		var dropped_item: Wood = slot.item.duplicate()
		$"/root/World".add_child(dropped_item)
		var tile: Vector2 = $"/root/World/TileMap".world_to_map(
					$"/root/World/TileMap".get_global_mouse_position())
		dropped_item.position = $"/root/World/TileMap".map_to_world(tile)
		print(get_global_mouse_position())
		slot.amount -= 1
		if slot.amount == 0:
			slot.equipped = false
			queue_free()
	
	global_position = get_global_mouse_position()


func _on_slot_amount_changed(new_amount: int) -> void:
	$AmountLabel.text = str(new_amount)
