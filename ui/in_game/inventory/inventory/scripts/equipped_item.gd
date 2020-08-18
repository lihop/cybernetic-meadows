extends Sprite
class_name EquippedItem


const Blueprint = preload("res://items/misc/blueprint.tscn")
const DroppedThing = preload("res://items/misc/dropped_item.tscn")

var slot: InventorySlot setget set_slot

onready var map: Map2D = $"/root/World/Map"


var item_instance: Item2D # Deprecated
var instance_added := false # Deprecated
var blueprint: Blueprint



func _ready():
	scale *= 2


func set_slot(p_slot: InventorySlot) -> void:
	if slot == p_slot:
		return
	
	slot = p_slot
	texture = slot.get_node("Icon").texture
	$AmountLabel.text = str(slot.amount)
	slot.equipped = true
	
	slot.connect("amount_changed", self, "_on_slot_amount_changed")
	
	if slot.item.placeable: # TODO: And slot.item constructable?
		blueprint = Blueprint.instance()
		blueprint.scene = load(slot.item.scene_path)
		texture = null


func _process(_delta):
	if blueprint and not blueprint.get_parent():
		$"/root/World/Things".add_child(blueprint)
	
	global_position = get_global_mouse_position()
	
	if blueprint:
		blueprint.global_position = map.closest_tile(
			map.get_global_mouse_position()
		)
	
	if Input.is_action_just_pressed("cancel"):
		slot.equipped = false
		if blueprint:
			blueprint.queue_free()
		queue_free()
	
	if Input.is_action_just_pressed("drop_item"):
		# TODO: Create an instace of the item at mouse position.
		var dropped_item: Item2D = DroppedThing.instance()
		dropped_item.resource = slot.item
		print("dropped global mouse position: ", map.get_global_mouse_position())
		dropped_item.global_position = map.closest_empty_position(
					map.get_global_mouse_position())
		$"/root/World/Things".add_child(dropped_item)
		
		slot.amount -= 1
		if slot.amount == 0:
			slot.equipped = false
			if blueprint:
				blueprint.queue_free()
			queue_free()
	
	if Input.is_action_just_pressed("place_item") and blueprint:
		if blueprint.can_place():
			blueprint.place()
			slot.amount -= 1
			if slot.amount == 0:
				slot.equipped = false
				if blueprint:
					blueprint.queue_free()
				queue_free()


func _on_slot_amount_changed(new_amount: int) -> void:
	$AmountLabel.text = str(new_amount)
