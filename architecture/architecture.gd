extends Node2D
class_name Architecture

onready var tilemap: TileMap = $"/root/World/Navigation2D/TileMap"

var blueprint := false
var placed := false

var _closest_cell: Vector2 = Vector2()


func _ready():
	if blueprint:
		$Sprite.modulate = Color(1, 1, 1, 0.5)
	if $Area2D:
		$Area2D.connect("input_event", self, "_on_Area2D_input_event")


func _input(event):
	if blueprint:
		if Input.is_action_just_pressed("rotate_left"):
			rotate(deg2rad(-90))
		
		if Input.is_action_just_pressed("rotate_right"):
			rotate(deg2rad(90))
		
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_RIGHT:
				queue_free()
			if event.button_index == BUTTON_LEFT:
				set_process_input(false)
				placed = true
		
		
		if not event is InputEventMouseMotion:
			return
		
		# Get the closest cell to the cursor.
		var new_closest_cell = tilemap.world_to_map(get_global_mouse_position())
		if new_closest_cell != _closest_cell:
			_closest_cell = new_closest_cell
			global_position = tilemap.map_to_world(_closest_cell) + Vector2(32, 32)


func _on_Area2D_input_event(_viewport, event, _shapeidx):
	if not placed:
		return
	
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and \
			event.pressed:
		if blueprint:
			queue_free()
