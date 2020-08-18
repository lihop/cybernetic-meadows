extends Sprite

enum BELT_DIRECTION {
	CLOCKWISE
	COUNTERCLOCKWISE
}

const BELT_DIRECTION_CLOCKWISE = BELT_DIRECTION.CLOCKWISE
const BELT_DIRECTION_COUNTERCLOCKWISE = BELT_DIRECTION.COUNTERCLOCKWISE

export(int) var belt_speed := 200
export(BELT_DIRECTION) var belt_direction := BELT_DIRECTION_CLOCKWISE

# PhysicsBody2Ds currently riding this belt.
var _passengers := {}


func _process(delta):
	for key in _passengers.keys():
		var body: PhysicsBody2D = _passengers[key]
		if body is KinematicBody2D:
			body.move_and_slide(Vector2(200, 0), Vector2.UP)
		elif body is RigidBody2D:
			print(body.get_class())
			body.set_linear_velocity(Vector2(200, 0))


func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	_passengers[body.get_instance_id()] = body


func _on_Area2D_body_exited(body: PhysicsBody2D) -> void:
	_passengers.erase(body.get_instance_id())
	if body is RigidBody2D:
		body.set_linear_velocity(Vector2.ZERO)
