extends VBoxContainer
class_name CraftingUI


const InventorySlot = preload("res://ui/in_game/inventory/inventory/inventory_slot.tscn")

export(NodePath) var inventory_path

onready var inventory: Inventory = get_node(inventory_path)


func _ready():
	inventory.connect("changed", self, "_update")
	_update()


func _update():
	for child in $GridContainer.get_children():
		child.queue_free()
	for craftable in Crafting.craftables:
		if craftable.recipe.enabled:
			var slot = InventorySlot.instance()
			slot.item = craftable
			slot.disabled = not Crafting.can_craft(craftable, inventory)
			slot.connect("pressed", self, "_on_slot_pressed", [slot])
			$GridContainer.add_child(slot)


func _on_slot_pressed(slot: InventorySlot):
	# Craft the item and add it to inventory.
	Crafting.craft(slot.item, inventory)
