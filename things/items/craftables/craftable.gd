extends Item
class_name Craftable


export(int) var crafting_time
export(Array) var ingredients


class Ingredient:
	extends Reference
	
	var amount: int = 1
	var raw_material: RawMaterial
