extends Thing
class_name NaturalResource

# Emitted when there are zero units of RawMaterial remaining.
signal depleted()
# Emitted when health reaches zero. A NaturalResource can be destroyed
# regardless of whether or not all units of RawMaterial have been extracted.
signal destroyed()

# The RawMaterial that can be extracted from the resource.
export(PackedScene) var raw_material
# How maximum number of units of RawMaterial that the resource can hold.
export(int) var max_units := 0
# The amount of effort required to extract one yield of raw material.
export(float) var extraction_effort := 0.0
export(int) var units_per_yield := 0

# The number of units the NaturalResource currently has.
onready var units := max_units

onready var _next_yield := extraction_effort


func extract(effort: float) -> Array:
	print('effort: ', effort)
	print('_next_yield', _next_yield)
	var result := []
	
	if units <= 0:
		return result
	
	_next_yield -= effort
	print(_next_yield)
	if _next_yield <= 0:
		units -= units_per_yield
		
		for _i in range(units_per_yield):
			result.append(raw_material.instance())
		
		if units == 0:
			emit_signal("depleted")
		
		# Extraction effort rolls over to the next yield.
		_next_yield += extraction_effort
	
	return result
