extends WindowDialog
# User interface for interacting with furnaces.


var furnace: Item2D
var player_inventory: Inventory

onready var UI: InGameUI = $"/root/World/UI"

onready var fuel_slot = $VBoxContainer/FurnacePanel/VBoxContainer/Fuel/FuelSlot
onready var input_slot = $VBoxContainer/FurnacePanel/VBoxContainer/Production/InputSlot
onready var output_slot = $VBoxContainer/FurnacePanel/VBoxContainer/Production/OutputSlot


func _ready():
	$VBoxContainer/PlayerInventory.inventory = player_inventory
