extends Node2D
class_name Polluter
# Adds pollution to the environment.


export(float) var pollution_per_second := 0.0


func _process(delta):
	Map.add_pollution(global_position, pollution_per_second * delta)
