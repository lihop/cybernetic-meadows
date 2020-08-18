extends CanvasLayer
class_name InGameUI


export(NodePath) var player_node

var current_window = null
var player_inventory: Inventory

onready var player: Player = get_node(player_node)


func _ready():
	player_inventory = player.get_node("Inventory")
	$CraftingWindow/HBoxContainer/CraftingMenu.inventory = player_inventory
	$CraftingWindow/HBoxContainer/PlayerInventory.inventory = player_inventory
	$InventoryWindow/HBoxContainer/PlayerInventory.inventory = player_inventory


func open_inventory_window(inventory: Inventory):
	print(inventory)
	$InventoryWindow/HBoxContainer/TargetInventory.inventory = inventory
	open_window($InventoryWindow)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_close_window") and current_window:
		close_window(current_window)
		get_tree().set_input_as_handled()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_open_crafting_window"):
		open_window($CraftingWindow)


func open_window(window: Popup):
	for window in get_tree().get_nodes_in_group("ui_windows"):
		window.hide()
	# Use popup_centered() to center the window, but then use hide() and show()
	# to make in non-modal (i.e. the user can click away from the window and it
	# won't close.
	window.set_as_minsize()
	window.popup_centered()
	window.hide()
	window.show()
	current_window = window


func close_window(window: Popup):
	window.hide()
	current_window = null
