extends Control


func _on_Architect_toggled(button_pressed):
	print(button_pressed)
	$ArchitectSubMenu.visible = button_pressed
