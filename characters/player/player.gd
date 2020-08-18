extends KinematicBody2D


const FloatingLabel = preload("res://ui/in_game/floating_label/floating_label.tscn")

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


func _process(delta):
	if target and not target.in_reach_of(self):
		if target and Input.is_action_just_pressed("interact"):
			Notifications.send_mouse("Too far away", Notifications.LEVEL_ERROR)
	
	
	elif target and Input.is_action_pressed("interact"):
#		if target is NaturalResource:
#			# TODO: Play extraction animation and sound effects.
#			# Advance extraction by delta.
#			var units = target.extract(1 * delta)
#			if units.size() > 0:
#				# TODO: Notification singleton.
#				var floating_label = FloatingLabel.instance()
#				floating_label.text = "+%d wood (total)" % units.size()
#				floating_label.global_position = get_global_mouse_position()
#				$"/root/World".add_child(floating_label)
#
#				inventory.add_item(units[0], units.size())
	
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
