extends Node2D
class_name Blueprint


# The scene this blueprint is for. Used to get the scenes texture and footprint.
var scene: PackedScene

var _sprite: Sprite
var _footprint: Area2D

onready var map: Map2D = $"/root/World/Map"


func _ready():
	var scene_instance = scene.instance()
	if scene_instance.has_node("Sprite"):
		_sprite = scene_instance.get_node("Sprite").duplicate()
	if scene_instance.has_node("Footprint"):
		_footprint = scene_instance.get_node("Footprint").duplicate()
	scene_instance.queue_free()
	if _footprint:
		# It seems areas overlap even if they are touching (not actually overlapping
		# so reduce the blueprint's footprint shape by one pixel. As long as it is
		# snapped to the grid it should still be accurate.
		var shape: RectangleShape2D = _footprint.get_node("CollisionShape2D").shape.duplicate()
		shape.extents -= Vector2(1, 1)
		_footprint.get_node("CollisionShape2D").shape = shape
		_footprint.connect("area_entered", self, "_set_sprite_color_deferred")
		_footprint.connect("area_exited", self, "_set_sprite_color_deferred")
		_set_sprite_color()
		add_child(_sprite)
		add_child(_footprint)


func _set_sprite_color_deferred(_area = null) -> void:
	call_deferred("_set_sprite_color")


func _set_sprite_color() -> void:
	if can_place():
		_sprite.modulate = Color(0, 1, 0, 0.5)
	else:
		_sprite.modulate = Color(1, 0, 0, 0.5)


func can_place() -> bool:
	return _footprint.get_overlapping_areas().empty()


func place():
	var new_instance = scene.instance()
	new_instance.global_position = global_position
	$"/root/World/Things".add_child(new_instance)
