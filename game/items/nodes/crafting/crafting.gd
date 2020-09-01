extends Node
class_name Crafting


signal started()
signal stopped()
signal output_transferred()

export(float) var crafting_speed := 1.0
export(int) var input_slots := 1
export(int) var output_slots := 1

var on := false setget set_on
var recipe: Recipe setget set_recipe
var previous_recipe: Recipe
var goal := 0.0
var progress := 0.0
var inputs := {}
var outputs := {}

onready var input_inventory := Inventory.new(input_slots)
onready var output_inventory := Inventory.new(output_slots)


func set_recipe(new_recipe: Recipe) -> void:
	if recipe != new_recipe:
		recipe = new_recipe
		if recipe == null:
			self.on = false
			return
		else:
			inputs = {}
			outputs = {}
			goal = recipe.energy_required
			progress = 0.0
			self.on = true


func set_on(is_on: bool) -> void:
	if on != is_on:
		on = is_on
		if on:
			set_process(true)
			emit_signal("started")
		else:
			set_process(false)
			emit_signal("stopped")


func _ready():
	set_process(false)
	input_inventory.connect("items_added", self, "_on_items_added")
	add_child(input_inventory)
	add_child(output_inventory)


func _process(delta: float) -> void:
	if not recipe:
		self.on = false
		return
	
	if not outputs.empty():
		# We need to tranfer the current outputs before we can continue crafting.
		_transfer_outputs()
	if inputs.empty():
		# We don't have any ingredients loaded for crafting.
		_refill_inputs()
	
	if progress >= goal:
		inputs = {}
		outputs = {}
		progress = 0
		goal = recipe.energy_required
		for ingredient in recipe.products:
			outputs[ingredient.item] = ingredient.quantity
	else:
		progress += crafting_speed * delta

func _transfer_outputs():
	if output_inventory.can_insert(outputs):
		output_inventory.insert(outputs)
		outputs = {}
		emit_signal("output_transferred")
	else:
		# Output inventory is full. We need to stop processing until we can
		# get rid of our current outputs.
		self.on = false


func _refill_inputs():
	if not recipe:
		self.on = false
		return
	elif inputs.empty():
		var contents = input_inventory.get_contents()
		inputs = {}
		for ingredient in recipe.ingredients:
			if contents.has(ingredient.item) and contents[ingredient.item] >= ingredient.quantity:
				inputs[ingredient.item] = ingredient.quantity
			else:
				self.on = false
				return
		input_inventory.remove(inputs)
	self.on = not inputs.empty()


func _on_items_added(_items):
	_refill_inputs()


func can_craft(recipe: Recipe) -> bool:
	var ingredients = recipe.ingredients
	var contents = input_inventory.get_contents()
	for ingredient in ingredients:
		if not contents.has(ingredient.item) or \
				contents[ingredient.item] < ingredient.quantity:
			return false
	return true
