extends Resource
class_name Recipe
# Contains a recipe for taking inputs and producing an output.


export(float) var time := 0.0
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


func _ready():
	# Remove any empty ingredients.
	for i in range(ingredients.size() - 1, 0):
		if ingredients[i].quantity < 1 or not ingredients[i].item:
			ingredients.remove(i)


