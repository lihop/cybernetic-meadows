extends Node
class_name Inventory


const EquippedItem = preload("res://ui/in_game/inventory/equipped_item.tscn")
onready var UI = $"/root/World/UI"

signal inventory_updated()

export(int) var num_slots := 80

var equipped_item: EquippedItem = null
var slots := []


func _ready():
	for i in range(num_slots):
		var slot = InventorySlot.new()
		slots.append(slot)
	emit_signal("inventory_updated")


func add_item(item: Item, amount: int = 1):
	for slot in slots:
		if slot.item and slot.item.name == item.name:
			slot.amount += amount
			emit_signal("inventory_updated")
			return
	
	for slot in slots:
		if slot.amount == 0:
			slot.item = item
			slot.amount = amount
			emit_signal("inventory_updated")
			return


func remove_item(item: Item, amount: int = 1):
	var removed := 0
	
	for slot in slots:
		if slot.item and slot.item.name == item.name:
			var to_remove = min(slot.amount, amount)
			slot.amount -= to_remove
			removed += to_remove
			if removed == amount:
				break
	emit_signal("inventory_updated")


func equip_slot(slot_idx: int) -> void:
	var slot = slots[slot_idx]

	if equipped_item and equipped_item.slot == slot:
		slot.equipped = false
		equipped_item.queue_free()
		return

	if equipped_item and slot.amount < 1:
		equipped_item.slot.equipped = false
		equipped_item.queue_free()
		return

	if not equipped_item and slot.amount > 0:
		equipped_item = EquippedItem.instance()
		equipped_item.slot = slot
		UI.add_child(equipped_item)


func unequip_slot():
	if equipped_item and equipped_item.slot:
		equipped_item.cancel()


# Returns whether inventory has amount of item.
func has_item(item: Item, amount: int = 1) -> bool:
	var total := 0
	for slot in slots:
		if slot.item and slot.item.name == item.name:
			total += slot.amount
	return total > 0
