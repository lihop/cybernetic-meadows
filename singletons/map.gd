extends Node


# 2D array to track the amount of pollution per quadrant.
var pollution := 0.0


func add_pollution(position: Vector2, amount: float) -> void:
	pollution += amount


func subtract_pollution(position: Vector2, amount: float) -> void:
	pollution -= amount


func get_pollution(position: Vector2) -> float:
	return pollution
