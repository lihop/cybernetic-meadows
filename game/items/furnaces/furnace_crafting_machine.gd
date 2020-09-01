extends CraftingMachine
class_name FurnaceCraftingMachine
# A crafting machine that automatically picks its recipe from among SMELTING
# recipes based on input.


onready var input_slot: InventorySlot = input_inventory.get_child(0)


func _ready():
	# FIX ME: If we don't set a default recipe the furnace will run for a few
	# frames before stopping.
	recipe = load("res://items/processed_materials/stone_brick/stone_brick_recipe.tres")
	input_slot.connect("item_changed", self, "_on_input_item_changed")


func _on_input_item_changed(new_item: Item) -> void:
	# Automatically select the recipe based on input item and method.
	var recipes := Data.recipe.find({"method": Recipe.METHOD_SMELTING}).recipes
	for smelting_recipe in recipes:
		if smelting_recipe.ingredients[0].item == new_item:
			recipe = smelting_recipe
			self.on = true
