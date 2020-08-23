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

# Optional icon for this recipe. If no icon is specified the icon of the
# recipe's first product will be used. If there is no first product or the first
# product does not have an icon, a placeholder icon will be returned.
export(Texture) var icon = null setget ,get_icon
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


func get_icon() -> Texture:
	if icon is Texture:
		return icon
	elif products.size() > 0 and products[0].item.icon is Texture:
		return products[0].item.icon
	else:
		return preload("./assets/placeholder_icon.png")
