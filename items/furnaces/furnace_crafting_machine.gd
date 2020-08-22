extends CraftingMachine
class_name FurnaceCraftingMachine
# A crafting machine that automatically picks its recipe from among SMELTING
# recipes based on input.


onready var input_slot: InventorySlot = input_inventory.get_child(0)


func _ready():
	recipe = load("res://items/processed_materials/stone_brick/stone_brick_recipe.tres")
