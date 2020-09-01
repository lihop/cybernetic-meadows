extends WindowDialog


func _on_PlayerInventory_resized():
	$HBoxContainer/CraftingMenu.rect_size = $HBoxContainer/PlayerInventory.rect_size
