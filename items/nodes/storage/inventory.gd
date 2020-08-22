extends Node
class_name Inventory


const EquippedItem = preload("res://ui/in_game/inventory/equipped_item.tscn")
onready var UI = get_node_or_null("/root/World/UI")

signal inventory_updated()
signal slot_updated(slot_index)
# Emitted when one or more items are added to the inventory
signal items_added(items)


export(int) var num_slots := 80

# Filters determine what items can be stored in this inventory.
var filters := []


func _init(num_slots: int = 80):
	self.num_slots = num_slots


func _ready():
	while get_child_count() < num_slots:
		var slot = InventorySlot.new()
		add_child(slot)
	emit_signal("inventory_updated")


func add_item(item: Item, amount: int = 1):
	for i in range(get_children().size()):
		var slot = get_child(i)
		if slot.item and slot.item.name == item.name:
			slot.amount += amount
			emit_signal("inventory_updated")
			return
	
	for i in range(get_children().size()):
		var slot = get_child(i)
		if slot.amount == 0:
			slot.item = item
			slot.amount = amount
			emit_signal("inventory_updated")
			return
	
	emit_signal("items_added", item, amount)


func remove_item(item: Item, amount: int = 1):
	var removed := 0
	
	for slot in get_children():
		if slot.item and slot.item.name == item.name:
			var to_remove = min(slot.amount, amount)
			slot.amount -= to_remove
			removed += to_remove
			if removed == amount:
				break
	emit_signal("inventory_updated")


func equip_slot(slot_idx: int) -> void:
	var slot = get_child(slot_idx)

	if UI.equipped_item and UI.equipped_item.slot == slot:
		slot.equipped = false
		UI.equipped_item.queue_free()
		return

	if UI.equipped_item and slot.amount < 1:
		UI.equipped_item.slot.equipped = false
		UI.equipped_item.queue_free()
		return

	if not UI.equipped_item and slot.amount > 0:
		UI.equipped_item = EquippedItem.instance()
		UI.equipped_item.slot = slot
		$"/root/World/UI".add_child(UI.equipped_item)


func unequip_slot():
	if UI.equipped_item and UI.equipped_item.slot:
		UI.equipped_item.cancel()


# Returns whether inventory has amount of item.
func has_item(item: Item, amount: int = 1) -> bool:
	var total := 0
	for slot in get_children():
		if not slot.item or not item:
			continue
		if slot.item and slot.item.name == item.name:
			total += slot.amount
	return total > 0


func add_filter(filter: FuncRef) -> void:
	filters.append(filter)


func can_insert(items: Dictionary) -> bool:
	for item in items.keys():
		for filter in filters:
			if not filter.call_func(item):
				return false
	return true


func insert(items: Dictionary) -> int:
	# TODO: Implement me properly.
	var total = 0
	for item in items.keys():
		add_item(item, items[item])
		total += items[item]
	return total


func empty() -> bool:
	for slot in get_children():
		if slot.amount > 0:
			return false
	return true


func get_contents() -> Dictionary:
	var contents := {}
	for slot in get_children():
		if slot.item:
			if contents.has(slot.item):
				contents[slot.item] += slot.amount
			else:
				contents[slot.item] = slot.amount
	return contents


func remove(items: Dictionary) -> int:
	var total_removed := 0
	for item in items.keys():
		if has_item(item, items[item]):
			remove_item(item, items[item])
			total_removed += items[item]
	return total_removed
