extends VBoxContainer
class_name Inventory


const InventorySlot: PackedScene = preload("./inventory_slot.tscn")
const EquippedItem: PackedScene = preload("./equipped_item.tscn")

# Emitted when an inventory slot is updated. For example, the amount changed
# or a new item was added.
signal slot_updated(slot_number)
# Emitted when the inventory itself was updated. For example after a resort.
signal inventory_updated()

export(int) var num_slots := 80

var equipped_item: EquippedItem = null


func _ready():
	for i in range(num_slots):
		var slot = InventorySlot.instance()
		slot.connect("pressed", self, "equip_slot", [i])
		$GridContainer.add_child(slot)
		$GridContainer.get_child(i).number = i
	emit_signal("inventory_updated")


func add_item(item: Item, amount: int = 1):
	for slot in $GridContainer.get_children():
		if slot.item and slot.item.name == item.name:
			slot.amount += amount
			emit_signal("slot_updated", slot.number)
			return
	
	for slot in $GridContainer.get_children():
		if slot.amount == 0:
			slot.item = item
			slot.amount = amount
			emit_signal("slot_updated", slot.number)
			return


func equip_slot(slot_idx: int) -> void:
	var slot = $GridContainer.get_child(slot_idx)
	
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
		add_child(equipped_item)
		equipped_item.set_as_toplevel(true)
