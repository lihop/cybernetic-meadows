extends CanvasLayer


var inventory_visible := false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("toggle_inventory"):
		inventory_visible = not inventory_visible
		if inventory_visible:
			$InventoryCraftingDialog.show()
		else:
			$InventoryCraftingDialog.hide()


func _on_InventoryCraftingDialog_hide():
	inventory_visible = false
