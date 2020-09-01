extends WAT.Test


const wood = preload("res://items/raw_materials/wood/wood.tres")

var energy_source: BurnerEnergySource


func title():
	return "BurnerEnergySource"


func start():
	# Runs before all test related methods once
	pass


func pre():
	energy_source = BurnerEnergySource.new()
	energy_source.input_slots = 1
	add_child(energy_source)


func test_refuels_when_fuel_added_to_inventory():
	describe("Refuels when fuel added to inventory")
	asserts.is_equal(energy_source.energy, 0)
	energy_source.input_inventory.add_item(wood, 1)
	asserts.is_true(energy_source.energy > 0)
	asserts.is_true(energy_source.input_inventory.empty())


func test_emits_signal_depleted():
	describe("Uses energy after being refueled")
	energy_source.input_inventory.add_item(wood, 1)
	asserts.is_true(energy_source.energy > 0)
	energy_source.energy_usage = wood.energy * 60
	yield(until_signal(energy_source, "depleted", 0.2), YIELD)
	asserts.is_equal(energy_source.energy, 0)
	asserts.is_true(energy_source.input_inventory.empty())


func test_refuels_until_inventory_is_empty():
	describe("Refuels until inventory is empty")
	energy_source.input_inventory.add_item(wood, 2)
	asserts.is_true(energy_source.energy > 0)
	asserts.is_false(energy_source.input_inventory.empty())
	energy_source.energy_usage = wood.energy * 60
	yield(until_signal(energy_source, "depleted", 0.2), YIELD)
	asserts.is_equal(energy_source.energy, 0)
	asserts.is_true(energy_source.input_inventory.empty())


func post():
	# Runs after each test method
	pass


func end():
	# Runs after all other test related methods once
	pass
