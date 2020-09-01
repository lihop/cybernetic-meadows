extends WAT.Test


const wood = preload("res://items/raw_materials/wood/wood.tres")
const stone = preload("res://items/raw_materials/stone/stone.tres")

var inventory: Inventory


func title():
	return "Inventory"


func start():
	# Runs before all test related methods once
	pass


func pre():
	inventory = Inventory.new()


static func is_wood(item: Item) -> bool:
	return item.name == "wood"


static func is_stone(item: Item) -> bool:
	return item.name == "stone"


func test_can_insert_if_no_filters():
	describe("Returns true if there are no filters on the inventory")
	asserts.is_true(inventory.can_insert({wood: 1}))


func test_can_insert_if_filter_matches():
	describe("Returns true if the item matches the filter")
	var wood_filter = FuncRef.new()
	wood_filter.set_instance(self)
	wood_filter.set_function("is_wood")
	inventory.add_filter(wood_filter)
	asserts.is_true(inventory.can_insert({wood: 1}))


func test_can_insert_if_filter_not_matches():
	describe("Returns false if the item does not match the filter")
	var stone_filter = FuncRef.new()
	stone_filter.set_instance(self)
	stone_filter.set_function("is_stone")
	inventory.add_filter(stone_filter)
	asserts.is_true(not inventory.can_insert({wood: 1}))


func test_empty_if_empty():
	describe("Returns true if the every slot in the inventory is empty")
	inventory = Inventory.new(80)
	add_child(inventory)
	asserts.is_true(inventory.empty())


func test_empty_if_not_empty():
	describe("Returns false if at least one slot in the the inventory has some amount of item")
	inventory = Inventory.new(80)
	add_child(inventory)
	inventory.get_child(40).item = wood
	inventory.get_child(40).amount = 1
	asserts.is_false(inventory.empty())


func test_get_contents_empty_inventory():
	describe("Returns an empty dictionary if the inventory is empty")
	inventory = Inventory.new(80)
	add_child(inventory)
	asserts.is_equal(hash({}), hash(inventory.get_contents()))


func test_get_contents():
	describe("Returns a dictionary containing the counts of items contained in the inventory")
	inventory = Inventory.new(80)
	add_child(inventory)
	inventory.add_item(wood, 5)
	inventory.add_item(stone, 12)
	asserts.is_equal(hash({wood: 5, stone: 12}), hash(inventory.get_contents()))


func test_remove():
	describe("Removes items from inventory")
	inventory = Inventory.new(80)
	add_child(inventory)
	inventory.add_item(wood, 5)
	inventory.add_item(stone, 12)
	inventory.remove({wood: 3})
	var contents = inventory.get_contents()
	asserts.is_equal(contents[wood], 2)
	asserts.is_equal(contents[stone], 12)


func end():
	# Runs after all other test related methods once
	pass
