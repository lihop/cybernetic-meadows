extends Item2D
class_name Furnace


const FurnaceWindow = preload("./ui/furnace_window.tscn")
onready var UI = $"/root/World/UI"


func interact_primary(player):
	var furnace_window = FurnaceWindow.instance()
	furnace_window.furnace = self
	furnace_window.player_inventory = player.get_node("Inventory")
	UI.open_window(furnace_window)

func _on_Smelting_started():
	$AnimatedSprite.playing = true
	$AnimatedSprite.visible = true


func _on_Smelting_stopped():
	$AnimatedSprite.playing = false
	$AnimatedSprite.visible = false
