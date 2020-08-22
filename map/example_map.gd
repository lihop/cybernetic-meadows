extends Node2D


func _ready():
	# Add some items to the players inventory.
	var inventory = $Things/Player.inventory
	inventory.add_item(load("res://items/raw_materials/wood/wood.tres"), 25)
	inventory.add_item(load("res://items/raw_materials/stone/stone.tres"), 25)
	inventory.add_item(load("res://items/processed_materials/stone_brick/stone_brick.tres"), 25)
