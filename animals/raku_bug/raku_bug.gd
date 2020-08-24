extends Node2D


export(float) var frequency = 1.75
export(float) var magnitude = 1
export(float) var speed = 1

var _time := 0.0


func _process(delta: float) -> void:
	_time += delta
	$AnimatedSprite.position += Vector2.UP * sin(_time * frequency) * magnitude
	position.x += speed * delta
