extends EnergySource
class_name BurnerEnergySource


export(int) var input_slots := 1
export(int) var output_slots := 0
export(Array) var fuel_sources = [Item, Item, Item, Item, Item]

onready var input_inventory := Inventory.new(input_slots)
onready var output_inventory := Inventory.new(output_slots)


static func burner_inventory_filter(item: Item) -> bool:
	if item.fuel_categories:
		return "CHEMICAL" in item.fuel_categories
	return false


func _ready():
	var filter = FuncRef.new()
	filter.set_instance(self)
	filter.set_function("burner_inventory_filter")
	input_inventory.add_filter(filter)
	input_inventory.connect("items_added", self, "_on_items_added")
	add_child(input_inventory)


func _on_items_added(_items):
	refuel()


func refuel():
	if not input_inventory.empty() and energy <= 0:
		var item = input_inventory.get_contents().keys()[0]
		input_inventory.remove_item(item)
		self.energy = item.energy
