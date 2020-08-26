extends Node2D


func _ready():
	# Add some items to the players inventory.
	var inventory = $Things/Player.inventory
	inventory.add_item(load("res://items/raw_materials/wood/wood.tres"), 25)
	inventory.add_item(load("res://items/raw_materials/stone/stone.tres"), 25)
	inventory.add_item(load("res://items/raw_materials/iron_ore/iron_ore.tres"), 25)
	inventory.add_item(load("res://items/processed_materials/stone_brick/stone_brick.tres"), 25)
	inventory.add_item(load("res://items/processed_materials/iron_plate/iron_plate.tres"), 25)


func _on_ToRoot_body_entered(body):
	# TODO: Change the scene to town square.
	pass
