extends TextureButton
class_name InventorySlot

signal amount_changed(new_amount)

var thing: Item = null setget set_thing
var item: Item = null setget set_item
var amount := 0 setget set_amount
var icon
var number: int
var type: String

var _style = StyleBoxFlat.new()
var _blinking := true
var equipped := false setget set_equipped


func set_equipped(is_equipped: bool) -> void:
	equipped = is_equipped
	if equipped:
		$AmountLabel.hide()
		$Icon.texture = load("res://ui/in_game/inventory/inventory/assets/hand.png")
	else:
		$AmountLabel.show()
		$Icon.texture = item.icon


func _ready():
	set_process(false)


# Deprecated
func set_thing(new_thing):
	thing = new_thing # Deprecated
	$Icon.texture = thing.icon
	print('setting thing')


func set_item(new_item: Item) -> void:
	print('setting item')
	item = new_item
	$Icon.texture = item.icon


func set_amount(new_amount):
	var old_amount = amount
	amount = new_amount
	
	if amount <= 0:
		thing = null
		$AmountLabel.visible = false
	else:
		$AmountLabel.visible = true
		$AmountLabel.text = str(amount)
	
	if old_amount != new_amount:
		emit_signal("amount_changed", new_amount)


func blink():
	add_stylebox_override("panel", _style)
	set_process(true)
	_blinking = true
	yield(get_tree().create_timer(1), "timeout")
	_blinking = false
	set_process(false)


func _process(delta):
	if equipped:
		set_global_position(get_global_mouse_position())
