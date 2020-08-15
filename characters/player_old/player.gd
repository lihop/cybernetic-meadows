extends KinematicBody2D
class_name Player

const FloatingLabel = preload("res://ui/in_game/floating_label/floating_label.tscn")

export(int) var speed := 400
export(NodePath) var inventory_node

var velocity = Vector2()
var target: Thing = null

onready var inventory = get_node(inventory_node)


func get_input():
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


func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)


func _process(delta):
	if target and not target.in_reach_of(self):
		if target and Input.is_action_just_pressed("interact"):
			# TODO: Make a Notification global. We could have different types
			# of notification. This would be an at cursor error type one.
			var floating_label = FloatingLabel.instance()
			floating_label.text = "Too far away!"
			floating_label.error = true
			floating_label.global_position = get_global_mouse_position()
			$"/root/World".add_child(floating_label)
	
	elif target and Input.is_action_pressed("interact"):
		if target is NaturalResource:
			# TODO: Play extraction animation and sound effects.
			# Advance extraction by delta.
			var units = target.extract(1 * delta)
			if units.size() > 0:
				# TODO: Notification singleton.
				var floating_label = FloatingLabel.instance()
				floating_label.text = "+%d wood (total)" % units.size()
				floating_label.global_position = get_global_mouse_position()
				$"/root/World".add_child(floating_label)
				
				inventory.add_item(units[0], units.size())
		
		if target is RawMaterial:
			inventory.add_item(target)
			target.queue_free()
