extends Node2D
class_name Purifier
# Removes pollution from the environment.


# The amount of pollution this node removes per second.
export(float) var purification_per_second := 0.0


var elapsed_time := 0.0


func _process(delta):
	Map.subtract_pollution(global_position, purification_per_second * delta)
