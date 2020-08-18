extends Node2D
class_name Purifier
# Removes pollution from the environment.


# The amount of pollution this node removes per second.
export(float) var purification_per_second := 0.0

onready var map: Map2D = $"/root/World/Map"

var elapsed_time := 0.0


func _process(delta):
	map.subtract_pollution(global_position, purification_per_second * delta)
