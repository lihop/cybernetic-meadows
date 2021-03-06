extends Node2D
class_name Extractable
# Extract resources from things using this node.
# For example, right clicking on rock will mine it, thus extracting stone.
# It can also be used to deconstruct an item. For example, right click a
# building to deconstruct it. If you deconstruct a wooden chest it will
# yield 1. Wooden Chest, 2. The contents of that chest.


# Emitted when the resource_provider has run out of resource. Usually this
# will result in the parent being destroyed.
signal depleted()


export(Resource) var resource
export(int) var units_per_yield := 0
export(float) var extraction_effort := 0.0
export(int) var max_units := 0

var extracting := false setget set_extracting

onready var units := max_units
onready var next_yield := extraction_effort


func set_extracting(is_extracting: bool) -> void:
	extracting = is_extracting


func extract(effort: float):
	print(effort)
	print(next_yield)
	print(units)
	var result := []
	
	if units <= 0:
		return result
	
	next_yield -= effort
	if next_yield <= 0:
		units -= units_per_yield
		
		result.append({"resource": resource, "quantity": units_per_yield})
	
		if units == 0:
			emit_signal("depleted")
		
		# Extraction effort rolls over to the next yield.
		next_yield += extraction_effort
	
	return result
