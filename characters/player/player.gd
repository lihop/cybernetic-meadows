extends KinematicBody2D
class_name Player


export(int) var speed := 75
export(NodePath) var inventory_node

var velocity = Vector2()
var target: Item2D = null

onready var inventory = get_node(inventory_node)


func _get_input():
	velocity = Vector2()
	if Input.is_action_pressed('move_right'):
		velocity.x += 1
	if Input.is_action_pressed('move_left'):
		velocity.x -= 1
	if Input.is_action_pressed('move_down'):
		velocity.y += 1
	if Input.is_action_pressed('move_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	
	if velocity != Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("walk")
		$AnimationTree.set("parameters/idle/blend_position", velocity)
		$AnimationTree.set("parameters/walk/blend_position", velocity)
	else:
		$AnimationTree.get("parameters/playback").travel("idle")


func _physics_process(_delta):
	_get_input()
	velocity = move_and_slide(velocity)


func _unhandled_input(event: InputEvent) -> void:
	if not target:
		return
	
	if event.is_action_pressed("interact_primary") and target.has_method("interact_primary"):
		if not target.in_reach_of(self):
			Notifications.send_mouse("Too far away", Notifications.LEVEL_ERROR)
		else:
			target.interact_primary(self)


func _process(delta: float) -> void:
	if target and Input.is_action_pressed("interact"):
		var extractable: Extractable = target.get_node_or_null("Extractable")
		if extractable:
			var units = extractable.extract(1 * delta)
			if units.size() > 0:
				for unit in units:
					# TODO: Display total in notification message.
					Notifications.send_mouse("+%d %s (total)" % [unit.quantity,
							unit.resource.name])
					inventory.add_item(unit.resource, unit.quantity)
			
			# Animation stuff. Maybe move to target.hit() instead?
			if extractable.has_method("hit"):
				extractable.hit()
		
		
		if target.has_method("deconstruct"):
			target.deconstruct(self)
