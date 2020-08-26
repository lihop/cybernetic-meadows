extends TileMap
class_name Map2D
# Represents the map. Useful for tracking things like pollution, temperature
# perhaps. Cells are 8x8 which is the smallest possible size for anything.

# We only care about collisions with other footprints, so only check the
# footprint areas collision layer (layer 6).
const footprint_collision_layer = 32 # bit 5, 32

var pollution := 0.0

# Returns the closest empty position to pos of the given size.
func closest_empty_position(pos: Vector2, size: Vector2 = cell_size):
	var tile = world_to_map(pos)
	var origin: Vector2 = map_to_world(tile)
	var target := origin
	var space_state := get_world_2d().direct_space_state
	var collisions: Array = space_state.intersect_point(target, 32, [],
	footprint_collision_layer, false, true)
	var i = Vector2.ZERO
	print(collisions)
	while not collisions.empty():
		i += cell_size
		for direction in [Vector2.UP, Vector2.DOWN, Vector2.LEFT,
				Vector2.RIGHT, Vector2.UP + Vector2.LEFT,
				Vector2.UP + Vector2.RIGHT, Vector2.DOWN + Vector2.LEFT,
				Vector2.DOWN + Vector2.RIGHT]:
			target = origin + direction * i
			collisions = space_state.intersect_point(target, 32, [],
					footprint_collision_layer, false, true)
			if collisions.empty():
				break
	return target


# Returs the closest tile center position to pos.
func closest_tile(pos: Vector2) -> Vector2:
	return map_to_world(world_to_map(pos))


func add_pollution(position: Vector2, amount: float) -> void:
	pollution += amount


func subtract_pollution(position: Vector2, amount: float) -> void:
	pollution -= amount


func get_pollution(position: Vector2) -> float:
	return pollution
