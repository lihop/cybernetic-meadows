extends Node2D
class_name ThingFrame
# Used to draw a frame around a thing to show that it is focused or selected.


const corner := preload("res://ui/in_game/thing_frame/frame_corner.tscn")

# Path to the Thing to draw a frame around.
export(NodePath) var thing

# Whether or not the frame is within reach of the player.
var within_reach := false setget set_within_reach

onready var _thing = get_node(thing)


func _ready():
	visible = false
	
	var shape: RectangleShape2D
	for child in _thing.area.get_children():
		if child is CollisionShape2D:
			shape = child.shape
			break
	
	var origin: Vector2 = _thing.area.position - shape.extents
	
	var scale_factor = Vector2(1, 1)
	var shortest_side = min(shape.extents.x, shape.extents.y)
	if shortest_side < 64:
		scale_factor = Vector2(0.5, 0.5)
		if shortest_side < 32:
			scale_factor = Vector2(0.25, 0.25)
	
	var top_left = corner.instance()
	top_left.position = origin
	top_left.scale = scale_factor
	add_child(top_left)
	
	var top_right = corner.instance()
	top_right.position = Vector2(shape.extents.x + shape.extents.x * \
			(1 - scale_factor.x), 0) + origin
	top_right.flip_h = true
	top_right.scale = scale_factor
	add_child(top_right)
	
	var bottom_left = corner.instance()
	bottom_left.position = Vector2(0, shape.extents.y + (shape.extents.y / 2) \
			+ shape.extents.y * (1 - scale_factor.y) / 2) + origin
	bottom_left.flip_v = true
	bottom_left.scale = scale_factor
	add_child(bottom_left)
	
	var bottom_right = corner.instance()
	bottom_right.position = Vector2(shape.extents.x + shape.extents.x * \
			(1 - scale_factor.x), shape.extents.y + (shape.extents.y / 2) \
			+ shape.extents.y * (1 - scale_factor.y) / 2) + origin
	bottom_right.flip_v = true
	bottom_right.flip_h = true
	bottom_right.scale = scale_factor
	add_child(bottom_right)


func set_within_reach(is_within_reach: bool) -> void:
	within_reach = is_within_reach
	
	for child in get_children():
		if child is AnimatedSprite:
			child.frame = 1 if within_reach else 0
