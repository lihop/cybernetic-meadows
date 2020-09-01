extends Node2D
class_name Polluter
# Adds pollution to the environment.


export(float) var pollution_per_second := 0.0


onready var map: Map2D = $"/root/World/Map"


func _process(delta):
	map.add_pollution(global_position, pollution_per_second * delta)
