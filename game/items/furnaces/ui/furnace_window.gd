extends WindowDialog
# User interface for interacting with furnaces.


var furnace: Item2D
var player_inventory: Inventory

onready var UI: InGameUI = $"/root/World/UI"

onready var crafting: Crafting = furnace.get_node("CraftingMachine")
onready var energy_source: BurnerEnergySource = furnace.get_node("EnergySource")
onready var fuel_level = $VBoxContainer/FurnacePanel/VBoxContainer/Fuel/FuelRemaining
onready var crafting_progress = $VBoxContainer/FurnacePanel/VBoxContainer/Production/ProductionProgress

func _ready():
	$VBoxContainer/PlayerInventory.inventory = player_inventory
	$VBoxContainer/FurnacePanel/VBoxContainer/Fuel/FuelSlot.set_slot(
			energy_source.input_inventory.get_child(0))
	$VBoxContainer/FurnacePanel/VBoxContainer/Production/InputSlot.set_slot(
			crafting.input_inventory.get_child(0))
	$VBoxContainer/FurnacePanel/VBoxContainer/Production/OutputSlot.set_slot(
			crafting.output_inventory.get_child(0))
	_update_levels()


func _process(delta: float) -> void:
	_update_levels()


func _update_levels():
	# NOTE: ProgressBar doesn't like it when max_value and value both equal 0.0
	# so we do this weird max thing.
	fuel_level.max_value = max(energy_source.energy_scale, 0.00001)
	fuel_level.value = energy_source.energy
	crafting_progress.max_value = max(crafting.goal, 0.00001)
	crafting_progress.value = crafting.progress
