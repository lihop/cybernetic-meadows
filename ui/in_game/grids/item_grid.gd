extends MarginContainer
class_name ItemGrid


const SlotScene := preload("res://ui/in_game/grids/item_slot.tscn")
onready var grid := $VBoxContainer/GridContainer


func _ready():
	set("custom_constants/margin_top", 15)
	set("custom_constants/margin_right", 15)
	set("custom_constants/margin_left", 15)
	set("custom_constants/margin_bottom", 15)


func clear_grid():
	for child in grid.get_children():
		child.free()
