extends Node
class_name Inventory


const EquippedItem = preload("res://ui/in_game/inventory/equipped_item.tscn")
onready var UI = $"/root/World/UI"

signal inventory_updated()
signal slot_updated(slot_index)

export(int) var num_slots := 80


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
