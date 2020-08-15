extends Node2D
class_name Thing
# Base class for all non-character things in the game (i.e. items, objects).
# Called "Thing" because the Object class name is already taken.


# The amount of pollution a thing produces per second when operating at full
# capacity. A lot of things will produce zero pollution. Things can also
# absorb pollution, in which case this number will be negative.
export(float) var pollution_per_second := 0
# The base market value of a thing. Of course this may fluctuate depending
# on some other factors.
export(float) var market_value := 0
export(int) var max_health := 0
# Color used to represent this thing on the map.
export(Color) var map_color := Color()
# Path to the things Area2D which is used to highlight the thing on mouseover
# and interact with the thing on mouse click.
export(NodePath) var area_node
# The radius of the area the player must be within to interact with the thing.
export(int) var reach_area_radius := 150 

var health := max_health

onready var area: Area2D = get_node(area_node) if area_node else $Footprint

var _frame: ThingFrame


func _ready():
	area.connect("mouse_entered", self, "_on_Area2D_mouse_entered")
	area.connect("mouse_exited", self, "_on_Area2D_mouse_exited")

	$Reach/CollisionShape2D.shape.radius = reach_area_radius
	$Reach.connect("body_exited", self, "_on_Area2D_body_exited")
	$Reach.connect("body_entered", self, "_on_Area2D_body_entered")

	_frame = ThingFrame.new()
	_frame.thing = get_path()
	add_child(_frame)


func _on_Area2D_mouse_entered():
	_frame.visible = true
	$"/root/World/Things/Player".target = self


func _on_Area2D_mouse_exited():
	_frame.visible = false
	if $"/root/World/Things/Player".target == self:
		$"/root/World/Things/Player".target = null


func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if body.is_in_group("players"):
		_frame.within_reach = true


func _on_Area2D_body_exited(body: PhysicsBody2D) -> void:
	if body.is_in_group("players"):
		_frame.within_reach = false


# Returns true if body is touching the reach area of the thing.
func in_reach_of(body: PhysicsBody2D):
	return $Reach.get_overlapping_bodies().has(body)
