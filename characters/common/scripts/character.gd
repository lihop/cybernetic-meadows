extends Sprite

var speed := 400.0
var path := PoolVector2Array() setget set_path

func _ready() -> void:
	set_process(false)


func _process(delta: float) -> void:
	var move_distance := speed * delta
	move_along_path(move_distance)


func move_along_path(distance: float) -> void:
	var start_point := position
	# warning-ignore:unused_variable
	for i in range(path.size()):
		var distance_to_next := start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			# Set the sprite frame based on direction.
			var angle = (start_point - path[0]).normalized().angle()
			if angle < 0:
				angle += 2 * PI
			var direction = int(round(angle / PI * 4))
			match direction:
				3, 4, 5:
					frame = 3
				7, 8, 1, 0:
					frame = 2
				2:
					frame = 1
				6, _:
					frame = 0
				
			
			position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
	
	if path.size() == 0:
		# Arrived at destination.
		set_process(false)


func set_path(value: PoolVector2Array) -> void:
	path = value
	if value.size() == 0:
		return
	set_process(true)
