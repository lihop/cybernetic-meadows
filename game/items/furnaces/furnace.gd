extends Item2D
class_name Furnace


onready var UI = $"/root/World/UI"

var test_recipe = load("res://items/processed_materials/stone_brick/stone_brick_recipe.tres")

func interact_primary(player):
	var furnace_window = load("res://items/furnaces/ui/furnace_window.tscn").instance()
	furnace_window.furnace = self
	furnace_window.player_inventory = player.get_node("Inventory")
	UI.open_window(furnace_window)


func _ready():
	$CraftingMachine.recipe = test_recipe


func _on_CraftingMachine_started():
	$AnimatedSprite.visible = true
	$AnimatedSprite.playing = true
	$AudioStreamPlayer2D.playing = true


func _on_CraftingMachine_stopped():
	$AnimatedSprite.visible = false
	$AnimatedSprite.playing = false
	$AudioStreamPlayer2D.playing = false
