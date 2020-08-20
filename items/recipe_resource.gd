extends Resource
class_name Recipe


enum Method {
	CRAFTING
	SMELTING
	GROWING
}
const METHOD_CRAFTING = Method.CRAFTING
const METHOD_SMELTING = Method.SMELTING
const METHOD_GROWING = Method.GROWING

export(bool) var enabled := false
export(float) var energy_required := 0.0
export(Method) var method := Method.CRAFTING
export(Array) var ingredients = [
	{"item": Item, "quantity": 0},
	{"item": Item, "quantity": 0},
	{"item": Item, "quantity": 0},
	{"item": Item, "quantity": 0},
	{"item": Item, "quantity": 0},
	{"item": Item, "quantity": 0},
	{"item": Item, "quantity": 0},
	{"item": Item, "quantity": 0},
	{"item": Item, "quantity": 0},
	{"item": Item, "quantity": 0},
]
export(Array) var products = [
	{"item": Item, "quantity": 0},
	{"item": Item, "quantity": 0},
	{"item": Item, "quantity": 0},
	{"item": Item, "quantity": 0},
	{"item": Item, "quantity": 0},
	{"item": Item, "quantity": 0},
	{"item": Item, "quantity": 0},
	{"item": Item, "quantity": 0},
	{"item": Item, "quantity": 0},
	{"item": Item, "quantity": 0},
]
