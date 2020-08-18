extends Resource
class_name Recipe
# Contains a recipe for taking inputs and producing an output.


export(bool) var enabled := false
export(float) var energy_required := 0.0
# Because of some limitations with exporting custom types in GDScript and for
# convenience, we pre-define some elements in the exported ingredient array.
#
# Note: "item" should be set to the resource file (e.g. '.tres') of the item
# we want to use as an ingredient.
export(Array) var ingredients = [
	{"item": Resource, "quantity": 0},
	{"item": Resource, "quantity": 0},
	{"item": Resource, "quantity": 0},
	{"item": Resource, "quantity": 0},
	{"item": Resource, "quantity": 0},
	{"item": Resource, "quantity": 0},
	{"item": Resource, "quantity": 0},
	{"item": Resource, "quantity": 0},
	{"item": Resource, "quantity": 0},
	{"item": Resource, "quantity": 0},
]
